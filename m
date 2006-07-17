Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWGQQeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWGQQeK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWGQQeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:34:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:5309 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750989AbWGQQd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:33:59 -0400
Date: Mon, 17 Jul 2006 09:29:39 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, dev@openvz.org, kuznet@ms2.inr.ac.ru,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 45/45] fix fdset leakage
Message-ID: <20060717162939.GT4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-fdset-leakage.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Kirill Korotaev <dev@openvz.org>

When found, it is obvious.  nfds calculated when allocating fdsets is
rewritten by calculation of size of fdtable, and when we are unlucky, we
try to free fdsets of wrong size.

Found due to OpenVZ resource management (User Beancounters).

Signed-off-by: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Signed-off-by: Kirill Korotaev <dev@openvz.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 fs/file.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.17.6.orig/fs/file.c
+++ linux-2.6.17.6/fs/file.c
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

--
