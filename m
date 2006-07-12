Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWGLOJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWGLOJQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 10:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWGLOJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 10:09:16 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:54227 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751379AbWGLOJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 10:09:15 -0400
Subject: Re: [SYSFS] Kernel Null pointer dereference in sysfs_readdir()
From: Steven Rostedt <rostedt@goodmis.org>
To: "Duetsch, Thomas  LDE1" <thomas.duetsch@siemens.com>
Cc: linux-kernel@vger.kernel.org, maneesh@in.ibm.com, mingo@elte.hu,
       Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <5B0042046ADE774687F32BF3652F5BB9021C92CA@kher9eaa.ww007.siemens.net>
References: <5B0042046ADE774687F32BF3652F5BB9021C92CA@kher9eaa.ww007.siemens.net>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 10:06:19 -0400
Message-Id: <1152713179.8309.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ added Patrick since his name is on the sysfs documentation ]
[ added Andrew since I am including a patch for 2.6.18 ]

On Wed, 2006-07-12 at 14:39 +0200, Duetsch, Thomas LDE1 wrote:
> Steven Rostedt wrote:
> > On Wed, 2006-07-12 at 13:35 +0200, Duetsch, Thomas LDE1 wrote:
> >> Hi,
> >> 
> >> I'm currently working on a custom kernel based on Ingo's -rt patch
> >> (2.6.16-rt29). 
> >> 
> >> While rebooting my machine, I came across a kernel null pointer
> >> dereference in this code segment in fs/sysfs/dir.c, function
> >> sysfs_readdir(): 
> >> 
> >> 		for (p=q->next; p!= &parent_sd->s_children; p=p->next) {
> struct
> >> 			sysfs_dirent *next; const char * name;
> >> 			int len;
> >> 
> >> 			next = list_entry(p, struct sysfs_dirent,
> >> 					   s_sibling);
> >> 			if (!next->s_element)
> >> 				continue;
> >> 
> >> 			name = sysfs_get_name(next);
> >> 			len = strlen(name);
> >> 			if (next->s_dentry)
> >> PROBLEM ->			ino = next->s_dentry->d_inode->i_ino;
> >> 			else
> >> 				ino = iunique(sysfs_sb, 2);
> >> 
> > 
> > Hi Thomas,
> > 
> > Do you have a backtrace to look at? It might be helpful to see what
> > functions brought us to this point. Also it might help to determine if
> > the problem is vanilla, -rt, or the custom kernel.
> > 
> > Thanks,
> > 
> > -- Steve
> 
> Of course, here you go:
> 
> <1>BUG: Unable to handle kernel NULL pointer dereference at virtual
> address 00000020
> <1> printing eip:
> <4>c01af187
> <1>*pde = 00000000
> <0>Oops: 0000 [#1]
> <0>PREEMPT
> <4>cpu=0 current  find:2667
> <4>current resource_set: 0
> <4> [<c0103fb1>] show_trace+0x21/0x30 (20)
> <4> [<c01040ee>] dump_stack+0x1e/0x30 (20)
> <4> [<c01044ca>] die+0xba/0x1b0 (68)
> <4> [<c01146ed>] do_page_fault+0x37d/0x6d0 (96)
> <4> [<c0103b0b>] error_code+0x4f/0x54 (120)
> <4> [<c0182a60>] vfs_readdir+0xa0/0xc0 (36)
> <4> [<c0182e85>] sys_getdents64+0x75/0xd0 (64)
> <4> [<c0102fd9>] syscall_call+0x7/0xb (-8116)
> <4>Modules linked in: ide_dump diskdump ipv6 eeprom adm1021 hwmon
> i2c_piix4 i2c_core NPCI pcnet32 e100 unix
> <0>CPU:    0
> <4>EIP:    0060:[<c01af187>]    Tainted: P      VLI
> <4>EFLAGS: 00010286   (2.6.16-rt29-rs_1.0 #1)
> <0>EIP is at sysfs_readdir+0xd7/0x240
> <0>eax: 00000000   ebx: cfd095a0   ecx: 00000005   edx: cf02be88
> <0>esi: cfd0959c   edi: ce150c16   ebp: c35b5f50   esp: c35b5f14
> <0>ds: 007b   es: 007b   ss: 0068   preempt: 00000001
> <0>Process find (pid: 2667, threadinfo=c35b4000 task=c3686730
> wchan=00000000) stack_left=7900 worst_left=-1)
> <0>Stack: <0>cfd0959c c3618e60 00000004 00000003 00000000 00000d74
> 00000004 cfe46a58
> <0>       00000005 ce150c10 cf02bb68 cfe46a4c ca844f20 fffffffe cfe47e40
> c35b5f74
> <0>       c0182a60 ca844f20 c35b5f98 c0182d20 cfe47ec8 00001000 ca844f20
> c0182d20
> <0>Call Trace:
> <4>cpu=0 current  find:2667
> <4>current resource_set: 0
> <0> [<c010406a>] show_stack_log_lvl+0xaa/0xe0 (32)
> <0> [<c01042ca>] show_registers+0x1ca/0x250 (64)
> <0> [<c0104508>] die+0xf8/0x1b0 (68)
> <0> [<c01146ed>] do_page_fault+0x37d/0x6d0 (96)
> <0> [<c0103b0b>] error_code+0x4f/0x54 (120)
> <0> [<c0182a60>] vfs_readdir+0xa0/0xc0 (36)
> <0> [<c0182e85>] sys_getdents64+0x75/0xd0 (64)
> <0> [<c0102fd9>] syscall_call+0x7/0xb (-8116)
> <0>Code: 8d 74 26 00 89 34 24 e8 68 e4 ff ff 89 45 e8 b9 ff ff ff ff 31
> c0 8b 7d e8 f2 ae f7 d1 49 89 4d e4 8b 46 20 85 c0 74 74 8b 40 20 <8b>
> 50 20
> 0f b7 46 1c 89 54 24 14 8b 4d 08 c1 e8 0c 89 44 24 18
> 
> I hope that helps,
> 

I believe I found the race.  Here's the problem:

There's no real protection in the sysfs_readdir regarding that for loop.
So the if statement 

				if (next->s_dentry)
					ino = next->s_dentry->d_inode->i_ino;

has the race.

We _can_ have a s_dentry without a d_inode! Reason is that in attaching an
attribute we have: in fs/sysfs/dir.c sysfs_attach_attr()

	sd->s_dentry = dentry;
	error = sysfs_create(dentry, (attr->mode & S_IALLUGO) | S_IFREG, init);

Where the dentry->d_inode can be NULL. I don't see any protection in 
this code to prevent this from happening.

Now the question is, is it safe to add the test for s_dentry->d_inode too.
I ask this because the s_dentry is in the process of being filled, and 
I don't know what effect this will have on what readdir wants.  I guess
it may be safe, so I'm giving this patch:

-- Steve


Description:

In the process of creating a sysfs attribute, we can have a state
where the sysfs descriptor can have a dentry with a NULL inode.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.18-rc1/fs/sysfs/dir.c
===================================================================
--- linux-2.6.18-rc1.orig/fs/sysfs/dir.c	2006-07-12 09:43:10.000000000 -0400
+++ linux-2.6.18-rc1/fs/sysfs/dir.c	2006-07-12 10:01:18.000000000 -0400
@@ -445,7 +445,7 @@ static int sysfs_readdir(struct file * f
 
 				name = sysfs_get_name(next);
 				len = strlen(name);
-				if (next->s_dentry)
+				if (next->s_dentry && next->s_dentry->d_inode)
 					ino = next->s_dentry->d_inode->i_ino;
 				else
 					ino = iunique(sysfs_sb, 2);


