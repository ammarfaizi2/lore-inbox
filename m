Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422829AbWJFSdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422829AbWJFSdn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422830AbWJFSdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:33:43 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:35470 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1422829AbWJFSdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:33:43 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 6 Oct 2006 20:33:17 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: ohci1394 regression in 2.6.19-rc1
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bcollins@debian.org, linux1394-devel@lists.sourceforge.net
In-Reply-To: <45268FB1.6080605@s5r6.in-berlin.de>
Message-ID: <tkrat.9af0ae80a84cddfa@s5r6.in-berlin.de>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
 <200610052132.11544.s0348365@sms.ed.ac.uk>
 <4525842F.3040109@s5r6.in-berlin.de>
 <200610052337.17805.s0348365@sms.ed.ac.uk>
 <452593AC.3000406@s5r6.in-berlin.de> <45266042.4060107@s5r6.in-berlin.de>
 <45268FB1.6080605@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair, could you please test the following one-liner on top of
2.6.19-rc1?

-----------------

Date: Fri, 6 Oct 2006 19:49:52 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: ieee1394: nodemgr: fix startup of knodemgrd

Revert a thinko in commit d2f119fe319528da8c76a1107459d6f478cbf28c:
When knodemgrd starts, it needs to sleep until host->generation was
incremented above its initial value of 0.  My wrong logic caused it to
start sending requests when the bus wasn't completely ready.  Seen as
"AT dma reset ctx=0, aborting transmission" messages in 2.6.19-rc1.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c	2006-10-06 19:20:00.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.c	2006-10-06 19:26:28.000000000 +0200
@@ -1614,7 +1614,7 @@ static int nodemgr_host_thread(void *__h
 {
 	struct host_info *hi = (struct host_info *)__hi;
 	struct hpsb_host *host = hi->host;
-	unsigned int g, generation = get_hpsb_generation(host) - 1;
+	unsigned int g, generation = 0;
 	int i, reset_cycles = 0;
 
 	/* Setup our device-model entries */


