Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbVKSKrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbVKSKrY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 05:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVKSKrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 05:47:23 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:18478 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751073AbVKSKrW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 05:47:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HW+SFgG+CwMu3PD5T7hImQJNsqfzMsl9wmlJD0lC30fIWVC8ngL+NFzb7/K+2Ss98pwrtYJTk9L9ng0CXCH4DcMc6KiBCLh3wdncM7ueS//3Rjq18AdT7kGn/AZZgn/Ek0TTRqug4L1NMDistrTVe/jL2bMPfo7Q6rFcGlPSXik=
Message-ID: <84144f020511190247n5cf17800lb4ff019aa406470@mail.gmail.com>
Date: Sat, 19 Nov 2005 12:47:21 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Phillip Hellewell <phillip@hellewell.homeip.net>
Subject: Re: [PATCH 4/12: eCryptfs] Main module functions
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
In-Reply-To: <20051119041740.GD15747@sshock.rn.byu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051119041130.GA15559@sshock.rn.byu.edu>
	 <20051119041740.GD15747@sshock.rn.byu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/05, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> +int ecryptfs_verbosity = 1;
> +
> +module_param(ecryptfs_verbosity, int, 0);
> +MODULE_PARM_DESC(ecryptfs_verbosity,
> +                "Initial verbosity level (0 or 1; defaults to "
> +                "0, which is Quiet)");
> +
> +void __ecryptfs_printk(int verb, const char *fmt, ...)
> +{
> +       va_list args;
> +       va_start(args, fmt);
> +       if ((ecryptfs_verbosity >= verb) && printk_ratelimit())
> +               vprintk(fmt, args);
> +       va_end(args);
> +}
> +

[snip]

> +int ecryptfs_interpose(struct dentry *lower_dentry, struct dentry *dentry,
> +                      struct super_block *sb, int flag)
> +{
> +       struct inode *lower_inode;
> +       int err = 0;
> +       struct inode *inode;
> +
> +       ecryptfs_printk(1, KERN_NOTICE, "Enter; lower_dentry = [%p], "
> +                       "lower_dentry->d_name.name = [%s], dentry = "
> +                       "[%p], dentry->d_name.name = [%s], sb = [%p]; "
> +                       "flag = [%.4x]; lower_dentry->d_count "
> +                       "= [%d]; dentry->d_count = [%d]\n", lower_dentry,
> +                       lower_dentry->d_name.name, dentry, dentry->d_name.name,
> +                       sb, flag, atomic_read(&lower_dentry->d_count),
> +                       atomic_read(&dentry->d_count));

Could you use KERN_DEBUG instead and drop ecryptfs_printk()?

> +       if (NULL == ECRYPTFS_INODE_TO_LOWER(inode)) {
> +               ECRYPTFS_INODE_TO_LOWER(inode) = igrab(lower_inode);
> +               /* If we are still NULL at this point, igrab failed.
> +                * We are _NOT_ supposed to be failing here */
> +               if (NULL == ECRYPTFS_INODE_TO_LOWER(inode)) {

If you're worried about assignment, why not use the normal idiom:

   if (!p) {
      ...
   }

> +                       BUG();
> +                       err = -EINVAL;
> +                       goto out;

Why do you want to BUG() and then handle the situation?

> +kmem_cache_t *ecryptfs_sb_info_cache;

We have struct kmem_cache now so please consider using it instead.

> +/* This provides a means of backing out cache creations out of the kernel
> + * so that we can elegantly fail should we run out of memory.
> + */
> +#define ECRYPTFS_AUTH_TOK_LIST_ITEM_CACHE      0x0001
> +#define ECRYPTFS_AUTH_TOK_PKT_SET_CACHE         0x0002
> +#define ECRYPTFS_AUTH_TOK_REQUEST_CACHE         0x0004
> +#define ECRYPTFS_AUTH_TOK_REQUEST_BLOB_CACHE    0x0008
> +#define ECRYPTFS_FILE_INFO_CACHE               0x0010
> +#define ECRYPTFS_DENTRY_INFO_CACHE             0x0020
> +#define ECRYPTFS_INODE_INFO_CACHE              0x0040
> +#define ECRYPTFS_SB_INFO_CACHE                         0x0080
> +#define ECRYPTFS_HEADER_CACHE_0                0x0100
> +#define ECRYPTFS_HEADER_CACHE_1                0x0200
> +#define ECRYPTFS_HEADER_CACHE_2                0x0400
> +#define ECRYPTFS_LOWER_PAGE_CACHE              0x0800
> +#define ECRYPTFS_CACHE_CREATION_SUCCESS                0x0FF1

A better way would be to either (1) make ecryptfs_init_kmem_caches()
clean up after itself on error using gotos or (2) keep caches NULL
before initialization and check for that in
ecryptfs_free_kmem_caches().

> +
> +static short ecryptfs_allocated_caches;
> +
> +/**
> + * @return Zero on success; non-zero otherwise
> + *
> + * Sets ecryptfs_allocated_caches with flags so that we can
> + * free created caches should we run out of memory during
> + * creation period.
> + *
> + * The overhead for doing this is offset by the fact that we
> + * only do this once, and that should there be insufficient
> + * memory, then we can elegantly fail, and not leave extra
> + * caches around, or worse, panic the kernel trying to free
> + * something that's not there.
> + */
> +static int ecryptfs_init_kmem_caches(void)
> +{
> +       int rc = 0;
> +
> +       ecryptfs_auth_tok_list_item_cache =
> +           kmem_cache_create("ecryptfs_auth_tok_list_item",
> +                             sizeof(struct ecryptfs_auth_tok_list_item),
> +                             0, SLAB_HWCACHE_ALIGN, NULL, NULL);
> +       if (ecryptfs_auth_tok_list_item_cache)
> +               rc |= ECRYPTFS_AUTH_TOK_LIST_ITEM_CACHE;
> +       else
> +               ecryptfs_printk(0, KERN_WARNING, "ecryptfs_auth_tok_list_item "
> +                               "kmem_cache_create failed\n");
> +
> +       ecryptfs_file_info_cache =
> +           kmem_cache_create("ecryptfs_file_cache",
> +                             sizeof(struct ecryptfs_file_info),
> +                             0, SLAB_HWCACHE_ALIGN, NULL, NULL);
> +       if (ecryptfs_file_info_cache)
> +               rc |= ECRYPTFS_FILE_INFO_CACHE;
> +       else
> +               ecryptfs_printk(0, KERN_WARNING, "ecryptfs_file_cache "
> +                               "kmem_cache_create failed\n");
> +
> +       ecryptfs_dentry_info_cache =
> +           kmem_cache_create("ecryptfs_dentry_cache",
> +                             sizeof(struct ecryptfs_dentry_info),
> +                             0, SLAB_HWCACHE_ALIGN, NULL, NULL);
> +       if (ecryptfs_dentry_info_cache)
> +               rc |= ECRYPTFS_DENTRY_INFO_CACHE;
> +       else
> +               ecryptfs_printk(0, KERN_WARNING, "ecryptfs_dentry_cache "
> +                               "kmem_cache_create failed\n");
> +
> +       ecryptfs_inode_info_cache =
> +           kmem_cache_create("ecryptfs_inode_cache",
> +                             sizeof(struct ecryptfs_inode_info), 0,
> +                             SLAB_HWCACHE_ALIGN, inode_info_init_once, NULL);
> +       if (ecryptfs_inode_info_cache)
> +               rc |= ECRYPTFS_INODE_INFO_CACHE;
> +       else
> +               ecryptfs_printk(0, KERN_WARNING, "ecryptfs_inode_cache "
> +                               "kmem_cache_create failed\n");
> +
> +       ecryptfs_sb_info_cache =
> +           kmem_cache_create("ecryptfs_sb_cache",
> +                             sizeof(struct ecryptfs_sb_info),
> +                             0, SLAB_HWCACHE_ALIGN, NULL, NULL);
> +       if (ecryptfs_sb_info_cache)
> +               rc |= ECRYPTFS_SB_INFO_CACHE;
> +       else
> +               ecryptfs_printk(0, KERN_WARNING, "ecryptfs_sb_cache "
> +                               "kmem_cache_create failed\n");
> +
> +       ecryptfs_header_cache_0 =
> +           kmem_cache_create("ecryptfs_headers_0", PAGE_CACHE_SIZE,
> +                             0, SLAB_HWCACHE_ALIGN, NULL, NULL);
> +       if (ecryptfs_header_cache_0)
> +               rc |= ECRYPTFS_HEADER_CACHE_0;
> +       else
> +               ecryptfs_printk(0, KERN_WARNING, "ecryptfs_headers_0 "
> +                               "kmem_cache_create failed\n");
> +
> +       ecryptfs_header_cache_1 =
> +           kmem_cache_create("ecryptfs_headers_1", PAGE_CACHE_SIZE,
> +                             0, SLAB_HWCACHE_ALIGN, NULL, NULL);
> +       if (ecryptfs_header_cache_1)
> +               rc |= ECRYPTFS_HEADER_CACHE_1;
> +       else
> +               ecryptfs_printk(0, KERN_WARNING, "ecryptfs_headers_1 "
> +                               "kmem_cache_create failed\n");
> +
> +       ecryptfs_header_cache_2 =
> +           kmem_cache_create("ecryptfs_headers_2", PAGE_CACHE_SIZE,
> +                             0, SLAB_HWCACHE_ALIGN, NULL, NULL);
> +       if (ecryptfs_header_cache_2)
> +               rc |= ECRYPTFS_HEADER_CACHE_2;
> +       else
> +               ecryptfs_printk(0, KERN_WARNING, "ecryptfs_headers_2 "
> +                               "kmem_cache_create failed\n");
> +
> +       ecryptfs_lower_page_cache =
> +           kmem_cache_create("ecryptfs_lower_page_cache", PAGE_CACHE_SIZE,
> +                             0, SLAB_HWCACHE_ALIGN, NULL, NULL);
> +       if (ecryptfs_lower_page_cache)
> +               rc |= ECRYPTFS_LOWER_PAGE_CACHE;
> +       else
> +               ecryptfs_printk(0, KERN_WARNING, "ecryptfs_lower_page_cache "
> +                               "kmem_cache_create failed\n");
> +
> +       ecryptfs_allocated_caches = rc;
> +       rc = ECRYPTFS_CACHE_CREATION_SUCCESS ^ rc;
> +       return rc;
> +}
> +
> +/**
> + * @return Zero on success; non-zero otherwise
> + */
> +static int ecryptfs_free_kmem_caches(void)
> +{
> +       int rc = 0;
> +       int err;
> +
> +       if (ecryptfs_allocated_caches & ECRYPTFS_AUTH_TOK_LIST_ITEM_CACHE) {
> +               rc = kmem_cache_destroy(ecryptfs_auth_tok_list_item_cache);
> +               if (rc)
> +                       ecryptfs_printk(0, KERN_WARNING,
> +                                       "Not all ecryptfs_auth_tok_"
> +                                       "list_item_cache structures were "
> +                                       "freed\n");
> +       }
> +       if (ecryptfs_allocated_caches & ECRYPTFS_FILE_INFO_CACHE) {
> +               err = kmem_cache_destroy(ecryptfs_file_info_cache);
> +               if (err)
> +                       ecryptfs_printk(0, KERN_WARNING,
> +                                       "Not all ecryptfs_file_info_"
> +                                       "cache regions were freed\n");
> +               rc |= err;
> +       }
> +       if (ecryptfs_allocated_caches & ECRYPTFS_DENTRY_INFO_CACHE) {
> +               err = kmem_cache_destroy(ecryptfs_dentry_info_cache);
> +               if (err)
> +                       ecryptfs_printk(0, KERN_WARNING,
> +                                       "Not all ecryptfs_dentry_info_"
> +                                       "cache regions were freed\n");
> +               rc |= err;
> +       }
> +       if (ecryptfs_allocated_caches & ECRYPTFS_INODE_INFO_CACHE) {
> +               err = kmem_cache_destroy(ecryptfs_inode_info_cache);
> +               if (err)
> +                       ecryptfs_printk(0, KERN_WARNING,
> +                                       "Not all ecryptfs_inode_info_"
> +                                       "cache regions were freed\n");
> +               rc |= err;
> +       }
> +       if (ecryptfs_allocated_caches & ECRYPTFS_SB_INFO_CACHE) {
> +               err = kmem_cache_destroy(ecryptfs_sb_info_cache);
> +               if (err)
> +                       ecryptfs_printk(0, KERN_WARNING,
> +                                       "Not all ecryptfs_sb_info_"
> +                                       "cache regions were freed\n");
> +               rc |= err;
> +       }
> +       if (ecryptfs_allocated_caches & ECRYPTFS_HEADER_CACHE_0) {
> +               err = kmem_cache_destroy(ecryptfs_header_cache_0);
> +               if (err)
> +                       ecryptfs_printk(0, KERN_WARNING, "Not all ecryptfs_"
> +                                       "header_cache_0 regions were freed\n");
> +               rc |= err;
> +       }
> +       if (ecryptfs_allocated_caches & ECRYPTFS_HEADER_CACHE_1) {
> +               err = kmem_cache_destroy(ecryptfs_header_cache_1);
> +               if (err)
> +                       ecryptfs_printk(0, KERN_WARNING, "Not all ecryptfs_"
> +                                       "header_cache_1 regions were freed\n");
> +               rc |= err;
> +       }
> +       if (ecryptfs_allocated_caches & ECRYPTFS_HEADER_CACHE_2) {
> +               err = kmem_cache_destroy(ecryptfs_header_cache_2);
> +               if (err)
> +                       ecryptfs_printk(0, KERN_WARNING, "Not all ecryptfs_"
> +                                       "header_cache_2 regions were freed\n");
> +               rc |= err;
> +       }
> +       if (ecryptfs_allocated_caches & ECRYPTFS_LOWER_PAGE_CACHE) {
> +               err = kmem_cache_destroy(ecryptfs_lower_page_cache);
> +               if (err)
> +                       ecryptfs_printk(0, KERN_WARNING, "Not all ecryptfs_"
> +                                       "lower_page_cache regions were "
> +                                       "freed\n");
> +               rc |= err;
> +       }
> +       return rc;
> +}
> +
> +static int __init init_ecryptfs_fs(void)
> +{
> +       int rc;
> +
> +       rc = ecryptfs_init_kmem_caches();
> +       if (rc) {
> +               ecryptfs_printk(0, KERN_EMERG, "Failure occured while "
> +                               "attempting to create caches [CREATED: %x]."
> +                               "Now freeing caches.\n",
> +                               ecryptfs_allocated_caches);
> +               ecryptfs_free_kmem_caches();
> +               return -ENOMEM;
> +       }
> +       ecryptfs_printk(1, KERN_NOTICE, "Registering eCryptfs\n");
> +       return register_filesystem(&ecryptfs_fs_type);

register_filesystem() can fail in which case youre leaking all the
slab caches here.

                                      Pekka
