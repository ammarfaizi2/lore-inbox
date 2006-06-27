Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWF0SFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWF0SFw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWF0SFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:05:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38322 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932488AbWF0SFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:05:52 -0400
Date: Tue, 27 Jun 2006 11:05:46 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [ZVC 4/4] Inline counters for single processor configurations
In-Reply-To: <20060627174607.11172.28265.sendpatchset@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0606271104260.11380@schroedinger.engr.sgi.com>
References: <20060627174551.11172.49700.sendpatchset@schroedinger.engr.sgi.com>
 <20060627174607.11172.28265.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm.. i386/x86_64 do not convert the adds to incs like ia64. Therefore 
one can decrease memory usage even further by using atomic_inc/dec 
explicitly.

Index: linux-2.6.17-mm3/include/linux/vmstat.h
===================================================================
--- linux-2.6.17-mm3.orig/include/linux/vmstat.h	2006-06-27 03:53:05.000000000 -0700
+++ linux-2.6.17-mm3/include/linux/vmstat.h	2006-06-27 03:54:16.000000000 -0700
@@ -186,12 +186,14 @@
 
 static inline void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
 {
-	zone_page_state_add(1, page_zone(page), item);
+	atomic_long_inc(&page_zone(page)->vm_stat[item]);
+	atomic_long_inc(&vm_stat[item]);
 }
 
 static inline void __dec_zone_page_state(struct page *page, enum zone_stat_item item)
 {
-	zone_page_state_add(-1, page_zone(page), item);
+	atomic_long_dec(&page_zone(page)->vm_stat[item]);
+	atomic_long_dec(&vm_stat[item]);
 }
 
 /*
