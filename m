Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVGMSEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVGMSEz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVGMSDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:03:34 -0400
Received: from [151.97.230.9] ([151.97.230.9]:13036 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261539AbVGMSA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:00:28 -0400
Subject: [patch 2/9] uml: workaround host bug in "TT mode vs. NPTL link fix"
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Wed, 13 Jul 2005 20:02:15 +0200
Message-Id: <20050713180216.01CA921E732@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A big bug has been diagnosed on hosts running the SKAS patch and built with
CONFIG_REGPARM, due to some missing prevent_tail_call().

On these hosts, this workaround is needed to avoid triggering that bug,
because "to" is kept by GCC only in EBX, which is corrupted at the return of
mmap2().

Since to trigger this bug int 0x80 must be used when doing the call, it rarely
manifests itself, so I'd prefer to get this merged to workaround that host
bug, since it should cause no functional change. Still, you might prefer to
drop it, I'll leave this to you.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-broken-paolo/arch/um/sys-i386/unmap.c   |    2 +-
 linux-2.6.git-broken-paolo/arch/um/sys-x86_64/unmap.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/um/sys-i386/unmap.c~uml-fix-link-tt-mode-against-nptl arch/um/sys-i386/unmap.c
--- linux-2.6.git-broken/arch/um/sys-i386/unmap.c~uml-fix-link-tt-mode-against-nptl	2005-07-13 19:37:10.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/sys-i386/unmap.c	2005-07-13 19:37:32.000000000 +0200
@@ -15,7 +15,7 @@ int switcheroo(int fd, int prot, void *f
 	if(munmap(to, size) < 0){
 		return(-1);
 	}
-	if(mmap2(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) != to){
+	if(mmap2(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1 ){
 		return(-1);
 	}
 	if(munmap(from, size) < 0){
diff -puN arch/um/sys-x86_64/unmap.c~uml-fix-link-tt-mode-against-nptl arch/um/sys-x86_64/unmap.c
--- linux-2.6.git-broken/arch/um/sys-x86_64/unmap.c~uml-fix-link-tt-mode-against-nptl	2005-07-13 19:37:10.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/sys-x86_64/unmap.c	2005-07-13 19:37:32.000000000 +0200
@@ -15,7 +15,7 @@ int switcheroo(int fd, int prot, void *f
 	if(munmap(to, size) < 0){
 		return(-1);
 	}
-	if(mmap(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) != to){
+	if(mmap(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1){
 		return(-1);
 	}
 	if(munmap(from, size) < 0){
_
