Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbUK1Rem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbUK1Rem (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 12:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUK1Rem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 12:34:42 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:6917 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S261315AbUK1Red (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 12:34:33 -0500
Message-ID: <41AA0C28.4070301@highlandsun.com>
Date: Sun, 28 Nov 2004 09:34:32 -0800
From: Howard Chu <hyc@highlandsun.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8a5) Gecko/20041101
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lemon@freebsd.org
CC: linux-kernel@vger.kernel.org
Subject: [Fwd: Re: >1024 connections in slapd / select->poll]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,
    I read your kqueue paper with great interest. Some other mechanisms 
were also suggested to me but kqueue is by far the most 
powerful/flexible I've seen so far. I would like to extend it a bit 
further though and wanted to get your feedback on the idea.

In adding support for Linux epoll() to OpenLDAP slapd one of the 
difficulties was that there is no direct way to ask "did descriptor N 
trigger" without walking through the entire list of returned events. 
This has to do with supporting prioritized events, certain descriptors 
must be processed before others. This is a key benefit of using 
select(), all the events are in a fixed array and any one can be 
accessed directly. kqueue also behaves the same way epoll does in this 
respect, and the documentation suggests that using multiple nested 
kqueues will allow prioritization. Certainly true, but that's somewhat 
clumsy, and requires a lot more work for the application developer.

My idea here is to use mapped/shared memory to store the event list. 
When returning a list of triggered events, the return list is simply a 
list of indices into the original event list. The actual event is 
flagged in the original event list. So apps that don't care about 
priority can still process events in the returned order, but with one 
additional dereference. Apps that do care about priority can find their 
events directly in the original list.

Let's call this approach "equeue" for the purposes of this discussion. 
There will be two system calls, analogous to kqueue/kevent. The first 
creates the queue. Like linux epoll() it takes an argument, the maximum 
size of its event list. Unlike epoll, this is a hard limit, because it 
maps a memory region for this size and the region is never grown after 
that. It takes another argument, a pointer to where to store the address 
of the allocated shared memory.
     int equeue( int size, struct equeue **addr );

The struct equeue describes the event list:

struct equeue {
     short maxevents;
     short nchanges;
     short *ievents;
     struct eevent events[];
};

This is just a header for the mapped region. Since we're using shorts 
for array indices there is a limit of 65535 events in an equeue. The 
actual layout of the mapped region is thus the header, followed by 
(maxevents) eevent structs, followed by the array of indices. The eevent 
structure is basically a kevent structure with an additional field 
containing the result flags for the event. The equeue struct is 
initialized by the equeue() system call before being returned to the user.

  struct eevent {
    uintpt_t   ident;   /* identifier for event */
    short   filter;   /* filter for event */
    u_short flags;   /* action flags */
    u_int inflags;   /* filter flags of interest */
    u_int outflags;   /* resulting flags */
    intptr_t   data;   /* filter data value */
    void *udata;   /* opaque identifier */
  };

A call to eevent() just needs two arguments - the fd returned from 
equeue(), and a timeout. The address of the mapped region is stored 
internally by the equeue() syscall, and is used implicitly by eevent().

On input, equeue.nchanges tells how many event structures are being 
controlled/modified and the ievents array gives the indices of each 
modified structure. On return from eevent() the equeue.nchanges tells 
how many events were triggered and the ievents array gives the indices 
of each triggered structure. A triggered event is reported by setting 
the outflags of the corresponding eevent struct.

This approach completely eliminates any copying of event 
records/descriptor lists between user/kernel space, so constructing 
event lists and modifying them is essentially zero-cost. Also, since the 
array of events remains in place, the application can inspect higher 
priority events of interest by direct reference.

As a further refinement, an event that is already registered can be 
masked and unmasked arbitrarily, by toggling a flag in the action flags. 
Masking an event leaves all the polling callbacks in place, but the 
callback will not wakeup the waiter. This saves any overhead of "adding" 
and "deleting" an event from the event list, when the app just wants to 
ignore it temporarily. (like sigprocmask, really.)

Toggling interest in descriptors is also something that slapd does 
frequently, and the epoll_ctl method really slows us down. With 2048 
active connections slapd with epoll() is noticably slower than slapd 
with select() on a 2.6 Linux kernel, mainly because of this epoll_ctl 
overhead. Since kqueue combines event modification with event wait the 
overhead is probably lower, but I haven't tried it yet. Still, the lack 
of direct access to "event for descriptor X" makes it less usable.

I plan to implement this in the next month or two but wanted to get some 
feedback from you first, thanks.
-- 
   -- Howard Chu
   Chief Architect, Symas Corp.       Director, Highland Sun
   http://www.symas.com               http://highlandsun.com/hyc
   Symas: Premier OpenSource Development and Support

-------- Original Message --------
Date: 	Thu, 18 Nov 2004 22:15:40 -0800
From: 	Howard Chu <hyc@symas.com>
To: 	Yusuf Goolamabbas <yusufg@outblaze.com>
Cc: 	Volker.Lendecke@SerNet.DE, openldap-devel@OpenLDAP.org
Subject: 	Re: >1024 connections in slapd / select->poll
Comment: 	openldap-devel mailing list <http://www.OpenLDAP.org/lists/>
List-Archive: 	<http://www.OpenLDAP.org/lists/openldap-devel/>


Yusuf Goolamabbas wrote:

 >>Well if you're feeling brave, I've just completed a patch in CVS HEAD
 >>supporting epoll. I haven't tried testing it with a massive number of
 >>connections yet, but the code now passes the regular test suite. It
 >>should be simple enough to add kqueue support as well now (I would have
 >>begun that but I don't have BSD installed anywhere at the moment).
 >>Regular poll can easily be added if you want, but there's really no
 >>reason to. Solaris /dev/poll is a bit more awkward.
 >>
 >>
 >
 >Solaris 10 supports event ports which is supposedly thread friendly
 >
 >http://blogs.sun.com/roller/page/barts/20040720
 >http://developers.sun.com/solaris/articles/event_completion.html
 >
 >
Thanks for the links, good references. Of course they seem to confirm
that there's no compelling reason to migrate away from select() in
slapd...poll() blocks the entire process, /dev/poll has strict mutex
requirements and performs poorly when the descriptor list changes
frequently... epoll has some of that characteristic as well - modifying
the descriptor set requires a system call, a trip across the user/kernel
barrier. With select you just flip a bit in userspace and you're done.
The Solaris event ports sound interesting, but I think anybody who
develops a "new event handler" on Unix and forgets to support signal()
at the outset has overlooked something important...

Anyway, it's too bad that everyone is just copying each other's ideas
and not actually learning from the obvious limitations of all of these
schemes. A real solution needs to not only perform well on large sets of
monitored items, but it needs to be extremely cheap to create and manage
these sets in the first place. Only select wins on that score, and the
obvious solution to avoid the argument passing overhead that everyone
seems so foolishly focused on is to use explicitly mapped memory for the
event sets. I.e., mmap a region that is directly accessible in both user
and kernel space so that no byte copying needs to be done.

Another point where select (and poll) wins is that there is a fast
mapping from the input set to the result set - i.e., if you want to know
"did event #5 occur?" you can find out in constant time, because it's
just a fixed bitfield lookup. For all the other mechanisms that either
return events one at a time or in a flat list, you have to iterate thru
the list to look for "event #5". They have thus taken the linear search
that the kernel does for select and kicked it out into userland, thus
perceiving a great savings in kernel CPU time but not really improving
life for the application developer. There is an obvious way to solve
both of these problems with no additional cost - do both.

Define the input event set as an array of structures, as most of these
mechanisms do. The array resides in a shared memory region. We can use a
modified struct kevent as a typical structure:
  struct kevent {
    uintpt_t   ident;   /* identifier for event */
    short   filter;   /* filter for event */
    u_short flags;   /* action flags */
    u_int inflags;   /* filter flags of interest */
    u_int outflags;   /* resulting flags */
    intptr_t   data;   /* filter data value */
    void *udata;   /* opaque identifier */
   }

kqueue is pretty darn good, but it still misses on the argument copying
problem, its result set is an array of struct kevent's describing the
results, and it doesn't give you direct access for priority
management.The bulk of the struct is redundant information, all we want
to know are the resulting flags and any data accompanying it.

What a really good, efficient mechanism would do is leave the input
event array in place, set the result flags and data there, and return a
list of *offsets* to all the entries in the array that got signaled.
That way you can navigate the result list in priority order and in event
order, all without expensive linear search time. (If your argument list
is a mmap'd region, using offsets means you don't have to guarantee the
region gets mapped to any particular address, but you can still remember
the location of the relevant structure for a monitored object and access
it in constant time.)

Maybe I'll write a patch for this for Linux over the holidays. Starting
from either of poll or kqueue it would be pretty easy to fix this up right.

-- 
   -- Howard Chu
   Chief Architect, Symas Corp.       Director, Highland Sun
   http://www.symas.com               http://highlandsun.com/hyc
   Symas: Premier OpenSource Development and Support

