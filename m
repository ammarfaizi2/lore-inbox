Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRA3FCS>; Tue, 30 Jan 2001 00:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129398AbRA3FCJ>; Tue, 30 Jan 2001 00:02:09 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:21779 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129143AbRA3FCD>; Tue, 30 Jan 2001 00:02:03 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Message-ID: <CA2569E4.001AB22F.00@d73mta05.au.ibm.com>
Date: Tue, 30 Jan 2001 10:15:02 +0530
Subject: RFC:  Kernel mechanism: Compound event wait/notify + callback
	 chains
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Comments, suggestions, advise, feedback solicited !

If this seems like something that might (after some refinements) be a
useful abstraction to have, then I need some help in straightening out the
design. I am not very satisfied with it in its current form.


A Kernel Mechanism for Compound Event Wait/Notify with Callback Chaining
-----------------------------------------------------------------------------------------------------------------

Objective:
-----------------

This is a proposal for a kernel mechanism for event notification that can
provide for:
     (i)   triggering of multiple actions via callback chains (the way
notifier lists do) -  some of these actions could involve waking up
synchronous waiters and asynchronous signalling
     (ii)  compound events  : a compound event is an event that is
essentially an aggregation of several sub-events, each of which in turn may
have their own sub-events)  [should extend to more than 2 levels, unlike
semaphore groups or poll wait tables]
     (iii) a single abstraction that can serve as an IO completion
indicator

The need for such a structure originally came about in the context of
layered drivers and layered filesystem implementations, where an io
structure may need to pass through several layers of post-processing as
part of actual i/o completion, which must be asynchronous.

Ben LaHaise had some thoughts about extending the wait queue interface to
allow callbacks, thus building a generic way to address this requirement
for any kind of io structure.

Here is an attempt to take that idea further, keeping in mind certain
additional requirements (including buffer splitting, io cancellation) and
various potential usage scenarios and also considering  existing
synchronization/ notification/ callback primitives that exist in the linux
kernel today.

Calling this abstraction a "compound_event" or "cev", for short  right now
( for want of a better name ).


How/where would/could this be used ?
----------------------------------------------------------

A cev would typically be associated with an object -- e.g. an io structure
or descriptor. Either have the cev embedded in the io structure, or just a
private pointer field in the cev used to link the cev to the object.

1. In io/mem structures -- buffer/kiobuf/page_cache - especially places
where layered callbacks and compound IOs may occur (e.g encryption filter
filesystems, encryption drivers, lvm, raid, evms type situations).
[Need to explore the possibility of using it in n/w i/o structures, as
well]

2. As a basic synchronization primitive to trigger action when multiple
pre-conditions are involved.  Could potentially be used as an alternative
way to implement select/poll and even semaphore groups. The key advantage
is that multiple actions/checks can be invoked without involving a context
switch, and that sub-events can be aborted top down through multiple levels
of aggregation  (using the cancellation feature).

3. A primitive to trigger a sequence of actions on an event, and to wake up
waiters on completion of the sequence. (e.g a timer could be associated
with a cev to trigger a chain of actions and a notification of completion
of all of these to multiple interested parties)

Some reasons for using such a primitive rather than current approach of
adding end_io/private/wait fields directly within buffer heads or
vfs_kiovecs :

1. Uniformity of structure at different levels; may also be helpful in
terms of statistics collection/metering.  Keeps the completion linkage
mechanism external to the specific io structures.
2. Callback chaining makes layered systems/interceptors easier to add on,
as no sub-structures need to be created in cases where splitting/merging
isn't necessary.
3. The ability to abort the callback chain for the time being based on the
return value of a callback has some interesting consequences in making it
possible to support error recovery/retries of failed sub-ios, and also in
networking stack kind of layering architecture involving queues at each
level with delayed callbacks rather than a direct callback invokation


-------------------------------------------------------------------------------------------------------------------------------------------------------
Proposed Design
--------------------------

"Perfection in design is achieved not when there is nothing more to add,
but when there is nothing left to take away"

So, not there yet !
Anyway, after a few iterations to try to bring this down, and to keep it
efficient in simplest usage scenarios, while at the same time supporting
infrastructure for all the intended functionality, this is how it stands
(Some fields are there for search efficiency reasons when sub-events are
involved, though not actually essential):

I'm not too happy with this design in its current form. Need some
suggestions to improve this.

struct compound_event {
     /* 1. Basic infrastructure for simplest cases */
     void (*done)();
     unsigned int status;
     void *private;
     /* Add a lock somewhere here ? */

     /* 2. When layered callbacks are involved */
     struct cb_queue *callbackq;

     /* 3. To support cancellation */
     void (*cancel)();
     /* 4. To support multiple cancellation actions */
     struct cb_queue *cancelq;

     /* OPTIONAL SECTION */
     /* Sub - events support   */
     /* Keeping this explicit may help with more efficient completion,
cancellation, status monitoring and traces,
          though this information can be stored indirectly within the
cancel callback queue */
     /* 5. List of sub-events */
     struct list_head *sub_cevs;
     /* 6. Entry into list of events having the same dependent compound
event  */
     struct list_head event_list;
};

The above could possibly be used in multiple incarnations. With some
casting tricks, the same set of routines can operate on both, accessible
via (struct compound_event *) pointers:

a. struct chained_event  --  fields (1 - 2)        :  event with multiple
completion actions
b. struct cancellable_event -- fields ( 1 - 4)     :  event whose related
operations can be cancelled by the initiator
c. struct compound_event  -- fields (1 - 6)        :  event that is
triggered by a combination of sub-events

Personally, I'd prefer not have to distinguish between (a-c) and always use
the full compound_event structure (1 - 6) uniformly. It means 5 extra
fields (ptrs), i.e 20 bytes, getting included even when explicit
cancellation or compound event support may not be required, but I wonder if
that is too bad, considering the gains in terms of uniformity.

So, the relevant routines for using compound events (cev 's for short):
     i.     cev_alloc    - could have variations depending on which of a, b
is required

     All of the following routines simply work on the generic cev pointer
(struct compound_event *)
     [the parameters and interfaces are tentative, currently for
illustration only]

     ii.    cev_init(cev, [callback], [private])        [callback here
refers to the done() routine, a default exists]
     iii.   cev_add_interceptor(cev, cbq_entry)         [ equivalent to
cev_add_callback_head() ]
     iv.   cev_add_notifier(cev, cbq_entry)        [equivalent to
cev_add_callback_tail() ]
     v.    cev_add_wait(cev, wait_entry)           [special case to add a
notifier to wake up a registered waiter]
                                   (like add_wait_queue)
            cev_remove_wait
            cev_remove_callback
     vi.   cev_add_async(cev, fasync_entry)        [special case to add a
notifier for async signalling]
     vii.  cev_done(cev, status, arg)              [trigger the event
completion sequence]
     viii. cev_cancel(cev, arg)               [only for a cancellable event
- initiate cancellation ]
     ix.   cev_add_canceller(cev, cbq_entry)       [register a cancellation
action (typically for a sub-event )]
            cev_remove_canceller
     x.    cev_add_cev(child_cev, parent_cev[, [callback_struct],
[cancel_struct]])    [ ] => optional
          [ only for compund events ]
          The assumption is that a cev can have only one parent. This is
the default line of ascent during event completion and this is the path
through which cancellation would be initiated. Other cevs may be dependent
on this cev, and may register callbacks to get notifified, but the
cancellations of those cevs wouldn't automatically cancel this cev. Only
when the parent is cancelled, would that happen.
          Steps in cev_add_cev:
               Adds a notifier to the child to signal completion to the
parent
               Links the child into the parent's sub-events list
               Adds a cancellation action if appropriate

                      cev_remove_cev

     Parameters for cev callbacks:
          callback(cev, cbq_entry, cbarg, status, arg)  [cbarg is the
argument in the callback struct and arg is the argument passed to cev_done
or cev_cancel ]

A callback queue (struct cb_queue: linked list of struct cbq_struct -
having a callback routine and an arguments pointer) is very similar to a
task queue as in tqueue.h (it would be evaluated in LIFO order too) or even
more like a notifier list in terms of function as there is an added
provision to abort processing the subsequent callbacks in the chain for the
time being depending on the return value of a callback routine.   [Need to
give some thought to whether some kind of convergence with these existing
mechanisms can be brought ]

The completion logic is designed with a view to avoid inefficiencies due to
checks for more complicated cases from happening in simpler situations, at
least in the operational paths where the object gets passes through during
a notification. This is achieved by embedding each extra logic component
for more complex situations as a callback in itself. So, if we don't need
the logic in a particular case, we just don't have that callback.

Some simple flows to explain how this would work or could be used:

A compound_event would typically be associated with an io/mem object that
represents the results of an operation.
     e.g buffer heads, vfs_kiovecs, page cache/page_buf structures  - may
all have a cev field embedded in them as a completion indicator, for
various users of these structures.

Scenario 1
----------------

An io buffer (kiobuf or rather something like vfs_kiovec proposed by
Christoph or buffer heads or page structures) may be associated with a
completion/status indicator via a compound event.
For example the vfs_kiovec could look like:
     struct vfs_kiovec {
     struct kiovec *     iov;
     /* completion indicator */
     struct compound_event cev;
     };
          or
     struct vfs_kiovec {
     struct kiovec *     iov;
     struct compound_event *cev;
     }
     with cev->private being set to vfs_kiovec *

Or the buffer head, bh structure would have a field like this instead of
the end_io function pointer.

1. When setting up a vfs_kiovec structure, the caller would initialize the
cev using cev_init(). This would result in:
     cev->done = cev_default_complete;
     cev_default_complete() is a routine that just sets the cev's status
field to the completion status.

2. The vfs_kiovec structure gets passed down as part of the request to the
block driver involved.
When the request completes, the driver just calls cev_done() to mark the io
as complete.

Thus the default action on completion just sets the cev status to indicate
completed io - error/success as appropriate.

3. However, if there are waiters that expect to be woken up when the io
completes, then they would have added themselves to the cev's notifiers
queue requesting a wakeup by invoking cev_add_wait(). Internally, this
would translate to:
     cev_add_notifier() with a callback function that issues a wakeup, and
takes as an argument the task structure of the waiter.
     cev_add_notifier() calls cev_add_callback_tail() to register this
callback at the end of the queue.
     The first time this happens:
     Since the callback queue is empty, this first moves the current
cev->done() routine to the callback queue, then adds the wakeup callback
after it in the queue, and finally set cev->done = cev_extended_complete
     cev_extended_complete() is a routine that just effects a
cev_call_completion_chain to run all the callbacks on the queue one after
another unless a callback in between aborts the sequence by returning the
relevant status code (very much like notifier_call_chain)
     Next time onwards:
     The new wakeup callback is added at the end of the queue.

4. Thus if waiters exist, when the driver calls cev_done() to complete the
io:
     cev_done() calls cev->done() => cev_call_completion_chain()
     this first calls cev_default_complete()  which just sets cev->status
     then calls the routines in the chain to wakeup the waiters

5. In keeping with the wait queue philosophy, the entry would be removed
from the callback queue by the waiter after it wakes up and is done with
checking the status. (the usual linux sleep-wakeup mechanism applies)
[BTW, the same holds with callbacks here. Each callback has the
responsibility of ensuring that it gets taken off the chain at the
appropriate time]

Scenario 2
-----------------

If a filter driver, like an encryption driver for example is present, in
the above example, then for a read operation, in between steps1 and 2, the
following would happen:

1. The intermediate driver which gets the vfs_kiovec passed on to it, will
have to pass it down to the actual block driver underneath to get the data
from the media. However, it also needs to make sure it gets a chance to
decrypt the data read by the underlying block driver, before it is used by
upper layers or read by waiters for that io.
So, it invokes cev_add_interceptor() on the cev to register a callback
decrypt_data() on the callback queue. This callback is added to the head of
the queue.
Then it passes the vfs_kiovec structure downwards to the actual media
driver.

2. So, now the media driver invokes cev_done() to complete the io
     cev_done() calls cev->done() => cev_call_completion_chain()
     this first calls decrypt_data()
     then calls cev_default_complete()  which just sets cev->status
     then calls the routines in the chain to wakeup the waiters

     So all users/waiters see the processed data (decrypted form) as
desired. The status is not marked as done until the decryption callback is
done.

Notice that there was no need to generate a sub-event in this case where
just a simple 1-1 layering for the entire io suffices.

Scenario 3
----------------

A more complicated situation involving iobuf splitting, as in the case of
lvm driver layered above media drivers.

Consider the situation where the lvm gets a vfs_kiovec structure, and needs
to fill in portions of the buffer from 2 physical devices. In this
situation the vfs_kiovec has to be split up and each piece passed down to
the respective drivers separately.
Each of the sub vfs_kiovec structures would have their own cev fields.
Before passing the sub-requests down, lvm would invoke cev_add_cev to add
the child's cevs to the parent ( this would register a default callback
cev_default_notify_parent() to notify the parent cev when the child is done
). In addition it would add a cev_default_child_done() interceptor callback
to the parent, if no other callback is explicitly supplied.
     cev_default_notify_parent:  calls cev_done() on the parent
     cev_default_child_done:  removes the child cev from its list. If this
( parent) cev is ready for completion notifications and no sub-events are
pending on its list return success to continue with completion of this cev,
otherwise return a status code to abort completion (as more io is expected
to be pending)
     [Checking if the parent is ready for completion notifications avoid a
potential race in case some sub-events complete even before all the
sub-events have been set up]

Note that, this functionality could have been achieved without having the
explicit sub-events linkage in the structure, by using cancel callbacks,
only that this would have been less efficient as the parent completion
callback would have had to locate the child cev in its canceller callback
chain. Alternatively, the child cev's callback argument would have had to
include a pointer to the corresponding canceller entry in its parent.

Thus, now when the split requests complete there is some default logic to
consolidate the completion status.

In case of a different kind of device, e.g if sub-requests are sent to
replica/mirrored devices, it is possible that a separate callback would be
set up to consider the io as complete if any of the sub-requests are done,
and to cancel the remaining sub-ios now that they aren't required any more.

Note:  A simple pending sub-events count (just as with counting semaphores)
may suffice in several cases as an indicator of when all the sub-ios are
done, without necessiating this kind of sub-event tracking, but greater
flexibility is achievable if the sub-events list is maintained.

Scenario 4
----------------

Just for the heck of it, an alternative way of implementing the
multiple_wait functionality that poll/select provides. The approach follows
exactly the same principle as the current wait table based implementation.

Note that in this case, explicit sub-event linkage is not used, because
there could be multiple aggregator events depending on a particular
sub-event.

Each child cev would have a notifier (cev_default_notify_parent) registered
to complete the parent cev, passing the child cev as the additional
argument to cev_done (sort of parallel to poll_wait).
For each child cev , the parent cev would have a canceller registered to
remove itself from child cev's callback list.
The parent cev, would have an interceptor cev_complete_any_child(), which
on being invoked, gets its callbacks removed from its sub-cevs (sort of
like what poll_free_wait does), and continues with completing the parent
cev, which then wakes up registered waiters.



  Suparna Bhattacharya
  Systems Software Group, IBM Global Services, India
  E-mail : bsuparna@in.ibm.com
  Phone : 91-80-5267117, Extn : 2525




  Suparna Bhattacharya
  Systems Software Group, IBM Global Services, India
  E-mail : bsuparna@in.ibm.com
  Phone : 91-80-5267117, Extn : 2525


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
