Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWGLT5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWGLT5E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 15:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWGLT5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 15:57:04 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:30399 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932130AbWGLT5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 15:57:02 -0400
Date: Thu, 13 Jul 2006 01:27:00 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Duetsch, Thomas  LDE1" <thomas.duetsch@siemens.com>,
       linux-kernel@vger.kernel.org, mingo@elte.hu,
       Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [SYSFS] Kernel Null pointer dereference in sysfs_readdir()
Message-ID: <20060712195700.GA1743@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <5B0042046ADE774687F32BF3652F5BB9021C92CA@kher9eaa.ww007.siemens.net> <1152713179.8309.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152713179.8309.35.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 10:06:19AM -0400, Steven Rostedt wrote:
> [ added Patrick since his name is on the sysfs documentation ]
> [ added Andrew since I am including a patch for 2.6.18 ]
> 
> On Wed, 2006-07-12 at 14:39 +0200, Duetsch, Thomas LDE1 wrote:
> > Steven Rostedt wrote:
> > > On Wed, 2006-07-12 at 13:35 +0200, Duetsch, Thomas LDE1 wrote:
> > >> Hi,
> > >> 
> > >> I'm currently working on a custom kernel based on Ingo's -rt patch
> > >> (2.6.16-rt29). 
> > >> 
> > >> While rebooting my machine, I came across a kernel null pointer
> > >> dereference in this code segment in fs/sysfs/dir.c, function
> > >> sysfs_readdir(): 
> > >> 
> > >> 		for (p=q->next; p!= &parent_sd->s_children; p=p->next) {
> > struct
> > >> 			sysfs_dirent *next; const char * name;
> > >> 			int len;
> > >> 
> > >> 			next = list_entry(p, struct sysfs_dirent,
> > >> 					   s_sibling);
> > >> 			if (!next->s_element)
> > >> 				continue;
> > >> 
> > >> 			name = sysfs_get_name(next);
> > >> 			len = strlen(name);
> > >> 			if (next->s_dentry)
> > >> PROBLEM ->			ino = next->s_dentry->d_inode->i_ino;
> > >> 			else
> > >> 				ino = iunique(sysfs_sb, 2);
> > >> 
> > > 
> > > Hi Thomas,
> > > 
> > > Do you have a backtrace to look at? It might be helpful to see what
> > > functions brought us to this point. Also it might help to determine if
> > > the problem is vanilla, -rt, or the custom kernel.
> > > 
> > > Thanks,
> > > 
> > > -- Steve
> > 
> > Of course, here you go:
> > 
> > <1>BUG: Unable to handle kernel NULL pointer dereference at virtual
> > address 00000020
> > <1> printing eip:
> > <4>c01af187
> > <1>*pde = 00000000
> > <0>Oops: 0000 [#1]
> > <0>PREEMPT
> > <4>cpu=0 current  find:2667
> > <4>current resource_set: 0
> > <4> [<c0103fb1>] show_trace+0x21/0x30 (20)
> > <4> [<c01040ee>] dump_stack+0x1e/0x30 (20)
> > <4> [<c01044ca>] die+0xba/0x1b0 (68)
> > <4> [<c01146ed>] do_page_fault+0x37d/0x6d0 (96)
> > <4> [<c0103b0b>] error_code+0x4f/0x54 (120)
> > <4> [<c0182a60>] vfs_readdir+0xa0/0xc0 (36)
> > <4> [<c0182e85>] sys_getdents64+0x75/0xd0 (64)
> > <4> [<c0102fd9>] syscall_call+0x7/0xb (-8116)
> > <4>Modules linked in: ide_dump diskdump ipv6 eeprom adm1021 hwmon
> > i2c_piix4 i2c_core NPCI pcnet32 e100 unix
> > <0>CPU:    0
> > <4>EIP:    0060:[<c01af187>]    Tainted: P      VLI
> > <4>EFLAGS: 00010286   (2.6.16-rt29-rs_1.0 #1)
> > <0>EIP is at sysfs_readdir+0xd7/0x240
> > <0>eax: 00000000   ebx: cfd095a0   ecx: 00000005   edx: cf02be88
> > <0>esi: cfd0959c   edi: ce150c16   ebp: c35b5f50   esp: c35b5f14
> > <0>ds: 007b   es: 007b   ss: 0068   preempt: 00000001
> > <0>Process find (pid: 2667, threadinfo=c35b4000 task=c3686730
> > wchan=00000000) stack_left=7900 worst_left=-1)
> > <0>Stack: <0>cfd0959c c3618e60 00000004 00000003 00000000 00000d74
> > 00000004 cfe46a58
> > <0>       00000005 ce150c10 cf02bb68 cfe46a4c ca844f20 fffffffe cfe47e40
> > c35b5f74
> > <0>       c0182a60 ca844f20 c35b5f98 c0182d20 cfe47ec8 00001000 ca844f20
> > c0182d20
> > <0>Call Trace:
> > <4>cpu=0 current  find:2667
> > <4>current resource_set: 0
> > <0> [<c010406a>] show_stack_log_lvl+0xaa/0xe0 (32)
> > <0> [<c01042ca>] show_registers+0x1ca/0x250 (64)
> > <0> [<c0104508>] die+0xf8/0x1b0 (68)
> > <0> [<c01146ed>] do_page_fault+0x37d/0x6d0 (96)
> > <0> [<c0103b0b>] error_code+0x4f/0x54 (120)
> > <0> [<c0182a60>] vfs_readdir+0xa0/0xc0 (36)
> > <0> [<c0182e85>] sys_getdents64+0x75/0xd0 (64)
> > <0> [<c0102fd9>] syscall_call+0x7/0xb (-8116)
> > <0>Code: 8d 74 26 00 89 34 24 e8 68 e4 ff ff 89 45 e8 b9 ff ff ff ff 31
> > c0 8b 7d e8 f2 ae f7 d1 49 89 4d e4 8b 46 20 85 c0 74 74 8b 40 20 <8b>
> > 50 20
> > 0f b7 46 1c 89 54 24 14 8b 4d 08 c1 e8 0c 89 44 24 18
> > 
> > I hope that helps,
> > 
> 
> I believe I found the race.  Here's the problem:
> 
> There's no real protection in the sysfs_readdir regarding that for loop.
> So the if statement 
> 
> 				if (next->s_dentry)
> 					ino = next->s_dentry->d_inode->i_ino;
> 
> has the race.
> 
> We _can_ have a s_dentry without a d_inode! Reason is that in attaching an
> attribute we have: in fs/sysfs/dir.c sysfs_attach_attr()
> 
> 	sd->s_dentry = dentry;
> 	error = sysfs_create(dentry, (attr->mode & S_IALLUGO) | S_IFREG, init);
> 
> Where the dentry->d_inode can be NULL. I don't see any protection in 
> this code to prevent this from happening.
> 

sysfs_attach_attr() is called from sysfs_lookup() only, and which in turn
is called under parent inode's i_mutex from VFS layer.

But you did help in spotting a bug which could happen like this

i_mutext held
sysfs_lookup()
-->sysfs_attach_attr()
   --> sysfs_create() fails
   --> sd->s_dentry has a NULL d_inode
   --> sysfs_put() frees the sysfs_dirent 
   --> error returned to lookup
i_mutex released

But the sysfs_dirent with NULL d_inode is never unlinked from 
the parent sysfs_dirent. And later on this happens

vfs_readdir()
i_mutex held
-->sysfs_readdir()
   --> trips on the freed sysfs_dirent with NULL inode.

I am not sure if it is possible for other thread to see the freed 
sysfs_dirent and trip at sd->s_dentry->d_inode but the sysfs_dirent
should have been unlinked from the parent sysfs_dirent's s_children list.

> Now the question is, is it safe to add the test for s_dentry->d_inode too.
> I ask this because the s_dentry is in the process of being filled, and 
> I don't know what effect this will have on what readdir wants.  I guess
> it may be safe, so I'm giving this patch:
> 
> -- Steve
> 
> 
> Description:
> 
> In the process of creating a sysfs attribute, we can have a state
> where the sysfs descriptor can have a dentry with a NULL inode.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Index: linux-2.6.18-rc1/fs/sysfs/dir.c
> ===================================================================
> --- linux-2.6.18-rc1.orig/fs/sysfs/dir.c	2006-07-12 09:43:10.000000000 -0400
> +++ linux-2.6.18-rc1/fs/sysfs/dir.c	2006-07-12 10:01:18.000000000 -0400
> @@ -445,7 +445,7 @@ static int sysfs_readdir(struct file * f
>  
>  				name = sysfs_get_name(next);
>  				len = strlen(name);
> -				if (next->s_dentry)
> +				if (next->s_dentry && next->s_dentry->d_inode)
>  					ino = next->s_dentry->d_inode->i_ino;
>  				else
>  					ino = iunique(sysfs_sb, 2);
> 

I think this patch only fixes the sympton. I have tried to keep the
assumption of no negative dentries (dentries with NULL d_inode) valid 
in sysfs. So, this does indicate a bug. 

Could you please try the following patch instead



o Unlink the half baked sysfs_dirent if sysfs_create() fails.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
---

 linux-2.6.18-rc1-git5-maneesh/fs/sysfs/dir.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN fs/sysfs/dir.c~fix-sysfs_create-errors fs/sysfs/dir.c
--- linux-2.6.18-rc1-git5/fs/sysfs/dir.c~fix-sysfs_create-errors	2006-07-13 01:21:25.000000000 +0530
+++ linux-2.6.18-rc1-git5-maneesh/fs/sysfs/dir.c	2006-07-13 01:21:25.000000000 +0530
@@ -212,6 +212,7 @@ static int sysfs_attach_attr(struct sysf
 	sd->s_dentry = dentry;
 	error = sysfs_create(dentry, (attr->mode & S_IALLUGO) | S_IFREG, init);
 	if (error) {
+ 		list_del_init(&sd->s_sibling);
 		sysfs_put(sd);
 		return error;
 	}
@@ -236,8 +237,10 @@ static int sysfs_attach_link(struct sysf
 	if (!err) {
 		dentry->d_op = &sysfs_dentry_ops;
 		d_rehash(dentry);
-	} else
+	} else {
+ 		list_del_init(&sd->s_sibling);
 		sysfs_put(sd);
+	}
 
 	return err;
 }
_

