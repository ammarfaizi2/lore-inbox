Return-Path: <linux-kernel-owner+w=401wt.eu-S1752888AbWL2NGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbWL2NGv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 08:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753011AbWL2NGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 08:06:51 -0500
Received: from smtp20.orange.fr ([193.252.22.31]:15770 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880AbWL2NGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 08:06:50 -0500
X-ME-UUID: 20061229130648395.09A4B1C0009B@mwinf2019.orange.fr
Message-ID: <459512E6.2040704@free.fr>
Date: Fri, 29 Dec 2006 14:06:46 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.7) Gecko/20060405 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       Oliver Neukum <oliver@neukum.name>, Greg KH <greg@kroah.com>,
       Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.20-rc2-mm1: INFO: possible recursive locking detected in
 con_close
References: <20061228024237.375a482f.akpm@osdl.org> <45943638.30705@free.fr> <20061229110041.GA1441@slug>
In-Reply-To: <20061229110041.GA1441@slug>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 29.12.2006 12:00, Frederik Deweerdt a ecrit :
> On Thu, Dec 28, 2006 at 10:25:12PM +0100, Laurent Riffard wrote:
>> Le 28.12.2006 11:42, Andrew Morton a ecrit :
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc2/2.6.20-rc2-mm1/
>> Hello,
>>
>> got this with 2.6.20-rc2-mm1, reverting 
>> gregkh-driver-driver-core-fix-race-in-sysfs-between-sysfs_remove_file-and-read-write.patch made it disappear.
>>
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

Tested, it does work: the INFO about "possible recursive locking" went away.

Thanks
~~
laurent


> 
> Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>
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

