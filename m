Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbVHINei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbVHINei (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 09:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbVHINeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 09:34:37 -0400
Received: from pat.uio.no ([129.240.130.16]:46330 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932538AbVHINeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 09:34:36 -0400
Subject: Re: [RFC] atomic open(..., O_CREAT | ...)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1E2OoL-0006xQ-00@dorka.pomaz.szeredi.hu>
References: <E1E2G68-0006H2-00@dorka.pomaz.szeredi.hu>
	 <1123541926.8249.8.camel@lade.trondhjem.org>
	 <E1E2OoL-0006xQ-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 09:34:20 -0400
Message-Id: <1123594460.8245.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.505, required 12,
	autolearn=disabled, AWL 2.31, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 09.08.2005 Klokka 09:46 (+0200) skreiv Miklos Szeredi:
> > We've already got a patch that does this, and that I'm queueing up for
> > inclusion.
> 
> Cool!
> 
> > http://client.linux-nfs.org/Linux-2.6.x/2.6.12/linux-2.6.12-63-open_file_intents.dif
> 
> Comments:
> 
> >  /*
> > + * Open intents have to release any file pointer that was allocated
> > + * but not used by the VFS.
> > + */
> > +void path_release_open_intent(struct nameidata *nd)
> > +{
> > +	if ((nd->flags & LOOKUP_OPEN) && nd->intent.open.file != NULL) {
> > +		fput(nd->intent.open.file);
> 
> I think you should consider adding this:
> 
> +		if (!IS_ERR(nd->intent.open.file))
> +			fput(nd->intent.open.file);
> 
> so the filesystem can delay returning the error from the open
> operation until the other errors have been sorted out by the lookup
> code.

Intents are meant as optimisations, not replacements for existing
operations. I'm therefore not really comfortable about having them
return errors at all.

> > +		nd->intent.open.file = NULL;
> 
> Why is this NULL assignment needed?  nd will not be used after this.
> 
> > +	}
> > +	path_release(nd);
> > +}
> > +
> > 

It could be dropped. The reason for putting it in is that some parts of
the VFS may restart a path walk operation if it fails (see for instance
the ESTALE handling).

> > As for the "orig flags" thing. What is the point of that?
> 
> dentry_open() needs the original open flags, not the transformed ones
> stored in intent.open.flags.
> 
> The behavior is slightly strange, since filp_open() calculates
> namei_flags (which gets stored in intent.open.flags) so that an
> O_ACCMODE of 3 is transformed into FMODE_READ | FMODE_WRITE.
> 
> But dentry_open() calculates filp->f_mode, so that O_ACCMODE of 3 is
> transformed into zero.
> 
> This means that the (undocumented) access mode of 3 will require
> read-write permission, but will allow neither read() nor write() on
> the opened file.
> 
> If we want to keep this behavior, then the orig_flags field is needed.

Why do we want to keep this behaviour? It is undocumented, it is
non-posix, and it appears to do nothing you cannot do with the existing
access() call.

Are there any applications using it? If so, which ones, and why?

Cheers,
  Trond

