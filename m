Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbTLPDW3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 22:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264311AbTLPDW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 22:22:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:23981 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264310AbTLPDW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 22:22:27 -0500
Date: Mon, 15 Dec 2003 19:22:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Molina <tmolina@cablespeed.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Is Rational rational?
In-Reply-To: <Pine.LNX.4.58.0312152105550.5094@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0312151913460.3345@home.osdl.org>
References: <Pine.LNX.4.58.0312152105550.5094@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Dec 2003, Thomas Molina wrote:
>
> Does the enclosed patch to fs/namei.c make sense?

Hmm.. It may. Al is the final arbiter in this area, but from my fuzzy
memory, the whole (and only) point of that parent check is because we
didn't have proper locking for the whole path between rename/unlink. As
far as I can tell, we do the locking right, and the test is nonsensical
these days.

So what used to happen is that we could move the entry during the lookup,
and now the "rm" would succeed even though the "mv" to another directory
had _also_ succeeded (which is illogical).

Al? Does your recollection match mine?

> I'm not really competent to evaluate this proposesd patch, but it
> certainly makes me nervous.  Their comment on this also bothers me:
> "Rational Software believes that the check that is removed by this patch
> is one that should never fail for any properly operating filesystem. "

I think they are right. But I may have overlooked something really subtle.

		Linus

> --- /usr/src/linux/fs/namei.c Tue Oct 30 10:03:52 2001
> +++ /usr/src/linux-patched/namei.c Fri Jun 20 05:12:16 2003
> @@ -907,7 +907,7 @@
> static inline int may_delete(struct inode *dir,struct dentry *victim, int isdir)
> {
>  	int error;
> -	if (!victim->d_inode || victim->d_parent->d_inode != dir)
> +	if (!victim->d_inode)
>  		return -ENOENT;
>  	error = permission(dir,MAY_WRITE | MAY_EXEC);
>  	if (error)

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
