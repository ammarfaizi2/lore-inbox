Return-Path: <linux-kernel-owner+w=401wt.eu-S933224AbWLaVAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933224AbWLaVAX (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 16:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933227AbWLaVAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 16:00:23 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:42994 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933224AbWLaVAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 16:00:21 -0500
X-Originating-Ip: 74.109.98.100
Date: Sun, 31 Dec 2006 15:55:22 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Simplify some code to use the container_of() macro.
Message-ID: <Pine.LNX.4.64.0612311547200.30821@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Simplify a number of code snippets in source and header files to use
the kernel.h "container_of()" macro.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  and while we're at it, everybody can stop re-inventing the
container_of() macro.  :-)


 drivers/net/ppp_generic.c        |    2 +-
 drivers/s390/net/lcs.c           |    6 ++----
 drivers/video/sa1100fb.h         |    4 +---
 include/linux/security.h         |    2 +-
 net/ipv4/netfilter/nf_nat_core.c |    2 +-
 security/selinux/hooks.c         |    2 +-
 6 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ppp_generic.c b/drivers/net/ppp_generic.c
index c6de566..0986f6c 100644
--- a/drivers/net/ppp_generic.c
+++ b/drivers/net/ppp_generic.c
@@ -83,7 +83,7 @@ struct ppp_file {
 	int		dead;		/* unit/channel has been shut down */
 };

-#define PF_TO_X(pf, X)		((X *)((char *)(pf) - offsetof(X, file)))
+#define PF_TO_X(pf, X)		container_of(pf, X, file)

 #define PF_TO_PPP(pf)		PF_TO_X(pf, struct ppp)
 #define PF_TO_CHANNEL(pf)	PF_TO_X(pf, struct channel)
diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index e5665b6..732cd9f 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -1511,8 +1511,7 @@ lcs_txbuffer_cb(struct lcs_channel *channel, struct lcs_buffer *buffer)
 	LCS_DBF_TEXT(5, trace, "txbuffcb");
 	/* Put buffer back to pool. */
 	lcs_release_buffer(channel, buffer);
-	card = (struct lcs_card *)
-		((char *) channel - offsetof(struct lcs_card, write));
+	card = container_of(channel, struct lcs_card, write);
 	if (netif_queue_stopped(card->dev) && netif_carrier_ok(card->dev))
 		netif_wake_queue(card->dev);
 	spin_lock(&card->lock);
@@ -1810,8 +1809,7 @@ lcs_get_frames_cb(struct lcs_channel *channel, struct lcs_buffer *buffer)
 		LCS_DBF_TEXT(4, trace, "-eiogpkt");
 		return;
 	}
-	card = (struct lcs_card *)
-		((char *) channel - offsetof(struct lcs_card, read));
+	card = container_of(channel, struct lcs_card, write);
 	offset = 0;
 	while (lcs_hdr->offset != 0) {
 		if (lcs_hdr->offset <= 0 ||
diff --git a/drivers/video/sa1100fb.h b/drivers/video/sa1100fb.h
index 0b07f6a..48066ef 100644
--- a/drivers/video/sa1100fb.h
+++ b/drivers/video/sa1100fb.h
@@ -110,9 +110,7 @@ struct sa1100fb_info {
 #endif
 };

-#define __type_entry(ptr,type,member) ((type *)((char *)(ptr)-offsetof(type,member)))
-
-#define TO_INF(ptr,member)	__type_entry(ptr,struct sa1100fb_info,member)
+#define TO_INF(ptr,member)	container_of(ptr,struct sa1100fb_info,member)

 #define SA1100_PALETTE_MODE_VAL(bpp)    (((bpp) & 0x018) << 9)

diff --git a/include/linux/security.h b/include/linux/security.h
index 83cdefa..c554f60 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -492,7 +492,7 @@ struct request_sock;
  *	Note that the fown_struct, @fown, is never outside the context of a
  *	struct file, so the file structure (and associated security information)
  *	can always be obtained:
- *		(struct file *)((long)fown - offsetof(struct file,f_owner));
+ *		container_of(fown, struct file, f_owner)
  * 	@tsk contains the structure of task receiving signal.
  *	@fown contains the file owner information.
  *	@sig is the signal that will be sent.  When 0, kernel sends SIGIO.
diff --git a/net/ipv4/netfilter/nf_nat_core.c b/net/ipv4/netfilter/nf_nat_core.c
index 86a9227..26c8f69 100644
--- a/net/ipv4/netfilter/nf_nat_core.c
+++ b/net/ipv4/netfilter/nf_nat_core.c
@@ -168,7 +168,7 @@ find_appropriate_src(const struct nf_conntrack_tuple *tuple,

 	read_lock_bh(&nf_nat_lock);
 	list_for_each_entry(nat, &bysource[h], info.bysource) {
-		ct = (struct nf_conn *)((char *)nat - offsetof(struct nf_conn, data));
+		ct = container_of(nat, struct nf_conn, data);
 		if (same_src(ct, tuple)) {
 			/* Copy source part from reply tuple. */
 			nf_ct_invert_tuplepr(result,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 65fb5e8..778ceb9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2655,7 +2655,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 	struct file_security_struct *fsec;

 	/* struct fown_struct is never outside the context of a struct file */
-        file = (struct file *)((long)fown - offsetof(struct file,f_owner));
+        file = container_of(fown, struct file, f_owner);

 	tsec = tsk->security;
 	fsec = file->f_security;

