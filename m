Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbUBYPbV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 10:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbUBYPbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 10:31:21 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:44996 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261360AbUBYPbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 10:31:15 -0500
Date: Wed, 25 Feb 2004 16:31:26 +0100
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jean-Luc Cooke <jlcooke@certainkey.com>, jmorris@intercode.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: cryptoapi highmem bug
Message-ID: <20040225153126.GA7395@leto.cs.pocnet.net>
References: <1077655754.14858.0.camel@leto.cs.pocnet.net> <20040224223425.GA32286@certainkey.com> <1077663682.6493.1.camel@leto.cs.pocnet.net> <20040225043209.GA1179@certainkey.com> <20040224220030.13160197.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224220030.13160197.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 10:00:30PM -0800, Andrew Morton wrote:

> I don't think there is a practical way of doing this.  It would involve
> comparing the virtual address with the kmap and atomic kmap regions,
> performing a pagetable walk, extracting the pageframe.  If the page is not
> in a kmap area generate the pageframe directly.  Make that work on all
> architectures.  Very yuk.

We could also "simply" avoid to map the same page twice. My first idea
turned out slightly more complicated than I expected but works.

It's just a proof of concept though, it would be less complicated if we
would just pass the other walk struct to the functions that take one
and let them do the checking (no need to disable preemption and use
per cpu variables). Hmm.


--- linux-2.6.3/crypto/cipher.c	2004-02-25 13:49:53.000000000 +0100
+++ linux-2.6.3.test/crypto/cipher.c	2004-02-25 16:23:53.094207712 +0100
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/crypto.h>
 #include <linux/errno.h>
+#include <linux/percpu.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
@@ -42,6 +43,14 @@
 	KM_SOFTIRQ1,
 };
 
+struct kmapped_page {
+	struct page	*page;
+	void		*vaddr;
+	int		out;
+};
+
+static DEFINE_PER_CPU(struct kmapped_page[4], kmapped_pages);
+
 static inline void xor_64(u8 *a, const u8 *b)
 {
 	((u32 *)a)[0] ^= ((u32 *)b)[0];
@@ -64,7 +73,7 @@
 	return sg + 1;
 }
 
-void *which_buf(struct scatter_walk *walk, unsigned int nbytes, void *scratch)
+static void *which_buf(struct scatter_walk *walk, unsigned int nbytes, void *scratch)
 {
 	if (nbytes <= walk->len_this_page &&
 	    (((unsigned long)walk->data) & (PAGE_CACHE_SIZE - 1)) + nbytes <=
@@ -98,7 +107,38 @@
 
 static void scatterwalk_map(struct scatter_walk *walk, int out)
 {
-	walk->data = crypto_kmap(walk->page, out) + walk->offset;
+	struct kmapped_page *kmaps;
+	int idx = (in_softirq() ? 2 : 0) + out;
+	void *vaddr;
+
+	preempt_disable();
+	kmaps = __get_cpu_var(kmapped_pages);
+
+	if (kmaps[idx ^ 1].page == walk->page) {
+		vaddr = kmaps[idx ^ 1].vaddr;
+		out = kmaps[idx ^ 1].out;
+	} else
+		vaddr = crypto_kmap(walk->page, out);
+
+	kmaps[idx].page = walk->page;
+	kmaps[idx].vaddr = vaddr;
+	kmaps[idx].out = out;
+
+	walk->data = vaddr + walk->offset;
+}
+
+static void scatterwalk_unmap(void *vaddr, int out)
+{
+	struct kmapped_page *kmaps = __get_cpu_var(kmapped_pages);
+	int idx = (in_softirq() ? 2 : 0) + out;
+
+	if (kmaps[idx ^ 1].page != kmaps[idx].page)
+		crypto_kunmap(vaddr, kmaps[idx].out);
+
+	kmaps[idx].page = NULL;
+	kmaps[idx].vaddr = NULL;
+
+	preempt_enable();
 }
 
 static void scatter_page_done(struct scatter_walk *walk, int out,
@@ -127,7 +167,7 @@
 
 static void scatter_done(struct scatter_walk *walk, int out, int more)
 {
-	crypto_kunmap(walk->data, out);
+	scatterwalk_unmap(walk->data, out);
 	if (walk->len_this_page == 0 || !more)
 		scatter_page_done(walk, out, more);
 }
@@ -145,7 +185,7 @@
 			buf += walk->len_this_page;
 			nbytes -= walk->len_this_page;
 
-			crypto_kunmap(walk->data, out);
+			scatterwalk_unmap(walk->data, out);
 			scatter_page_done(walk, out, 1);
 			scatterwalk_map(walk, out);
 		}
