Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVANAcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVANAcX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVANAaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:30:07 -0500
Received: from hera.kernel.org ([209.128.68.125]:51383 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261730AbVANAWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:22:04 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] Kprobes /proc entry
Date: Thu, 13 Jan 2005 16:22:03 -0800
Organization: Open Source Development Lab
Message-ID: <20050113162203.737e90ac@dxpl.pdx.osdl.net>
References: <41E2AC82.8020909@gmail.com>
	<20050110181445.GA31209@kroah.com>
	<1105479077.17592.8.camel@pants.austin.ibm.com>
	<20050111213400.GB18422@kroah.com>
	<41E70234.50900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1105662121 20209 172.20.1.103 (14 Jan 2005 00:22:01 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Fri, 14 Jan 2005 00:22:01 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 0.9.13 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The module ref counting should be done by the VFS layer
not the interface. See below:

> - --- ./kernel/kprobes.c	2005-01-13 20:41:11.000000000 +0100
> +++ ./kernel/kprobes.c	2005-01-13 20:39:27.000000000 +0100
> @@ -33,6 +33,9 @@
>  #include <linux/hash.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/debugfs.h>
> +#include <linux/kallsyms.h>
>  #include <asm/cacheflush.h>
>  #include <asm/errno.h>
>  #include <asm/kdebug.h>
> @@ -131,6 +134,96 @@
>  	unregister_kprobe(&jp->kp);
>  }
> 
> +#ifdef CONFIG_DEBUG_FS
> +int kprobes_open(struct inode *inode, struct file *file)
> +{
> +	try_module_get(THIS_MODULE);
not needed (see below).
> +	return 0;
> +}
> +
> +int kprobes_release(struct inode *inode, struct file *file)
> +{
> +	module_put(THIS_MODULE);
ditto

> +	return 0;
> +}

> +
> +struct dentry *kprobes_dir, *kprobes_list;
> +struct file_operations kprobes_fops = {
> +	.open = kprobes_open,
> +	.read = kprobes_read,
> +	.release = kprobes_release
Add:
	.owner = THIS_MODULE,

