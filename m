Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbVIVMLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbVIVMLu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 08:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbVIVMLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 08:11:50 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:6638 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id S1030273AbVIVMLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 08:11:49 -0400
Message-ID: <43329F6E.3030706@cosmosbay.com>
Date: Thu, 22 Sep 2005 14:11:26 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
References: <43308324.70403@cosmosbay.com> <4331CFA7.50104@cosmosbay.com> <Pine.LNX.4.62.0509211542210.13045@schroedinger.engr.sgi.com> <20050921.173408.122945960.davem@davemloft.net> <Pine.LNX.4.62.0509211843530.13764@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0509211843530.13764@schroedinger.engr.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------030303090803010202030802"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 22 Sep 2005 14:11:27 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030303090803010202030802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Christoph Lameter a écrit :
> On Wed, 21 Sep 2005, David S. Miller wrote:
> 
> 
>>From: Christoph Lameter <clameter@engr.sgi.com>
>>Date: Wed, 21 Sep 2005 15:43:29 -0700 (PDT)
>>
>>
>>>Maybe we better introduce vmalloc_node() instead of improvising this for 
>>>several subsystems? The e1000 driver has similar issues.
>>
>>I agree.
> 
> 
> I did an implementation in June.
> 
> See http://marc.theaimsgroup.com/?l=linux-mm&m=111766643127530&w=2
> 
> Not sure if this will fit the bill. Never really tested it.


Maybe this simpler patch has more chances to be accepted ?

Thank you

[NUMA]

- Adds a vmalloc_node() function : A simple wrapper around vmalloc() to 
allocate memory from a preferred node.

This NUMA aware variant will be used by ip_tables and various network drivers.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--------------030303090803010202030802
Content-Type: text/plain;
 name="vmalloc_node"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vmalloc_node"

--- linux-2.6.14-rc2/include/linux/vmalloc.h	2005-09-20 05:00:41.000000000 +0200
+++ linux-2.6.14-rc2-ed/include/linux/vmalloc.h	2005-09-22 11:34:55.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef _LINUX_VMALLOC_H
 #define _LINUX_VMALLOC_H
 
+#include <linux/config.h>	/* vmalloc_node() needs CONFIG_ options */
 #include <linux/spinlock.h>
 #include <asm/page.h>		/* pgprot_t */
 
@@ -32,6 +33,14 @@
  *	Highlevel APIs for driver use
  */
 extern void *vmalloc(unsigned long size);
+#ifdef CONFIG_NUMA
+extern void *vmalloc_node(unsigned long size, int node);
+#else
+static inline void *vmalloc_node(unsigned long size, int node)
+{
+	return vmalloc(size);
+}
+#endif
 extern void *vmalloc_exec(unsigned long size);
 extern void *vmalloc_32(unsigned long size);
 extern void *__vmalloc(unsigned long size, unsigned int __nocast gfp_mask, pgprot_t prot);
--- linux-2.6.14-rc2/mm/vmalloc.c	2005-09-20 05:00:41.000000000 +0200
+++ linux-2.6.14-rc2-ed/mm/vmalloc.c	2005-09-22 11:55:19.000000000 +0200
@@ -19,6 +19,9 @@
 #include <asm/uaccess.h>
 #include <asm/tlbflush.h>
 
+#ifdef CONFIG_NUMA
+#include <linux/mempolicy.h>
+#endif
 
 DEFINE_RWLOCK(vmlist_lock);
 struct vm_struct *vmlist;
@@ -471,7 +474,7 @@
  *	Allocate enough pages to cover @size from the page level
  *	allocator and map them into contiguous kernel virtual space.
  *
- *	For tight cotrol over page level allocator and protection flags
+ *	For tight control over page level allocator and protection flags
  *	use __vmalloc() instead.
  */
 void *vmalloc(unsigned long size)
@@ -481,6 +484,40 @@
 
 EXPORT_SYMBOL(vmalloc);
 
+#ifdef CONFIG_NUMA
+/**
+ * vmalloc_node - allocate virtually contiguous memory
+ *
+ *	@size:		allocation size
+ *	@node:		preferred node
+ *
+ * This vmalloc variant try to allocate memory from a preferred node.
+ */
+void *vmalloc_node(unsigned long size, int node)
+{
+	void *result;
+	struct mempolicy *oldpol = current->mempolicy;
+	mm_segment_t oldfs = get_fs();
+	DECLARE_BITMAP(prefnode, MAX_NUMNODES);
+
+	mpol_get(oldpol);
+	bitmap_zero(prefnode, MAX_NUMNODES);
+	set_bit(node, prefnode);
+
+	set_fs(KERNEL_DS);
+	sys_set_mempolicy(MPOL_PREFERRED, prefnode, MAX_NUMNODES);
+	set_fs(oldfs);
+
+	result = vmalloc(size);
+
+	mpol_free(current->mempolicy);
+	current->mempolicy = oldpol;
+	return result;
+}
+
+EXPORT_SYMBOL(vmalloc_node);
+#endif
+
 #ifndef PAGE_KERNEL_EXEC
 # define PAGE_KERNEL_EXEC PAGE_KERNEL
 #endif

--------------030303090803010202030802--
