Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261712AbSJQAHO>; Wed, 16 Oct 2002 20:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261713AbSJQAHO>; Wed, 16 Oct 2002 20:07:14 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:63989 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S261712AbSJQAHL>; Wed, 16 Oct 2002 20:07:11 -0400
Date: Wed, 16 Oct 2002 17:04:03 -0700
From: Chris Wright <chris@wirex.com>
To: Matt Reppert <arashi@arashi.yi.org>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AFS compile breakage in 2.5.43
Message-ID: <20021016170403.A28039@figure1.int.wirex.com>
Mail-Followup-To: Matt Reppert <arashi@arashi.yi.org>, dhowells@redhat.com,
	linux-kernel@vger.kernel.org
References: <20021016180350.52bc09ad.arashi@arashi.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021016180350.52bc09ad.arashi@arashi.yi.org>; from arashi@arashi.yi.org on Wed, Oct 16, 2002 at 06:03:50PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matt Reppert (arashi@arashi.yi.org) wrote:
> Is this valid? gcc-2.95.3 doesn't like it at all.

Yes, it's valid for newer compilers.  I have a similar patch that also
updates the varargs macro stuff used in AFS (and rxrpc) (for akpm's "crusty"
compilers ;-)

thanks,
-chris

--- 2.5.43/fs/afs/dir.c.egcs	Wed Oct 16 16:57:40 2002
+++ 2.5.43/fs/afs/dir.c	Wed Oct 16 16:57:51 2002
@@ -72,7 +72,7 @@
 		u8	name[16];
 		u8	overflow[4];	/* if any char of the name (inc NUL) reaches here, consume
 					 * the next dirent too */
-	};
+	} de;
 	u8	extended_name[32];
 } afs_dirent_t;
 
@@ -258,7 +258,7 @@
 
 		/* got a valid entry */
 		dire = &block->dirents[offset];
-		nlen = strnlen(dire->name,sizeof(*block) - offset*sizeof(afs_dirent_t));
+		nlen = strnlen(dire->de.name,sizeof(*block) - offset*sizeof(afs_dirent_t));
 
 		_debug("ENT[%u.%u]: %s %u \"%.*s\"\n",
 		       blkoff/sizeof(afs_dir_block_t),offset,
@@ -290,11 +290,11 @@
 
 		/* found the next entry */
 		ret = filldir(cookie,
-			      dire->name,
+			      dire->de.name,
 			      nlen,
 			      blkoff + offset * sizeof(afs_dirent_t),
-			      ntohl(dire->vnode),
-			      filldir==afs_dir_lookup_filldir ? dire->unique : DT_UNKNOWN);
+			      ntohl(dire->de.vnode),
+			      filldir==afs_dir_lookup_filldir ? dire->de.unique : DT_UNKNOWN);
 		if (ret<0) {
 			_leave(" = 0 [full]");
 			return 0;
--- 2.5.43/fs/afs/internal.h.egcs	Wed Oct 16 16:57:40 2002
+++ 2.5.43/fs/afs/internal.h	Wed Oct 16 17:07:17 2002
@@ -21,24 +21,24 @@
 /*
  * debug tracing
  */
-#define kenter(FMT,...)	printk("==> %s("FMT")\n",__FUNCTION__,##__VA_ARGS__)
-#define kleave(FMT,...)	printk("<== %s()"FMT"\n",__FUNCTION__,##__VA_ARGS__)
-#define kdebug(FMT,...)	printk(FMT"\n",##__VA_ARGS__)
-#define kproto(FMT,...)	printk("### "FMT"\n",##__VA_ARGS__)
-#define knet(FMT,...)	printk(FMT"\n",##__VA_ARGS__)
+#define kenter(FMT, VA...) printk("==> %s("FMT")\n", __FUNCTION__ , ##VA)
+#define kleave(FMT, VA...) printk("<== %s()"FMT"\n", __FUNCTION__ , ##VA)
+#define kdebug(FMT, VA...) printk(FMT"\n", ##VA)
+#define kproto(FMT, VA...) printk("### "FMT"\n", ##VA)
+#define knet(FMT, VA...)   printk(FMT"\n", ##VA)
 
 #if 0
-#define _enter(FMT,...)	kenter(FMT,##__VA_ARGS__)
-#define _leave(FMT,...)	kleave(FMT,##__VA_ARGS__)
-#define _debug(FMT,...)	kdebug(FMT,##__VA_ARGS__)
-#define _proto(FMT,...)	kproto(FMT,##__VA_ARGS__)
-#define _net(FMT,...)	knet(FMT,##__VA_ARGS__)
+#define _enter(FMT, VA...) kenter(FMT, ##VA)
+#define _leave(FMT, VA...) kleave(FMT, ##VA)
+#define _debug(FMT, VA...) kdebug(FMT, ##VA)
+#define _proto(FMT, VA...) kproto(FMT, ##VA)
+#define _net(FMT, VA...)   knet(FMT, ##VA)
 #else
-#define _enter(FMT,...)	do { } while(0)
-#define _leave(FMT,...)	do { } while(0)
-#define _debug(FMT,...)	do { } while(0)
-#define _proto(FMT,...)	do { } while(0)
-#define _net(FMT,...)	do { } while(0)
+#define _enter(FMT, VA...) do { } while(0)
+#define _leave(FMT, VA...) do { } while(0)
+#define _debug(FMT, VA...) do { } while(0)
+#define _proto(FMT, VA...) do { } while(0)
+#define _net(FMT, VA...)   do { } while(0)
 #endif
 
 #if LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,0)
--- 2.5.43/net/rxrpc/internal.h.egcs	Wed Oct 16 16:57:40 2002
+++ 2.5.43/net/rxrpc/internal.h	Wed Oct 16 17:08:49 2002
@@ -29,24 +29,24 @@
 /*
  * debug tracing
  */
-#define kenter(FMT,...)	printk("==> %s("FMT")\n",__FUNCTION__,##__VA_ARGS__)
-#define kleave(FMT,...)	printk("<== %s()"FMT"\n",__FUNCTION__,##__VA_ARGS__)
-#define kdebug(FMT,...)	printk("    "FMT"\n",##__VA_ARGS__)
-#define kproto(FMT,...)	printk("### "FMT"\n",##__VA_ARGS__)
-#define knet(FMT,...)	printk("    "FMT"\n",##__VA_ARGS__)
+#define kenter(FMT, VA...)	printk("==> %s("FMT")\n", __FUNCTION__ , ##VA)
+#define kleave(FMT, VA...)	printk("<== %s()"FMT"\n", __FUNCTION__ , ##VA)
+#define kdebug(FMT, VA...)	printk("    "FMT"\n", ##VA)
+#define kproto(FMT, VA...)	printk("### "FMT"\n", ##VA)
+#define knet(FMT, VA...)	printk("    "FMT"\n", ##VA)
 
 #if 0
-#define _enter(FMT,...)	kenter(FMT,##__VA_ARGS__)
-#define _leave(FMT,...)	kleave(FMT,##__VA_ARGS__)
-#define _debug(FMT,...)	kdebug(FMT,##__VA_ARGS__)
-#define _proto(FMT,...)	kproto(FMT,##__VA_ARGS__)
-#define _net(FMT,...)	knet(FMT,##__VA_ARGS__)
+#define _enter(FMT, VA...)	kenter(FMT,##VA)
+#define _leave(FMT, VA...)	kleave(FMT,##VA)
+#define _debug(FMT, VA...)	kdebug(FMT,##VA)
+#define _proto(FMT, VA...)	kproto(FMT,##VA)
+#define _net(FMT, VA...)	knet(FMT,##VA)
 #else
-#define _enter(FMT,...)	do { if (rxrpc_ktrace) kenter(FMT,##__VA_ARGS__); } while(0)
-#define _leave(FMT,...)	do { if (rxrpc_ktrace) kleave(FMT,##__VA_ARGS__); } while(0)
-#define _debug(FMT,...)	do { if (rxrpc_kdebug) kdebug(FMT,##__VA_ARGS__); } while(0)
-#define _proto(FMT,...)	do { if (rxrpc_kproto) kproto(FMT,##__VA_ARGS__); } while(0)
-#define _net(FMT,...)	do { if (rxrpc_knet)   knet  (FMT,##__VA_ARGS__); } while(0)
+#define _enter(FMT, VA...)	do { if (rxrpc_ktrace) kenter(FMT, ##VA); } while(0)
+#define _leave(FMT, VA...)	do { if (rxrpc_ktrace) kleave(FMT, ##VA); } while(0)
+#define _debug(FMT, VA...)	do { if (rxrpc_kdebug) kdebug(FMT, ##VA); } while(0)
+#define _proto(FMT, VA...)	do { if (rxrpc_kproto) kproto(FMT, ##VA); } while(0)
+#define _net(FMT, VA...)	do { if (rxrpc_knet)   knet  (FMT, ##VA); } while(0)
 #endif
 
 static inline void rxrpc_discard_my_signals(void)
--- 2.5.43/net/rxrpc/main.c.egcs	Wed Oct 16 16:57:40 2002
+++ 2.5.43/net/rxrpc/main.c	Wed Oct 16 16:57:51 2002
@@ -123,5 +123,5 @@
 	__RXACCT(printk("Outstanding Peers      : %d\n",atomic_read(&rxrpc_peer_count)));
 	__RXACCT(printk("Outstanding Transports : %d\n",atomic_read(&rxrpc_transport_count)));
 
-	kleave();
+	kleave("");
 } /* end rxrpc_cleanup() */
