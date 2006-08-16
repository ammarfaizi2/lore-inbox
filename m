Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWHPCNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWHPCNZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 22:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWHPCNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 22:13:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44953 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750727AbWHPCNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 22:13:24 -0400
Date: Tue, 15 Aug 2006 19:13:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2/3] Create call_usermodehelper_pipe()
Message-Id: <20060815191319.e535f5c6.akpm@osdl.org>
In-Reply-To: <20060815142225.52cc86b3.akpm@osdl.org>
References: <20060814 127.183332000@suse.de>
	<20060814112731.5A16213BD9@wotan.suse.de>
	<20060815142225.52cc86b3.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 14:22:25 -0700
Andrew Morton <akpm@osdl.org> wrote:

> On Mon, 14 Aug 2006 13:27:31 +0200 (CEST)
> Andi Kleen <ak@suse.de> wrote:
> 
> > +	/* Install input pipe when needed */
> > +	if (sub_info->stdin) {
> > +		struct files_struct *f = current->files;
> > +		struct fdtable *fdt;
> > +		/* no races because files should be private here */
> > +		sys_close(0);
> > +		fd_install(0, sub_info->stdin);
> > +		spin_lock(&f->file_lock);
> > +		fdt = files_fdtable(f);
> > +		FD_SET(0, fdt->open_fds);
> > +		FD_CLR(0, fdt->close_on_exec);
> > +		spin_unlock(&f->file_lock);
> > +	}
> 
> This is all going to be run by kernel threads, and all kernel threads share
> current->files=&init_files.

hm, that's wrong, isn't it - we're not using CLONE_FILES...

So what we have is a copy of init_files.  So the sys_close(0) shouldn't be needed?
