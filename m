Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267175AbUBSKiS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 05:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267177AbUBSKiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 05:38:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:40326 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267175AbUBSKiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 05:38:13 -0500
Date: Thu, 19 Feb 2004 02:38:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
       error27@email.com
Subject: Re: [Announce] Strace Test
Message-Id: <20040219023813.2d4b0ced.akpm@osdl.org>
In-Reply-To: <16436.35563.593635.277584@laputa.namesys.com>
References: <20040216052257.A2C971D7214@ws3-3.us4.outblaze.com>
	<16436.35563.593635.277584@laputa.namesys.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <Nikita@Namesys.COM> wrote:
>
>  > Strace Test uses a modified version of strace 4.5.1.  
>   > Instead of printing out information about system calls, 
>   > the modified version calls the syscalls with improper 
>   > values.
> 
>  It immediately DoSes kernel by calling sys_sysctl() with huge nlen:
>  printk() consumes all CPU.

Something like this?

--- 25/kernel/sysctl.c~sysctl-nlen-check	2004-02-19 02:36:20.000000000 -0800
+++ 25-akpm/kernel/sysctl.c	2004-02-19 02:37:40.000000000 -0800
@@ -913,6 +913,9 @@ asmlinkage long sys_sysctl(struct __sysc
 
 	if (copy_from_user(&tmp, args, sizeof(tmp)))
 		return -EFAULT;
+
+	if (tmp.nlen < 0 || tmp.nlen > CTL_MAXNAME)
+		return -EINVAL;
 	
 	if (tmp.nlen != 2 || copy_from_user(name, tmp.name, sizeof(name)) ||
 	    name[0] != CTL_KERN || name[1] != KERN_VERSION) { 

_

