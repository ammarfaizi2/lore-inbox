Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbTJMJfW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 05:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbTJMJfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 05:35:22 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:53633
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261626AbTJMJfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 05:35:16 -0400
Date: Mon, 13 Oct 2003 05:34:55 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6] No swapping on memory backed swapfiles
In-Reply-To: <20031013022441.79c800b6.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0310130525470.28426@montezuma.fsmlabs.com>
References: <Pine.LNX.4.53.0310130354440.28426@montezuma.fsmlabs.com>
 <20031013011117.103de5e7.akpm@osdl.org> <Pine.LNX.4.53.0310130502440.28426@montezuma.fsmlabs.com>
 <20031013022441.79c800b6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Oct 2003, Andrew Morton wrote:

> A non-memory-backed fs may still have a NULL ->readpage though (ncpfs?).
> 
> I do think it best to just test for ->readpage, and give the user the extra
> rope.

Ok, here we go;

Index: linux-2.6.0-test7/mm/swapfile.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test7/mm/swapfile.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 swapfile.c
--- linux-2.6.0-test7/mm/swapfile.c	9 Oct 2003 05:56:12 -0000	1.1.1.1
+++ linux-2.6.0-test7/mm/swapfile.c	13 Oct 2003 09:23:31 -0000
@@ -1318,6 +1318,10 @@ asmlinkage long sys_swapon(const char __
 	/*
 	 * Read the swap header.
 	 */
+	if (!mapping->a_ops->readpage) {
+		error = -EIO;
+		goto bad_swap;
+	}
 	page = read_cache_page(mapping, 0,
 			(filler_t *)mapping->a_ops->readpage, swap_file);
 	if (IS_ERR(page)) {
