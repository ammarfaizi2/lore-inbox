Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQKCAph>; Thu, 2 Nov 2000 19:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130036AbQKCAp1>; Thu, 2 Nov 2000 19:45:27 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:65488 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129431AbQKCApO>;
	Thu, 2 Nov 2000 19:45:14 -0500
Date: Thu, 2 Nov 2000 19:45:06 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl fixes - part 1
Message-ID: <Pine.GSO.4.21.0011021932410.13665-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Bunch of sysctl bugs:
* use of proc_dostring with ->strategy==NULL instead of systcl_string.
* use of sysctl_intvec with NULL ->extra1 and ->extra2 (harmless, but silly).
Patch follows. Please, apply.
							Cheers,
								Al
PS: that's the first part of large sequence and I'm not sure that everything
will go for 2.4, but I'll try to feed that stuff in reasonable order. The
final goal: kernfs. As in "dcache-based, sysctl(2) done via path_walk(),
no bloody static initializers, less crap in procfs". I _hope_ that it will
go in 2.4.<something>, but even if it's 2.5 fodder there are obvious bugs
that can be fixed without any API changes.

diff -urN rc10/net/core/sysctl_net_core.c rc10-sysctl/net/core/sysctl_net_core.c
--- rc10/net/core/sysctl_net_core.c	Thu Nov  2 22:39:09 2000
+++ rc10-sysctl/net/core/sysctl_net_core.c	Thu Nov  2 22:45:45 2000
@@ -82,7 +82,7 @@
 #ifdef CONFIG_NET_DIVERT
 	{NET_CORE_DIVERT_VERSION, "divert_version",
 	 (void *)sysctl_divert_version, 32, 0444, NULL,
-	 &proc_dostring},
+	 &proc_dostring, sysctl_dostring},
 #endif /* CONFIG_NET_DIVERT */
 #endif /* CONFIG_NET */
 	{ 0 }
diff -urN rc10/net/decnet/sysctl_net_decnet.c rc10-sysctl/net/decnet/sysctl_net_decnet.c
--- rc10/net/decnet/sysctl_net_decnet.c	Thu Apr 27 22:01:29 2000
+++ rc10-sysctl/net/decnet/sysctl_net_decnet.c	Thu Nov  2 22:48:55 2000
@@ -345,8 +345,7 @@
 	&min_decnet_dst_gc_interval, &max_decnet_dst_gc_interval},
 	{NET_DECNET_DEBUG_LEVEL, "debug", &decnet_debug_level, 
 	sizeof(int), 0644, 
-	NULL, &proc_dointvec, &sysctl_intvec, NULL,
-	NULL, NULL},
+	NULL, &proc_dointvec},
 	{0}
 };
 
diff -urN rc10/net/khttpd/sysctl.c rc10-sysctl/net/khttpd/sysctl.c
--- rc10/net/khttpd/sysctl.c	Sun Sep 12 21:16:55 1999
+++ rc10-sysctl/net/khttpd/sysctl.c	Thu Nov  2 22:48:03 2000
@@ -83,9 +83,6 @@
 		NULL,
 		proc_dostring,
 		&sysctl_string,
-		NULL,
-		NULL,
-		NULL
 	},
 	{	NET_KHTTPD_STOP,
 		"stop",
@@ -94,10 +91,6 @@
 		0644,
 		NULL,
 		proc_dointvec,
-		&sysctl_intvec,
-		NULL,
-		NULL,
-		NULL
 	},
 	{	NET_KHTTPD_START,
 		"start",
@@ -106,10 +99,6 @@
 		0644,
 		NULL,
 		proc_dointvec,
-		&sysctl_intvec,
-		NULL,
-		NULL,
-		NULL
 	},
 	{	NET_KHTTPD_UNLOAD,
 		"unload",
@@ -118,10 +107,6 @@
 		0644,
 		NULL,
 		proc_dointvec,
-		&sysctl_intvec,
-		NULL,
-		NULL,
-		NULL
 	},
 	{	NET_KHTTPD_THREADS,
 		"threads",
@@ -130,10 +115,6 @@
 		0644,
 		NULL,
 		proc_dointvec,
-		&sysctl_intvec,
-		NULL,
-		NULL,
-		NULL
 	},
 	{	NET_KHTTPD_MAXCONNECT,
 		"maxconnect",
@@ -142,10 +123,6 @@
 		0644,
 		NULL,
 		proc_dointvec,
-		&sysctl_intvec,
-		NULL,
-		NULL,
-		NULL
 	},
 	{	NET_KHTTPD_SLOPPYMIME,
 		"sloppymime",
@@ -154,10 +131,6 @@
 		0644,
 		NULL,
 		proc_dointvec,
-		&sysctl_intvec,
-		NULL,
-		NULL,
-		NULL
 	},
 	{	NET_KHTTPD_CLIENTPORT,
 		"clientport",
@@ -166,10 +139,6 @@
 		0644,
 		NULL,
 		proc_dointvec,
-		&sysctl_intvec,
-		NULL,
-		NULL,
-		NULL
 	},
 	{	NET_KHTTPD_PERMREQ,
 		"perm_required",
@@ -178,10 +147,6 @@
 		0644,
 		NULL,
 		proc_dointvec,
-		&sysctl_intvec,
-		NULL,
-		NULL,
-		NULL
 	},
 	{	NET_KHTTPD_PERMFORBID,
 		"perm_forbid",
@@ -190,10 +155,6 @@
 		0644,
 		NULL,
 		proc_dointvec,
-		&sysctl_intvec,
-		NULL,
-		NULL,
-		NULL
 	},
 	{	NET_KHTTPD_LOGGING,
 		"logging",
@@ -202,10 +163,6 @@
 		0644,
 		NULL,
 		proc_dointvec,
-		&sysctl_intvec,
-		NULL,
-		NULL,
-		NULL
 	},
 	{	NET_KHTTPD_SERVERPORT,
 		"serverport",
@@ -214,10 +171,6 @@
 		0644,
 		NULL,
 		proc_dointvec,
-		&sysctl_intvec,
-		NULL,
-		NULL,
-		NULL
 	},
 	{	NET_KHTTPD_DYNAMICSTRING,
 		"dynamic",
@@ -227,21 +180,19 @@
 		NULL,
 		proc_dosecurestring,
 		&sysctl_SecureString,
-		NULL,
-		NULL,
-		NULL
 	},
-	{0,0,0,0,0,0,0,0,0,0,0}	};
+	{0}
+};
 	
 	
 static ctl_table khttpd_dir_table[] = {
 	{NET_KHTTPD, "khttpd", NULL, 0, 0555, khttpd_table,0,0,0,0,0},
-	{0,0,0,0,0,0,0,0,0,0,0}
+	{0}
 };
 
 static ctl_table khttpd_root_table[] = {
 	{CTL_NET, "net", NULL, 0, 0555, khttpd_dir_table,0,0,0,0,0},
-	{0,0,0,0,0,0,0,0,0,0,0}
+	{0}
 };
 	
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
