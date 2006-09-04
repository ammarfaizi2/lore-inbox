Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWIDLVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWIDLVS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 07:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWIDLVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 07:21:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:63076 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964773AbWIDLVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 07:21:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=AuDv/oSXBUYjQnWI+92nhH0Qm+pHs8eIO5CR0TOaP4fs21Ta6wJC6JN/7PD4iq3oc6V9GrxcZ/4K+urbXYINH/4DcT2QXMhUx0OcLF4TP/nLlaEn7oLQlo0t5k/hUHqgwXvXWH7XjcJSlMTpqF5QPQf+7hEtfAAyG/sAdbzbC7A=
Message-ID: <84144f020609040420l5c24a48ci2b7b53516e74bcee@mail.gmail.com>
Date: Mon, 4 Sep 2006 14:20:43 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Josef Sipek" <jsipek@cs.sunysb.edu>
Subject: Re: [PATCH 03/22][RFC] Unionfs: Branch management functionality
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
In-Reply-To: <20060901014010.GD5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
	 <20060901014010.GD5788@fsl.cs.sunysb.edu>
X-Google-Sender-Auth: 7cbe9cacfda8e3a3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/06, Josef Sipek <jsipek@cs.sunysb.edu> wrote:
> +struct dentry **alloc_new_dentries(int objs)
> +{
> +       if (!objs)
> +               return NULL;
> +
> +       return kzalloc(sizeof(struct dentry *) * objs, GFP_KERNEL);

kcalloc

> +struct unionfs_usi_data *alloc_new_data(int objs)
> +{
> +       if (!objs)
> +               return NULL;
> +
> +       return kzalloc(sizeof(struct unionfs_usi_data) * objs, GFP_KERNEL);
> +}

Same here. I suggest you kill the wrappers too.

> +int unionfs_ioctl_incgen(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +       struct super_block *sb;
> +       int gen;
> +
> +       sb = file->f_dentry->d_sb;
> +
> +       unionfs_write_lock(sb);
> +
> +       atomic_inc(&stopd(sb)->usi_generation);
> +       gen = atomic_read(&stopd(sb)->usi_generation);

You could use atomic_inc_return here. Is usi_generation protected by
write lock on sb or do you really need atomic ops?

> +
> +       atomic_set(&dtopd(sb->s_root)->udi_generation, gen);
> +       atomic_set(&itopd(sb->s_root->d_inode)->uii_generation, gen);
> +
> +       unionfs_write_unlock(sb);
> +
> +       return gen;
> +}

-- 
VGER BF report: U 0.5
