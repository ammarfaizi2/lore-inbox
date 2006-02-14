Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbWBNFLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbWBNFLb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWBNFL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:11:26 -0500
Received: from smtpout.mac.com ([17.250.248.87]:13821 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030425AbWBNFLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:11:12 -0500
In-Reply-To: <Pine.LNX.4.44L0.0602132317530.20628-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0602132317530.20628-100000@netrider.rowland.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9F9173CE-E059-433B-98AD-91084823AFDD@mac.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Tue, 14 Feb 2006 00:11:05 -0500
To: Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 13, 2006, at 23:28, Alan Stern wrote:
> On Mon, 13 Feb 2006, Kyle Moffett wrote:
>> A good set of suspend scripts should handle the hardware-suspend  
>> with no extra work because hardware supporting hardware-suspend  
>> basically inevitably supports USB low-power-mode,
>
> Unfortunately a lot of hardware doesn't support USB low-power  
> mode.  I guess you'd say therefore it doesn't really support  
> hardware-suspend.  This may be so, but it's small comfort to the  
> owners of those systems.
>
> I have to admit, although technically Phillip's argument is wrong,  
> from a usability standpoint it is right.  Windows allows users to  
> disconnect and reconnect USB storage devices while the system is  
> hibernating, with no  apparent ill effects -- although I've never  
> tried to unplug one device and then plug in a different one on the  
> same port while the computer was asleep.  I don't know to what  
> extent Windows checks descriptors/serial  numbers/disk labels/ 
> whatever when it wakes up.

For the software-suspend/no-low-power-mode case, I see a couple of  
practical and spec-conforming options:

1)  The kernel should notice that it has a filesystem mounted from a  
hotpluggable block device and abort the suspend process.  This isn't  
terribly user friendly, but is guaranteed to prevent data loss, and a  
good set of suspend scripts could notice the reason for failure and  
report it to the user (optionally unmounting the filesystems  
automatically and retrying).

2)  The kernel should notice that it has a filesystem mounted from a  
hotpluggable block device and forcibly unmount said filesystem.  This  
is also not user-friendly, and has the disadvantage of not being  
easily userspace-controllable.

3)  The kernel should notice that it has a filesystem mounted from a  
hotpluggable block device and forcibly disconnect the mount.   
Beforehand, uswsusp would have saved information about all mounted  
blockdevs into the suspend file/disk.  When resuming, early userspace  
would reread that information and attempt to relocate the block  
devices from userspace, using any tools available to it at the time  
(including a bunch of fs-probing tools and such).  After it's scanned  
devices and found any that it could reliably get, it would pass that  
information to the kernel being resumed which would use it to  
reattach filesystems to disks.  This is a lot more complicated, but  
more user friendly.  It has the downside of making the kernel do a  
lot of extra unreliable work looking up paths and files again, but it  
might work in a good percentage of the cases.  I doubt the advantages  
of this one over (1) or (2) are worth the added complexity, though.

Cheers,
Kyle Moffett

--
Simple things should be simple and complex things should be possible
   -- Alan Kay



