Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSH3XKx>; Fri, 30 Aug 2002 19:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314938AbSH3XKw>; Fri, 30 Aug 2002 19:10:52 -0400
Received: from pat.uio.no ([129.240.130.16]:4819 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S313563AbSH3XKl>;
	Fri, 30 Aug 2002 19:10:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15727.64630.55337.973572@charged.uio.no>
Date: Sat, 31 Aug 2002 01:15:02 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Introduce BSD-style user credential [2/3]
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename 'struct ucred' in <linux/socket.h> to 'struct scm_ucred'.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.32-cred1/include/linux/netlink.h linux-2.5.32-cred2/include/linux/netlink.h
--- linux-2.5.32-cred1/include/linux/netlink.h	Tue Jun 25 17:42:13 2002
+++ linux-2.5.32-cred2/include/linux/netlink.h	Wed Aug 28 23:45:10 2002
@@ -88,7 +88,7 @@
 
 struct netlink_skb_parms
 {
-	struct ucred		creds;		/* Skb credentials	*/
+	struct scm_ucred	creds;		/* Skb credentials	*/
 	__u32			pid;
 	__u32			groups;
 	__u32			dst_pid;
diff -u --recursive --new-file linux-2.5.32-cred1/include/linux/socket.h linux-2.5.32-cred2/include/linux/socket.h
--- linux-2.5.32-cred1/include/linux/socket.h	Tue Feb  5 16:23:43 2002
+++ linux-2.5.32-cred2/include/linux/socket.h	Wed Aug 28 23:45:10 2002
@@ -119,10 +119,10 @@
 /* "Socket"-level control message types: */
 
 #define	SCM_RIGHTS	0x01		/* rw: access rights (array of int) */
-#define SCM_CREDENTIALS 0x02		/* rw: struct ucred		*/
+#define SCM_CREDENTIALS 0x02		/* rw: struct scm_ucred		*/
 #define SCM_CONNECT	0x03		/* rw: struct scm_connect	*/
 
-struct ucred {
+struct scm_ucred {
 	__u32	pid;
 	__u32	uid;
 	__u32	gid;
diff -u --recursive --new-file linux-2.5.32-cred1/include/net/af_unix.h linux-2.5.32-cred2/include/net/af_unix.h
--- linux-2.5.32-cred1/include/net/af_unix.h	Mon Feb 11 08:06:52 2002
+++ linux-2.5.32-cred2/include/net/af_unix.h	Wed Aug 28 23:45:10 2002
@@ -27,7 +27,7 @@
 
 struct unix_skb_parms
 {
-	struct ucred		creds;		/* Skb credentials	*/
+	struct scm_ucred	creds;		/* Skb credentials	*/
 	struct scm_fp_list	*fp;		/* Passed files		*/
 };
 
diff -u --recursive --new-file linux-2.5.32-cred1/include/net/scm.h linux-2.5.32-cred2/include/net/scm.h
--- linux-2.5.32-cred1/include/net/scm.h	Sat Feb  9 04:10:55 2002
+++ linux-2.5.32-cred2/include/net/scm.h	Wed Aug 28 23:45:10 2002
@@ -16,7 +16,7 @@
 
 struct scm_cookie
 {
-	struct ucred		creds;		/* Skb credentials	*/
+	struct scm_ucred	creds;		/* Skb credentials	*/
 	struct scm_fp_list	*fp;		/* Passed files		*/
 	unsigned long		seq;		/* Connection seqno	*/
 };
diff -u --recursive --new-file linux-2.5.32-cred1/include/net/sock.h linux-2.5.32-cred2/include/net/sock.h
--- linux-2.5.32-cred1/include/net/sock.h	Sun Mar 31 15:37:59 2002
+++ linux-2.5.32-cred2/include/net/sock.h	Wed Aug 28 23:45:10 2002
@@ -164,7 +164,7 @@
 	unsigned short		type;
 	unsigned char		localroute;	/* Route locally only */
 	unsigned char		protocol;
-	struct ucred		peercred;
+	struct scm_ucred	peercred;
 	int			rcvlowat;
 	long			rcvtimeo;
 	long			sndtimeo;
diff -u --recursive --new-file linux-2.5.32-cred1/net/core/scm.c linux-2.5.32-cred2/net/core/scm.c
--- linux-2.5.32-cred1/net/core/scm.c	Mon Jul 22 12:12:48 2002
+++ linux-2.5.32-cred2/net/core/scm.c	Wed Aug 28 23:45:10 2002
@@ -38,7 +38,7 @@
  *	setu(g)id.
  */
 
-static __inline__ int scm_check_creds(struct ucred *creds)
+static __inline__ int scm_check_creds(struct scm_ucred *creds)
 {
 	if ((creds->pid == current->pid || capable(CAP_SYS_ADMIN)) &&
 	    ((creds->uid == current->uid || creds->uid == current->euid ||
@@ -141,9 +141,9 @@
 				goto error;
 			break;
 		case SCM_CREDENTIALS:
-			if (cmsg->cmsg_len != CMSG_LEN(sizeof(struct ucred)))
+			if (cmsg->cmsg_len != CMSG_LEN(sizeof(struct scm_ucred)))
 				goto error;
-			memcpy(&p->creds, CMSG_DATA(cmsg), sizeof(struct ucred));
+			memcpy(&p->creds, CMSG_DATA(cmsg), sizeof(struct scm_ucred));
 			err = scm_check_creds(&p->creds);
 			if (err)
 				goto error;
diff -u --recursive --new-file linux-2.5.32-cred1/net/netlink/af_netlink.c linux-2.5.32-cred2/net/netlink/af_netlink.c
--- linux-2.5.32-cred1/net/netlink/af_netlink.c	Fri Jul 19 08:16:20 2002
+++ linux-2.5.32-cred2/net/netlink/af_netlink.c	Wed Aug 28 23:45:10 2002
@@ -614,7 +614,7 @@
 	NETLINK_CB(skb).groups	= nlk->groups;
 	NETLINK_CB(skb).dst_pid = dst_pid;
 	NETLINK_CB(skb).dst_groups = dst_groups;
-	memcpy(NETLINK_CREDS(skb), &scm->creds, sizeof(struct ucred));
+	memcpy(NETLINK_CREDS(skb), &scm->creds, sizeof(struct scm_ucred));
 
 	/* What can I do? Netlink is asynchronous, so that
 	   we will have to save current capabilities to
diff -u --recursive --new-file linux-2.5.32-cred1/net/unix/af_unix.c linux-2.5.32-cred2/net/unix/af_unix.c
--- linux-2.5.32-cred1/net/unix/af_unix.c	Sat Aug 24 13:27:51 2002
+++ linux-2.5.32-cred2/net/unix/af_unix.c	Wed Aug 28 23:45:10 2002
@@ -1216,7 +1216,7 @@
 	if (skb==NULL)
 		goto out;
 
-	memcpy(UNIXCREDS(skb), &scm->creds, sizeof(struct ucred));
+	memcpy(UNIXCREDS(skb), &scm->creds, sizeof(struct scm_ucred));
 	if (scm->fp)
 		unix_attach_fds(scm, skb);
 
@@ -1369,7 +1369,7 @@
 		 */
 		size = min_t(int, size, skb_tailroom(skb));
 
-		memcpy(UNIXCREDS(skb), &scm->creds, sizeof(struct ucred));
+		memcpy(UNIXCREDS(skb), &scm->creds, sizeof(struct scm_ucred));
 		if (scm->fp)
 			unix_attach_fds(scm, skb);
 
