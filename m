Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbUBZGn5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 01:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbUBZGn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 01:43:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:31682 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262712AbUBZGnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 01:43:55 -0500
Date: Wed, 25 Feb 2004 22:44:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: kingsley@aurema.com, linux-kernel@vger.kernel.org
Subject: Re: /proc visibility patch breaks GDB, etc.
Message-Id: <20040225224410.3eb21312.akpm@osdl.org>
In-Reply-To: <16445.37304.155370.819929@wombat.chubb.wattle.id.au>
References: <16445.37304.155370.819929@wombat.chubb.wattle.id.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb <peter@chubb.wattle.id.au> wrote:
>
> 
> In fs/proc/base.c:proc_pid_lookup(), the patch
> 
>         read_unlock(&tasklist_lock); 
>         if (!task) 
>                 goto out; 
> +       if (!thread_group_leader(task)) 
> +               goto out_drop_task; 
>   
>         inode = proc_pid_make_inode(dir->i_sb, task, PROC_TGID_INO); 
> 
> means that threads other than the thread group leader don't appear in
> the /proc top-level directory.  Programs that are informed via pid of
> events can no longer find the appropriate process -- for example,
> using gdb on a multi-threaded process, or profiling using perfmon.
> 
> The immediate symptom is GDB saying:
>     Could not open /proc/757/status
> when 757 is a TID not a PID.

What does `ls /proc/757' say?  Presumably no such file or directory?
It's fairly bizare behaviour to be able to open files which don't exist
according to readdir, which is why we made that change.

The node to tid 757 should appear under its thread group leader's
directory: /proc/NNN/757.  That node should be visible to readdir, and that
is the node which gdb and perfmon should be looking for.

Of course, we may have burnt our boats with the initial silliness.  It's a
shame that gdb and perfmon went and used it.
