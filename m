Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbTJMEoU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 00:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbTJMEoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 00:44:20 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:39085 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261397AbTJMEoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 00:44:17 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Date: Mon, 13 Oct 2003 14:43:57 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16266.11661.91185.167555@notabene.cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: include/linux/nfs/nfsfh.h declares a symbol
In-Reply-To: message from  =?ISO-8859-1?Q?=20J=F6rn?= Engel on Wednesday October 1
References: <20031001121811.GE31698@wohnheim.fh-wedel.de>
X-Mailer: VM 7.17 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday October 1, joern@wohnheim.fh-wedel.de wrote:
> Neil, the function SVCFH_fmt uses a static variable to sprintf into.
> Looks like this variable is declared locally for every .c file
> including nfsfh.h, which is quite a few.
> 
> You could remove the static, but that would increase the stack usage,
> which might be a problem too.  The buffer could be reduced to 64
> chars, to reduce that problem.  kmalloc()ing it seems a bit expensive,
> but might be an option, too.

Thanks.  I think it is best to simply make SVCFH_fmt a real function
instead of inline, as below.

NeilBrown

=======================================
Move SVCFH_fmt from being 'inline' to being 'extern'.

This way, the "static char buf" is defined only once instead
of once per file.

 ----------- Diffstat output ------------
 ./fs/nfsd/nfsfh.c            |   18 ++++++++++++++++++
 ./include/linux/nfsd/nfsfh.h |   17 ++---------------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff ./fs/nfsd/nfsfh.c~current~ ./fs/nfsd/nfsfh.c
--- ./fs/nfsd/nfsfh.c~current~	2003-10-13 14:24:46.000000000 +1000
+++ ./fs/nfsd/nfsfh.c	2003-10-13 14:30:06.000000000 +1000
@@ -489,3 +489,21 @@ fh_put(struct svc_fh *fhp)
 	return;
 }
 
+/*
+ * Shorthand for dprintk()'s
+ */
+char * SVCFH_fmt(struct svc_fh *fhp)
+{
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	
+	static char buf[80];
+	sprintf(buf, "%d: %08x %08x %08x %08x %08x %08x",
+		fh->fh_size,
+		fh->fh_base.fh_pad[0],
+		fh->fh_base.fh_pad[1],
+		fh->fh_base.fh_pad[2],
+		fh->fh_base.fh_pad[3],
+		fh->fh_base.fh_pad[4],
+		fh->fh_base.fh_pad[5]);
+	return buf;
+}

diff ./include/linux/nfsd/nfsfh.h~current~ ./include/linux/nfsd/nfsfh.h
--- ./include/linux/nfsd/nfsfh.h~current~	2003-10-13 14:22:27.000000000 +1000
+++ ./include/linux/nfsd/nfsfh.h	2003-10-13 14:30:16.000000000 +1000
@@ -186,21 +186,8 @@ static inline void mk_fsid_v2(u32 *fsidv
 /*
  * Shorthand for dprintk()'s
  */
-inline static char * SVCFH_fmt(struct svc_fh *fhp)
-{
-	struct knfsd_fh *fh = &fhp->fh_handle;
-	
-	static char buf[80];
-	sprintf(buf, "%d: %08x %08x %08x %08x %08x %08x",
-		fh->fh_size,
-		fh->fh_base.fh_pad[0],
-		fh->fh_base.fh_pad[1],
-		fh->fh_base.fh_pad[2],
-		fh->fh_base.fh_pad[3],
-		fh->fh_base.fh_pad[4],
-		fh->fh_base.fh_pad[5]);
-	return buf;
-}
+extern char * SVCFH_fmt(struct svc_fh *fhp);
+
 /*
  * Function prototypes
  */
