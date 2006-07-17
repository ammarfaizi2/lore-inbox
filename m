Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWGQQnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWGQQnw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWGQQcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:32:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:26042 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750935AbWGQQbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:31:49 -0400
Date: Mon, 17 Jul 2006 09:29:29 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, dev@openvz.org, trond.myklebust@fys.uio.no,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 43/45] struct file leakage
Message-ID: <20060717162929.GR4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="struct-file-leakage.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Kirill Korotaev <dev@sw.ru>

2.6.16 leaks like hell. While testing, I found massive leakage
(reproduced in openvz) in:

*filp
*size-4096

And 1 object leaks in
*size-32
*size-64
*size-128

It is the fix for the first one.  filp leaks in the bowels of namei.c.

Seems, size-4096 is file table leaking in expand_fdtables.

I have no idea what are the rest and why they show only accompanying
another leaks.  Some debugging structs?

[akpm@osdl.org, Trond: remove the IS_ERR() check]
Signed-off-by: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/namei.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- linux-2.6.17.6.orig/fs/namei.c
+++ linux-2.6.17.6/fs/namei.c
@@ -1712,8 +1712,14 @@ do_link:
 	if (error)
 		goto exit_dput;
 	error = __do_follow_link(&path, nd);
-	if (error)
+	if (error) {
+		/* Does someone understand code flow here? Or it is only
+		 * me so stupid? Anathema to whoever designed this non-sense
+		 * with "intent.open".
+		 */
+		release_open_intent(nd);
 		return error;
+	}
 	nd->flags &= ~LOOKUP_PARENT;
 	if (nd->last_type == LAST_BIND)
 		goto ok;

--
