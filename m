Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937929AbWLGBiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937929AbWLGBiv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 20:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937927AbWLGBiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 20:38:50 -0500
Received: from ns.suse.de ([195.135.220.2]:42576 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937929AbWLGBit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 20:38:49 -0500
From: Neil Brown <neilb@suse.de>
To: Olaf Titz <Olaf.Titz@inka.de>
Date: Thu, 7 Dec 2006 12:38:56 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17783.28848.504885.606906@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19: OOPS in cat /proc/fs/nfs/exports
In-Reply-To: message from Olaf Titz on Tuesday December 5
References: <E1GrJH9-0003Hr-00@bigred.inka.de>
	<17780.62607.544405.181452@cse.unsw.edu.au>
	<E1Gripc-0004KC-00@bigred.inka.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday December 5, Olaf.Titz@inka.de wrote:
> 
> strace on exportfs shows this:nfsservctl(0x3, 0xbf875824, 0)          =
> - -1 ENOMEM

What version of nfs-utils are you running?  We haven't been using
nfsservctl(3, ...) on 2.6 kernels for ages - which probably explains
why exp_export() has suffered so much bit-rot.  When I convinced
exportfs to use that nfsservctl I got a very similar oops.


This patch fixes it for me.  Does it fix it for you too?

Thanks,
NeilBrown



diff .prev/fs/nfsd/export.c ./fs/nfsd/export.c
--- .prev/fs/nfsd/export.c	2006-12-06 14:57:24.000000000 +1100
+++ ./fs/nfsd/export.c	2006-12-07 12:36:28.000000000 +1100
@@ -983,6 +983,9 @@ exp_export(struct nfsctl_export *nxp)
 
 	dprintk("nfsd: creating export entry %p for client %p\n", exp, clp);
 
+	new.ex_path = kstrdup(nxp->ex_path, GFP_KERNEL);
+	if (!new.ex_path)
+		goto finish;
 	new.h.expiry_time = NEVER;
 	new.h.flags = 0;
 	new.ex_client = clp;
@@ -992,6 +995,9 @@ exp_export(struct nfsctl_export *nxp)
 	new.ex_anon_uid = nxp->ex_anon_uid;
 	new.ex_anon_gid = nxp->ex_anon_gid;
 	new.ex_fsid = nxp->ex_dev;
+	new.ex_fslocs.locations = NULL;
+	new.ex_fslocs.locations_count = 0;
+	new.ex_fslocs.migrated = 0;
 
 	exp = svc_export_lookup(&new);
 	if (exp)
@@ -1007,8 +1013,10 @@ exp_export(struct nfsctl_export *nxp)
 		cache_flush();
 		err = -ENOMEM;
 	}
-
+	err = 0;
 finish:
+	if (new.ex_path)
+		kfree(new.ex_path);
 	if (exp)
 		exp_put(exp);
 	if (fsid_key && !IS_ERR(fsid_key))

