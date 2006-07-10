Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbWGJNlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWGJNlS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbWGJNlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:41:18 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:13096 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964912AbWGJNlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:41:18 -0400
Message-ID: <44B258E3.7070708@openvz.org>
Date: Mon, 10 Jul 2006 17:40:51 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: [PATCH] fdset's leakage
Content-Type: multipart/mixed;
 boundary="------------080705040507060402090106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080705040507060402090106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

Another patch from Alexey Kuznetsov fixing memory leak in alloc_fdtable().

[PATCH] fdset's leakage

When found, it is obvious. nfds calculated when allocating fdsets
is rewritten by calculation of size of fdtable, and when we are
unlucky, we try to free fdsets of wrong size.

Found due to OpenVZ resource management (User Beancounters).

Signed-Off-By: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>


--------------080705040507060402090106
Content-Type: text/plain;
 name="diff-fdset-leakage"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-fdset-leakage"

diff -urp linux-2.6-orig/fs/file.c linux-2.6/fs/file.c
--- linux-2.6-orig/fs/file.c	2006-07-10 12:10:51.000000000 +0400
+++ linux-2.6/fs/file.c	2006-07-10 14:47:01.000000000 +0400
@@ -277,11 +277,13 @@ static struct fdtable *alloc_fdtable(int
 	} while (nfds <= nr);
 	new_fds = alloc_fd_array(nfds);
 	if (!new_fds)
-		goto out;
+		goto out2;
 	fdt->fd = new_fds;
 	fdt->max_fds = nfds;
 	fdt->free_files = NULL;
 	return fdt;
+out2:
+	nfds = fdt->max_fdset;
 out:
   	if (new_openset)
   		free_fdset(new_openset, nfds);

--------------080705040507060402090106--
