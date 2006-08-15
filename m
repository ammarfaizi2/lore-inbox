Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWHOVWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWHOVWa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 17:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWHOVWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 17:22:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4257 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750706AbWHOVW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 17:22:29 -0400
Date: Tue, 15 Aug 2006 14:22:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2/3] Create call_usermodehelper_pipe()
Message-Id: <20060815142225.52cc86b3.akpm@osdl.org>
In-Reply-To: <20060814112731.5A16213BD9@wotan.suse.de>
References: <20060814 127.183332000@suse.de>
	<20060814112731.5A16213BD9@wotan.suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 13:27:31 +0200 (CEST)
Andi Kleen <ak@suse.de> wrote:

> +	/* Install input pipe when needed */
> +	if (sub_info->stdin) {
> +		struct files_struct *f = current->files;
> +		struct fdtable *fdt;
> +		/* no races because files should be private here */
> +		sys_close(0);
> +		fd_install(0, sub_info->stdin);
> +		spin_lock(&f->file_lock);
> +		fdt = files_fdtable(f);
> +		FD_SET(0, fdt->open_fds);
> +		FD_CLR(0, fdt->close_on_exec);
> +		spin_unlock(&f->file_lock);
> +	}

This is all going to be run by kernel threads, and all kernel threads share
current->files=&init_files.

So I suspect that if two coredumps happen at the same time bad things will
happen.  Like a BUG() in fd_install()?

