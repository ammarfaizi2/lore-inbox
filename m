Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbVJ3Psr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbVJ3Psr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVJ3Psr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:48:47 -0500
Received: from cantor.suse.de ([195.135.220.2]:12504 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751063AbVJ3Psq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:48:46 -0500
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: [PATCH] x86_64: Work around Re: 2.6.14-git1 (and -git2) build failure on AMD64
Date: Sun, 30 Oct 2005 16:49:41 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org
References: <16080000.1130681008@[10.10.2.4]>
In-Reply-To: <16080000.1130681008@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510301649.42064.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 October 2005 15:03, Martin J. Bligh wrote:
> CC      arch/x86_64/pci/../../i386/pci/fixup.o
> arch/x86_64/pci/../../i386/pci/fixup.c: In function `pci_fixup_i450nx':
> arch/x86_64/pci/../../i386/pci/fixup.c:13: error: pci_fixup_i450nx causes a section type conflict
> make[1]: *** [arch/x86_64/pci/../../i386/pci/fixup.o] Error 1
> make: *** [arch/x86_64/pci] Error 2
> 
> Config: http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/amd64
> 

I think it's a gcc bug. Anyways, this should work around it.

Linus, can you please apply it?

---

Work around gcc bug that causes build failures like
(exact function it is reported on varies with compiler version and optimization
level) 

> arch/x86_64/pci/../../i386/pci/fixup.c: In function `pci_fixup_i450nx':
> arch/x86_64/pci/../../i386/pci/fixup.c:13: error: pci_fixup_i450nx causes a section type conflict

with !CONFIG_HOTPLUG. It makes the !CONFIG_HOTPLUG case act
like CONFIG_HOTPLUG. This wastes a bit of memory, but is not
too bad.

The sections are legitimate, but gcc somehow gets confused.

Compiling with -O3 seems to also help at least with gcc 4, but I'm
not sure it'll help everything. Splitting up the file might
a different option.

Signed-off-by: Andi Kleen <ak@suse.de> 

diff -u linux-2.6.14-git2/arch/i386/pci/fixup.c-o linux-2.6.14-git2/arch/i386/pci/fixup.c
--- linux-2.6.14-git2/arch/i386/pci/fixup.c-o	2005-10-30 16:09:41.000000000 +0100
+++ linux-2.6.14-git2/arch/i386/pci/fixup.c	2005-10-30 16:42:32.000000000 +0100
@@ -8,6 +8,9 @@
 #include <linux/init.h>
 #include "pci.h"
 
+/* Works around a gcc bug which gets confused with so many section switches */
+#undef __devinit
+#define __devinit
 
 static void __devinit pci_fixup_i450nx(struct pci_dev *d)
 {

