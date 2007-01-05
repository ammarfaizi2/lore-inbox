Return-Path: <linux-kernel-owner+w=401wt.eu-S965109AbXAEBKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbXAEBKf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 20:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbXAEBKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 20:10:35 -0500
Received: from ns2.suse.de ([195.135.220.15]:58385 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965109AbXAEBKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 20:10:34 -0500
Date: Thu, 4 Jan 2007 17:10:05 -0800
From: Greg KH <greg@kroah.com>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Oliver Neukum <oliver@neukum.name>, Maneesh Soni <maneesh@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.20-rc2-mm1: INFO: possible recursive locking detected in con_close
Message-ID: <20070105011004.GA7682@kroah.com>
References: <20061228024237.375a482f.akpm@osdl.org> <45943638.30705@free.fr> <20061229110041.GA1441@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229110041.GA1441@slug>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2006 at 11:00:41AM +0000, Frederik Deweerdt wrote:
> On Thu, Dec 28, 2006 at 10:25:12PM +0100, Laurent Riffard wrote:
> > Le 28.12.2006 11:42, Andrew Morton a ?crit :
> > >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc2/2.6.20-rc2-mm1/
> > 
> > Hello,
> > 
> > got this with 2.6.20-rc2-mm1, reverting 
> > gregkh-driver-driver-core-fix-race-in-sysfs-between-sysfs_remove_file-and-read-write.patch made it disappear.
> > 
> Hi, 
> 
> This is due to sysfs_hash_and_remove() holding dir->d_inode->i_mutex
> before calling sysfs_drop_dentry() which calls orphan_all_buffers()
> which in turn takes node->i_mutex.
> The following patch solves the problem by defering the buffers orphaning
> after the dir->d_inode->imutex is released. Not sure it's the best
> solution though, Greg?
> 
> Regards,
> Frederik
> 
> Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

Maneesh and Oliver, any objections to this patch?

thanks,

greg k-h


> 
> diff --git a/fs/sysfs/inode.c b/fs/sysfs/inode.c
> index 8c533cb..7cac0b6 100644
> --- a/fs/sysfs/inode.c
> +++ b/fs/sysfs/inode.c
> @@ -230,10 +230,10 @@ static inline void orphan_all_buffers(struct inode *node)
>   * Unhashes the dentry corresponding to given sysfs_dirent
>   * Called with parent inode's i_mutex held.
>   */
> -void sysfs_drop_dentry(struct sysfs_dirent * sd, struct dentry * parent)
> +struct inode *sysfs_drop_dentry(struct sysfs_dirent * sd, struct dentry * parent)
>  {
>  	struct dentry * dentry = sd->s_dentry;
> -	struct inode *inode;
> +	struct inode *inode = NULL;
>  
>  	if (dentry) {
>  		spin_lock(&dcache_lock);
> @@ -248,19 +248,19 @@ void sysfs_drop_dentry(struct sysfs_dirent * sd, struct dentry * parent)
>  			spin_unlock(&dentry->d_lock);
>  			spin_unlock(&dcache_lock);
>  			simple_unlink(parent->d_inode, dentry);
> -			orphan_all_buffers(inode);
> -			iput(inode);
>  		} else {
>  			spin_unlock(&dentry->d_lock);
>  			spin_unlock(&dcache_lock);
>  		}
>  	}
> +	return inode;
>  }
>  
>  int sysfs_hash_and_remove(struct dentry * dir, const char * name)
>  {
>  	struct sysfs_dirent * sd;
>  	struct sysfs_dirent * parent_sd;
> +	struct inode *inode;
>  	int found = 0;
>  
>  	if (!dir)
> @@ -277,7 +277,7 @@ int sysfs_hash_and_remove(struct dentry * dir, const char * name)
>  			continue;
>  		if (!strcmp(sysfs_get_name(sd), name)) {
>  			list_del_init(&sd->s_sibling);
> -			sysfs_drop_dentry(sd, dir);
> +			inode = sysfs_drop_dentry(sd, dir);
>  			sysfs_put(sd);
>  			found = 1;
>  			break;
> @@ -285,5 +285,10 @@ int sysfs_hash_and_remove(struct dentry * dir, const char * name)
>  	}
>  	mutex_unlock(&dir->d_inode->i_mutex);
>  
> +	if (found == 1 && inode) {
> +		orphan_all_buffers(inode);
> +		iput(inode);
> +	}
> +
>  	return found ? 0 : -ENOENT;
>  }
> diff --git a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
> index 5100a12..ef9d217 100644
> --- a/fs/sysfs/sysfs.h
> +++ b/fs/sysfs/sysfs.h
> @@ -17,7 +17,7 @@ extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **)
>  extern void sysfs_remove_subdir(struct dentry *);
>  
>  extern const unsigned char * sysfs_get_name(struct sysfs_dirent *sd);
> -extern void sysfs_drop_dentry(struct sysfs_dirent *sd, struct dentry *parent);
> +extern struct inode * sysfs_drop_dentry(struct sysfs_dirent *sd, struct dentry *parent);
>  extern int sysfs_setattr(struct dentry *dentry, struct iattr *iattr);
>  
>  extern struct rw_semaphore sysfs_rename_sem;
