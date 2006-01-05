Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWAENuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWAENuH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 08:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWAENuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 08:50:07 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:22668 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751271AbWAENuF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 08:50:05 -0500
Message-ID: <43BD2406.2040007@cosmosbay.com>
Date: Thu, 05 Jan 2006 14:49:58 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] reduce sizeof(percpu_data) and removes dependance against
 NR_CPUS
References: <1135251766.3557.13.camel@pmac.infradead.org> <20060105021929.498f45ef.akpm@osdl.org>
In-Reply-To: <20060105021929.498f45ef.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------070908000401030906070201"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 05 Jan 2006 14:49:59 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070908000401030906070201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew

Current sizeof(percpu_data) is NR_CPUS*sizeof(void *)

This trivial patch makes percpu_data real size depends on 
highest_possible_processor_id() instead of NR_CPUS

percpu_data allocations are not performance critical, we can spend few CPU 
cycles and save some ram.

This patch should replace remove-unused-blkp-field-in-percpu_data.patch in mm tree

Thank you

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------070908000401030906070201
Content-Type: text/plain;
 name="shrink_percpu_data.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="shrink_percpu_data.patch"

--- linux-2.6.15/include/linux/percpu.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-edum/include/linux/percpu.h	2006-01-05 14:45:48.000000000 +0100
@@ -18,8 +18,7 @@
 #ifdef CONFIG_SMP
 
 struct percpu_data {
-	void *ptrs[NR_CPUS];
-	void *blkp;
+	void *ptrs[1]; /* real size depends on highest_possible_processor_id() */
 };
 
 /* 
--- linux-2.6.15/mm/slab.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-edum/mm/slab.c	2006-01-05 14:37:13.000000000 +0100
@@ -2949,7 +2949,8 @@
 void *__alloc_percpu(size_t size, size_t align)
 {
 	int i;
-	struct percpu_data *pdata = kmalloc(sizeof (*pdata), GFP_KERNEL);
+	size_t pdsize = highest_possible_processor_id() * sizeof(void *);
+	struct percpu_data *pdata = kmalloc(pdsize, GFP_KERNEL);
 
 	if (!pdata)
 		return NULL;

--------------070908000401030906070201--
