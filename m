Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129272AbRBAIGF>; Thu, 1 Feb 2001 03:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129693AbRBAIFz>; Thu, 1 Feb 2001 03:05:55 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:10252 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129272AbRBAIFo>; Thu, 1 Feb 2001 03:05:44 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Message-ID: <CA2569E6.002C643A.00@d73mta03.au.ibm.com>
Date: Thu, 1 Feb 2001 13:28:33 +0530
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait 
	/notify + callback chains
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a second pass attempt, based on Ben's wait queue extensions:
Does this sound any better ?

[This doesn't require any changes to the existing wait_queue_head based i/o
structures or to existing drivers, and the constructs mentioned come into
the picture only when compound events are actually required]

The key aspects are:
1.  Just using an extended wait queue now instead of the callbackq for
completion (this can take care of layered callbacks, and aggregation via
wakeup functions)
2. The io structures don't need to change - as they already have a
wait_queue_head embedded anyway (e.g b_wait; in fact io completion happens
simply by waking up the waiters in the wait queue, just as it happens now.
3. Instead, all co-relation information is maintained in the wait_queue
entries that involve compound events
4. No cancel callback queue any more.

(a) For simple layered callbacks (as in encryption filesystems/drivers):
     Intermediate layers simply use add_wait_queue(_lifo) to add their
callbacks to the object's wait queue as wakeup functions. The wakeup
function can access fields in the object associated with the wait queue,
using the wait_queue_head address since the wait_queue_head is embedded in
the object.
     If the wakeup function has to be associated with any other private
data, then an embedding structure is required, e.g:
/* Layered event structure */
 struct lev {
     wait_queue_t        wait;
     void           *data;
}

or, maybe something like the work_todo structure that Ben had stated as an
example (if callback actions have to be delayed to task context). Actually
in that case, we might like to have the wakeup function return 1 if it
needs to do some work later, and that work needs to be completed before the
remaining waiters are worken up.

(b) For compound events:

/* Compound event structure */
 struct cev_wait {
     wait_queue_t        wait;
     wait_queue_head_t * parent;
     unsigned int        flags;      /* optional */
     struct list_head         cev_list;  /* links to siblings or child
cev_waits as applicable*/
     wait_queue_head_t   *head;    /* head of wait queue on which this
is/was queued  - optional ? */
  };

In this case , for each child:
 wait.func() is set up to a routine that performs any necessary
transfer/status/count updates from the child to the parent object, issues a
wakeup on the parent's wait queue (it also removes itself from the child's
wait queue, and optionally from the parent's cev_list too ).
It is this update step that will be situation/subsystem specific, and also
have a return value to indicate whether to detach from the parent or not.

And for the parent queue, a cev_wait would be registered at the beginning,
with its wait.func() set up to collate ios and let completion proceed if
the relevant criteria is met. It can reach all the child cev_waits through
the cev_list links, useful for aggregating data from all children.
During i/o cancellation, the status of the parent object is set to indicate
cancellation and wakeup issued on its wait queue. The parent cev_wait's
wakeup function, if it recognizes the cancel, would then cancel all the
sub-events.
(Is there a nice way to access the object's status from the wakeup function
that doesn't involve subsystem specific code ? )

So, it is the step of collating ios and deciding whether to proceed  which
is situation/subsystem specific. Similarly, the actual operation
cancellation logic (e.g cancelling the underlying io request) is also
non-generic.

For this reason, I was toying with the option of introducing two function
pointers - complete() and cancel() to the cev_wait  structure, so that the
rest of the logic in the wakeup function can be kept common. Does that make
sense ?

Need to define routines for initializing and setting up parent-child
cev_waits.

Right now this assumes that the changes suggested in my last posting can be
made. So still need to think if there is a way to address the cache
efficiency issue (that's a little hard).

Regards
Suparna

  Suparna Bhattacharya
  Systems Software Group, IBM Global Services, India
  E-mail : bsuparna@in.ibm.com
  Phone : 91-80-5267117, Extn : 2525


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
