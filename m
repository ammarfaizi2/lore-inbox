Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbTJYKyS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 06:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbTJYKyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 06:54:18 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:61194 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262572AbTJYKyN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 06:54:13 -0400
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NLS as module
References: <Pine.LNX.4.44.0310232155320.3344-100000@poirot.grange>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 25 Oct 2003 19:53:49 +0900
In-Reply-To: <Pine.LNX.4.44.0310232155320.3344-100000@poirot.grange>
Message-ID: <87d6cloaf6.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:

> Problem: NLS support can only be compiled in the kernel - and not as a
> module. And if you don't configure one of Joliet / FAT and some other
> filesystems at kernel compile-time, you can't compile these filesystems
> later as modules(*). However, I see nothing that would prevent one from
> compiling nls_base as a module. I tried - it worked, but I didn't actually
> use any of the codepages. Just tried insmod nls_base, insmod <fs>, mount.
> So, is it desired / really this trivial or are there some real reasons why
> nls_base cannot be properly done as a module? I am attaching a naive
> patch - but not really understanding NLS internals and not being able to
> extensively test it, it might be not quite correct.

Sound good to me. And I like this, but it may be more test needed
(i.e. module autoload etc.). So I suggest it start on development
tree. And backport after it.

>  # msdos and Joliet want NLS
> -if [ "$CONFIG_JOLIET" = "y" -o "$CONFIG_FAT_FS" != "n" \
> -	-o "$CONFIG_NTFS_FS" != "n" -o "$CONFIG_NCPFS_NLS" = "y" \
> +if [ "$CONFIG_JOLIET" = "y" -o "$CONFIG_FAT_FS" = "y" \
> +	-o "$CONFIG_NTFS_FS" = "y" -o "$CONFIG_NCPFS_NLS" = "y" \
>  	-o "$CONFIG_SMB_NLS" = "y" ]; then
>    define_bool CONFIG_NLS y
>  else
> -  define_bool CONFIG_NLS n
> +  tristate 'Base NLS support'	CONFIG_NLS
>  fi

Looks like module dependency was broken.

> +static int __init init_nls_base(void)
> +{
> +	return 0;
> +}
> +
> +static void __exit exit_nls_base(void)
> +{
> +}
> +
> +module_init(init_nls_base)
> +module_exit(exit_nls_base)

Was this really needed?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
