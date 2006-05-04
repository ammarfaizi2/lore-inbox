Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751503AbWEDPNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWEDPNR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 11:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWEDPNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 11:13:17 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:10619 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751503AbWEDPNQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 11:13:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=As5bBSH6E1NGc1nR8STOt9/BEzhhnkhA3nqXq2uc+NgdCF1tLC+egzmp38f5A+jRYeaGJyf+Xp+Oc72LLOIAZl7CSmvTz5uZ8EPNAEjURZNLOMPWuXcgbEQVrZ1r8xY4hIs5WE0T2EUtJL/RsxPyzyLdq7qn6GUQoo6x8u1T+CM=
Message-ID: <84144f020605040813q29fcddcr1c846d27cf156432@mail.gmail.com>
Date: Thu, 4 May 2006 18:13:15 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Phillip Hellewell" <phillip@hellewell.homeip.net>
Subject: Re: [PATCH 10/13: eCryptfs] Mmap operations
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, "James Morris" <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, "Erez Zadok" <ezk@cs.sunysb.edu>,
       "David Howells" <dhowells@redhat.com>
In-Reply-To: <20060504034127.GI28613@hellewell.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060504031755.GA28257@hellewell.homeip.net>
	 <20060504034127.GI28613@hellewell.homeip.net>
X-Google-Sender-Auth: bd895ff97570cf15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/06, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> +/**
> + * Get one page from cache or lower f/s, return error otherwise.
> + *
> + * @return Unlocked and up-to-date page (if ok), with increased
> + *         refcnt.
> + */
> +static struct page *ecryptfs_get1page(struct file *file, int index)
> +{
> +       struct page *page;
> +       struct dentry *dentry;
> +       struct inode *inode;
> +       struct address_space *mapping;
> +       int rc;
> +
> +       ecryptfs_printk(KERN_DEBUG, "Enter\n");
> +       dentry = file->f_dentry;
> +       inode = dentry->d_inode;
> +       mapping = inode->i_mapping;
> +       page = read_cache_page(mapping, index,
> +                              (filler_t *)mapping->a_ops->readpage,
> +                              (void *)file);
> +       if (IS_ERR(page))
> +               goto out;
> +       wait_on_page_locked(page);
> +       if (!PageUptodate(page)) {
> +               lock_page(page);
> +               rc = mapping->a_ops->readpage(file, page);

What's the purpose of this second read?

> +               if (rc) {
> +                       page = ERR_PTR(rc);
> +                       goto out;
> +               }
> +               wait_on_page_locked(page);
> +               if (!PageUptodate(page)) {
> +                       page = ERR_PTR(-EIO);
> +                       goto out;
> +               }
> +       }
> +out:
> +       ecryptfs_printk(KERN_DEBUG, "Exit\n");
> +       return page;
> +}

[snip]

> +/**
> + * Reads the data from the lower file file at index lower_page_index
> + * and copies that data into page.
> + *
> + * @param page Page to fill
> + * @param lower_page_index Index of the page in the lower file to get
> + */
> +int ecryptfs_do_readpage(struct file *file, struct page *page,
> +                        pgoff_t lower_page_index)
> +{
> +       int rc = -EIO;
> +       struct dentry *dentry;
> +       struct file *lower_file;
> +       struct dentry *lower_dentry;
> +       struct inode *inode;
> +       struct inode *lower_inode;
> +       char *page_data;
> +       struct page *lower_page = NULL;
> +       char *lower_page_data;
> +       struct address_space_operations *lower_a_ops;
> +
> +       ecryptfs_printk(KERN_DEBUG, "Enter; lower_page_index = [0x%.16x]\n",
> +                       lower_page_index);
> +       dentry = file->f_dentry;
> +       if (NULL == ECRYPTFS_FILE_TO_PRIVATE_SM(file)) {
> +               rc = -ENOENT;
> +               ecryptfs_printk(KERN_ERR, "No lower file info\n");
> +               goto out;
> +       }
> +       lower_file = ECRYPTFS_FILE_TO_LOWER(file);
> +       lower_dentry = ECRYPTFS_DENTRY_TO_LOWER(dentry);
> +       inode = dentry->d_inode;
> +       lower_inode = ECRYPTFS_INODE_TO_LOWER(inode);
> +       lower_a_ops = lower_inode->i_mapping->a_ops;
> +       lower_page = read_cache_page(lower_inode->i_mapping, lower_page_index,
> +                                    (filler_t *)lower_a_ops->readpage,
> +                                    (void *)lower_file);
> +       if (IS_ERR(lower_page)) {
> +               rc = PTR_ERR(lower_page);
> +               lower_page = NULL;
> +               ecryptfs_printk(KERN_ERR, "Error reading from page cache\n");
> +               goto out;
> +       }
> +       wait_on_page_locked(lower_page);
> +       if (!PageUptodate(lower_page)) {

And here?

> +               lock_page(lower_page);
> +               rc = lower_a_ops->readpage(lower_file, lower_page);
> +               if (rc) {
> +                       lower_page = NULL;
> +                       rc = -EIO;
> +                       ecryptfs_printk(KERN_ERR, "Error reading lower "
> +                                       "page at index=[0x%.16x]\n",
> +                                       lower_page_index);
> +                       goto out;
> +               }
> +               wait_on_page_locked(lower_page);
> +               if (!PageUptodate(lower_page)) {
> +                       rc = -EIO;
> +                       ecryptfs_printk(KERN_ERR, "Error reading lower "
> +                                       "page at index=[0x%.16x]\n",
> +                                       lower_page_index);
> +                       goto out;
> +               }
> +       }
