Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVCUJvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVCUJvT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 04:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVCUJvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 04:51:17 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:10646 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261721AbVCUJua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 04:50:30 -0500
To: linux-kernel@vger.kernel.org
cc: Keir.Fraser@cl.cam.ac.uk
Subject: Suspected bug in floppy.c
Date: Mon, 21 Mar 2005 09:50:29 +0000
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1DDJYL-0008BW-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think I may have uncovered a bug in the floppy driver while getting
it to work on Xen. The problem is that vfree() may get called in
softirq context, via the following backtrace:

 vfree
 fd_dma_mem_free
 floppy_release_irq_and_dma
 set_dor
 motor_off_callback 

On native i386, this would normally happen only if the driver has
entered virtual dma mode; usually it uses free_pages() which is safe
from irq context. On Xen we always PIO, so this triggered rather
easily. I'd have thought it would for architectures like m68k as well
(also only does virtual dma).

For now I'll fix it by doing __get_free_pages/free_pages, but I wonder
if the grab/release calls in floppy.c should be deferred on a work
queue or something like that?

 -- Keir
