Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbUJZXZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbUJZXZc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 19:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbUJZXZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 19:25:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:32641 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261538AbUJZXZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 19:25:27 -0400
Date: Tue, 26 Oct 2004 16:29:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: tharbaugh@lnxi.com
Cc: klibc@zytor.com, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: chicken/egg between pipefs and initramfs/hotplug
Message-Id: <20041026162922.0e9f7f88.akpm@osdl.org>
In-Reply-To: <1098729008.19348.80.camel@tubarao>
References: <1098729008.19348.80.camel@tubarao>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thayne Harbaugh <tharbaugh@lnxi.com> wrote:
>
> It appears that linux/init/main.c:init() has a chicken/egg problem.
> Apparently modprobe and other programs need a pipe and pipefs isn't
> mounted until later on in do_basic_setup()/do_initcalls().  That means
> that linux/fs/pipe.c:static struct vfsmount *pipe_mnt;  isn't
> initialized and blows up when it's derefernced in
> linux/fs/pipe.c:get_pipe_inode().

That's a bit sad.  Does this fix it?

--- 25/fs/pipe.c~a	Tue Oct 26 16:28:44 2004
+++ 25-akpm/fs/pipe.c	Tue Oct 26 16:28:52 2004
@@ -718,5 +718,5 @@ static void __exit exit_pipe_fs(void)
 	mntput(pipe_mnt);
 }
 
-module_init(init_pipe_fs)
+fs_initcall(init_pipe_fs)
 module_exit(exit_pipe_fs)
_

