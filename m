Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263229AbUEWSRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbUEWSRQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 14:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263231AbUEWSRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 14:17:16 -0400
Received: from cantor.suse.de ([195.135.220.2]:20962 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263229AbUEWSRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 14:17:14 -0400
Date: Sun, 23 May 2004 20:17:13 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] handle 512 byte aligned gzip headers
Message-ID: <20040523181713.GA17359@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This one is from Al, maybe he sent it already. Some compressed initramfs
cpio archive cant be uncompressed with current kernels.

 <viro>  olh: what happens does happen when the end of final header is well-aligned
 <viro>  olh: cpio does pad the sucker otherwise and that's enough to mask the bug in do_skip()
 <viro>  olh: if the end of header is on a multiple of 512, as it is in your case, it _is_ the last thing gunzip shoves into window
 <viro>  olh: and there's nothing past it
 <viro>  olh: fix is trivial - in do_skip() replace <= with <

diff -purNX /tmp/kernel_exclude.txt linux-2.6.7-rc1.orig/init/initramfs.c linux-2.6.7-rc1/init/initramfs.c
--- linux-2.6.7-rc1.orig/init/initramfs.c	2004-05-10 02:31:59.000000000 +0000
+++ linux-2.6.7-rc1/init/initramfs.c	2004-05-23 17:44:45.000000000 +0000
@@ -207,7 +207,7 @@ static int __init do_header(void)
 
 static int __init do_skip(void)
 {
-	if (this_header + count <= next_header) {
+	if (this_header + count < next_header) {
 		eat(count);
 		return 1;
 	} else {
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
