Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261668AbSIXNaE>; Tue, 24 Sep 2002 09:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261669AbSIXNaE>; Tue, 24 Sep 2002 09:30:04 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:57092 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S261668AbSIXNaD>; Tue, 24 Sep 2002 09:30:03 -0400
Date: Tue, 24 Sep 2002 23:34:49 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Andrew Morton <akpm@digeo.com>
cc: Steven Cole <scole@lanl.gov>, lkml <linux-kernel@vger.kernel.org>,
       <netfilter-devel@lists.netfilter.org>,
       Harald Welte <laforge@gnumonks.org>
Subject: Re: Sleeping function called from illegal context at slab.c:1378
In-Reply-To: <3D8F5DB2.A3E36E16@digeo.com>
Message-ID: <Mutt.LNX.4.44.0209242331430.1239-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2002, Andrew Morton wrote:

> That's a bug in ip_fw_ctl().  It's calling convert_ipfw()
> inside FWC_WRITE_LOCK_IRQ(&ip_fw_lock, flags);
> 
> But convert_ipfw() does kmalloc(GFP_KERNEL).
> 

Below a patch to correct this. The bug is also present in 2.2 and 2.4 
(patches to follow on netfilter-devel).

- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -urN -X dontdiff linux-2.5.38.orig/net/ipv4/netfilter/ipchains_core.c linux-2.5.38.w1/net/ipv4/netfilter/ipchains_core.c
--- linux-2.5.38.orig/net/ipv4/netfilter/ipchains_core.c	Tue Sep 10 09:43:30 2002
+++ linux-2.5.38.w1/net/ipv4/netfilter/ipchains_core.c	Tue Sep 24 23:09:50 2002
@@ -1252,7 +1252,7 @@
 		return NULL;
 	}
 
-	fwkern = kmalloc(SIZEOF_STRUCT_IP_FW_KERNEL, GFP_KERNEL);
+	fwkern = kmalloc(SIZEOF_STRUCT_IP_FW_KERNEL, GFP_ATOMIC);
 	if (!fwkern) {
 		duprintf("convert_ipfw: kmalloc failed!\n");
 		*errno = ENOMEM;

