Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVF0PCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVF0PCh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVF0O7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:59:55 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:65514 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262056AbVF0N3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 09:29:49 -0400
Date: Mon, 27 Jun 2005 18:59:41 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, gdb@sources.redhat.com
Subject: Re: [Fastboot] Re: [-mm patch] i386: enable REGPARM by default
Message-ID: <20050627132941.GD3764@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20050624200916.GJ6656@stusta.de> <20050624132826.4cdfb63c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624132826.4cdfb63c.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 01:28:26PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > This patch:
> > - removes the dependency of REGPARM on EXPERIMENTAL
> > - let REGPARM default to y
> 
> hm, a compromise.
> 
> One other concern I have with this is that I expect -mregparm will make
> kgdb (and now crashdump) less useful.  When incoming args are on the stack
> you have a good chance of being able to see what their value is by walking
> the stack slots.
> 
> When the incoming args are in registers I'd expect that it would be a lot
> harder (or impossible) to work out their value.
> 
> Have the kdump guys thought about (or encountered) this?
> 

[copying to gdb@sources.redhat.com]

I too played a little bit with this (gdb stack trace outputs without REGPARM 
and with REGPARM). Following are stack traces of both the cases.

REGPARM Disabled
----------------
(gdb) bt
#0  0xc0113d22 in crash_get_current_regs (regs=0xedf33e6c)
    at arch/i386/kernel/crash.c:102
#1  0xc0113d9d in crash_save_self (saved_regs=0xedf33e6c)
    at arch/i386/kernel/crash.c:134
#2  0xc013d19a in crash_kexec (regs=0x2) at kernel/kexec.c:1059
#3  0xc011c999 in panic (fmt=0x2 <Address 0x2 out of bounds>)
    at kernel/panic.c:86
#4  0xc014086a in func2 (a=2, b=0x2, c=100 'd') at kernel/ksysfs.c:36
#5  0xc01408a5 in func1 (a=20, b=0xc044cae8, c=100 'd') at kernel/ksysfs.c:42
#6  0xc01408f8 in stack_debug_show (subsys=0xc044cb00,
    page=0x2 <Address 0x2 out of bounds>) at kernel/ksysfs.c:59
#7  0xc0198e3f in subsys_attr_show (kobj=0xc044cb18, attr=0x2,
    page=0x2 <Address 0x2 out of bounds>) at fs/sysfs/file.c:30
#8  0xc0198ed8 in fill_read_buffer (dentry=0x1, buffer=0xee33db20)
    at fs/sysfs/file.c:86
#9  0xc0198fe7 in sysfs_read_file (file=0x1,
    buf=0x2 <Address 0x2 out of bounds>, count=2, ppos=0x2)
    at fs/sysfs/file.c:153
#10 0xc0160599 in vfs_read (file=0xef3d8880,
    buf=0x804d858 <Address 0x804d858 out of bounds>, count=4096,
    pos=0xedf33fa4) at fs/read_write.c:238
#11 0xc0160871 in sys_read (fd=2, buf=0x2 <Address 0x2 out of bounds>,
count=2)
    at fs/read_write.c:321


Here all the function arguments does not seem to be right. I introduced
func1 and func2 and value of parameters is partially correct. (Right values
are a=20, b=0xecab5f18,, c='d').

Time to talk to gdb folks.

With REGPARM Enabled
--------------------
(gdb) bt
#0  0xc0112a20 in crash_get_current_regs (regs=0xee661e94)
    at arch/i386/kernel/crash.c:102
#1  0xc0112a89 in crash_save_self (saved_regs=0x0)
    at arch/i386/kernel/crash.c:134
#2  0xc0138be2 in crash_kexec (regs=0x5400) at kernel/kexec.c:1059
#3  0xc011adeb in panic (fmt=0xc03b7499 "Vivek: Invoked panic\n")
    at kernel/panic.c:86
#4  0xc013beab in func2 (a=-295297388, b=0x5400, c=-108 '\224')
    at kernel/ksysfs.c:36
#5  0xc013bedb in func1 (a=-1069483288, b=0x14, c=-108 '\224')
    at kernel/ksysfs.c:42
#6  0xc013bf36 in stack_debug_show (subsys=0xee661e94, page=0xede0f000 "")
    at kernel/ksysfs.c:60
#7  0xc018d31c in subsys_attr_show (kobj=0xee661e94, attr=0x5400,
    page=0xede0f000 "") at fs/sysfs/file.c:30
#8  0xc018d38e in fill_read_buffer (dentry=0xee661e94, buffer=0xefd32360)
    at fs/sysfs/file.c:86
#9  0xc018d481 in sysfs_read_file (file=0xee0909c0,
    buf=0x804d858 <Address 0x804d858 out of bounds>, count=4096,
    ppos=0xee661e94) at fs/sysfs/file.c:153
#10 0xc0159260 in vfs_read (file=0xee0909c0,
    buf=0x804d858 <Address 0x804d858 out of bounds>, count=4096,
    pos=0xee661fa4) at fs/read_write.c:238
#11 0xc01594e9 in sys_read (fd=3999669908,
    buf=0x804d858 <Address 0x804d858 out of bounds>, count=4096)
    at fs/read_write.c:321

Here all the arguments of func1 and func2 are bad. Looks like REGPARM might
worsen the output.

Will look more into this.

Thanks
Vivek

