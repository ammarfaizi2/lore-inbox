Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWFMPhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWFMPhg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 11:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWFMPhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 11:37:36 -0400
Received: from the-doors.enix.org ([193.19.211.1]:56493 "EHLO
	the-doors.enix.org") by vger.kernel.org with ESMTP id S932140AbWFMPhf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 11:37:35 -0400
Date: Tue, 13 Jun 2006 17:37:33 +0200
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Use of spinlock after free with CFQ scheduler
Message-ID: <20060613173733.618192bf@thomas.toulouse>
X-Mailer: Sylpheed-Claws 2.2.0 (GTK+ 2.8.3; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While developing a block device driver, we stumbled upon the kernel
panic reported at
http://www.ussg.iu.edu/hypermail/linux/kernel/0512.3/0297.html.
According to the mail and your answer, it seems that the CFQ scheduler
uses the queue lock after blk_cleanup_queue(). At this time, the
spinlock might have been freed. I can confirm that the bug doesn't
appear with other I/O schedulers.

However, the proposed fix for "ub" looks quite strange to me. It uses
a static array of spinlocks, so that they remain in memory after
blk_cleanup_queue(). However, "ub" can be compiled as a module, so I
don't see what prevent the use of the queue spinlocks by the CFQ
scheduler once the module has been unloaded. I do not understand how the
provided patch correctly fixes the bug.

The bug was reported on a pre-2.6.15 kernel, but we're still seeing
this bug with a 2.6.16 FedoraCore-hacked kernel.

To me, the bug seems to be in the CFQ scheduler itself, isn't it ?
Maybe we should use the internal queue lock (by passing NULL as the
lock parameter to the blk_init_queue() call), and then modify the CFQ
scheduler so that it correctly increments/decrements the queue->refcnt ?

What do you think about it ?

Thanks!

Thomas
-- 
Thomas Petazzoni - thomas.petazzoni@enix.org
http://{thomas,sos,kos}.enix.org - http://www.toulibre.org
http://www.{livret,agenda}dulibre.org
