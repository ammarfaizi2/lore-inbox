Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWAPXYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWAPXYG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 18:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWAPXYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 18:24:06 -0500
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:9936 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S1751278AbWAPXYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 18:24:04 -0500
Message-ID: <43CC2AF8.4050802@sw.ru>
Date: Tue, 17 Jan 2006 02:23:36 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
References: <20060116223431.GA24841@suse.de>
In-Reply-To: <20060116223431.GA24841@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf, can you please check if my patch for busy inodes from -mm tree 
helps you?
Patch name is fix-of-dcache-race-leading-to-busy-inodes-on-umount.patch
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm4/broken-out/fix-of-dcache-race-leading-to-busy-inodes-on-umount.patch

I can also provide you a more sophisticated debug patch for this if 
required.

Kirill

> I get 'Busy inodes after umount' very often, even with recent kernels.
> Usually it remains unnoticed for a while. A bit more info about what
> superblock had problems would be helpful.
> 
> bdevname() doesnt seem to be the best way for pretty-printing NFS mounts
> for example. Should it just print the major:minor pair? 
> Are there scripts or something that parse such kernel messages, should
> the extra info go somewhere else?
> 
>  fs/super.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/fs/super.c
> ===================================================================
> --- linux-2.6.orig/fs/super.c
> +++ linux-2.6/fs/super.c
> @@ -227,6 +227,7 @@ void generic_shutdown_super(struct super
>  {
>  	struct dentry *root = sb->s_root;
>  	struct super_operations *sop = sb->s_op;
> +	char b[BDEVNAME_SIZE];
>  
>  	if (root) {
>  		sb->s_root = NULL;
> @@ -247,8 +248,9 @@ void generic_shutdown_super(struct super
>  
>  		/* Forget any remaining inodes */
>  		if (invalidate_inodes(sb)) {
> -			printk("VFS: Busy inodes after unmount. "
> -			   "Self-destruct in 5 seconds.  Have a nice day...\n");
> +			printk("VFS: (%s) Busy inodes after unmount. "
> +			   "Self-destruct in 5 seconds.  Have a nice day...\n",
> +			   bdevname(sb->s_bdev, b));
>  		}
>  
>  		unlock_kernel();
