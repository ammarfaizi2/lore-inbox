Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVCVPZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVCVPZk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 10:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVCVPZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 10:25:40 -0500
Received: from colin2.muc.de ([193.149.48.15]:1294 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261400AbVCVPYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 10:24:50 -0500
Date: 22 Mar 2005 16:24:42 +0100
Date: Tue, 22 Mar 2005 16:24:42 +0100
From: Andi Kleen <ak@muc.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [BUG?] x86_64 : Can not read /dev/kmem ?
Message-ID: <20050322152442.GA73893@muc.de>
References: <42348474.7040808@aknet.ru> <20050313201020.GB8231@elf.ucw.cz> <4234A8DD.9080305@aknet.ru> <Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org> <Pine.LNX.4.58.0503131614360.2822@ppc970.osdl.org> <423518A7.9030704@aknet.ru> <m14qfey3iz.fsf@muc.de> <4235695F.5070203@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4235695F.5070203@cosmosbay.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 11:37:19AM +0100, Eric Dumazet wrote:
> 
> Hi Andi
> 
> I tried to mmap /dev/kmem on x86_64 (linux-2.6.11) and got no success.
> 

Here's a patch that fixes the problem to me.


Fix mmap of /dev/kmem. It cannot ever have worked before.

vmalloc is still not supported because that would be more
complicated.

Signed-off-by: Andi Kleen <ak@suse.de>


diff -u linux-2.6.11/drivers/char/mem.c-o linux-2.6.11/drivers/char/mem.c
--- linux-2.6.11/drivers/char/mem.c-o	2004-12-24 22:34:47.000000000 +0100
+++ linux-2.6.11/drivers/char/mem.c	2005-03-22 12:36:33.852319000 +0100
@@ -211,6 +211,23 @@
 	return 0;
 }
 
+static int mmap_kmem(struct file * file, struct vm_area_struct * vma)
+{
+        unsigned long long val;
+	/* 
+	 * RED-PEN: on some architectures there is more mapped memory
+	 * than available in mem_map which pfn_valid checks
+	 * for. Perhaps should add a new macro here.
+	 * 
+	 * RED-PEN: vmalloc is not supported right now. 
+	 */
+	if (!pfn_valid(vma->vm_pgoff))
+		return -EIO;
+	val = (u64)vma->vm_pgoff << PAGE_SHIFT;
+	vma->vm_pgoff = __pa(val) >> PAGE_SHIFT; 
+	return mmap_mem(file, vma);
+}
+
 extern long vread(char *buf, char *addr, unsigned long count);
 extern long vwrite(char *buf, char *addr, unsigned long count);
 
@@ -567,7 +584,6 @@
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
 
-#define mmap_kmem	mmap_mem
 #define zero_lseek	null_lseek
 #define full_lseek      null_lseek
 #define write_zero	write_null
