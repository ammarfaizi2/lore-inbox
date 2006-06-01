Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965232AbWFARbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbWFARbs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbWFARbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:31:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63111 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965232AbWFARbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:31:47 -0400
Date: Thu, 1 Jun 2006 10:35:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: michal.k.k.piotrowski@gmail.com, gregkh@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-Id: <20060601103549.99dc7951.akpm@osdl.org>
In-Reply-To: <1149182408.3115.75.camel@laptopd505.fenrus.org>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	<6bffcb0e0606010851n75b49d83u9f43136b3108886c@mail.gmail.com>
	<1149182408.3115.75.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2006 19:20:08 +0200
Arjan van de Ven <arjan@linux.intel.com> wrote:

> On Thu, 2006-06-01 at 17:51 +0200, Michal Piotrowski wrote:
> > Hi,
> > 
> > On 01/06/06, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/
> > >
> > 
> > I don't know why, but first bug appears only when avahi-daemon is
> > started. Second look like a problem with my camera.
> > http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/bug_1.jpg
> > http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/bug_2.jpg
> > 
> > Here is config http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/mm-config
> 
> 
> can you confirm this fixes it ?
> 

s/fixes it/makes it go away/

Please describe these patches better.

Where was the outermost lock taken?  How do we know that an attempt cannot
be made to take them in the opposite order?


> ---
>  drivers/usb/core/inode.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6.17-rc5-mm1.5/drivers/usb/core/inode.c
> ===================================================================
> --- linux-2.6.17-rc5-mm1.5.orig/drivers/usb/core/inode.c
> +++ linux-2.6.17-rc5-mm1.5/drivers/usb/core/inode.c
> @@ -333,7 +333,7 @@ static int usbfs_empty (struct dentry *d
>  static int usbfs_unlink (struct inode *dir, struct dentry *dentry)
>  {
>  	struct inode *inode = dentry->d_inode;
> -	mutex_lock(&inode->i_mutex);
> +	mutex_lock_nested(&inode->i_mutex, I_MUTEX_CHILD);
>  	dentry->d_inode->i_nlink--;
>  	dput(dentry);
>  	mutex_unlock(&inode->i_mutex);
> @@ -346,7 +346,7 @@ static int usbfs_rmdir(struct inode *dir
>  	int error = -ENOTEMPTY;
>  	struct inode * inode = dentry->d_inode;
>  
> -	mutex_lock(&inode->i_mutex);
> +	mutex_lock_nested(&inode->i_mutex, I_MUTEX_CHILD);
>  	dentry_unhash(dentry);
>  	if (usbfs_empty(dentry)) {
>  		dentry->d_inode->i_nlink -= 2;
> @@ -528,7 +528,7 @@ static void fs_remove_file (struct dentr
>  	if (!parent || !parent->d_inode)
>  		return;
>  
> -	mutex_lock(&parent->d_inode->i_mutex);
> +	mutex_lock_nested(&parent->d_inode->i_mutex, I_MUTEX_PARENT);
>  	if (usbfs_positive(dentry)) {
>  		if (dentry->d_inode) {
>  			if (S_ISDIR(dentry->d_inode->i_mode))
