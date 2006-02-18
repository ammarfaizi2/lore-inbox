Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWBRVEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWBRVEK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 16:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWBRVEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 16:04:09 -0500
Received: from mx1.rowland.org ([192.131.102.7]:39172 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S932151AbWBRVEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 16:04:08 -0500
Date: Sat, 18 Feb 2006 16:04:07 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
cc: Phillip Susi <psusi@cfl.rr.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: Flames over -- Re: Which is simpler?
In-Reply-To: <20060217210445.GR3490@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.44L0.0602181531290.4115-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2006, Pavel Machek wrote:

> > If there is no better way to tell for sure that the device that is 
> > now there is not the same as the one that was there, then the kernel 
> > must assume the user did not do something stupid and continue to use 
> 
> Must?! Are you Linus or what?

Technical issues aside, the question about recogizing formerly-attached 
devices when waking up from a system sleep is really about 
user-friendliness.  The choice between what Phillip is advocating and what 
the rest of us have been saying is a policy choice, one that the kernel 
can't easily avoid making.

Given that this is a policy decision, it might not be such a bad idea to 
ask Andrew or Linus for their opinion.  In fact, I'll do that right now.


To summarize the background:

When a hotpluggable bus (USB for sure, possibly others as well) loses 
power, the hardware interprets this as a disconnection of all attached 
devices.  When power is restored, it appears to the kernel as though a 
completely new set of devices has now been plugged in.

This is unfriendly for people whose motherboard/USB-controller hardware
doesn't supply minimal power during hardware- or software-suspend.  Any
mounted filesystems on a USB storage device get blown away when the system
resumes, since the kernel thinks the device was unplugged.

In principle the kernel is capable of detecting that a device present on a
port during resume is very similar to the device that had been present
during the suspend.  Through a combination of checks (descriptors, serial
numbers, superblocks, maybe others) it could try to verify this and then
keep the device data structures intact, as though the device had been
connected all along.

The advantage is that people wouldn't lose half-stored data on their
removable drives, they wouldn't have unmount before suspending and remount 
after resuming, and they would be able to suspend with their root
filesystem on a USB drive without causing a panic upon resume.

The disadvantage is that sometimes people do switch removable drives or
removable media while the system is asleep.  If the kernel gets fooled
into thinking the new device is the same as the old one, it would proceed
to destroy the data on the new device by overwriting it with data from the
old one.  (Not to mention that this kind of approach is contrary to the
USB specification.)

On the other hand, it's what Windows does.  We don't want people to say 
that Linux is incapable of implementing a feature that Windows has had for 
a long time.  :-)


So the question is: What should the kernel do?  Assume the device has 
changed (as it does now) or make some checks to see if it might still be 
the same (dangerous though that may be)?

If you really want to waffle, you can recommend that the capability to do
this be present but normally disabled, controlled by a flag somewhere in
/sys/kernel -- thus pushing the decision off to userspace.

Alan Stern

