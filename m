Return-Path: <linux-kernel-owner+w=401wt.eu-S1760665AbWLJWgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760665AbWLJWgM (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 17:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760663AbWLJWgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 17:36:11 -0500
Received: from mail.suse.de ([195.135.220.2]:48264 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760665AbWLJWgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 17:36:10 -0500
From: Neil Brown <neilb@suse.de>
To: Olaf Titz <olaf@bigred.inka.de>
Date: Mon, 11 Dec 2006 09:36:16 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17788.35808.421807.546159@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19: OOPS in cat /proc/fs/nfs/exports
In-Reply-To: message from Olaf Titz on Sunday December 10
References: <E1GrJH9-0003Hr-00@bigred.inka.de>
	<17780.62607.544405.181452@cse.unsw.edu.au>
	<E1Gripc-0004KC-00@bigred.inka.de>
	<17783.28848.504885.606906@cse.unsw.edu.au>
	<E1GtWmU-0007Cu-00@bigred.inka.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday December 10, olaf@bigred.inka.de wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> > What version of nfs-utils are you running?  We haven't been using
> > nfsservctl(3, ...) on 2.6 kernels for ages - which probably explains
> > why exp_export() has suffered so much bit-rot.  When I convinced
> > exportfs to use that nfsservctl I got a very similar oops.
> >
> > This patch fixes it for me.  Does it fix it for you too?
> 
> The patch fixes the problem; however when I tested it, after some
> export/unexport cycles, trying to mount gave me this:
> 
> Dec 10 21:32:10 glotze kernel: kernel BUG at /usr/opt/src/kernel/linux-2.6.19/mm/slab.c:594!
> Dec 10 21:32:10 glotze kernel: invalid opcode: 0000 [#1]

Looks like that might be a bug in the patch I sent you, which I fixed
before I sent it upstream.  Could you try this (against 2.6.19)
instead and confirm that it fixes all problems? thanks.

> 
> Might be unrelated (mountd not exportfs), but perhaps this code has
> got as much bitrot too.
> 
> I've replaced exportfs, mountd and nfsd with a newer version and it
> works now.

What version were you using?  I would really like to know.

> 
> If this nfsservctl functions are not used anymore by the officially
> supported version of system tools, shouldn't that code be removed
> altogether? If OTOH it falls under "don't break userspace interface",
> perhaps there is more left to fix...

Yes, it is a case of "don't break userspace interface" - at least not
without suitable warning and good reason.  So I want the old nfs-utils
to still work. (We might deprecate the old interface one day, but not
yet). 

Thanks,
NeilBrown

-----------------------------------
Fix up some bit-rot in exp_export

The nfsservctl systemcall isn't used but recent nfs-utils releases for
exporting filesystems, and consequently the code that is uses -
exp_export - has suffered some bitrot.

Particular:
  - some newly added fields in 'struct svc_export' are being initialised
    properly.
  - the return value is now always -ENOMEM ...

This patch fixes both these problems.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff .prev/fs/nfsd/export.c ./fs/nfsd/export.c
--- .prev/fs/nfsd/export.c	2006-12-11 09:35:46.000000000 +1100
+++ ./fs/nfsd/export.c	2006-12-11 09:35:48.000000000 +1100
@@ -950,6 +950,8 @@ exp_export(struct nfsctl_export *nxp)
 
 	exp = exp_get_by_name(clp, nd.mnt, nd.dentry, NULL);
 
+	memset(&new, 0, sizeof(new));
+
 	/* must make sure there won't be an ex_fsid clash */
 	if ((nxp->ex_flags & NFSEXP_FSID) &&
 	    (fsid_key = exp_get_fsid_key(clp, nxp->ex_dev)) &&
@@ -980,6 +982,9 @@ exp_export(struct nfsctl_export *nxp)
 
 	new.h.expiry_time = NEVER;
 	new.h.flags = 0;
+	new.ex_path = kstrdup(nxp->ex_path, GFP_KERNEL);
+	if (! new.ex_path)
+		goto finish;
 	new.ex_client = clp;
 	new.ex_mnt = nd.mnt;
 	new.ex_dentry = nd.dentry;
@@ -1000,10 +1005,11 @@ exp_export(struct nfsctl_export *nxp)
 		/* failed to create at least one index */
 		exp_do_unexport(exp);
 		cache_flush();
-		err = -ENOMEM;
-	}
-
+	} else
+		err = 0;
 finish:
+	if (new.ex_path)
+		kfree(new.ex_path);
 	if (exp)
 		exp_put(exp);
 	if (fsid_key && !IS_ERR(fsid_key))
