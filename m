Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131490AbRCNRu6>; Wed, 14 Mar 2001 12:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131480AbRCNRus>; Wed, 14 Mar 2001 12:50:48 -0500
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:13447 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S131490AbRCNRul>; Wed, 14 Mar 2001 12:50:41 -0500
From: Ulrich.Weigand@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: alan@lxorguk.ukuu.org.uk
cc: linux-kernel@vger.kernel.org
Message-ID: <C1256A0F.0061EC62.00@d12mta11.de.ibm.com>
Date: Wed, 14 Mar 2001 18:49:33 +0100
Subject: Bug in 2.2 update_vm_cache_conditional?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Alan,

there appears to a bug in update_vm_cache_conditional
that manifests itself only on S/390:

update_vm_cache_conditional is called with a source_address
parameter that can either be a kernel or a user space virtual
address, depending on how get_fs() is set.

update_vm_cache_conditional wants to check whether the
source_address is in fact equal to the destination address
in the page cache.  This check should hit only when the
source_address is actually a *kernel* space address; if the
source is a user space address the page cache must always
be updated.

However, update_vm_cache_conditional never checks whether the
address is a kernel address, it does just a
  if ((unsigned long)dest != source_address)

On Intel, this is not a problem, as every user space address
is different from every kernel space address anyway.

On S/390, however, the kernel lives in a separate address space,
so shares the same range of addresses as the user spaces.  This
means that in certain rare cases, this check can accidentally
hit even if the source lives in user space.

This leads to the page cache update being skipped, and the
page cache is inconsistent with the buffer cache afterwards :-(

Do you agree that this is a bug?  What do you think of this fix:

Index: filemap.c
===================================================================
RCS file: /home/cvs/linux/mm/filemap.c,v
retrieving revision 1.3
diff -u -r1.3 filemap.c
--- filemap.c  2000/06/09 19:15:25 1.3
+++ filemap.c  2001/03/14 16:52:29
@@ -252,7 +252,8 @@
          if (page) {
               char *dest = (char*) (offset + page_address(page));

-              if ((unsigned long)dest != source_address) {
+              if (   (unsigned long)dest != source_address
+                            || !segment_eq(get_fs(), KERNEL_DS)) {
                    wait_on_page(page);
                    memcpy(dest, buf, len);
                    flush_dcache_page(page_address(page));


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com


