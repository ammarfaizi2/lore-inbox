Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161253AbVKRV5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161253AbVKRV5t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161256AbVKRV5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:57:49 -0500
Received: from web34113.mail.mud.yahoo.com ([66.163.178.111]:55730 "HELO
	web34113.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161253AbVKRV5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:57:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=xVwsqjKzW53qtdL8vTiyUwde/hdNnU1cOIYnd8GH1Tt7hrZ1HqEAuLeCnZVf43yNxcqVe9qW+kcpvTijF2oQiB9UfL53BL8ZQJ04h9il3U4gc3+ySdFIvcwoBu6T+UzU3NIdLsDOR7cyIsiHm4dYGbGl3z7g6JL/Wfr0tqETCdM=  ;
Message-ID: <20051118215747.19203.qmail@web34113.mail.mud.yahoo.com>
Date: Fri, 18 Nov 2005 13:57:47 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: mmap over nfs leads to excessive system load
To: Andrew Morton <akpm@osdl.org>
Cc: trond.myklebust@fys.uio.no, cel@citi.umich.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051117130403.4155c94c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@osdl.org> wrote:
> Could you send the test app please?  (Apologies if you've already done so
> and I missed it).

Here is an strace from a reduced test:
open("/mnt/bar", O_RDWR|O_CREAT|O_DIRECT|O_LARGEFILE, 0644) = 3
pwrite(3, "\0", 1, 4292870144)          = 1
mmap2(NULL, 2097152, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0xffc00) = 0xb7ace000
pwrite(3, "\0", 1, 4294967296)          = 1
munmap(0xb7ace000, 2097152)             = 0
mmap2(0xb7ace000, 2097152, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_FIXED, 3, 0xffe00) = 0xb7ace000
pwrite(3, "\0", 1, 4297064448)          = 1
munmap(0xb7ace000, 2097152)             = 0
mmap2(0xb7ace000, 2097152, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_FIXED, 3, 0x100000) = 0xb7ace000
pwrite(3, "\0", 1, 4299161600)          = 1
munmap(0xb7ace000, 2097152)             = 0
mmap2(0xb7ace000, 2097152, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_FIXED, 3, 0x100200) = 0xb7ace000
pwrite(3, "\0", 1, 4301258752


The final pwrite never returns.
This is with 2.6.15-rc1 + Trond's NFS patch (-mm2 would die on strace).

The only change from the previous test is that this one uses munmap/mmap64 instead of
remap_file_pages.

showPc shows:

SysRq : Show Regs

Pid: 4271, comm:            writetest
EIP: 0060:[<c029cd2b>] CPU: 0
EIP is at prio_tree_first+0x26/0xb8
 EFLAGS: 00000292    Tainted: P       (2.6.15-rc1)
EAX: 00000000 EBX: f6765d94 ECX: f6765d94 EDX: 00000200
ESI: 00000000 EDI: f5da475c EBP: f6765db4 DS: 007b ES: 007b
CR0: 8005003b CR2: b7590000 CR3: 36b5d000 CR4: 000006d0
 [<c029ce5e>] prio_tree_next+0xa1/0xa3
 [<c014822a>] vma_prio_tree_next+0x27/0x51
 [<c014b1dc>] unmap_mapping_range+0x18b/0x210
 [<c0120d06>] __do_softirq+0x6a/0xd1
 [<c0103a24>] apic_timer_interrupt+0x1c/0x24
 [<c0146577>] invalidate_inode_pages2_range+0x215/0x24c
 [<c01465cd>] invalidate_inode_pages2+0x1f/0x26
 [<c01e4031>] nfs_file_direct_write+0x1e1/0x21a
 [<c0159ea4>] do_sync_write+0xc7/0x10d
 [<c012ff32>] autoremove_wake_function+0x0/0x57
 [<c0159f92>] vfs_write+0xa8/0x177
 [<c015a275>] sys_pwrite64+0x88/0x8c
 [<c0102f51>] syscall_call+0x7/0xb


-Kenny



		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
