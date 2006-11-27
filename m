Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756871AbWK0FGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756871AbWK0FGf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 00:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756883AbWK0FGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 00:06:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:9759 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1756871AbWK0FGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 00:06:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=VJ+PijQ7IxQQJ0eQgXW11LS8N7ePxqqEKb8LdiwmbU89vim2D2puTkIntT2X8jH+GHuIvj1Bn+Qcx30aT95ac9Fqo6psPPIe0hUsyu389HHcFu+AVMTkT3o6keTGe49fpLmU5b9OVir7Ujj3NdQX3FlOUmiduqtQva3gGPVv0eE=
Date: Mon, 27 Nov 2006 13:59:22 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] fix create_write_pipe() error check
Message-ID: <20061127045922.GD1231@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of create_write_pipe()/create_read_pipe() should be
checked by IS_ERR().

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 kernel/kmod.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: work-fault-inject/kernel/kmod.c
===================================================================
--- work-fault-inject.orig/kernel/kmod.c
+++ work-fault-inject/kernel/kmod.c
@@ -307,14 +307,14 @@ int call_usermodehelper_pipe(char *path,
 		return 0;
 
 	f = create_write_pipe();
-	if (!f)
-		return -ENOMEM;
+	if (IS_ERR(f))
+		return PTR_ERR(f);
 	*filp = f;
 
 	f = create_read_pipe(f);
-	if (!f) {
+	if (IS_ERR(f)) {
 		free_write_pipe(*filp);
-		return -ENOMEM;
+		return PTR_ERR(f);
 	}
 	sub_info.stdin = f;
 
