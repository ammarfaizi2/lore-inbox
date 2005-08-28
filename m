Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVH1Saa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVH1Saa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 14:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVH1Saa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 14:30:30 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:58093 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750744AbVH1Sa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 14:30:29 -0400
Subject: [PATCH] v9fs: fix a problem with named-pipe transport
From: Eric Van Hensbergen <ericvh@gmail.com>
To: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
       V9FS Developers <v9fs-developer@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 28 Aug 2005 13:30:19 -0500
Message-Id: <1125253819.17501.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] v9fs: fix a problem with named-pipe transport

Found the problem. I am not sure why, but unix_mkname in
net/unix/af_unix.c writes a zero byte outside the sockaddr_un parameter.
There is even a comment that it might seem like a bug, but it is not --
I didn't understand the explanation -- it looks like a bug to me :)

The patch that I am attaching sets addr_len parameter of ops->connect to
sizeof(struct sockaddr_un) - 1 and thus ensures that unix_mkname won't
write outside the struct. The patch also checks if the length of the
unix
socket name specified in mount doesn't exceed UNIX_PATH_MAX.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>
Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---
commit f32fc66e311abe9e7167991e6b2d37e7c56dcc72
tree 3b2a77e0c674e86aed92823857d33352d93938f3
parent 97bc19b509356dda0145cd19fb9768ac3c88ecda
author Eric Van Hensbergen <ericvh@gmail.com> Sun, 28 Aug 2005 13:29:03
-0500
committer Eric Van Hensbergen <ericvh@gmail.com> Sun, 28 Aug 2005
13:29:03 -0500

 fs/9p/trans_sock.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/9p/trans_sock.c b/fs/9p/trans_sock.c
--- a/fs/9p/trans_sock.c
+++ b/fs/9p/trans_sock.c
@@ -202,14 +202,23 @@ static int
 v9fs_unix_init(struct v9fs_session_info *v9ses, const char *dev_name,
 	       char *data)
 {
-	struct socket *csocket = NULL;
+	int rc;
+	struct socket *csocket;
 	struct sockaddr_un sun_server;
-	struct v9fs_transport *trans = v9ses->transport;
-	int rc = 0;
+	struct v9fs_transport *trans;
+	struct v9fs_trans_sock *ts;
 
-	struct v9fs_trans_sock *ts =
-	    kmalloc(sizeof(struct v9fs_trans_sock), GFP_KERNEL);
+	rc = 0;
+	csocket = NULL;
+	trans = v9ses->transport;
+
+	if (strlen(dev_name) > UNIX_PATH_MAX) {
+		eprintk(KERN_ERR, "v9fs_trans_unix: address too long: %s\n",
+			dev_name);
+		return -ENOMEM;
+	}
 
+	ts = kmalloc(sizeof(struct v9fs_trans_sock), GFP_KERNEL);
 	if (!ts)
 		return -ENOMEM;
 
@@ -222,9 +231,8 @@ v9fs_unix_init(struct v9fs_session_info 
 	sun_server.sun_family = PF_UNIX;
 	strcpy(sun_server.sun_path, dev_name);
 	sock_create_kern(PF_UNIX, SOCK_STREAM, 0, &csocket);
-	rc = csocket->ops->connect(csocket,
-				   (struct sockaddr *)&sun_server,
-				   sizeof(struct sockaddr_un), 0);
+	rc = csocket->ops->connect(csocket, (struct sockaddr *)&sun_server, 
+		sizeof(struct sockaddr_un) - 1, 0);	/* -1 *is* important */
 	if (rc < 0) {
 		eprintk(KERN_ERR,
 			"v9fs_trans_unix: problem connecting socket: %s: %d\n",


