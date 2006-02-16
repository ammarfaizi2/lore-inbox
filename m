Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbWBPKVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbWBPKVJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 05:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWBPKVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 05:21:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59913 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030413AbWBPKVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 05:21:07 -0500
Date: Thu, 16 Feb 2006 10:20:56 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: SMP BUG
Message-ID: <20060216102056.GA24741@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Hubertus Franke <frankeh@watson.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <43F12207.9010507@watson.ibm.com> <20060215230701.GD1508@flint.arm.linux.org.uk> <Pine.LNX.4.64.0602151521320.22082@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602151521320.22082@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 03:23:02PM -0800, Linus Torvalds wrote:
> Does this fix the ARM oops?

It fixes that exact oops but only by preventing us getting that far
due to another oops.

We call cpu_up, which sends a CPU_UP_PREPARE event.  This causes the
migration thread to be spawned, and rq->migration_thread to be set.

Eventually, we call the architecture __cpu_up(), which ends up
calling init_idle().  Due to this patch, init_idle() then NULLs out
rq->migration_thread.

Later, we send a CPU_ONLINE event, which then tries to do
wake_up_process(rq->migration_thread) - resulting in a NULL pointer
deref in try_to_wake_up().

Hence, with this patch, it looks like rq will be used prior to
initialisation.  I could try commenting out the migration_thread
initialisation to NULL, but I suspect that there may be other
problems associated with this patch (eg, rq->migration_queue).

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
