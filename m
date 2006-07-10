Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWGJJF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWGJJF4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWGJJF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:05:56 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:17320 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751389AbWGJJFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:05:55 -0400
Message-ID: <44B2185F.1060402@sw.ru>
Date: Mon, 10 Jul 2006 13:05:35 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, devel@openvz.org
Subject: [PATCH] struct file leakage
Content-Type: multipart/mixed;
 boundary="------------010105050408050908010206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010105050408050908010206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello!

Andrew, this is a patch from Alexey Kuznetsov for 2.6.16.
I believe 2.6.17 still has this leak.

-------------------------------------------------------------

2.6.16 leaks like hell. While testing, I found massive leakage
(reproduced in openvz) in:

*filp
*size-4096

And 1 object leaks in
*size-32
*size-64
*size-128


It is the fix for the first one. filp leaks in the bowels
of namei.c.

Seems, size-4096 is file table leaking in expand_fdtables.

I have no idea what are the rest and why they show only
accompaniing another leaks. Some debugging structs?

Signed-Off-By: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
CC: Kirill Korotaev <dev@openvz.org>


--------------010105050408050908010206
Content-Type: text/plain;
 name="diff-namei-leak"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-namei-leak"

--- linux-2.6.16-w/fs/namei.c	2006-07-10 11:43:11.000000000 +0400
+++ linux-2.6.16/fs/namei.c	2006-07-10 11:53:36.000000000 +0400
@@ -1774,8 +1774,15 @@ do_link:
 	if (error)
 		goto exit_dput;
 	error = __do_follow_link(&path, nd);
-	if (error)
+	if (error) {
+		/* Does someone understand code flow here? Or it is only
+		 * me so stupid? Anathema to whoever designed this non-sense
+		 * with "intent.open".
+		 */
+		if (!IS_ERR(nd->intent.open.file))
+			release_open_intent(nd);
 		return error;
+	}
 	nd->flags &= ~LOOKUP_PARENT;
 	if (nd->last_type == LAST_BIND)
 		goto ok;

--------------010105050408050908010206--
