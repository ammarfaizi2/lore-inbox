Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWGaE1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWGaE1w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 00:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWGaE1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 00:27:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51857 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751148AbWGaE1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 00:27:51 -0400
Date: Sun, 30 Jul 2006 21:27:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Alan Stern <stern@rowland.harvard.edu>, cpufreq@www.linux.org.uk
Subject: Re: Linux v2.6.18-rc3
Message-Id: <20060730212746.4c2e1466.akpm@osdl.org>
In-Reply-To: <4807377b0607302113i4e984ff6j1ebae5562148907c@mail.gmail.com>
References: <Pine.LNX.4.64.0607292320490.4168@g5.osdl.org>
	<4807377b0607302113i4e984ff6j1ebae5562148907c@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2006 21:13:48 -0700
"Jesse Brandeburg" <jesse.brandeburg@gmail.com> wrote:

> On 7/29/06, Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > Ok, this missed a week (it should really have been -rc4, and we should
> > have had a -rc3 a week ago), but the fact is, with a lot of people at the
> > kernel summit and at OLS, it was so quiet for a week that there simply was
> > no point.
> 
> not sure if this is a regression or not, get this on my IBM thinkpad
> T43 when resuming from S3 or from hibernate to disk.
> 
> acpi acpi: suspend
> PM: Entering mem sleep
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> Back to C!
> BUG: sleeping function called from invalid context at kernel/rwsem.c:20
> in_atomic():0, irqs_disabled():1
>  [<c012d638>] down_read+0x12/0x1f
>  [<c012605b>] blocking_notifier_call_chain+0xe/0x29
>  [<c029199a>] cpufreq_resume+0x118/0x13f
>  [<c0231b68>] __sysdev_resume+0x20/0x53
>  [<c0231ca9>] sysdev_resume+0x16/0x47
>  [<c0235f93>] device_power_up+0x5/0xa
>  [<c013358d>] suspend_enter+0x3b/0x44
>  [<c011b644>] printk+0x1b/0x1f
>  [<c01336fe>] enter_state+0x168/0x198
>  [<c01337b3>] state_store+0x85/0x99
>  [<c013372e>] state_store+0x0/0x99
>  [<c019047a>] subsys_attr_store+0x1e/0x22
>  [<c01906ca>] sysfs_write_file+0xa6/0xcc
>  [<c0190624>] sysfs_write_file+0x0/0xcc
>  [<c015ae52>] vfs_write+0xa8/0x159
>  [<c015b398>] sys_write+0x41/0x67
>  [<c0102bc9>] sysenter_past_esp+0x56/0x79
> PM: Finishing wakeup.
> acpi acpi: resuming
> 
> full dmesg and .config attached, I can test patches.

I think this is the cpufreq problem wherein it sometimes requires that the
notifier chain be traversed from atomic context and at other times it
requires that sleeping functions be callable from within the traversal. 
IOW: we're screwed whatever type of locking we use on that chain.

I think Alan is cooking up a scheme wherein we fix this with an srcu-locked
notifier chain.  If so, it'd be nice to get that moving along a bit?

If not, I'm not sure what the fix is - perhaps create a second notifier
chain which has the same contents but uses a different locking approach?
