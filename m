Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261699AbTCQAYF>; Sun, 16 Mar 2003 19:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261709AbTCQAYE>; Sun, 16 Mar 2003 19:24:04 -0500
Received: from packet.digeo.com ([12.110.80.53]:5791 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261699AbTCQAYD>;
	Sun, 16 Mar 2003 19:24:03 -0500
Date: Sun, 16 Mar 2003 16:34:44 -0800
From: Andrew Morton <akpm@digeo.com>
To: Brian Davids <dlister@yossman.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.64-bk multiple oops on boot
Message-Id: <20030316163444.4d495d59.akpm@digeo.com>
In-Reply-To: <3E75138C.7030607@yossman.net>
References: <3E75138C.7030607@yossman.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Mar 2003 00:34:38.0015 (UTC) FILETIME=[FDBE6CF0:01C2EC1C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Davids <dlister@yossman.net> wrote:
>
> I get the following oopsen during booting with 2.5.64-bk pulled at 
> around 10 AM EST today...  system is running RedHat Phoebe 8.0.94 beta, 
> gcc 3.2.1
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>   printing eip:
> c01a4c9b
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0060:[<c01a4c9b>]    Not tainted
> EFLAGS: 00010283
> EIP is at devfs_get_ops+0xb/0x40

Does this help?

diff -puN fs/devfs/base.c~devfs-oops-fix fs/devfs/base.c
--- 25/fs/devfs/base.c~devfs-oops-fix	2003-03-16 16:33:16.000000000 -0800
+++ 25-akpm/fs/devfs/base.c	2003-03-16 16:33:49.000000000 -0800
@@ -1802,8 +1802,11 @@ int devfs_generate_path (devfs_handle_t 
 static struct file_operations *devfs_get_ops (devfs_handle_t de)
 {
     struct file_operations *ops = de->u.cdev.ops;
-    struct module *owner = ops->owner;
+    struct module *owner;
 
+    if (!ops)
+	return NULL;
+    owner = ops->owner;
     read_lock (&de->parent->u.dir.lock);  /*  Prevent module from unloading  */
     if ( (de->next == de) || !try_module_get (owner) )
     {   /*  Entry is already unhooked or module is unloading  */

_

