Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbUKDJ6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbUKDJ6l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 04:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbUKDJ6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 04:58:41 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:13837 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262145AbUKDJ6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 04:58:35 -0500
Message-ID: <4189FEBF.9000800@hist.no>
Date: Thu, 04 Nov 2004 11:04:47 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell Miller <rmiller@duskglow.com>
CC: Jim Nelson <james4765@verizon.net>, DervishD <lkml@dervishd.net>,
       Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot?
References: <200411030751.39578.gene.heskett@verizon.net> <20041103192648.GA23274@DervishD> <4189586E.2070409@verizon.net> <200411031644.58979.rmiller@duskglow.com>
In-Reply-To: <200411031644.58979.rmiller@duskglow.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Miller wrote:

>On Wednesday 03 November 2004 16:15, Jim Nelson wrote:
>
>  
>
>>I did this to myself a number of times when I was first learning Samba -
>>even an ls would become unkillable.  You couldn't rmmod smb, since it was
>>in use, and you couldn't kill the process, since it was waiting on a
>>syscall.  Ergh.
>>
>>    
>>
>
>I'm not going to pretend to be a kernel expert, or really anything other than 
>a newbie when it comes to kernel internals, so please take this with the 
>merits it deserves - many, or none, depending.
>
>Anyway, is there a way to simply signal a syscall that it is to be interrupted 
>and forcibly cause the syscall to end? 
>
There is a way.  Processes go into D state happens all the time
when waiting for disk io or similiar.  Then the io happens a few ms later,
and the fs or device driver tells the kernel to wake up the process
so it gets a chance at the next scheduling opportunity. So the mechanism to
unstick a prcess exists, and is used by every device driver that
use sleeping.  Which is most of them.

Breakage happens when something never comes out of D-state.
One could write a trivial syscall (or addition to "kill") that "wakes"
processes waiting for io.  It itsn't hard to do at all - just copy the
waking code from any device driver.  This will allow to kill and
fully remove any process that hangs around in D-state.  This might
also release other stuck resources as the syscall
continues, returns to userspace, and allows the process to die.

Unfortunately, this isn't enough.  In some cases the syscall
expects the io device interrupt handler to have done something
vital - but this haven't happened when we forcibly wakes a process.
We can hope for an io error, but might get a crash instead. This
can be fixes with a lot of work - basically check at every wakeup
if the process were woken by this new killing mechanism and
act accordingly.  It shouldn't be hard, but _lots_ of work
inspecting every sleeping point, at least every device driver.

Another problem exist if the long-waiting io wasn't lost - just 
extremely slow.
If the io actually comes through after the process is gone and the memory
is used for something else - bang!  Dealing properly with this case
is harder - a new generic mechanism for cancelling outstanding io
requests is needed for this.
It might even be impossible in some cases.  If a memory address is handed
over to a bus-mastering device such as a scsi adapter, then the memory
must be pinned down until the operation completes.  It cannot be released.
The rest of the process can go, but the hw might not support any way
of cancelling the request.  A few may have a way, many won't.  Some devices
can be reset - but at a considerable cost.  A disk controller might be 
unavailable
for seconds during such a reset - instant DOS attack if a user keeps 
starting lots of
disk intensive processes and kill them off while in a D-state that 
normally last way shorter than a reset.  PCI devices can be turned off, 
but we might really want
to use them again . . .

Fortunately, most cases of long-running D-state is just driver bugs and
can be fixed as such.  nfs has a forced umount option.  If samba can 
hang, then
it _can_ be fixed in similiar ways.  (smbfs is software only - no quirky 
hw to deal with.)
Hw drivers that puts processes into everlasting D-state usually do so 
because of
a bug. (Lost request or interrupt because of internal errors.)  Fix 
that, and the
problem never happens.  So the hard problem of killing stuff stuck in 
D-state
doesn't need a solution - fix the real bug instead.  Having a way to 
kill such processes
will only mean that hard-to-trigger bugs won't get fixed because there is
workaround.  This is bad for stability too, as broken hw drivers can 
hang the
kernel even if a better process killer comes into existence.

> Kicking the program execution out of 
>kernel space would be sufficient to "unstick" the process - and coupling that 
>with an automatic KILL signal may not be a bad idea.
>
>I'm pretty sure that someone will think of a way why this wouldn't work with 
>very little effort.  Please enlighten me?
>  
>
It is doable - but not with "very little effort".  I have outlined above 
the trouble
you get if you trivially wake up the sleeping process.  Another trivial 
alternative
is to remove the process while it is in-kernel.  The downside is that it 
might
be holding a lock or semaphore that won't ever be released this way.  
And no,
locks aren't necessarily accounted for anywhere.  (They are implicitly
accounted for by the fact that a process exists whose future execution
path leads to the release of said lock.)  Explicit accounting that allows
lock-breaking is deemed too slow, and what to do about the data structures
the lock/semaphore were protecting?

The stuck process is a sign of another bug - better fix that one.

Helge Hafting




