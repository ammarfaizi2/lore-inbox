Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbTHaVks (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 17:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTHaVks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 17:40:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:33685 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262684AbTHaVkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 17:40:47 -0400
Date: Sun, 31 Aug 2003 14:40:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: create_proc_entry and !CONFIG_PROC_FS
Message-Id: <20030831144033.6f9d8708.akpm@osdl.org>
In-Reply-To: <20030831150632.GU7038@fs.tum.de>
References: <20030831150632.GU7038@fs.tum.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> Hi,
> 
> I've observed a possible problem with create_proc_entry and 
> !CONFIG_PROC_FS.
> 
> If !CONFIG_PROC_FS include/linux/proc_fs.h includes a dummy 
> create_proc_entry that simply returns NULL.
> 
> Unfortunately, many callers of this function do things like e.g.
> 
> static int __init br2684_init(void)
> {
>         struct proc_dir_entry *p;
>         if ((p = create_proc_entry("br2684", 0, atm_proc_root)) == NULL)
>                 return -ENOMEM;
>         p->proc_fops = &br2684_proc_operations;
>         br2684_ioctl_set(br2684_ioctl);
>         return 0;
> }
> 
> 
> IOW, the dummy create_proc_entry fixes the compilation but the init 
> function always returns -ENOMEM if !CONFIG_PROC_FS.
> 
> Is there any better solution than removing the dummy create_proc_entry 
> and #ifdef'ing all places where it's used?

The normal fix would be to sprinkle ifdefs throughout the driver itself.

You need to lok at the driver and ask yourself "is anyone ever going to want
to use this in a no-procfs system".  Probably, the answer is always "no". 
In which case appropriate fixes would be to ignore the problem, or disable
the driver in config if !CONFIG_PROC_FS.

