Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWEORFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWEORFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWEORFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:05:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33235 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964851AbWEORFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:05:38 -0400
Date: Mon, 15 May 2006 10:01:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, phillip@hellewell.homeip.net,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Howells <dhowells@redhat.com>
Subject: Re: 2.6.17-rc4-mm1
Message-Id: <20060515100144.0aff41b1.akpm@osdl.org>
In-Reply-To: <20060515164938.GB10143@mipter.zuzino.mipt.ru>
References: <20060515005637.00b54560.akpm@osdl.org>
	<20060515164938.GB10143@mipter.zuzino.mipt.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> >   - Added the ecryptfs filesystem
> 
>   CC [M]  fs/ecryptfs/super.o
> fs/ecryptfs/super.c: In function `ecryptfs_statfs':
> fs/ecryptfs/super.c:129: warning: passing arg 1 of `vfs_statfs' from incompatible pointer type
> fs/ecryptfs/super.c: At top level:
> fs/ecryptfs/super.c:207: warning: initialization from incompatible pointer type

hm, I wonder why I didn't notice that.

> * ->statfs wants vfsmount as first argument
> * ecryptfs_statfs() is inlined

yup.  Fixed a bunch of those, let one slip through.

I don't immediately see how to fix this one, actually:

static inline int ecryptfs_statfs(struct super_block *sb, struct kstatfs *buf)
{
	return vfs_statfs(ecryptfs_superblock_to_lower(sb), buf);
}

Once we've run ecryptfs_superblock_to_lower() to get the "lower
superblock", we need to turn that back into a vfsmount for vfs_statfs()..

(and that function needn't have been inlined - it's only ever called
indirectly)

I think I'll be dropping the fs-cache patches (again) fairly soon.  They're
intrusive, quite some effort to carry, they're not getting adequate review
(afaict) and there doesn't seem to be a lot of demand for them, sorry.
