Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbUJZK3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbUJZK3K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 06:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUJZK3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 06:29:10 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:33549 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262211AbUJZK2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 06:28:39 -0400
Date: Tue, 26 Oct 2004 11:28:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Waychison <michael.waychison@sun.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Subject: Re: [PATCH 15/28] VFS: Mountpoint file descriptor umount support
Message-ID: <20041026102838.GB12026@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Waychison <michael.waychison@sun.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	raven@themaw.net
References: <10987155332448@sun.com> <10987155691365@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10987155691365@sun.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 10:46:09AM -0400, Mike Waychison wrote:
> This patch adds functionality to mountfd so that a user can perform the
> various types of umount (forced umount, not-busy umount, lazy-umount).
> 
> Signed-off-by: Mike Waychison <michael.waychison@sun.com>
> ---
> 
>  fs/mountfd.c       |   20 ++++++++++++++++++++
>  fs/namespace.c     |    2 +-
>  include/linux/fs.h |    5 ++++-
>  3 files changed, 25 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.9-quilt/fs/mountfd.c
> ===================================================================
> --- linux-2.6.9-quilt.orig/fs/mountfd.c	2004-10-22 17:17:40.736271288 -0400
> +++ linux-2.6.9-quilt/fs/mountfd.c	2004-10-22 17:17:41.367175376 -0400
> @@ -11,6 +11,8 @@
>  
>  #define VFSMOUNT(filp) ((struct vfsmount *)((filp)->private_data))
>  
> +extern int do_umount(struct vfsmount *mnt, int flags);
> +
>  static struct vfsmount *mfdfs_mnt;
>  
>  static void mfdfs_read_inode(struct inode *inode);
> @@ -72,6 +74,18 @@ static int mfd_release(struct inode *ino
>  	return 0;
>  }
>  
> +static long mfd_umount(struct file *mountfilp, int flags)
> +{
> +	struct vfsmount *mnt;
> +	int error;
> +	
> +	mnt = mntget(VFSMOUNT(mountfilp));
> +
> +	error = do_umount(mnt, flags);
> +
> +	return error;
> +}
> +
>  static int mfd_ioctl(struct inode *inode, struct file *filp,
>  		     unsigned int cmd, unsigned long arg);
>  static struct file_operations mfd_file_ops = {
> @@ -243,6 +257,12 @@ static int mfd_ioctl(struct inode *inode
>  	switch (cmd) {
>  	case MOUNTFD_IOC_GETDIRFD:
>  		return mfd_getdirfd(filp);
> +	case MOUNTFD_IOC_DETACH:
> +		return mfd_umount(filp, MNT_DETACH);
> +	case MOUNTFD_IOC_UNMOUNT:
> +		return mfd_umount(filp, 0);
> +	case MOUNTFD_IOC_FORCEDUNMOUNT:
> +		return mfd_umount(filp, MNT_FORCE);

Urgg, you don't want to add gazillions of strange ioctls, do you?

