Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030730AbWLETvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030730AbWLETvg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030709AbWLETvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:51:36 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:55718 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030629AbWLETve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:51:34 -0500
Date: Tue, 5 Dec 2006 14:50:13 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 26/35] Unionfs: Privileged operations workqueue
Message-ID: <20061205195013.GE2240@filer.fsl.cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu> <1165235471170-git-send-email-jsipek@cs.sunysb.edu> <Pine.LNX.4.61.0612052020420.18570@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0612052020420.18570@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 08:27:51PM +0100, Jan Engelhardt wrote:
> 
> On Dec 4 2006 07:30, Josef 'Jeff' Sipek wrote:
> >+#include "union.h"
> >+
> >+struct workqueue_struct *sioq;
> >+
> >+int __init init_sioq(void)
> 
> Although it's just me, I'd prefer sioq_init(), sioq_exit(),
> sioq_run(), etc. to go in hand with what most drivers use as naming
> (i.e. <modulename> "_" <function>).

That makes sense.

> >+	sioq = create_workqueue("unionfs_siod");
> 
> Beat me: what does SIO stand for?

Super-user IO - sometimes we need to perform actions which would fail due to
the unix permissions on the parent directory (e.g., rmdir a directory which
appears empty, but in reality contains whiteouts).

> >+void fin_sioq(void)
> 
> No __exit tag?

Good catch.

> >+void __unionfs_mknod(void *data)
> >+{
> >+	struct sioq_args *args = data;
> >+	struct mknod_args *m = &args->mknod;
> 
> Care to make that: const struct mknod_args *m = &args->mknod;?
> (Same for other places)
 
Right.
 
> >+
> >+	args->err = vfs_mknod(m->parent, m->dentry, m->mode, m->dev);
> >+	complete(&args->comp);
> >+}
> >+void __unionfs_symlink(void *data)
> >+{
> 
> Hah, missing free line :^)

:)

> >+	struct sioq_args *args = data;
> >+	struct symlink_args *s = &args->symlink;
> >+
> >+	args->err = vfs_symlink(s->parent, s->dentry, s->symbuf, s->mode);
> >+	complete(&args->comp);
> >+}
> >+
> 
> >+++ b/fs/unionfs/sioq.h
> >+struct isopaque_args {
> >+	struct dentry *dentry;
> >+};
> 
> This name puzzled me at first. iso - paque - "same (o)paque"?
> Try is_opaque_args.

Will do.

> >+/* Extern definitions for our privledge escalation helpers */
> 
> -> privilege

Why do I keep misspelling that?

Thanks for the comments.

Josef "Jeff" Sipek.

-- 
Bad pun of the week: The formula 1 control computer suffered from a race
condition
