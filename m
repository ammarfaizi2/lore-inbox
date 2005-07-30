Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbVG3TFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbVG3TFg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263108AbVG3TD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:03:59 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:15782 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S263107AbVG3TCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:02:50 -0400
Subject: [patch 1/1] sys_get_thread_area does not clear the returned argument
To: stable@kernel.org
Cc: linux-kernel@vger.kernel.org, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Sat, 30 Jul 2005 21:07:02 +0200
Message-Id: <20050730190703.233BB843@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Blaisorblade <blaisorblade@yahoo.it>
CC: <stable@kernel.org>

sys_get_thread_area does not memset to 0 its struct user_desc info before
copying it to user space...  since sizeof(struct user_desc) is 16 while the
actual datas which are filled are only 12 bytes + 9 bits (across the
bitfields), there is a (small) information leak.

This was already committed to Linus' repository.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 vanilla-linux-2.6.12-paolo/arch/i386/kernel/process.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN arch/i386/kernel/process.c~sec-micro-info-leak arch/i386/kernel/process.c
--- vanilla-linux-2.6.12/arch/i386/kernel/process.c~sec-micro-info-leak	2005-07-28 21:19:26.000000000 +0200
+++ vanilla-linux-2.6.12-paolo/arch/i386/kernel/process.c	2005-07-28 21:19:26.000000000 +0200
@@ -827,6 +827,8 @@ asmlinkage int sys_get_thread_area(struc
 	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
 		return -EINVAL;
 
+	memset(&info, 0, sizeof(info));
+
 	desc = current->thread.tls_array + idx - GDT_ENTRY_TLS_MIN;
 
 	info.entry_number = idx;
_
