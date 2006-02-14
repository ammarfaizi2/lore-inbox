Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422886AbWBNXcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422886AbWBNXcf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422887AbWBNXcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:32:35 -0500
Received: from smtpout.mac.com ([17.250.248.97]:63740 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1422886AbWBNXcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:32:35 -0500
In-Reply-To: <43F247EC.3070503@cfl.rr.com>
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org> <43F11A9D.5010301@cfl.rr.com> <BCC8C7FA-25A2-4460-A667-5AA88BF5BC6D@mac.com> <43F13BDF.3060208@cfl.rr.com> <DD0B9449-14AF-47D1-8372-DDC7E896DBC2@mac.com> <43F17850.8080600@cfl.rr.com> <"F157 <D2DF8AE9-51A0-42DF-8346-0EF4C264627D"@mac.com> <43F247EC.3070503@cfl.rr.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <79A58445-4313-4645-8382-8C82C8831B5F@mac.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Tue, 14 Feb 2006 18:32:27 -0500
To: Phillip Susi <psusi@cfl.rr.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 14, 2006, at 16:13, Phillip Susi wrote:
> Because you can not go yanking devices out from under the kernel  
> without it's knowledge or consent.  This is no more acceptable than  
> ejecting a floppy without first unmounting it; the only difference  
> is that the floppy drive doesn't erroneously inform the kernel that  
> you have done this simply because you suspend.

Yes, but causing it to overwrite data over random blockdevs when the  
unexpected happens is _not_ OK.

>> Did you read what I wrote?  People don't generally expect to  
>> randomly plug and unplug SCSI drives whenever they feel like it.   
>> They _do_ expect to randomly plug and unplug USB drives, mice,  
>> keyboards, tablets, network adapters, etc, because _everything_  
>> supports such random plugging.
>
> No, they don't.  Users do not expect ( or should not and are told  
> not to by admins ) to be able to yank out their usb memory stick  
> while it is mounted.  They are told to always unmount first.  If  
> they fail to do so, then they get what they asked for.  It doesn't  
> matter if the disk is SCSI or USB; you don't go yanking it out  
> without unmounting it first, or you will loose data.

You've obviously never administrated any kind of large scale linux  
lab.  We had so many people just saving files on their USB sticks and  
pulling them that we would daily get people reporting that they  
couldn't _mount_ their USB stick because the last user hadn't  
unmounted it first.  At one point we had to write a Perl script run  
from cron that ran every 10 minutes and verified if USB-stick mounts  
were still good, and if not it forcefully unmounted them.  Now  
obviously this is the kind of behavior that we want to avoid, but end- 
users are bound to do stupid stuff until it comes back and bites them  
at least twice (except on Linux with -o sync mounts it usually  
doesn't).  Think about how most linux distros automatically turn on - 
o sync on USB keys and the like; they do it for precisely this reason.

> Maybe it does make sense to have hibernation scripts unmount  
> removable media for the common silly user who can't remember to  
> unmount disks before ejecting/unplugging them, but you should be  
> able to suspend a system with its root on a usb disk and not have  
> the kernel panic for no good reason when it resumes.

I described a workable method to handle root-on-USB (and I'm not  
sure, but I doubt it works now).  You would have early userspace find  
your USB filesystems again and pass device information to the  
resuming kernel, which would then restore RAM and then use the passed  
information to attach its filesystems again.

One other alternative that just occurs to me now is to have a special  
stackable filesystem that can suspend all IO and unmount the  
filesystem underneath it then have the filesystem be easily  
reattachable later on (the stackable layer would look up paths again  
on remount.  You would have an mlocked program start during suspend  
that would create a new namespace with a basic tmpfs, procfs, and  
sysfs.  It would be able to rescan all removable devices on resume  
and reattach them to the stackable mounts in the primary namespace  
through /proc/<pid>/root.  This seems to me to be the most race-free  
and most flexible solution.  It will even handle network suspend and  
resume without too much extra effort.

Cheers,
Kyle Moffett

--
Simple things should be simple and complex things should be possible
   -- Alan Kay



