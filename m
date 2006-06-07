Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWFGFi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWFGFi7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 01:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWFGFi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 01:38:59 -0400
Received: from pat.uio.no ([129.240.10.4]:59568 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750935AbWFGFi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 01:38:59 -0400
Subject: Re: [PATCH] NFS server does not update mtime on setattr request
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Staubach <staubach@redhat.com>
Cc: Neil Brown <neilb@suse.de>, NFS List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4485C3FE.5070504@redhat.com>
References: <4485C3FE.5070504@redhat.com>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 01:38:26 -0400
Message-Id: <1149658707.27298.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.118, required 12,
	autolearn=disabled, AWL 1.70, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 14:05 -0400, Peter Staubach wrote:

> On the NFS client side, there was an optimization added which attempted
> to avoid an over the wire call if the size of the file was not going to
> change.  This would be great, except for the side effect of the mtime
> on the file needing to change anyway.  The solution is just to issue the
> over the wire call anyway, which, as a side effect, updates the mtime and
> ctime fields.

Vetoed!

The current code gets it quite right: if someone calls open(O_TRUNC),
then may_open() calls do_truncate() with the ATTR_MTIME|ATTR_CTIME flags
set. That will cause the client to do the right thing _regardless_ of
the size optimisation.

> On the NFS server side, there was a change to the routine, inode_setattr(),
> which now relies upon the caller to set the ATTR_MTIME and ATTR_CTIME
> flags in ia_valid in addition to the ATTR_SIZE.  Previously, this routine
> would force these bits on if the size of the file was not changing.  Now,
> this routine relies upon the caller to specify all of the fields which need
> to be updated.

Also wrong.

This change causes the server to do entirely the wrong thing for
truncate()/ftruncate() calls: in the SuSv3 spec, a call that fails to
change the file length is supposed to leave the file entirely unchanged:
that includes mtime/ctime as well as suid/sgid bits.

Cheers,
  Trond

