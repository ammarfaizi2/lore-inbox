Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265511AbUBFOAf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 09:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265507AbUBFOAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 09:00:33 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:22033 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S265506AbUBFOAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 09:00:30 -0500
Date: Fri, 6 Feb 2004 15:00:15 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andreas Gruenbacher <agruen@suse.de>
cc: "kbuild-devel@lists.sourceforge.net" 
	<kbuild-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Bug in "select" dependency checking?
In-Reply-To: <1076027838.2223.95.camel@nb.suse.de>
Message-ID: <Pine.LNX.4.58.0402061448500.7851@serv>
References: <1076027838.2223.95.camel@nb.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 6 Feb 2004, Andreas Gruenbacher wrote:

> With this configuration, menuconf gives me this message (among others):
>
>   Warning! Found recursive dependency: NFSD_V3 NFSD_ACL NFSD NFSD_V3

This is indeed a wrong positive, the patch below fixes this, but you if
change your config into e.g.:

config NFSD_ACL
	bool "..."
	depends on NFSD_V3
	select NFS_ACL_SUPPORT if NFSD

you avoid the warning and it does the same.

> In my understanding, the select statement does not cause a dependency of
> NFSD on NFSD_ACL. I can write the same thing without selects as follows:
>
>   config NFS_ACL_SUPPORT
>         tristate
>         default y if (NFSD=y || NFS_FS=y) && (NFSD_ACL || NFS_ACL)
>         default m if (NFSD!=y && NFS_FS!=y) && (NFSD=m || NFS_FS=m) &&
> 		     (NFSD_ACL || NFS_ACL)

Or you could also write this simpler as:

config NFS_ACL_SUPPORT
	tristate
	default (NFSD && NFSD_ACL) || (NFS_FS && NFS_ACL)

bye, Roman

Index: scripts/kconfig/symbol.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.6/scripts/kconfig/symbol.c,v
retrieving revision 1.1.1.2
diff -u -p -r1.1.1.2 symbol.c
--- scripts/kconfig/symbol.c	9 Sep 2003 08:33:49 -0000	1.1.1.2
+++ scripts/kconfig/symbol.c	6 Feb 2004 13:51:39 -0000
@@ -706,7 +706,7 @@ struct symbol *sym_check_deps(struct sym
 		goto out;

 	for (prop = sym->prop; prop; prop = prop->next) {
-		if (prop->type == P_CHOICE)
+		if (prop->type == P_CHOICE || prop->type == P_SELECT)
 			continue;
 		sym2 = sym_check_expr_deps(prop->visible.expr);
 		if (sym2)
