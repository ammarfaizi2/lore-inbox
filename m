Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbVKCWG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbVKCWG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 17:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbVKCWG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 17:06:57 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:15570 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751397AbVKCWG4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 17:06:56 -0500
Subject: Re: [PATCH 12/12: eCryptfs] Crypto functions
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Phillip Hellewell <phillip@hellewell.homeip.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
In-Reply-To: <20051103035659.GL3005@sshock.rn.byu.edu>
References: <20051103033220.GD2772@sshock.rn.byu.edu>
	 <20051103035659.GL3005@sshock.rn.byu.edu>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 16:06:50 -0600
Message-Id: <1131055610.9365.17.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 20:56 -0700, Phillip Hellewell wrote:
> +/**
> + * Write the file headers out.  This will likely involve a userspace
> + * callout, in which the session key is encrypted with one or more
> + * public keys and/or the passphrase necessary to do the encryption
> is
> + * retrieved via a prompt.  Exactly what happens at this point should
> + * be policy-dependent.
> + *
> + * @param lower_file The lower file struct, which was returned from
> + * dentry_open
> + * @return Zero on success; non-zero on error
> + */
> +int ecryptfs_write_headers(struct dentry *ecryptfs_dentry,
> +                          struct file *lower_file)
> +{
> +       int rc = 0;
> +       char *page_virt;
> +       struct ecryptfs_crypt_stats *crypt_stats;
> +       mm_segment_t oldfs;
> +       int ecryptfs_marker_len;
> +       ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
> +       crypt_stats =
> &INODE_TO_PRIVATE(ecryptfs_dentry->d_inode)->crypt_stats;
> +       if (likely(1 == crypt_stats->encrypted)) {
> +               if (!crypt_stats->key_valid) {
> +                       ecryptfs_printk(1, KERN_NOTICE, "Key is "
> +                                       "invalid; bailing out\n");
> +                       rc = -EINVAL;
> +                       goto out;
> +               }
> +       } else {
> +               rc = -EINVAL;
> +               ecryptfs_printk(0, KERN_WARNING,
> +                               "Called with crypt_stats->encrypted ==
> 0\n");
> +               goto out;
> +       }
> +       /* Released in this function */
> +       page_virt =
> +           ecryptfs_kmem_cache_alloc(ecryptfs_header_cache_0,
> SLAB_USER);
> +       if (!page_virt) {
> +               ecryptfs_printk(0, KERN_ERR, "Out of memory\n");
> +               return -ENOMEM;
> +       }
> +       ecryptfs_marker_len = write_ecryptfs_marker(page_virt,
> +
> ECRYPTFS_FILE_SIZE_BYTES);
> +       rc = ecryptfs_generate_key_packet_set(page_virt,
> +
> (ECRYPTFS_FILE_SIZE_BYTES
> +                                              + ecryptfs_marker_len),
> +                                             crypt_stats,
> ecryptfs_dentry);
> +       if (unlikely(rc == 0)) {
> +               rc = -EIO;
> +               ecryptfs_printk(0, KERN_ERR, "Error whilst generating
> the key "
> +                               "packet set; writing zero's\n");
> +               goto out_free;
> +       }
> +       rc = 0;
> +       ecryptfs_printk(1, KERN_NOTICE,
> +                       "Writing key packet set to underlying file
> \n");
> +       lower_file->f_pos = 0;
> +       oldfs = get_fs();
> +       set_fs(get_ds());
> +       lower_file->f_op->write(lower_file, (char __user *)page_virt,
> +                               PAGE_CACHE_SIZE, &lower_file->f_pos);
> +       set_fs(oldfs);
> +       ecryptfs_fput(lower_file);

Why the call to ecryptfs_fput() here?  The caller does it's own fput on
lower_file.

> +       ecryptfs_printk(1, KERN_NOTICE,
> +                       "Done writing key packet set to underlying
> file.\n");
> +out_free:
> +       ecryptfs_kmem_cache_free(ecryptfs_header_cache_0, page_virt);
> +out:
> +       ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
> +       return rc;
> +}
-- 
David Kleikamp
IBM Linux Technology Center

