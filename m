Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWDYOdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWDYOdF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 10:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWDYOdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 10:33:04 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:27786 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932232AbWDYOdE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 10:33:04 -0400
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Michael Holzheu <holzheu@de.ibm.com>
Cc: ioe-lkml@rameria.de, linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       joern@wohnheim.fh-wedel.de
In-Reply-To: <20060424191941.7aa6412a.holzheu@de.ibm.com>
References: <20060424191941.7aa6412a.holzheu@de.ibm.com>
Date: Tue, 25 Apr 2006 17:33:01 +0300
Message-Id: <1145975582.11508.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 19:19 +0200, Michael Holzheu wrote:
> +static int hypfs_create_cpu_files(struct super_block *sb,
> +				  struct dentry *cpus_dir, void *cpu_info)
> +{
> +	struct dentry *cpu_dir;
> +	char buffer[TMP_SIZE];

Holy cow! That's 1 KB allocated on the stack! Please use kmalloc()
instead.

> +static int hypfs_create_phys_cpu_files(struct super_block *sb,
> +				       struct dentry *cpus_dir, void *cpu_info)
> +{
> +	struct dentry *cpu_dir;
> +	char buffer[TMP_SIZE];

Ditto.

> +static ssize_t hypfs_aio_write(struct kiocb *iocb, const char __user *buf,
> +			       size_t count, loff_t pos)
> +{
> +	int rc;
> +
> +	mutex_lock(&hypfs_lock);
> +	if (last_update_time == get_seconds()) {
> +		rc = -EBUSY;
> +		goto out;
> +	}
> +	hypfs_delete_tree(hypfs_sblk->s_root);

To state what I said earlier: the use of a global hypfs_sblk is
problematic because now we can only have the filesystem mounted once. So
I would really like to see some other way of updating. How do you feel
about the s_ops->fs_remount thing?

				Pekka

