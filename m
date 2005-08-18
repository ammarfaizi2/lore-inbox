Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbVHRRut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVHRRut (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 13:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVHRRut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 13:50:49 -0400
Received: from tierw.net.avaya.com ([198.152.13.100]:25278 "EHLO
	tierw.net.avaya.com") by vger.kernel.org with ESMTP id S932348AbVHRRus convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 13:50:48 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Debugging kernel semaphore contention and priority inversion
Date: Thu, 18 Aug 2005 11:50:27 -0600
Message-ID: <21FFE0795C0F654FAD783094A9AE1DFC0830FF63@cof110avexu4.global.avaya.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Debugging kernel semaphore contention and priority inversion
Thread-Index: AcWkHCHf6cOxq92mT1O6JnvvAEeIbgAABs8Q
From: "Davda, Bhavesh P \(Bhavesh\)" <bhavesh@avaya.com>
To: "Keith Mannthey" <kmannth@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Keith Mannthey [mailto:kmannth@gmail.com] 
> Sent: Thursday, August 18, 2005 11:40 AM

> On 8/17/05, Davda, Bhavesh P (Bhavesh) <bhavesh@avaya.com> wrote:
> > > From: Keith Mannthey [mailto:kmannth@gmail.com]
> > > Sent: Wednesday, August 17, 2005 5:33 PM
> > >
> > > On 8/17/05, Davda, Bhavesh P (Bhavesh) <bhavesh@avaya.com> wrote:
> > > > Is there a way to know which task has a particular (struct
> > > semaphore
> > > > *) down()ed, leading to another task's down() blocking on it?
> > >
> > > I would add a field to struct semaphore that tracks the current 
> > > process.
> > > In your various up and downs have that field tracks the "current" 
> > > process.
> > 
> > Yeah, I thought about that. Unfortunately, it doesn't meet 
> my need for 
> > not Heisenberg'ing the system. I can't instrument the 
> struct semaphore 
> > {} in a running system.
> 
>   What kernel are you using?


2.6.11.12 from kernel.org


>   Can you do some form of a crash dump (maybe some diskdump thing)? 
> It is hard to debug without insturmentation of some kind....  
> You are most likely going to have to rebuild/change your 
> current kernel to sort this issue out....


I've written a trivial debug module that can poke around in kernel data
sturctures. Currently it dumps out any task's user space registers, some
flags in its signal structure, and its kernel stack.

I'm considering enhancing it to get to the inode->i_sem semaphore I
suspect and dump out its contents too.



> > > This way you dump the semaphore you can see what task it 
> is holding 
> > > it.  Have the module dump the semaphore and you can id the task
> > >
> > > > It would be helpful to get a kernel stacktrace for the 
> culprit too.
> > >
> > > Have you tried sysrq t?  See the Documentation/sysrq.txt file.
> > 
> > This is a headless system.
> 
>   How do you know you are spinning on some inode semaphore?  
> If the system is only headless how do you know you are 
> dealing with some priority inversion issue?  Maybe the system 
> has a panic or ????


I can boost a remote ssh shell up to SCHED_RR/SCHED_FIFO priority 99. I
know that the root cause of this priority inverstion/starvation issue is
a bug in a priority 4 SCHED_FIFO task, but want to get to the bottom of
who is being starved.

> 
>   It seems to me you might be jumping to conclusions.  


I don't think so. I've unwound the kernel stack (as dumped out by my
debug module) to determine that it is stuck on a __down() of the
inode->i_sem semaphore for a file I know (the fd is on the kernel stack,
and I know which file from /proc/pid/task/tid/fd)

>  
> > >
> > > How stuck is the system?
> > >
> > > Keith
> > 
> > Very. Only pingable, but can't login via 
> telnet/ssh/anything. Reason 
> > is the same reason the low priority mystery task is unable 
> to run and 
> > release the held semaphore.
> 
>   From the present state you have described you would be 
> unable to load a module or interact with the box in anyway. 
> It is really hard to debug a kernel without a console.  As 
> others have suggested a serial console/net console would help a bunch.
> 
> Good luck!
> 
> Keith
> 

I have hooked up a console, but what good is that going to do for
debugging? As I said, sysrq stuff is not enough to get to the bottom of
this. My real question is if anybody knows of other signatures to look
for in the running tasks, to know which one might be holding the
inode->i_sem semaphore, so I can do something about that task.

Thanks

- Bhavesh

Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
1300 West 120th Avenue | B3-B03 | Westminster, CO 80234 | U.S.A. |
Voice/Fax: 303.538.4438 | bhavesh@avaya.com

