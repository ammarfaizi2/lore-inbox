Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161060AbWIGRPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbWIGRPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 13:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWIGRPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 13:15:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2182 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161060AbWIGRPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 13:15:17 -0400
Date: Thu, 7 Sep 2006 10:15:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] proc: Make the generation of the self symlink table
 driven.
Message-Id: <20060907101512.3e3a9604.akpm@osdl.org>
In-Reply-To: <m1odttx8uz.fsf@ebiederm.dsl.xmission.com>
References: <m1odttx8uz.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Sep 2006 10:23:00 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> 
> This patch generalizes the concept of files in /proc that are
> related to processes but live in the root directory of /proc
> 
> Ideally this would reuse infrastructure from the rest of the
> process specific parts of proc but unfortunately
> security_task_to_inode must not be called on files that
> are not strictly per process.  security_task_to_inode
> really needs to be reexamined as the security label can
> change in important places that we are not currently
> catching, but I'm not certain that simplifies this problem.
> 
> By at least matching the structure of the rest of proc
> we get more idiom reuse and it becomes easier to spot problems
> in the way things are put together.
> 
> Later things like /proc/mounts are likely to be moved into
> proc_base as well.  If union mounts are ever supported
> we may be able to make /proc a union mount, and properly
> split it into 2 filesystems.
> 
> ..
>
>  /*
> + * proc base
> + *
> + * These are the directory entries in the root directory of /proc
> + * that properly belong to the /proc filesystem, as they describe
> + * describe something that is process related.
> + */
> +static struct pid_entry proc_base_stuff[] = {
> +	NOD(PROC_TGID_INO, 	"self", S_IFLNK|S_IRWXUGO,
> +		&proc_self_inode_operations, NULL, {}),
> +	{}
> +};

We could save a bunch of bytes here.

> +	/* Lookup the directory entry */
> +	for (p = proc_base_stuff; p->name; p++) {

By using ARRAY_SIZE here.

> +	for (; nr < (ARRAY_SIZE(proc_base_stuff) - 1); filp->f_pos++, nr++) {

like that does.


