Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269517AbUJLIXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269517AbUJLIXd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 04:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269524AbUJLIXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 04:23:33 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:2463 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S269517AbUJLIX0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 04:23:26 -0400
Message-ID: <416B9436.3010902@andrew.cmu.edu>
Date: Tue, 12 Oct 2004 04:22:14 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc4] USB && mass-storage && disconnect broken semantics
References: <20041011120701.GA824@outpost.ds9a.nl>
In-Reply-To: <20041011120701.GA824@outpost.ds9a.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There really is a 90% solution all in userspace, which is at the 
bottom.  The rest of this message is mostly an argument for why the 
"user expecations" aren't really supportable.

bert hubert wrote:

>This is about stupid users (including me) unplugging USB devices whilst
>still mounted, and expecting sane semantics.
>
>This has generally not been the 'Unix' or even 'Linux' way, but people
>expect it to work. I also see no clear automated and robust solution from
>userspace. "Don't do that then" is a pretty weak answer, especially since we
>want to work on the desktop.
>  
>
How do you expect writing to a device followed by a forced dismount to 
work if you aren't using a data journaled file system, and you don't 
tell it needs to clean its caches?  Our lab has been using memory sticks 
for embedded development for 5 years and we've managed to teach people 
"don't do that" pretty well (in fact I just taught another person 
today).  It is of course a mistake everyone makes a few times while 
learning.  However the last time I used Windows for this, you had to 
click on the taskbar to shut down the USB storage device, which is 
basically the same thing as unmounting.  Not doing so often required a 
reboot.

With *nix, most data only gets written at unmount, so the only way this 
can "sanely" work is for mounts you haven't written to.  That case is of 
course not currently handled very well, but writing would be damn near 
impossible to unmount well.  In order to keep the device consistent, the 
only thing you can do is wait for the user to reinsert the device and 
then clear your caches.  However they might have modified the storage in 
the meantime on another device, so you'd need some sort of consistency 
check and a mirror of pretty much everything in order to do that check.  
See how this is gets complicated real quickly?

In the days of DOS, you could just cut the power to the computer to turn 
it off; eventually users were educated not to do that, for much the same 
reason (unwritten data to storage devices).  I think with a well 
designed UI, most of these errors can be eliminated.

>The expected behaviour is that on forceably unplugging an USB memory stick,
>the created SCSI device should vanish, along with the mounts based on it.
>  
>
Along with any data that hasen't yet been written to the drive.  You're 
quite likely to corrupt a fragile FS such as FAT.

>When the user plugs in the device again, people expect to see it get the
>first available name, and be available for remount, possible automated.
>  
>
Automated mounting with special fixed names can already be done, this 
has little to do with forced dismounting.  Use something like udev for 
this part.

># mount /dev/sda1 /keychain
># grep /keychain /proc/mounts 
>/dev/sda1 /keychain vfat rw,nodiratime,fmask=0033,dmask=0033 0 0
>  
>
Read-write VFAT without being mounted sync will pretty much never work 
for forced-dismount if you have written anything.

>Unmounting and unplugging and replugging saves us.
>  
>
You're likely to have corruption too if you did any writing.

>Greg, others, I hope you agree this needs work. I hope we have the
>infrastructure to umount based on USB disconnect events, or, alternatively,
>will support 'replugging' which at least does part of what people expect.
>  
>
That infrastructure would have to include knowing when to clear caches 
before the user ever disconnects the device.  In other words, not 
possible, unless you force it to sync constantly which is not very 
healthy for a flash device (limited number or writes before it dies).  
Replugging is the only possibility that could ever support writes.  The 
only case that could really be *solved* is the "read-only or no-writes" 
condition, which is only 50% of the time for something like flash used 
to transfer files.  The only thing would could reasonably expect with 
writing is to be able to clear the pinned resources somehow.

Well, what are we to do then when new university students have to use 
the use the system for a class?  Simply wrap copies in a script like the 
following:

copy-to-memstick:
    if(!mounted) mount /memstick
    rsync $arg1 /memstick
    umount /memstick

All I ever expect the kernel to eventually support is forced dismount of 
devices that haven't been written to.  I think from there its up to 
userspace to sync whenever it thinks its done copying, or perhaps even 
to speculatively unmount something that hasen't been used in a while.  A 
common data-journaled file system for use on flash could change things, 
but I'm not holding my breath for other devices or OSes to support 
something like that.

If you have an idea how your proposed behavior could be implemented with 
details sorted out, such as writing and where the data in caches goes, 
then please prove me wrong.  That would make our students happier anyway...

 - Jim Bruce

