Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267334AbUJITwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267334AbUJITwV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 15:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267343AbUJITwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 15:52:21 -0400
Received: from [145.85.127.2] ([145.85.127.2]:1761 "EHLO mail.il.fontys.nl")
	by vger.kernel.org with ESMTP id S267334AbUJITwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 15:52:01 -0400
Message-ID: <60256.217.121.83.210.1097351510.squirrel@217.121.83.210>
Date: Sat, 9 Oct 2004 21:51:50 +0200 (CEST)
Subject: [Patch] lockd: remove hardcoded maximum NLM cookie length
From: "Ed Schouten" <ed@il.fontys.nl>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

At the moment, the NLM cookie length is fixed to 8 bytes, while 1024 is
the theoretical maximum. FreeBSD uses 16 bytes, Mac OS X uses 20 bytes.
Therefore we need to make the length dynamic (which I set to 32 bytes).

This patch is based on an old patch for Linux 2.4.23-pre9, which I changed
to patch properly (also added some stylish NIPQUAD fixes).

You can also download this patch at:
http://linux.g-rave.nl/patches/patch-lockd-cookies.diff
---

 fs/lockd/svclock.c          |   16 ++++++++--------
 fs/lockd/xdr.c              |   37 +++++++++++++++++++++++++++++++++----
 fs/lockd/xdr4.c             |    6 +++---
 include/linux/lockd/debug.h |    9 +++++++++
 include/linux/lockd/xdr.h   |    8 +++++---
 5 files changed, 58 insertions(+), 18 deletions(-)

diff -u -r --new-file linux-2.6.9-rc3/fs/lockd/svclock.c
linux-2.6.9-rc3-ed0/fs/lockd/svclock.c
--- linux-2.6.9-rc3/fs/lockd/svclock.c	2004-09-30 05:04:24.000000000 +0200
+++ linux-2.6.9-rc3-ed0/fs/lockd/svclock.c	2004-10-09 21:16:18.412284000
+0200
@@ -112,11 +112,11 @@
 				(long long)lock->fl.fl_end, lock->fl.fl_type);
 	for (head = &nlm_blocked; (block = *head) != 0; head = &block->b_next) {
 		fl = &block->b_call.a_args.lock.fl;
-		dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%x\n",
+		dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
 				block->b_file, fl->fl_pid,
 				(long long)fl->fl_start,
 				(long long)fl->fl_end, fl->fl_type,
-				*(unsigned int*)(block->b_call.a_args.cookie.data));
+				nlmdbg_cookie2a(&block->b_call.a_args.cookie));
 		if (block->b_file == file && nlm_compare_locks(fl, &lock->fl)) {
 			if (remove) {
 				*head = block->b_next;
@@ -584,13 +584,13 @@
 	struct sockaddr_in	*peer_addr = RPC_PEERADDR(task->tk_client);

 	dprintk("lockd: GRANT_MSG RPC callback\n");
-	dprintk("callback: looking for cookie %x, host (%08x)\n",
-		*(unsigned int *)(call->a_args.cookie.data),
-		ntohl(peer_addr->sin_addr.s_addr));
+	dprintk("callback: looking for cookie %s, host (%u.%u.%u.%u)\n",
+		nlmdbg_cookie2a(&call->a_args.cookie),
+		NIPQUAD(peer_addr->sin_addr.s_addr));
 	if (!(block = nlmsvc_find_block(&call->a_args.cookie, peer_addr))) {
-		dprintk("lockd: no block for cookie %x, host (%08x)\n",
-			*(u32 *)(call->a_args.cookie.data),
-			ntohl(peer_addr->sin_addr.s_addr));
+		dprintk("lockd: no block for cookie %s, host (%u.%u.%u.%u)\n",
+			nlmdbg_cookie2a(&call->a_args.cookie),
+			NIPQUAD(peer_addr->sin_addr.s_addr));
 		return;
 	}

diff -u -r --new-file linux-2.6.9-rc3/fs/lockd/xdr.c
linux-2.6.9-rc3-ed0/fs/lockd/xdr.c
--- linux-2.6.9-rc3/fs/lockd/xdr.c	2004-09-30 05:03:51.000000000 +0200
+++ linux-2.6.9-rc3-ed0/fs/lockd/xdr.c	2004-10-09 21:14:52.165284000 +0200
@@ -55,7 +55,7 @@
 		c->len=4;
 		memset(c->data, 0, 4);	/* hockeypux brain damage */
 	}
-	else if(len<=8)
+	else if(len<=NLM_MAXCOOKIELEN)
 	{
 		c->len=len;
 		memcpy(c->data, p, len);
@@ -64,7 +64,7 @@
 	else
 	{
 		printk(KERN_NOTICE
-			"lockd: bad cookie size %d (only cookies under 8 bytes are
supported.)\n", len);
+			"lockd: bad cookie size %d (only cookies under %d bytes are
supported.)\n", len, NLM_MAXCOOKIELEN);
 		return NULL;
 	}
 	return p;
@@ -86,7 +86,7 @@

 	if ((len = ntohl(*p++)) != NFS2_FHSIZE) {
 		printk(KERN_NOTICE
-			"lockd: bad fhandle size %x (should be %d)\n",
+			"lockd: bad fhandle size %d (should be %d)\n",
 			len, NFS2_FHSIZE);
 		return NULL;
 	}
@@ -512,7 +512,7 @@
  * Buffer requirements for NLM
  */
 #define NLM_void_sz		0
-#define NLM_cookie_sz		3	/* 1 len , 2 data */
+#define NLM_cookie_sz		1+QUADLEN(NLM_MAXCOOKIELEN)
 #define NLM_caller_sz		1+QUADLEN(sizeof(system_utsname.nodename))
 #define NLM_netobj_sz		1+QUADLEN(XDR_MAX_NETOBJ)
 /* #define NLM_owner_sz		1+QUADLEN(NLM_MAXOWNER) */
@@ -604,3 +604,32 @@
 		.stats		= &nlm_stats,
 };

+#ifdef RPC_DEBUG
+const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
+{
+	/*
+	 * We can get away with a static buffer because we're only
+	 * called with BKL held.
+	 */
+	static char buf[2*NLM_MAXCOOKIELEN+1];
+	int i;
+	int len = sizeof(buf);
+	char *p = buf;
+
+	len--;	/* allow for trailing \0 */
+	if (len < 3)
+		return "???";
+	for (i = 0 ; i < cookie->len ; i++) {
+		if (len < 2) {
+			strcpy(p-3, "...");
+			break;
+		}
+		sprintf(p, "%02x", cookie->data[i]);
+		p += 2;
+		len -= 2;
+	}
+	*p = '\0';
+
+	return buf;
+}
+#endif
diff -u -r --new-file linux-2.6.9-rc3/fs/lockd/xdr4.c
linux-2.6.9-rc3-ed0/fs/lockd/xdr4.c
--- linux-2.6.9-rc3/fs/lockd/xdr4.c	2004-09-30 05:03:45.000000000 +0200
+++ linux-2.6.9-rc3-ed0/fs/lockd/xdr4.c	2004-10-09 21:14:52.169284000 +0200
@@ -56,7 +56,7 @@
 		c->len=4;
 		memset(c->data, 0, 4);	/* hockeypux brain damage */
 	}
-	else if(len<=8)
+	else if(len<=NLM_MAXCOOKIELEN)
 	{
 		c->len=len;
 		memcpy(c->data, p, len);
@@ -65,7 +65,7 @@
 	else
 	{
 		printk(KERN_NOTICE
-			"lockd: bad cookie size %d (only cookies under 8 bytes are
supported.)\n", len);
+			"lockd: bad cookie size %d (only cookies under %d bytes are
supported.)\n", len, NLM_MAXCOOKIELEN);
 		return NULL;
 	}
 	return p;
@@ -515,7 +515,7 @@
  * Buffer requirements for NLM
  */
 #define NLM4_void_sz		0
-#define NLM4_cookie_sz		3	/* 1 len , 2 data */
+#define NLM4_cookie_sz		1+XDR_QUADLEN(NLM_MAXCOOKIELEN)
 #define NLM4_caller_sz		1+XDR_QUADLEN(NLM_MAXSTRLEN)
 #define NLM4_netobj_sz		1+XDR_QUADLEN(XDR_MAX_NETOBJ)
 /* #define NLM4_owner_sz		1+XDR_QUADLEN(NLM4_MAXOWNER) */
diff -u -r --new-file linux-2.6.9-rc3/include/linux/lockd/debug.h
linux-2.6.9-rc3-ed0/include/linux/lockd/debug.h
--- linux-2.6.9-rc3/include/linux/lockd/debug.h	2004-09-30
05:05:25.000000000 +0200
+++ linux-2.6.9-rc3-ed0/include/linux/lockd/debug.h	2004-10-09
21:14:52.237284000 +0200
@@ -45,4 +45,13 @@
 #define NLMDBG_ALL		0x7fff


+/*
+ * Support for printing NLM cookies in dprintk()
+ */
+#ifdef RPC_DEBUG
+struct nlm_cookie;
+/* Call this function with the BKL held (it uses a static buffer) */
+extern const char *nlmdbg_cookie2a(const struct nlm_cookie *);
+#endif
+
 #endif /* LINUX_LOCKD_DEBUG_H */
diff -u -r --new-file linux-2.6.9-rc3/include/linux/lockd/xdr.h
linux-2.6.9-rc3-ed0/include/linux/lockd/xdr.h
--- linux-2.6.9-rc3/include/linux/lockd/xdr.h	2004-09-30
05:03:44.000000000 +0200
+++ linux-2.6.9-rc3-ed0/include/linux/lockd/xdr.h	2004-10-09
21:26:33.473284000 +0200
@@ -13,6 +13,7 @@
 #include <linux/nfs.h>
 #include <linux/sunrpc/xdr.h>

+#define NLM_MAXCOOKIELEN    	32
 #define NLM_MAXSTRLEN		1024

 #define QUADLEN(len)		(((len) + 3) >> 2)
@@ -33,13 +34,14 @@
 };

 /*
- *	NLM cookies. Technically they can be 1K, Nobody uses over 8 bytes
- *	however.
+ *	NLM cookies. Technically they can be 1K, but Linux only uses 8 bytes.
+ *	FreeBSD uses 16, Apple Mac OS X 10.3 uses 20. Therefore we set it to
+ *	32 bytes.
  */

 struct nlm_cookie
 {
-	unsigned char data[8];
+	unsigned char data[NLM_MAXCOOKIELEN];
 	unsigned int len;
 };
