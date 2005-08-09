Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbVHIVLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbVHIVLp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbVHIVLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:11:45 -0400
Received: from pat.uio.no ([129.240.130.16]:48890 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964971AbVHIVLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:11:44 -0400
Subject: Re: [RFC] atomic open(..., O_CREAT | ...)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1E2aw6-0007oY-00@dorka.pomaz.szeredi.hu>
References: <E1E2G68-0006H2-00@dorka.pomaz.szeredi.hu>
	 <1123541926.8249.8.camel@lade.trondhjem.org>
	 <E1E2OoL-0006xQ-00@dorka.pomaz.szeredi.hu>
	 <1123594460.8245.15.camel@lade.trondhjem.org>
	 <E1E2X9A-0007Uk-00@dorka.pomaz.szeredi.hu>
	 <1123607889.8245.107.camel@lade.trondhjem.org>
	 <E1E2Y92-0007Zv-00@dorka.pomaz.szeredi.hu>
	 <1123612734.8245.150.camel@lade.trondhjem.org>
	 <E1E2aw6-0007oY-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 17:11:30 -0400
Message-Id: <1123621890.8245.211.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.524, required 12,
	autolearn=disabled, AWL 2.29, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 09.08.2005 Klokka 22:42 (+0200) skreiv Miklos Szeredi:

> Trond, wake up!  __emul_lookup_dentry() does nothing of the sort.
> Neither does anything else.  In theory it could, but that's not a
> reason to do a confusing thing like that.

Really?

static int __emul_lookup_dentry(const char *name, struct nameidata *nd)
{
		.....
		if (path_walk(name, nd) == 0) {
			if (nd->dentry->d_inode) {
				dput(old_dentry);
				mntput(old_mnt);
				return 1;
			}
			path_release(nd);
		}
		nd->dentry = old_dentry;
		nd->mnt = old_mnt;
		nd->last = last;
		nd->last_type = last_type;
	}
	return 1;
}

Which is called by path_lookup(), which again returns success, and
expects the user to call path_release() later.

> > Firstly, the open_namei() flags field is not a "permissions" field. It
> > contains open mode information. The calculation of the open permissions
> > flags is done by open_namei() itself.
> 
> Based on flags.  It's just a FMODE_* -> MAY_* transformation
> 
> > Secondly, what advantage is there in allowing callers of open_namei() to
> > be able to override the MAY_WRITE check when doing open(O_TRUNC)? This
> > is a calculation that should be done _once_ in order to always get it
> > right, and it should therefore be done in open_namei() together with the
> > rest of the permissions calculation.
> 
> I think the _only_ caller of open_namei() is filp_open(), so this is
> not much of an issue, but yeah, you could do it that way too.

Currently, yes. The only caller of open_namei() is filp_open(). That was
not always the case previously.

If we think it will never be the case in the future, then there is an
argument for merging the two and/or making open_namei() and inlined
function.

Cheers,
  Trond

