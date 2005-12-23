Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030576AbVLWPCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030576AbVLWPCr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 10:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030568AbVLWPCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 10:02:47 -0500
Received: from pat.uio.no ([129.240.130.16]:27275 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030573AbVLWPCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 10:02:45 -0500
Subject: Re: [PATCH] fix posix lock on NFS, #2
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: ASANO Masahiro <masano@tnes.nec.co.jp>
Cc: matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20051223.233839.846934653.masano@tnes.nec.co.jp>
References: <20051223.233839.846934653.masano@tnes.nec.co.jp>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 16:02:31 +0100
Message-Id: <1135350151.8167.160.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.399, required 12,
	autolearn=disabled, AWL 1.55, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 23:38 +0900, ASANO Masahiro wrote:
> Here is a patch.  It changes nfsd to keep the range of file_lock for
> later use.  Any comments and feedback are welcome.
> 
> Signed-off-by: ASANO Masahiro <masano@tnes.nec.co.jp>
> 
> --- linux-2.6.15-rc6/fs/lockd/svclock.c.orig	2005-12-23 20:16:33.000000000 +0900
> +++ linux-2.6.15-rc6/fs/lockd/svclock.c	2005-12-23 20:24:13.000000000 +0900
> @@ -510,6 +510,7 @@ nlmsvc_grant_blocked(struct nlm_block *b
>  	struct nlm_file		*file = block->b_file;
>  	struct nlm_lock		*lock = &block->b_call.a_args.lock;
>  	struct file_lock	*conflock;
> +	struct file_lock	tmplck;
>  	int			error;
>  
>  	dprintk("lockd: grant blocked lock %p\n", block);
> @@ -542,7 +543,8 @@ nlmsvc_grant_blocked(struct nlm_block *b
>  	 * following yields an error, this is most probably due to low
>  	 * memory. Retry the lock in a few seconds.
>  	 */
> -	if ((error = posix_lock_file(file->f_file, &lock->fl)) < 0) {
> +	tmplck = lock->fl;	/* keep the range for later use */
> +	if ((error = posix_lock_file(file->f_file, &tmplck)) < 0) {
>  		printk(KERN_WARNING "lockd: unexpected error %d in %s!\n",
>  				-error, __FUNCTION__);
>  		nlmsvc_insert_block(block, 10 * HZ);

NACK. You cannot copy locks like this. See locks_copy_lock().

Cheers,
  Trond

