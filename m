Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267178AbUBSKvW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 05:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUBSKvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 05:51:22 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:55180 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S267178AbUBSKvV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 05:51:21 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16436.38183.533759.45718@laputa.namesys.com>
Date: Thu, 19 Feb 2004 13:51:19 +0300
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
       error27@email.com
Subject: Re: [Announce] Strace Test
In-Reply-To: <20040219023813.2d4b0ced.akpm@osdl.org>
References: <20040216052257.A2C971D7214@ws3-3.us4.outblaze.com>
	<16436.35563.593635.277584@laputa.namesys.com>
	<20040219023813.2d4b0ced.akpm@osdl.org>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Nikita Danilov <Nikita@Namesys.COM> wrote:
 > >
 > >  > Strace Test uses a modified version of strace 4.5.1.  
 > >   > Instead of printing out information about system calls, 
 > >   > the modified version calls the syscalls with improper 
 > >   > values.
 > > 
 > >  It immediately DoSes kernel by calling sys_sysctl() with huge nlen:
 > >  printk() consumes all CPU.
 > 
 > Something like this?

On slow console (serial kgdb) this still would be problematic. I think
printk_ratelimit() is needed. But why this loop is needed at all? It
seems strange that syscall prints its arguments instead of just
returning -EINVAL.

 > 
 > --- 25/kernel/sysctl.c~sysctl-nlen-check	2004-02-19 02:36:20.000000000 -0800
 > +++ 25-akpm/kernel/sysctl.c	2004-02-19 02:37:40.000000000 -0800
 > @@ -913,6 +913,9 @@ asmlinkage long sys_sysctl(struct __sysc
 >  
 >  	if (copy_from_user(&tmp, args, sizeof(tmp)))
 >  		return -EFAULT;
 > +
 > +	if (tmp.nlen < 0 || tmp.nlen > CTL_MAXNAME)
 > +		return -EINVAL;
 >  	
 >  	if (tmp.nlen != 2 || copy_from_user(name, tmp.name, sizeof(name)) ||
 >  	    name[0] != CTL_KERN || name[1] != KERN_VERSION) { 

Nikita.

 > 
 > _
 > 
