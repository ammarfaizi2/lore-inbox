Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbTKEEUM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 23:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbTKEEUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 23:20:12 -0500
Received: from pat.uio.no ([129.240.130.16]:63442 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261460AbTKEET6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 23:19:58 -0500
To: Bill Akers <akers@gseis.ucla.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs NLM locks greater than 8 bytes
References: <200311031652.36074.akers@gseis.ucla.edu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 04 Nov 2003 23:19:53 -0500
In-Reply-To: <200311031652.36074.akers@gseis.ucla.edu>
Message-ID: <shs7k2fwiom.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Bill Akers <akers@gseis.ucla.edu> writes:

    >> Unfortunately, this is actually "nobody" except FreeBSD 5.x,
    >> which uses 16-byte cookies.  As a result, any attempt by a
    >> FreeBSD client to lock an NFS-mounted file from a Linux server
    >> results in the process on the FreeBSD client hanging,
    >> unkillably.

     > His full original post is:
     > http://lists.freebsd.org/pipermail/freebsd-bugs/2003-September/003069.html


     "A proper fix would be either to somehow compress all three
     pieces of information -- pid, pid_start, and msg_seq -- into
     eight bytes (difficult); maintain an in-kernel table mapping an
     eight-byte sequence number to lockd_msg_ident; or find some
     other, smaller way of defending against pid recycling."

That's a laugh... They need 16-20 bytes to defend against pid
recycling??? For exactly how many lifetimes of the universe are they
planning on waiting on a lock?

Anyhow, Greg Banks of SGI sent me this patch in March last year. I
haven't been too crazy about it because the debugging code gets a bit
obscurantist.

It will solve your problem though...

Cheers,
  Trond

-------------------------

This patch makes lockd handle NLM cookies larger than 8 bytes, which
is needed for MacOS X interoperability.


diff -ruN --exclude-from=excludes linux-2.4.19.orig/fs/lockd/svclock.c
linux-2.4.19/fs/lockd/svclock.c
--- linux-2.4.19.orig/fs/lockd/svclock.c	Tue Mar  4 19:26:53 2003
+++ linux-2.4.19/fs/lockd/svclock.c	Tue Mar  4 20:32:10 2003
@@ -106,6 +106,7 @@
 {
 	struct nlm_block	**head, *block;
 	struct file_lock	*fl;
+	NLMDBG_COOKIE_BUF
 
 	dprintk("lockd: nlmsvc_lookup_block f=%p pd=%d %Ld-%Ld ty=%d\n",
 				file, lock->fl.fl_pid,
@@ -113,11 +114,11 @@
 				(long long)lock->fl.fl_end, lock->fl.fl_type);
 	for (head = &nlm_blocked; (block = *head); head = &block->b_next) {
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
@@ -572,12 +573,13 @@
 	struct nlm_rqst		*call = (struct nlm_rqst *) task->tk_calldata;
 	struct nlm_block	*block;
 	unsigned long		timeout;
+	NLMDBG_COOKIE_BUF
 
 	dprintk("lockd: GRANT_MSG RPC callback\n");
-	dprintk("callback: looking for cookie %x \n", 
-		*(unsigned int *)(call->a_args.cookie.data));
+	dprintk("callback: looking for cookie %s \n", 
+		nlmdbg_cookie2a(&call->a_args.cookie));
 	if (!(block = nlmsvc_find_block(&call->a_args.cookie))) {
-		dprintk("lockd: no block for cookie %x\n", *(u32 *)(call->a_args.cookie.data));
+		dprintk("lockd: no block for cookie %s\n", nlmdbg_cookie2a(&call->a_args.cookie));
 		return;
 	}
 
diff -ruN --exclude-from=excludes linux-2.4.19.orig/fs/lockd/xdr.c
linux-2.4.19/fs/lockd/xdr.c
--- linux-2.4.19.orig/fs/lockd/xdr.c	Tue Mar  4 19:26:53 2003
+++ linux-2.4.19/fs/lockd/xdr.c	Tue Mar  4 21:11:12 2003
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
-			"lockd: bad cookie size %d (only cookies under 8 bytes are supported.)\n", len);
+			"lockd: bad cookie size %d (only cookies under %d bytes are supported.)\n", len,
NLM_MAXCOOKIELEN);
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
@@ -534,7 +534,7 @@
  * Buffer requirements for NLM
  */
 #define NLM_void_sz		0
-#define NLM_cookie_sz		3	/* 1 len , 2 data */
+#define NLM_cookie_sz		1+QUADLEN(NLM_MAXCOOKIELEN)
 #define NLM_caller_sz		1+QUADLEN(sizeof(system_utsname.nodename))
 #define NLM_netobj_sz		1+QUADLEN(XDR_MAX_NETOBJ)
 /* #define NLM_owner_sz		1+QUADLEN(NLM_MAXOWNER) */
@@ -644,3 +644,23 @@
 }
 #endif
 
+#ifdef RPC_DEBUG
+const char *__nlmdbg_cookie2a(const struct nlm_cookie *cookie, char *buf, int len)
+{
+	int i;
+
+	len--;	/* allow for trailing \0 */
+	if (len < 3)
+		return "???";
+	for (i = 0 ; i < cookie->len ; i++) {
+		if (len < 2) {
+			strcpy(buf-3, "...");
+			break;
+		}
+		sprintf(buf, "%02x", cookie->data[i]);
+		buf += 2;
+		len -= 2;
+	}
+	*buf = '\0';
+}
+#endif
diff -ruN --exclude-from=excludes linux-2.4.19.orig/fs/lockd/xdr4.c
linux-2.4.19/fs/lockd/xdr4.c
--- linux-2.4.19.orig/fs/lockd/xdr4.c	Tue Mar  4 19:26:53 2003
+++ linux-2.4.19/fs/lockd/xdr4.c	Tue Mar  4 20:37:59 2003
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
-			"lockd: bad cookie size %d (only cookies under 8 bytes are supported.)\n", len);
+			"lockd: bad cookie size %d (only cookies under %d bytes are supported.)\n", len,
NLM_MAXCOOKIELEN);
 		return NULL;
 	}
 	return p;
@@ -540,7 +540,7 @@
  * Buffer requirements for NLM
  */
 #define NLM4_void_sz		0
-#define NLM4_cookie_sz		3	/* 1 len , 2 data */
+#define NLM4_cookie_sz		1+XDR_QUADLEN(NLM_MAXCOOKIELEN)
 #define NLM4_caller_sz		1+XDR_QUADLEN(NLM_MAXSTRLEN)
 #define NLM4_netobj_sz		1+XDR_QUADLEN(XDR_MAX_NETOBJ)
 /* #define NLM4_owner_sz		1+XDR_QUADLEN(NLM4_MAXOWNER) */
diff -ruN --exclude-from=excludes linux-2.4.19.orig/include/linux/lockd/debug.h
linux-2.4.19/include/linux/lockd/debug.h
--- linux-2.4.19.orig/include/linux/lockd/debug.h	Tue Mar  4 19:26:40 2003
+++ linux-2.4.19/include/linux/lockd/debug.h	Tue Mar  4 20:32:10 2003
@@ -49,4 +49,17 @@
 #define NLMDBG_ALL		0x7fff
 
 
+/*
+ * Support for printing NLM cookies in dprintk()
+ */
+#ifdef RPC_DEBUG
+struct nlm_cookie;
+extern const char *__nlmdbg_cookie2a(const struct nlm_cookie *, char *, int);
+#define NLMDBG_COOKIE_BUF   	char __nlmdbg_cookie_buf[2*NLM_MAXCOOKIELEN+1];
+#define nlmdbg_cookie2a(c) \
+    __nlmdbg_cookie2a(__nlmdbg_cookie_buf, sizeof(__nlmdbg_cookie_buf), (c))
+#else
+#define NLMDBG_COOKIE_BUF
+#endif
+
 #endif /* LINUX_LOCKD_DEBUG_H */
diff -ruN --exclude-from=excludes linux-2.4.19.orig/include/linux/lockd/xdr.h
linux-2.4.19/include/linux/lockd/xdr.h
--- linux-2.4.19.orig/include/linux/lockd/xdr.h	Tue Mar  4 19:26:40 2003
+++ linux-2.4.19/include/linux/lockd/xdr.h	Tue Mar  4 20:32:10 2003
@@ -33,14 +33,15 @@
 };
 
 /*
- *	NLM cookies. Technically they can be 1K, Nobody uses over 8 bytes
- *	however.
+ *	NLM cookies. Technically they can be 1K, Few people use over 8 bytes,
+ *	FreeBSD uses 16, Apple Mac OS-X 10.3 uses 20.
  */
  
 struct nlm_cookie
 {
-	unsigned char data[8];
 	unsigned int len;
+#define NLM_MAXCOOKIELEN    	32
+	unsigned char data[NLM_MAXCOOKIELEN];
 };
 
 /*


