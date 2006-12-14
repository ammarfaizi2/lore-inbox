Return-Path: <linux-kernel-owner+w=401wt.eu-S932655AbWLNT6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655AbWLNT6r (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 14:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbWLNT6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 14:58:47 -0500
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:60884 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932655AbWLNT6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 14:58:46 -0500
Date: Thu, 14 Dec 2006 14:58:42 -0500
From: Kyle McMartin <kyle@ubuntu.com>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Meelis Roos <mroos@linux.ee>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: V4L2: __ucmpdi2 undefined on ppc
Message-ID: <20061214195842.GA14041@athena.road.mcmartin.ca>
References: <Pine.SOC.4.61.0612131359430.10721@math.ut.ee> <1166053317.909.19.camel@praia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166053317.909.19.camel@praia>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 09:41:56PM -0200, Mauro Carvalho Chehab wrote:
> Argh! if this is caused by switch / ifs, compilation will fail on other
> places.
> 

I posted a patch to Paul this week to fix this, as saw we saw it on
Ubuntu's powerpc kernel builds.

Since ppc32 can't do a 64bit comparison on its own it seems, gcc
will generate a call to a helper function from libgcc. What other
arches do is link libgcc.a into libs-y, and export the symbol
they want from it. The build process will discard the rest of the
.a that is unused. parisc uses this method, for example.

Gcc targets can provide optimized versions of these helpers in
assembly, but at least in this case, the generic C version seems
to be used everywhere. It might be useful to provide kernel local
copies of these C versions linked __weak or something if the
arch happens to need them.

(Not going to sign off or anything, since I've already sent it to
paulus@ and I don't want it to get merged without his approval...)

Cheers,
	Kyle

---
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a00fe72..5b60c05 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -139,6 +139,8 @@ core-$(CONFIG_XMON)		+= arch/powerpc/xmon/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
+libs-y				+= `$(CC) -print-libgcc-file-name`
+
 # Default to zImage, override when needed
 defaultimage-y			:= zImage
 defaultimage-$(CONFIG_PPC_ISERIES) := vmlinux
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 9179f07..dea8384 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -164,6 +164,9 @@ long long __lshrdi3(long long, int);
 EXPORT_SYMBOL(__ashrdi3);
 EXPORT_SYMBOL(__ashldi3);
 EXPORT_SYMBOL(__lshrdi3);
+
+extern void __ucmpdi2(void);
+EXPORT_SYMBOL(__ucmpdi2);
 #endif
 
 EXPORT_SYMBOL(memcpy);
