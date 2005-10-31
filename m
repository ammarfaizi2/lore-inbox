Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVJaM4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVJaM4M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 07:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVJaM4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 07:56:11 -0500
Received: from pat.uio.no ([129.240.130.16]:16832 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932342AbVJaM4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 07:56:11 -0500
Subject: Re: [PATCH against 2.6.14] truncate() or ftruncate shouldn't
	change mtime if size doesn't change.
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1051031063444.9586@suse.de>
References: <20051031173358.9566.patches@notabene>
	 <1051031063444.9586@suse.de>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 07:51:45 -0500
Message-Id: <1130763105.8802.23.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.804, required 12,
	autolearn=disabled, AWL 2.01, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-31 at 17:34 +1100, NeilBrown wrote:
> 
> According to Posix and SUS, truncate(2) and ftruncate(2) only update
> ctime and mtime if the size actually changes.  Linux doesn't currently
> obey this.
> 
> There is no need to test the size under i_sem, as loosing any race
> will not make a noticable different the mtime or ctime.
> 
> (According to SUS, truncate and ftruncate 'may' clear setuid/setgid
>  as well, currently we don't.  Should we?
> )
> 
> 
> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./fs/open.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff ./fs/open.c~current~ ./fs/open.c
> --- ./fs/open.c~current~	2005-10-31 16:22:44.000000000 +1100
> +++ ./fs/open.c	2005-10-31 16:22:44.000000000 +1100
> @@ -260,7 +260,8 @@ static inline long do_sys_truncate(const
>  		goto dput_and_out;
>  
>  	error = locks_verify_truncate(inode, NULL, length);
> -	if (!error) {
> +	if (!error &&
> +	    length != i_size_read(dentry->d_inode)) {

This has me worried because it is putting yet another dependency on
cached attributes in the VFS.
This should normally be OK as far as NFS is concerned since we usually
end up revalidating the attribute cache in the lookup() code, but you
could imagine a networked filesystem that does not do this. I'd
therefore prefer if such checks were made in the filesystem itself.

What we can, however, do is to ensure that truncate() and ftruncate()
only set ATTR_SIZE, but ensure that may_open() sets ATTR_MTIME|
ATTR_CTIME as well.

Cheers,
  Trond

