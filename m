Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261324AbSJLSNF>; Sat, 12 Oct 2002 14:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261326AbSJLSNF>; Sat, 12 Oct 2002 14:13:05 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:10200 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261324AbSJLSND>; Sat, 12 Oct 2002 14:13:03 -0400
To: neilb@cse.unsw.edu.au
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.42: build nfsd as module broken
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Sat, 12 Oct 2002 20:18:14 +0200
Message-ID: <871y6vwmft.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# make modules_install
gives the following error:

[...]
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.42; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.42/kernel/fs/nfsd/nfsd.o
depmod:         auth_domain_find
depmod:         cache_fresh
depmod:         unix_domain_find
depmod:         auth_domain_put
depmod:         cache_flush
depmod:         cache_unregister
depmod:         add_hex
depmod:         cache_check
depmod:         svcauth_unix_purge
depmod:         get_word
depmod:         cache_clean
depmod:         cache_register
depmod:         auth_unix_lookup
depmod:         auth_unix_add_addr
depmod:         cache_init
depmod:         auth_unix_forget_old
depmod:         add_word

This patch adds several EXPORT_SYMBOL() to net/sunrpc/*.c. The kernel
builds and boots. I haven't tested nfsd yet.

Regards, Olaf.

diff -urN a/net/sunrpc/Makefile b/net/sunrpc/Makefile
--- a/net/sunrpc/Makefile	Sat Oct 12 14:24:21 2002
+++ b/net/sunrpc/Makefile	Sat Oct 12 19:37:20 2002
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_SUNRPC) += sunrpc.o
 
-export-objs := sunrpc_syms.o
+export-objs := sunrpc_syms.o svcauth.o svcauth_unix.o cache.o
 
 sunrpc-y := clnt.o xprt.o sched.o \
 	    auth.o auth_null.o auth_unix.o \
diff -urN a/net/sunrpc/cache.c b/net/sunrpc/cache.c
--- a/net/sunrpc/cache.c	Sat Oct 12 14:24:21 2002
+++ b/net/sunrpc/cache.c	Sat Oct 12 18:26:05 2002
@@ -925,3 +925,14 @@
 		return len;
 	return -1;
 }
+
+EXPORT_SYMBOL(cache_fresh);
+EXPORT_SYMBOL(cache_flush);
+EXPORT_SYMBOL(cache_unregister);
+EXPORT_SYMBOL(cache_check);
+EXPORT_SYMBOL(cache_clean);
+EXPORT_SYMBOL(cache_register);
+EXPORT_SYMBOL(cache_init);
+EXPORT_SYMBOL(add_word);
+EXPORT_SYMBOL(add_hex);
+EXPORT_SYMBOL(get_word);
diff -urN a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
--- a/net/sunrpc/svcauth.c	Sat Oct 12 14:24:21 2002
+++ b/net/sunrpc/svcauth.c	Sat Oct 12 19:36:38 2002
@@ -16,6 +16,7 @@
 #include <linux/sunrpc/svcsock.h>
 #include <linux/sunrpc/svcauth.h>
 #include <linux/err.h>
+#include <linux/module.h>
 
 #define RPCDBG_FACILITY	RPCDBG_AUTH
 
@@ -189,3 +190,6 @@
 	rv = auth_domain_lookup(&ad, 0);
 	return rv;
 }
+
+EXPORT_SYMBOL(auth_domain_find);
+EXPORT_SYMBOL(auth_domain_put);
diff -urN a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
--- a/net/sunrpc/svcauth_unix.c	Sat Oct 12 14:24:21 2002
+++ b/net/sunrpc/svcauth_unix.c	Sat Oct 12 18:25:16 2002
@@ -5,6 +5,7 @@
 #include <linux/sunrpc/svcsock.h>
 #include <linux/sunrpc/svcauth.h>
 #include <linux/err.h>
+#include <linux/module.h>
 
 #define RPCDBG_FACILITY	RPCDBG_AUTH
 
@@ -462,3 +463,8 @@
 	.release	= svcauth_unix_release,
 };
 
+EXPORT_SYMBOL(unix_domain_find);
+EXPORT_SYMBOL(auth_unix_lookup);
+EXPORT_SYMBOL(auth_unix_add_addr);
+EXPORT_SYMBOL(auth_unix_forget_old);
+EXPORT_SYMBOL(svcauth_unix_purge);
