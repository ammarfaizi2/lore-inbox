Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbUCJRQg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 12:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUCJRQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 12:16:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:55176 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262728AbUCJRQb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 12:16:31 -0500
Date: Wed, 10 Mar 2004 09:14:24 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Fabian LoneStar =?ISO-8859-1?Q?Fr=E9d=E9rick" ?= 
	<fabian.frederick@gmx.fr>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2.6.4rc2mm1] nfsroot parser
Message-Id: <20040310091424.4ce14f15.rddunlap@osdl.org>
In-Reply-To: <24490.1078916018@www18.gmx.net>
References: <24490.1078916018@www18.gmx.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004 11:53:38 +0100 (MET) Fabian LoneStar Frédérick wrote:

| Hi,
| 
|       Here's a patch against 2.6.4rc2mm1.
| 
|             -Nfs root standard parser
|             -Enum activated :)
| 
| PS : This time it compiles :)


diff -Naur orig/fs/nfs/nfsroot.c edited/fs/nfs/nfsroot.c
--- orig/fs/nfs/nfsroot.c	2004-03-10 10:54:23.000000000 +0100
+++ edited/fs/nfs/nfsroot.c	2004-03-10 11:43:05.000000000 +0100
 
-static void __init root_nfs_parse(char *name, char *buf)
+
+static int __init root_nfs_parse(char *name, char *buf)
 {
 
+	char *p;
+	substring_t args[MAX_OPT_ARGS];
+	int option;
+
+	if (!name)
+		return 1;
+
+	if (name[0] && strcmp(name, "default")){
+		strlcpy(buf, name, NFS_MAXPATHLEN);
+		return 1;
+	}
+	while ((p = strsep (&name, ",")) != NULL) {
+		int token; 
+		if (!*p)
+			continue;
+		token = match_token(p, tokens, args);
+
+		/* %u tokens only */
+		if (match_int(&args[0], &option))
+                                return 0;
+		switch (token) {
...

What??  "soft" just needs to set NFS_MOUNT_SOFT, "hard" needs to clear
(reset) it.
That "... |= 0" is useless.
Similar for other options that are "opposites" of each other.
So typically each case below is:
				set_or_reset_a_value;
				break;

And please s/ ;/;/ on those line endings.

+			case Opt_soft:
+				nfs_data.flags &= ~NFS_MOUNT_SOFT;
+				nfs_data.flags |= NFS_MOUNT_SOFT;
+				break;
+			case Opt_hard:
+				nfs_data.flags &= ~NFS_MOUNT_SOFT ;
+				nfs_data.flags |= 0 ;
+				break;
+			case Opt_intr:
+				nfs_data.flags &= ~NFS_MOUNT_INTR;
+				nfs_data.flags |= NFS_MOUNT_INTR;
+				break;
+			case Opt_nointr:
+				nfs_data.flags &= ~NFS_MOUNT_INTR;
+				nfs_data.flags |= 0;
+				break;
+			case Opt_posix:
+				nfs_data.flags &= ~NFS_MOUNT_POSIX;
+				nfs_data.flags |= NFS_MOUNT_POSIX;
+				break;
+			case Opt_noposix:
+				nfs_data.flags &= ~NFS_MOUNT_POSIX;
+				nfs_data.flags |= 0;
+				break;
+			case Opt_cto:
+				nfs_data.flags &= ~NFS_MOUNT_NOCTO;
+				nfs_data.flags |= 0;
+				break;
+			case Opt_nocto:
+				nfs_data.flags &= ~NFS_MOUNT_NOCTO;
+				nfs_data.flags |= NFS_MOUNT_NOCTO;
+				break;
+			case Opt_ac:
+				nfs_data.flags &= ~NFS_MOUNT_NOAC;
+				nfs_data.flags |= 0;
+				break;
+			case Opt_noac:
+				nfs_data.flags &= ~NFS_MOUNT_NOAC;
+				nfs_data.flags |= NFS_MOUNT_NOAC;
+				break;
+			case Opt_lock:
+				nfs_data.flags &= ~NFS_MOUNT_NONLM;
+				nfs_data.flags |= 0;
+				break;
+			case Opt_nolock:
+				nfs_data.flags &= ~NFS_MOUNT_NONLM;
+				nfs_data.flags |= NFS_MOUNT_NONLM;
+				break;
+			case Opt_v2:
+				nfs_data.flags &= ~NFS_MOUNT_VER3;
+				nfs_data.flags |= 0;
+				break;
+			case Opt_v3:
+				nfs_data.flags &= ~NFS_MOUNT_VER3;
+				nfs_data.flags |= NFS_MOUNT_VER3;
+				break;
+			case Opt_udp:
+				nfs_data.flags &= ~NFS_MOUNT_TCP;
+				nfs_data.flags |= 0;
+				break;
+			case Opt_tcp:
+				nfs_data.flags &= ~NFS_MOUNT_TCP;
+				nfs_data.flags |= NFS_MOUNT_TCP;
+				break;
+			case Opt_broken_suid:
+				nfs_data.flags &= ~NFS_MOUNT_BROKEN_SUID;
+				nfs_data.flags |= NFS_MOUNT_BROKEN_SUID;
+				break;
+			default : 
+				return 0;
 		}
 	}

--
~Randy
