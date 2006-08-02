Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWHBE7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWHBE7Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 00:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWHBE7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 00:59:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43146 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751185AbWHBE7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 00:59:24 -0400
Date: Tue, 1 Aug 2006 21:59:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       cpufreq@www.linux.org.uk
Subject: Re: Linux v2.6.18-rc3
Message-Id: <20060801215919.8596da9d.akpm@osdl.org>
In-Reply-To: <4807377b0608012131mf160bc3iff724910191b521@mail.gmail.com>
References: <20060731081112.05427677.akpm@osdl.org>
	<Pine.LNX.4.44L0.0607311627240.5805-100000@iolanthe.rowland.org>
	<4807377b0608012131mf160bc3iff724910191b521@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006 21:31:22 -0700
"Jesse Brandeburg" <jesse.brandeburg@gmail.com> wrote:

> On 7/31/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Mon, 31 Jul 2006, Andrew Morton wrote:
> >
> > > core_initcall() would suit.  That's actually a bit late for this sort of
> > > thing, but we can always add a new section later if it becomes a problem.
> > > I'd suggest that we ensure that srcu_notifier_chain_register() performs a
> > > reliable BUG() if it gets called too early.
> >
> > Here's a patch to test.  I can't try it out on my machine because
> > 2.6.18-rc2-mm1 (even without the patch) crashes partway through a
> > suspend-to-disk, in a way that's extremely hard to debug.  Some sort of
> > spinlock-related bug occurs within ioapic_write_entry.
> 
> can't test because I also can't suspend or hibernate with rc2-mm1
> (resume causes hard hang with the backlight and screen off)  The issue
> i reported was against linus' 2.6.18-rc3 kernel.
> 

This might help?


author Jiri Slaby <ku@bellona.localdomain> Tue, 01 Aug 2006 01:16:13 +0159

--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -2360,6 +2360,7 @@ static int ioapic_resume(struct sys_devi
 		reg_00.bits.ID = mp_ioapics[dev->id].mpc_apicid;
 		io_apic_write(dev->id, 0, reg_00.raw);
 	}
+	spin_unlock_irqrestore(&ioapic_lock, flags);
 	for (i = 0; i < nr_ioapic_registers[dev->id]; i ++)
 		ioapic_write_entry(dev->id, i, entry[i]);
 
-

