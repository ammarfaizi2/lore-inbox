Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756821AbWK0FDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756821AbWK0FDe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 00:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756834AbWK0FDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 00:03:34 -0500
Received: from nz-out-0102.google.com ([64.233.162.199]:46228 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1756821AbWK0FDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 00:03:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=QJQ+8SzS/y862qbXIkc3uz+kvkj75Rpv+/CLsftuRstgXoPrG1B79H43IuRbYtVTjrHgUp0abhvPvfyLzMziA10l52Z5YUAzv3Xl1vD9Xg6YKoB3Tzx2Ui75hDuRUsn47SdAgNZlEUHEfd8fm/oSOJ7FCpszmbzS/iceHfhxTAw=
Date: Mon, 27 Nov 2006 13:56:24 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] futex: init error ckeck
Message-ID: <20061127045624.GB1231@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch checks register_filesystem() and kern_mount() return
values.

Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 kernel/futex.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: work-fault-inject/kernel/futex.c
===================================================================
--- work-fault-inject.orig/kernel/futex.c
+++ work-fault-inject/kernel/futex.c
@@ -1857,10 +1857,16 @@ static struct file_system_type futex_fs_
 
 static int __init init(void)
 {
-	unsigned int i;
+	int i = register_filesystem(&futex_fs_type);
+
+	if (i)
+		return i;
 
-	register_filesystem(&futex_fs_type);
 	futex_mnt = kern_mount(&futex_fs_type);
+	if (IS_ERR(futex_mnt)) {
+		unregister_filesystem(&futex_fs_type);
+		return PTR_ERR(futex_mnt);
+	}
 
 	for (i = 0; i < ARRAY_SIZE(futex_queues); i++) {
 		INIT_LIST_HEAD(&futex_queues[i].chain);
