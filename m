Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272242AbRIKBSg>; Mon, 10 Sep 2001 21:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272247AbRIKBS1>; Mon, 10 Sep 2001 21:18:27 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:28680 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S272242AbRIKBSQ>; Mon, 10 Sep 2001 21:18:16 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andreas Steinmetz <ast@domdv.de>
Date: Tue, 11 Sep 2001 11:18:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15261.26206.601070.598763@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reboot notifier priority definitions
In-Reply-To: message from Andreas Steinmetz on Tuesday September 11
In-Reply-To: <XFMail.20010911015634.ast@domdv.de>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday September 11, ast@domdv.de wrote:
> As a suggestion to prevent further shutdown/reboot notifier processing problems
> here's a (crude) attempt of definitions for include/linux/notifier.h. I do
> believe it needs to be heavily reworked by someone with a broad kernel overview.
> 
> #define NOTIFY_REBOOT_PHYSICAL    0x00 /* scsi */
> #define NOTIFY_REBOOT_LOGICAL     0x10 /* md, lvm */
> #define NOTIFY_REBOOT_FS          0x20 /* knfsd */
> #define NOTIFY_REBOOT_APPLICATION 0x30 /* tux */

I think this misses the point of reboot notifiers (as I understand
it).

There are *only* meant for "physical" sorts of things.
The comment in the code says:
 *	Notifier list for kernel code which wants to be called
 *	at shutdown. This is used to stop any idling DMA operations
 *	and the like. 

md, lvm, knfsd and tux have no business registering a reboot notifier.
If they have something to shut down, it should be shut down in a
higher-level way, such as when a process gets a signal. 

Currently md does register a reboot notifier, but this is wrong and
will go away just as soon as it can.  Unfortuantely it cannot yet.
The problem is that if the root filesystem is on an md device, then
the device never received a final close, (bd_op->release) so it can
never make the array as "stable".  That is what the current
reboot notifier does.
I am hoping that when Al Viro's changes to the boot/mount-root sequence
go in, the the root filesystem will really close it's device during
shutdown and the reboot notifier can go away.

Until then, I will change the priority for the md reboot notifier to
be very high, so that it is run first, as you suggest.

I also have this idea that if the raid1d or raid5d gets a signal, it
will switch into a mode where the array is marked stable after each
write, and then marked dirty before each write.  This would have the
desired effect without requiring a final close....

NeilBrown

