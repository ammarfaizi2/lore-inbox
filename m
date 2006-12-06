Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936935AbWLFRgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936935AbWLFRgI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 12:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936942AbWLFRgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 12:36:08 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:35472 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936935AbWLFRgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 12:36:06 -0500
Date: Wed, 6 Dec 2006 12:32:45 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 26/35] Unionfs: Privileged operations workqueue
Message-ID: <20061206173245.GA23405@filer.fsl.cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu> <1165235471170-git-send-email-jsipek@cs.sunysb.edu> <Pine.LNX.4.61.0612052020420.18570@yvahk01.tjqt.qr> <20061205195013.GE2240@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205195013.GE2240@filer.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 02:50:13PM -0500, Josef Sipek wrote:
> On Tue, Dec 05, 2006 at 08:27:51PM +0100, Jan Engelhardt wrote:
> > 
> > On Dec 4 2006 07:30, Josef 'Jeff' Sipek wrote:
> > >+#include "union.h"
> > >+
> > >+struct workqueue_struct *sioq;
> > >+
> > >+int __init init_sioq(void)
> > 
> > Although it's just me, I'd prefer sioq_init(), sioq_exit(),
> > sioq_run(), etc. to go in hand with what most drivers use as naming
> > (i.e. <modulename> "_" <function>).
> 
> That makes sense.
 
Hrm. Looking at the code, I noticed that the opposite is true:

destroy_filldir_cache();
destroy_inode_cache();
destroy_dentry_cache();
unregister_filesystem(&unionfs_fs_type);

The last one in particular...
 
> > >+void __unionfs_mknod(void *data)
> > >+{
> > >+	struct sioq_args *args = data;
> > >+	struct mknod_args *m = &args->mknod;
> > 
> > Care to make that: const struct mknod_args *m = &args->mknod;?
> > (Same for other places)
>  
> Right.
 
If I make the *args = data line const, then gcc (4.1) yells about modifying
a const variable 3 lines down..

args->err = vfs_mknod(m->parent, m->dentry, m->mode, m->dev);

Sure, I could cast, but that seems like adding cruft for no good reason.

Josef "Jeff" Sipek.

-- 
Only two things are infinite, the universe and human stupidity, and I'm not
sure about the former.
		- Albert Einstein
