Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030678AbVIBEkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030678AbVIBEkg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 00:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030679AbVIBEkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 00:40:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27881 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030678AbVIBEkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 00:40:35 -0400
Date: Thu, 1 Sep 2005 21:38:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: lkml-z@robsims.com, linux-kernel@vger.kernel.org
Subject: Re: Change in NFS client behavior
Message-Id: <20050901213853.1bdbb2d8.akpm@osdl.org>
In-Reply-To: <1125634747.8635.17.camel@lade.trondhjem.org>
References: <20050831145545.GA8426@robsims.com>
	<1125617897.7627.14.camel@lade.trondhjem.org>
	<1125632597.8635.9.camel@lade.trondhjem.org>
	<20050901204520.58f07230.akpm@osdl.org>
	<1125633145.8635.11.camel@lade.trondhjem.org>
	<20050901210755.607f3e4d.akpm@osdl.org>
	<1125634523.8635.16.camel@lade.trondhjem.org>
	<1125634747.8635.17.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>

Looks good from a quick scan.

> +static int do_posix_truncate(struct dentry *dentry, loff_t length)
>  +{
>  +	int err = 0;
>  +	struct iattr newattrs;
>  +
>  +	newattrs.ia_size = length;
>  +	newattrs.ia_valid = ATTR_SIZE;
>  +
>  +	down(&dentry->d_inode->i_sem);
>  +	/* In SuS/Posix lore, truncate to the current file size is a no-op */
>  +	if (length != i_size_read(dentry->d_inode))
>  +		err = notify_change(dentry, &newattrs);
>  +	up(&dentry->d_inode->i_sem);
>  +	return err;
>  +}

I'm not sure that we really need to bother putting the i_size test inside
i_sem.  If somebody is changing the file size in parallel with truncate
then they'll get unpredictable results anyway.  Needs deep thought.
