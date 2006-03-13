Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751857AbWCMUHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbWCMUHz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbWCMUHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:07:55 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:37850 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751886AbWCMUHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:07:54 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] scm: fold __scm_send() into scm_send()
Date: Mon, 13 Mar 2006 21:05:31 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, netdev@vger.kernel.org
References: <200603130139.k2D1dpSQ021279@shell0.pdx.osdl.net> <20060312.180802.13404061.davem@davemloft.net>
In-Reply-To: <20060312.180802.13404061.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603132105.32794.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Oeser <ioe-lkml@rameria.de>

Fold __scm_send() into scm_send() and remove that interface completly
from the kernel.

Signed-off-by: Ingo Oeser <ioe-klml@rameria.de>
---
Inspired by the patch to inline scm_send()
I did the next logical step :-)

Regards

Ingo Oeser

diff --git a/include/net/scm.h b/include/net/scm.h
index eb44e5a..ec8b891 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -26,11 +26,9 @@ struct scm_cookie
 
 extern void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
 extern void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm);
-extern int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm);
 extern void __scm_destroy(struct scm_cookie *scm);
 extern struct scm_fp_list * scm_fp_dup(struct scm_fp_list *fpl);
-extern int scm_send(struct socket *sock, struct msghdr *msg,
-			struct scm_cookie *scm);
+extern int scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm);
 extern void scm_recv(struct socket *sock, struct msghdr *msg,
 		struct scm_cookie *scm, int flags);
 
diff --git a/net/core/scm.c b/net/core/scm.c
index b6dee90..6adbe60 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -110,10 +110,21 @@ void __scm_destroy(struct scm_cookie *sc
 	}
 }
 
-int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
+int scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
 {
 	struct cmsghdr *cmsg;
 	int err;
+	struct task_struct *tsk = current;
+	scm->creds = (struct ucred) {
+		.uid = tsk->uid,
+		.gid = tsk->gid,
+		.pid = tsk->tgid
+	};
+	scm->fp = NULL;
+	scm->sid = security_sk_sid(sock->sk, NULL, 0);
+	scm->seq = 0;
+	if (msg->msg_controllen <= 0)
+		return 0;
 
 	for (cmsg = CMSG_FIRSTHDR(msg); cmsg; cmsg = CMSG_NXTHDR(msg, cmsg))
 	{
@@ -136,15 +147,15 @@ int __scm_send(struct socket *sock, stru
 		switch (cmsg->cmsg_type)
 		{
 		case SCM_RIGHTS:
-			err=scm_fp_copy(cmsg, &p->fp);
+			err=scm_fp_copy(cmsg, &scm->fp);
 			if (err<0)
 				goto error;
 			break;
 		case SCM_CREDENTIALS:
 			if (cmsg->cmsg_len != CMSG_LEN(sizeof(struct ucred)))
 				goto error;
-			memcpy(&p->creds, CMSG_DATA(cmsg), sizeof(struct ucred));
-			err = scm_check_creds(&p->creds);
+			memcpy(&scm->creds, CMSG_DATA(cmsg), sizeof(struct ucred));
+			err = scm_check_creds(&scm->creds);
 			if (err)
 				goto error;
 			break;
@@ -153,15 +164,15 @@ int __scm_send(struct socket *sock, stru
 		}
 	}
 
-	if (p->fp && !p->fp->count)
+	if (scm->fp && !scm->fp->count)
 	{
-		kfree(p->fp);
-		p->fp = NULL;
+		kfree(scm->fp);
+		scm->fp = NULL;
 	}
 	return 0;
 	
 error:
-	scm_destroy(p);
+	scm_destroy(scm);
 	return err;
 }
 
@@ -284,22 +295,6 @@ struct scm_fp_list *scm_fp_dup(struct sc
 	return new_fpl;
 }
 
-int scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
-{
-	struct task_struct *p = current;
-	scm->creds = (struct ucred) {
-		.uid = p->uid,
-		.gid = p->gid,
-		.pid = p->tgid
-	};
-	scm->fp = NULL;
-	scm->sid = security_sk_sid(sock->sk, NULL, 0);
-	scm->seq = 0;
-	if (msg->msg_controllen <= 0)
-		return 0;
-	return __scm_send(sock, msg, scm);
-}
-
 void scm_recv(struct socket *sock, struct msghdr *msg,
 		struct scm_cookie *scm, int flags)
 {
@@ -332,7 +326,6 @@ void scm_recv(struct socket *sock, struc
 }
 
 EXPORT_SYMBOL(__scm_destroy);
-EXPORT_SYMBOL(__scm_send);
 EXPORT_SYMBOL(scm_send);
 EXPORT_SYMBOL(scm_recv);
 EXPORT_SYMBOL(put_cmsg);
