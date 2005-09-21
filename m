Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbVIUBW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVIUBW0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 21:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVIUBW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 21:22:26 -0400
Received: from sccrmhc14.comcast.net ([63.240.76.49]:53452 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932103AbVIUBWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 21:22:25 -0400
Date: Tue, 20 Sep 2005 21:22:22 -0400
From: Latchesar Ionkov <lucho@ionkov.net>
To: linux-kernel@vger.kernel.org
Cc: v9fs-developer@lists.sourceforge.net
Subject: [PATCH] v9fs-copy-transport-proto.patch
Message-ID: <20050921012222.GD2008@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

Attach copy of the transport prototype to the v9fs session, not the prototype
itself. Otherwise two sessions using the same transport type will overwrite
each other's data.

---
commit 34ad50ad5bf63c55687350d9f4e3c4dcc44304a7
tree ddd9f6d0b2c00c5e8aee40d4883e1e615bea4b29
parent 4f0a459f11309161616e22f4acf918eb04a9bd1a
author Latchesar Ionkov <lucho@ionkov.net> Tue, 20 Sep 2005 19:27:34 -0400
committer Latchesar Ionkov <lucho@ionkov.net> Tue, 20 Sep 2005 19:27:34 -0400

 fs/9p/v9fs.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -303,7 +303,13 @@ v9fs_session_init(struct v9fs_session_in
 		goto SessCleanUp;
 	};
 
-	v9ses->transport = trans_proto;
+	v9ses->transport = kmalloc(sizeof(*v9ses->transport), GFP_KERNEL);
+	if (!v9ses->transport) {
+		retval = -ENOMEM;
+		goto SessCleanUp;
+	}
+
+	memmove(v9ses->transport, trans_proto, sizeof(*v9ses->transport));
 
 	if ((retval = v9ses->transport->init(v9ses, dev_name, data)) < 0) {
 		eprintk(KERN_ERR, "problem initializing transport\n");
