Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422846AbWBNWgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422846AbWBNWgD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422849AbWBNWgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:36:01 -0500
Received: from wsip-68-14-232-151.ph.ph.cox.net ([68.14.232.151]:22657 "EHLO
	cantor.snitselaar.org") by vger.kernel.org with ESMTP
	id S1422846AbWBNWgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:36:00 -0500
Message-ID: <48822.198.115.32.5.1139956559.squirrel@cantor.snitselaar.org>
Date: Tue, 14 Feb 2006 15:35:59 -0700 (MST)
Subject: Problem: Possible deadlock for 2.4 SMP systems
From: "Gerard Snitselaar" <snits@snitselaar.org>
To: linux-kernel@vger.kernel.org
Reply-To: snits@snitselaar.org
User-Agent: SquirrelMail/1.4.6 [CVS]-0.cvs20050812.1.fc4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem: Possible deadlock for 2.4 SMP systems
Arch: i386

Full Description: I ran into this with the serial driver,
but it might affect other drivers and possibly other
architectures. On an smp system one cpu (cpu0) was in the
process of shutting down the serial port, while another cpu
(cpu1) was in the process of trying to service the interrupt
for that port. What appears to happen is cpu0 calls cli() in
shutdown() (drivers/char/serial.c), grabbing global_irq_lock.
Meanwhile cpu1 sets IRQ_INPROGRESS, and eventually calls
handle_IRQ_event() and spins on global_irq_lock in irq_enter().
CPU0 calls free_irq() and eventually gets to the point where
it spins while IRQ_INPROGRESS is set. Since cpu0 is holding
global_irq_lock, cpu1 can't do its work and clear IRQ_INPROGRESS.

I read somewhere that global_irq_lock is deprecated, so is there
something that the serial driver should be doing instead of cli()
and restore_flags() in shutdown()?

