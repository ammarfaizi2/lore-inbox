Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWDQLcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWDQLcK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 07:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWDQLcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 07:32:10 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:38262 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750776AbWDQLcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 07:32:09 -0400
Message-ID: <44437E6B.9060605@openvz.org>
Date: Mon, 17 Apr 2006 15:39:23 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       devel@openvz.org
Subject: [PATCH] IPC: access to unmapped vmalloc area in grow_ary()
Content-Type: multipart/mixed;
 boundary="------------020302040904090406080302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020302040904090406080302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

grow_ary() should not copy struct ipc_id_ary (it copies new->p, not 
new). Due to this, memcpy() src pointer could hit unmapped vmalloc page 
when near page boundary.

Found during OpenVZ stress testing

Signed-Off-By: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>

--------------020302040904090406080302
Content-Type: text/plain;
 name="diff-ipc-memcpy-bug-20060413"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ipc-memcpy-bug-20060413"

diff -urp ../git/linux-2.6.16-workgpl/ipc/util.c linux-2.6.16/ipc/util.c
--- ../git/linux-2.6.16-workgpl/ipc/util.c	2006-04-13 16:01:47.000000000 +0400
+++ linux-2.6.16/ipc/util.c	2006-04-13 16:01:05.000000000 +0400
@@ -187,8 +187,7 @@ static int grow_ary(struct ipc_ids* ids,
 	if(new == NULL)
 		return size;
 	new->size = newsize;
-	memcpy(new->p, ids->entries->p, sizeof(struct kern_ipc_perm *)*size +
-					sizeof(struct ipc_id_ary));
+	memcpy(new->p, ids->entries->p, sizeof(struct kern_ipc_perm *)*size);
 	for(i=size;i<newsize;i++) {
 		new->p[i] = NULL;
 	}

--------------020302040904090406080302--

