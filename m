Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbUCOV4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 16:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUCOV4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 16:56:31 -0500
Received: from ns.suse.de ([195.135.220.2]:3210 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262816AbUCOVzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 16:55:46 -0500
Subject: Re: [PATCH] per-backing dev unplugging #2
From: Chris Mason <mason@suse.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
In-Reply-To: <20040314210907.GA31082@suse.de>
References: <1079121113.4181.189.camel@watt.suse.com>
	 <20040312120322.0108a437.akpm@osdl.org> <20040312200253.GA16880@suse.de>
	 <1079123647.4186.211.camel@watt.suse.com> <20040312203452.GD16880@suse.de>
	 <1079124097.4187.216.camel@watt.suse.com> <20040312205104.GE16880@suse.de>
	 <1079297032.4185.277.camel@watt.suse.com> <20040314204701.GA2649@suse.de>
	 <20040314130437.512f00f2.akpm@osdl.org>  <20040314210907.GA31082@suse.de>
Content-Type: text/plain
Message-Id: <1079387882.4187.708.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 15 Mar 2004 16:58:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmpf, one more.  If one proc does a wait_on_buffer while another does
discard_buffer, bh->b_bdev might be null by the time __wait_on_buffer
uses it.  

Someone hit this with reiserfs, but it should be possible to trigger
anywhere.

-chris

Index: linux.t/fs/buffer.c
===================================================================
--- linux.t.orig/fs/buffer.c	2004-03-15 15:05:38.000000000 -0500
+++ linux.t/fs/buffer.c	2004-03-15 16:49:17.000000000 -0500
@@ -132,7 +132,11 @@ void __wait_on_buffer(struct buffer_head
 	do {
 		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
 		if (buffer_locked(bh)) {
-			blk_run_address_space(bh->b_bdev->bd_inode->i_mapping);
+			struct block_device *bd;
+			smp_mb();
+			bd = bh->b_bdev;
+			if (bd)
+				blk_run_address_space(bd->bd_inode->i_mapping);
 			io_schedule();
 		}
 	} while (buffer_locked(bh));







