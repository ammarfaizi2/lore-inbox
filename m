Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265614AbTIJT6f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265624AbTIJT6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:58:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46306 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265614AbTIJT6d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:58:33 -0400
Date: Wed, 10 Sep 2003 20:58:31 +0100
From: Matthew Wilcox <willy@debian.org>
To: Felipe W Damasio <felipewd@terra.com.br>, Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk API update (and bug fix) to CDU535 cdrom driver
Message-ID: <20030910195831.GD21596@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This cli-sti removal seems exactly as broken as all the ones i've NAKed on
kernel-janitors.  There's no evidence that I can see for locking in the
interrupt handler.  Here's a race example:

CPU 1				CPU 2
sony_sleep();
spin_lock_irq(&sonycd535_lock);
enable_interrupts();
				cdu535_interrupt();
				disable_interrupts();
				if (waitqueue_active(&cdu535_irq_wait)) {

prepare_to_wait(&cdu535_irq_wait, &wait, TASK_INTERRUPTIBLE);
spin_unlock_irq(&sonycd535_lock);

Either you need to move prepare_to_wait before enable_interrupts or
grab the sonycd535_lock in interrupt context.

Hang on a minute.  This driver is always polled, and never interrupt
driven.  There's no problem because this code path is never executed :-P
Nevertheless, it's probaby worth fixing so other more complex drivers
(eg cdu31a) don't copy it wrongly.

BTW, I bet sony_sleep() shouldn't be calling the new-and-improved yield().

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
