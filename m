Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbUJZK1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbUJZK1M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 06:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbUJZK1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 06:27:12 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:32781 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262206AbUJZK1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 06:27:05 -0400
Date: Tue, 26 Oct 2004 11:27:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Waychison <michael.waychison@sun.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Subject: Re: [PATCH 4/28] VFS: Stat shouldn't stop expire
Message-ID: <20041026102703.GA12026@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Waychison <michael.waychison@sun.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	raven@themaw.net
References: <10987152003432@sun.com> <1098715230634@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098715230634@sun.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 10:40:30AM -0400, Mike Waychison wrote:
> This patch fixes the problem where if you have a mountpoint that is going to
> expire, it fails to expire before somebody keeps stat(2)ing the root of it's
> filesystem.  For example, consider the case where a user has his home
> directory automounted on /home/mikew.   Some other user can keep the
> filesystem mounted forever by simply calling ls(1) in /home, because the stat
> action resets the marker on each call.
> 
> Signed-off-by: Mike Waychison <michael.waychison@sun.com>
> ---
> 
>  namei.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.9-quilt/fs/namei.c
> ===================================================================
> --- linux-2.6.9-quilt.orig/fs/namei.c	2004-08-14 01:36:45.000000000 -0400
> +++ linux-2.6.9-quilt/fs/namei.c	2004-10-22 17:17:34.762179488 -0400
> @@ -275,7 +275,16 @@ int deny_write_access(struct file * file
>  void path_release(struct nameidata *nd)
>  {
>  	dput(nd->dentry);
> -	mntput(nd->mnt);
> +	/*
> +	 * In order to ensure that access to an automounted filesystems'
> +	 * root does not reset it's expire counter, we check to see if the path
> +	 * being released here is a mountpoint itself.  If it is, then we call
> +	 * _mntput which leaves the expire counter alone.
> +	 */
> +	if (nd->mnt && nd->mnt->mnt_root == nd->dentry)
> +		_mntput(nd->mnt);
> +	else  
> +		mntput(nd->mnt);

Why only for the root dentry not any on stat()  This seems highly inconsistant.
Also while you're at it please give _mntput a more sensible name, e.g.
mntput_no_expire (yes, I know that name isn't your fault)

