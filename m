Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030605AbWBODIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030605AbWBODIT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 22:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030606AbWBODIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 22:08:19 -0500
Received: from ms-smtp-04-smtplb.tampabay.rr.com ([65.32.5.134]:9653 "EHLO
	ms-smtp-04.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1030605AbWBODIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 22:08:18 -0500
Message-ID: <43F29B1A.30309@cfl.rr.com>
Date: Tue, 14 Feb 2006 22:08:10 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Alan Stern <stern@rowland.harvard.edu>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org> <43F11A9D.5010301@cfl.rr.com> <BCC8C7FA-25A2-4460-A667-5AA88BF5BC6D@mac.com> <43F13BDF.3060208@cfl.rr.com> <DD0B9449-14AF-47D1-8372-DDC7E896DBC2@mac.com> <43F17850.8080600@cfl.rr.com> <"F15 <79A58445-4313-4645-8382-8C82C8831B5F@mac.com>
In-Reply-To: <79A58445-4313-4645-8382-8C82C8831B5F@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> On Feb 14, 2006, at 16:13, Phillip Susi wrote:
>> Because you can not go yanking devices out from under the kernel 
>> without it's knowledge or consent.  This is no more acceptable than 
>> ejecting a floppy without first unmounting it; the only difference is 
>> that the floppy drive doesn't erroneously inform the kernel that you 
>> have done this simply because you suspend.
> 
> Yes, but causing it to overwrite data over random blockdevs when the 
> unexpected happens is _not_ OK.
> 

Why not?  That is exactly what happens if you suspend and swap floppies. 
  Just don't do that and you're fine.  It is nice if you can handle the 
swapped case more gracefully, but not at the cost of data loss in the 
_normal_ case.

> You've obviously never administrated any kind of large scale linux lab.  
> We had so many people just saving files on their USB sticks and pulling 
> them that we would daily get people reporting that they couldn't _mount_ 
> their USB stick because the last user hadn't unmounted it first.  At one 
> point we had to write a Perl script run from cron that ran every 10 
> minutes and verified if USB-stick mounts were still good, and if not it 

This is a very good argument for _correctly_ detecting device removal. 
I am not arguing against that.  The problem is with _incorrectly_ 
detecting device removal.

> forcefully unmounted them.  Now obviously this is the kind of behavior 
> that we want to avoid, but end-users are bound to do stupid stuff until 
> it comes back and bites them at least twice (except on Linux with -o 
> sync mounts it usually doesn't).  Think about how most linux distros 
> automatically turn on -o sync on USB keys and the like; they do it for 
> precisely this reason.
> 

Some distros do.  Some do not.  I side with those who do not because 
doing so promotes stupid users ( they won't learn until it bites them 
twice ) and because it burns out the flash memory 10 times faster and 
slows down access.

> 
> I described a workable method to handle root-on-USB (and I'm not sure, 
> but I doubt it works now).  You would have early userspace find your USB 
> filesystems again and pass device information to the resuming kernel, 
> which would then restore RAM and then use the passed information to 
> attach its filesystems again.
> 

There is currently no such method of reconnecting a filesystem to a 
device once the device has been broken by an eject, is there?  Also that 
amounts to much the same thing as I have been saying all along: the 
system should check to see if the device that is there now is the same 
as the one that was there before, and if so, resume using it.

> One other alternative that just occurs to me now is to have a special 
> stackable filesystem that can suspend all IO and unmount the filesystem 
> underneath it then have the filesystem be easily reattachable later on 
> (the stackable layer would look up paths again on remount.  You would 
> have an mlocked program start during suspend that would create a new 
> namespace with a basic tmpfs, procfs, and sysfs.  It would be able to 
> rescan all removable devices on resume and reattach them to the 
> stackable mounts in the primary namespace through /proc/<pid>/root.  
> This seems to me to be the most race-free and most flexible solution.  
> It will even handle network suspend and resume without too much extra 
> effort.
> 

That seems rather complex with little benefit.  The only advantage that 
would have over not breaking the mount in the first place is in the 
pedantic case where the user screws with the media during suspend. 
Seems like a high price to pay to cleanly deal with a pedantic error 
condition.


