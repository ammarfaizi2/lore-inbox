Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVCFRzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVCFRzK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 12:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVCFRyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 12:54:50 -0500
Received: from rusty.kulnet.kuleuven.ac.be ([134.58.240.42]:49872 "EHLO
	rusty.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261455AbVCFRv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 12:51:56 -0500
From: "Panagiotis Issaris" <panagiotis.issaris@mech.kuleuven.ac.be>
Date: Sun, 6 Mar 2005 18:51:39 +0100
To: gerg@snapgear.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11-mm1] mtd: fix INFTL failure handling
Message-ID: <20050306175139.GA6192@mech.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The INFTL mount code contains a kmalloc() followed by a memset() without
handling a possible memory allocation failure.

Signed-off-by: <panagiotis.issaris@mech.kuleuven.ac.be>

diff -pruN linux-2.6.11-orig/drivers/mtd/inftlmount.c linux-2.6.11-pi/drivers/mtd/inftlmount.c
--- linux-2.6.11-orig/drivers/mtd/inftlmount.c	2005-03-05 03:08:52.000000000 +0100
+++ linux-2.6.11-pi/drivers/mtd/inftlmount.c	2005-03-06 18:17:15.000000000 +0100
@@ -574,6 +574,12 @@ int INFTL_mount(struct INFTLrecord *s)
 
 	/* Temporary buffer to store ANAC numbers. */
 	ANACtable = kmalloc(s->nb_blocks * sizeof(u8), GFP_KERNEL);
+	if (!ANACtable) {
+		printk(KERN_WARNING "INFTL: allocation of ANACtable "
+				"failed (%zd bytes)\n",
+				s->nb_blocks * sizeof(u8));
+		return -ENOMEM;
+	}
 	memset(ANACtable, 0, s->nb_blocks);
 
 	/*
