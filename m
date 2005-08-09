Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbVHIHqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbVHIHqb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 03:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVHIHqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 03:46:31 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:54791 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932226AbVHIHqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 03:46:30 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1123541926.8249.8.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Mon, 08 Aug 2005 18:58:46 -0400)
Subject: Re: [RFC] atomic open(..., O_CREAT | ...)
References: <E1E2G68-0006H2-00@dorka.pomaz.szeredi.hu> <1123541926.8249.8.camel@lade.trondhjem.org>
Message-Id: <E1E2OoL-0006xQ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 09 Aug 2005 09:46:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We've already got a patch that does this, and that I'm queueing up for
> inclusion.

Cool!

> http://client.linux-nfs.org/Linux-2.6.x/2.6.12/linux-2.6.12-63-open_file_intents.dif

Comments:

>  /*
> + * Open intents have to release any file pointer that was allocated
> + * but not used by the VFS.
> + */
> +void path_release_open_intent(struct nameidata *nd)
> +{
> +	if ((nd->flags & LOOKUP_OPEN) && nd->intent.open.file != NULL) {
> +		fput(nd->intent.open.file);

I think you should consider adding this:

+		if (!IS_ERR(nd->intent.open.file))
+			fput(nd->intent.open.file);

so the filesystem can delay returning the error from the open
operation until the other errors have been sorted out by the lookup
code.

> +		nd->intent.open.file = NULL;

Why is this NULL assignment needed?  nd will not be used after this.

> +	}
> +	path_release(nd);
> +}
> +
> 



> As for the "orig flags" thing. What is the point of that?

dentry_open() needs the original open flags, not the transformed ones
stored in intent.open.flags.

The behavior is slightly strange, since filp_open() calculates
namei_flags (which gets stored in intent.open.flags) so that an
O_ACCMODE of 3 is transformed into FMODE_READ | FMODE_WRITE.

But dentry_open() calculates filp->f_mode, so that O_ACCMODE of 3 is
transformed into zero.

This means that the (undocumented) access mode of 3 will require
read-write permission, but will allow neither read() nor write() on
the opened file.

If we want to keep this behavior, then the orig_flags field is needed.

Thanks,
Miklos
