Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbVBCCRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbVBCCRH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 21:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbVBCCRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 21:17:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32898 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262653AbVBCCQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 21:16:44 -0500
Message-Id: <200502030220.j132KFBZ013397@pasta.boston.redhat.com>
To: linux-kernel@vger.kernel.org
cc: Ernie Petrides <petrides@redhat.com>
Subject: [2.6 patch] minor conceptual fix for /proc/kcore header size
Date: Wed, 02 Feb 2005 21:20:15 -0500
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, folks.  While investigating the 2.4 memory corruption problem fixed
by the patch previously posted, it was noticed that the 2.6 version of
get_kcore_size() inappropriately uses sizeof(struct memelfnote) in its
calculation of the /proc/kcore ELF header size.  What is actually stored
in the header is an "elf_note" structure plus the 4 ASCII chars "CORE".

It just so happens that on 32-bit arches, both calculations result in
the same value (16).  But on 64-bit arches, the allocated size (24) is
larger than necessary (16).  This does not result in any possible data
corruption, but it might be nice to correct this "conceptual" error.

Cheers.  -ernie



--- linux-2.6.10/fs/proc/kcore.c.orig	2004-12-24 16:34:58.000000000 -0500
+++ linux-2.6.10/fs/proc/kcore.c	2005-02-02 20:44:13.000000000 -0500
@@ -101,7 +101,7 @@ static size_t get_kcore_size(int *nphdr,
 	}
 	*elf_buflen =	sizeof(struct elfhdr) + 
 			(*nphdr + 2)*sizeof(struct elf_phdr) + 
-			3 * sizeof(struct memelfnote) +
+			3 * (sizeof(struct elf_note) + 4) +
 			sizeof(struct elf_prstatus) +
 			sizeof(struct elf_prpsinfo) +
 			sizeof(struct task_struct);
