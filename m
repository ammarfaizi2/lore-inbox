Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWB1U7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWB1U7G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 15:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWB1U7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 15:59:05 -0500
Received: from the.earth.li ([193.201.200.66]:21446 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S932554AbWB1U7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 15:59:04 -0500
Date: Tue, 28 Feb 2006 20:59:03 +0000
From: Jonathan McDowell <noodles@earth.li>
To: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Make nand block functions use provided byte/word helpers.
Message-ID: <20060228205903.GZ14749@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I've been writing a NAND driver for the flash on the Amstrad E3. One of
the peculiarities of this device is that the write & read enable lines
are on a latch, rather than strobed by the act of reading/writing from
the data latch. As such I've got custom read_byte/write_byte functions
defined. However the nand_*_buf functions in drivers/mtd/nand/nand_base.c
are all appropriate, except for the fact they call readb/writeb
themselves, instead of using this->read_byte or this->write_byte. The
patch below changes them to use these functions, meaning a driver just
needs to define read_byte and write_byte functions and gains all the
nand_*_buf functions free.

Signed-off-by: Jonathan McDowell <noodles@earth.li>


----------
--- linux-2.6.15/drivers/mtd/nand/nand_base.c.orig	2006-02-28 20:41:54.000000000 +0000
+++ linux-2.6.15/drivers/mtd/nand/nand_base.c	2006-02-28 20:46:44.000000000 +0000
@@ -302,7 +302,7 @@ static void nand_write_buf(struct mtd_in
 	struct nand_chip *this = mtd->priv;
 
 	for (i=0; i<len; i++)
-		writeb(buf[i], this->IO_ADDR_W);
+		this->write_byte(mtd, buf[i]);
 }
 
 /**
@@ -319,7 +319,7 @@ static void nand_read_buf(struct mtd_inf
 	struct nand_chip *this = mtd->priv;
 
 	for (i=0; i<len; i++)
-		buf[i] = readb(this->IO_ADDR_R);
+		buf[i] = this->read_byte(mtd);
 }
 
 /**
@@ -336,7 +336,7 @@ static int nand_verify_buf(struct mtd_in
 	struct nand_chip *this = mtd->priv;
 
 	for (i=0; i<len; i++)
-		if (buf[i] != readb(this->IO_ADDR_R))
+		if (buf[i] != this->read_byte(mtd))
 			return -EFAULT;
 
 	return 0;
@@ -358,7 +358,7 @@ static void nand_write_buf16(struct mtd_
 	len >>= 1;
 
 	for (i=0; i<len; i++)
-		writew(p[i], this->IO_ADDR_W);
+		this->write_word(mtd, p[i]);
 
 }
 
@@ -378,7 +378,7 @@ static void nand_read_buf16(struct mtd_i
 	len >>= 1;
 
 	for (i=0; i<len; i++)
-		p[i] = readw(this->IO_ADDR_R);
+		p[i] = this->read_word(mtd);
 }
 
 /**
@@ -397,7 +397,7 @@ static int nand_verify_buf16(struct mtd_
 	len >>= 1;
 
 	for (i=0; i<len; i++)
-		if (p[i] != readw(this->IO_ADDR_R))
+		if (p[i] != this->read_word(mtd))
 			return -EFAULT;
 
 	return 0;
----------

J.

-- 
 [   There are always at least two ways to program the same thing.    ]
 [ http://www.blackcatnetworks.co.uk/ - IPv6 enabled ADSL/dialup/colo ]
