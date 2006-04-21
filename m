Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWDUEsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWDUEsv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWDUEoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:44:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:17538 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932253AbWDUEoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:20 -0400
Date: Thu, 20 Apr 2006 21:39:27 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Kirill Korotaev <dev@openvz.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 17/22] IPC: access to unmapped vmalloc area in grow_ary()
Message-ID: <20060421043927.GP12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ipc-access-to-unmapped-vmalloc-area-in-grow_ary.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>

[PATCH] IPC: access to unmapped vmalloc area in grow_ary()

grow_ary() should not copy struct ipc_id_ary (it copies new->p, not
new). Due to this, memcpy() src pointer could hit unmapped vmalloc page
when near page boundary.

Found during OpenVZ stress testing

Signed-off-by: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Signed-off-by: Kirill Korotaev <dev@openvz.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 ipc/util.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.16.9.orig/ipc/util.c
+++ linux-2.6.16.9/ipc/util.c
@@ -182,8 +182,7 @@ static int grow_ary(struct ipc_ids* ids,
 	if(new == NULL)
 		return size;
 	new->size = newsize;
-	memcpy(new->p, ids->entries->p, sizeof(struct kern_ipc_perm *)*size +
-					sizeof(struct ipc_id_ary));
+	memcpy(new->p, ids->entries->p, sizeof(struct kern_ipc_perm *)*size);
 	for(i=size;i<newsize;i++) {
 		new->p[i] = NULL;
 	}

--
