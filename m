Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272691AbTG1HHC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 03:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272694AbTG1HHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 03:07:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:61086 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272691AbTG1HG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 03:06:59 -0400
Date: Mon, 28 Jul 2003 00:22:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Andrey Borzenkov" <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, webvenza@libero.it
Subject: Re: 2.6.0-test1 devfs question
Message-Id: <20030728002216.4c3afb60.akpm@osdl.org>
In-Reply-To: <E19h2CQ-0009YQ-00.arvidjaar-mail-ru@f12.mail.ru>
References: <E19h2CQ-0009YQ-00.arvidjaar-mail-ru@f12.mail.ru>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andrey Borzenkov" <arvidjaar@mail.ru> wrote:
>
> the bug is almost for sure in init/do_mount_devfs.c:read_dir; it
>  allocates static buffer of size at most 2**MAX_ORDER and tries to
>  read the whole dir at once.

Yes, that function is buggy.

diff -puN init/do_mounts_devfs.c~read_dir-fix init/do_mounts_devfs.c
--- 25/init/do_mounts_devfs.c~read_dir-fix	2003-07-28 00:21:40.000000000 -0700
+++ 25-akpm/init/do_mounts_devfs.c	2003-07-28 00:21:40.000000000 -0700
@@ -54,7 +54,7 @@ static void * __init read_dir(char *path
 	if (fd < 0)
 		return NULL;
 
-	for (size = 1 << 9; size <= (1 << MAX_ORDER); size <<= 1) {
+	for (size = 1 << 9; size <= (PAGE_SIZE << MAX_ORDER); size <<= 1) {
 		void *p = kmalloc(size, GFP_KERNEL);
 		int n;
 		if (!p)

_

