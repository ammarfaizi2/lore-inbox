Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWGLMjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWGLMjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 08:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWGLMjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 08:39:51 -0400
Received: from thelpusa.erlm.siemens.de ([217.194.34.71]:43733 "EHLO
	thelpusa.erlm.siemens.de") by vger.kernel.org with ESMTP
	id S1751292AbWGLMju convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 08:39:50 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: AW: [SYSFS] Kernel Null pointer dereference in sysfs_readdir()
Date: Wed, 12 Jul 2006 14:39:45 +0200
Message-ID: <5B0042046ADE774687F32BF3652F5BB9021C92CA@kher9eaa.ww007.siemens.net>
In-Reply-To: <1152706005.8309.14.camel@localhost.localdomain>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [SYSFS] Kernel Null pointer dereference in sysfs_readdir()
Thread-Index: Acalq7K7E8R4TMAcRfSTx6wC7SKrLAAACNig
From: "Duetsch, Thomas  LDE1" <thomas.duetsch@siemens.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: <linux-kernel@vger.kernel.org>, <maneesh@in.ibm.com>, <mingo@elte.hu>
X-OriginalArrivalTime: 12 Jul 2006 12:39:45.0933 (UTC) FILETIME=[418E9BD0:01C6A5B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Wed, 2006-07-12 at 13:35 +0200, Duetsch, Thomas LDE1 wrote:
>> Hi,
>> 
>> I'm currently working on a custom kernel based on Ingo's -rt patch
>> (2.6.16-rt29). 
>> 
>> While rebooting my machine, I came across a kernel null pointer
>> dereference in this code segment in fs/sysfs/dir.c, function
>> sysfs_readdir(): 
>> 
>> 		for (p=q->next; p!= &parent_sd->s_children; p=p->next) {
struct
>> 			sysfs_dirent *next; const char * name;
>> 			int len;
>> 
>> 			next = list_entry(p, struct sysfs_dirent,
>> 					   s_sibling);
>> 			if (!next->s_element)
>> 				continue;
>> 
>> 			name = sysfs_get_name(next);
>> 			len = strlen(name);
>> 			if (next->s_dentry)
>> PROBLEM ->			ino = next->s_dentry->d_inode->i_ino;
>> 			else
>> 				ino = iunique(sysfs_sb, 2);
>> 
> 
> Hi Thomas,
> 
> Do you have a backtrace to look at? It might be helpful to see what
> functions brought us to this point. Also it might help to determine if
> the problem is vanilla, -rt, or the custom kernel.
> 
> Thanks,
> 
> -- Steve

Of course, here you go:

<1>BUG: Unable to handle kernel NULL pointer dereference at virtual
address 00000020
<1> printing eip:
<4>c01af187
<1>*pde = 00000000
<0>Oops: 0000 [#1]
<0>PREEMPT
<4>cpu=0 current  find:2667
<4>current resource_set: 0
<4> [<c0103fb1>] show_trace+0x21/0x30 (20)
<4> [<c01040ee>] dump_stack+0x1e/0x30 (20)
<4> [<c01044ca>] die+0xba/0x1b0 (68)
<4> [<c01146ed>] do_page_fault+0x37d/0x6d0 (96)
<4> [<c0103b0b>] error_code+0x4f/0x54 (120)
<4> [<c0182a60>] vfs_readdir+0xa0/0xc0 (36)
<4> [<c0182e85>] sys_getdents64+0x75/0xd0 (64)
<4> [<c0102fd9>] syscall_call+0x7/0xb (-8116)
<4>Modules linked in: ide_dump diskdump ipv6 eeprom adm1021 hwmon
i2c_piix4 i2c_core NPCI pcnet32 e100 unix
<0>CPU:    0
<4>EIP:    0060:[<c01af187>]    Tainted: P      VLI
<4>EFLAGS: 00010286   (2.6.16-rt29-rs_1.0 #1)
<0>EIP is at sysfs_readdir+0xd7/0x240
<0>eax: 00000000   ebx: cfd095a0   ecx: 00000005   edx: cf02be88
<0>esi: cfd0959c   edi: ce150c16   ebp: c35b5f50   esp: c35b5f14
<0>ds: 007b   es: 007b   ss: 0068   preempt: 00000001
<0>Process find (pid: 2667, threadinfo=c35b4000 task=c3686730
wchan=00000000) stack_left=7900 worst_left=-1)
<0>Stack: <0>cfd0959c c3618e60 00000004 00000003 00000000 00000d74
00000004 cfe46a58
<0>       00000005 ce150c10 cf02bb68 cfe46a4c ca844f20 fffffffe cfe47e40
c35b5f74
<0>       c0182a60 ca844f20 c35b5f98 c0182d20 cfe47ec8 00001000 ca844f20
c0182d20
<0>Call Trace:
<4>cpu=0 current  find:2667
<4>current resource_set: 0
<0> [<c010406a>] show_stack_log_lvl+0xaa/0xe0 (32)
<0> [<c01042ca>] show_registers+0x1ca/0x250 (64)
<0> [<c0104508>] die+0xf8/0x1b0 (68)
<0> [<c01146ed>] do_page_fault+0x37d/0x6d0 (96)
<0> [<c0103b0b>] error_code+0x4f/0x54 (120)
<0> [<c0182a60>] vfs_readdir+0xa0/0xc0 (36)
<0> [<c0182e85>] sys_getdents64+0x75/0xd0 (64)
<0> [<c0102fd9>] syscall_call+0x7/0xb (-8116)
<0>Code: 8d 74 26 00 89 34 24 e8 68 e4 ff ff 89 45 e8 b9 ff ff ff ff 31
c0 8b 7d e8 f2 ae f7 d1 49 89 4d e4 8b 46 20 85 c0 74 74 8b 40 20 <8b>
50 20
0f b7 46 1c 89 54 24 14 8b 4d 08 c1 e8 0c 89 44 24 18

I hope that helps,

Thomas
