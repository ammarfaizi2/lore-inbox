Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbUJYUxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbUJYUxG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbUJYUwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:52:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:23519 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262010AbUJYUuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:50:17 -0400
Date: Mon, 25 Oct 2004 13:50:16 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] move key_init to security_initcall
Message-ID: <20041025135016.M2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During system boot many probes, etc. will generate upcalls to userspace
via call_usermodehelper().  This has the effect of calling execve()
before the key subsystem has been initialized, and thus Oopsing on a
NULL key_jar during key_alloc().  Move key_init to security_initcall so
that it's called along with other securty initialization routines which
have similar requirements.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== security/keys/key.c 1.1 vs edited =====
--- 1.1/security/keys/key.c	2004-10-19 02:40:15 -07:00
+++ edited/security/keys/key.c	2004-10-25 13:28:37 -07:00
@@ -1036,4 +1036,4 @@
 
 } /* end key_init() */
 
-subsys_initcall(key_init);
+security_initcall(key_init);



--
Example Oops:

Unable to handle kernel NULL pointer dereference at 0000000000000094 RIP:
<ffffffff80163760>{kmem_flagcheck+32}
PML4 7febe067 PGD 7fec1067 PMD 0
Oops: 0000 [5] PREEMPT SMP
CPU 0
Modules linked in:
Pid: 13, comm: hotplug Tainted: G   M  2.6.10-rc1
RIP: 0010:[<ffffffff80163760>] <ffffffff80163760>{kmem_flagcheck+32}
RSP: 0000:0000010037e79bc0  EFLAGS: 00010246
RAX: 000001007ff45e10 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000000d0 R08: 0000000000000000 R09: 000001007ff45e10
R10: 00000000ffffffff R11: 0000000000000000 R12: 000001007ff45e10
R13: ffffffff805caae0 R14: 0000000000000008 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffffffff807199c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000094 CR3: 0000000000101000 CR4: 00000000000006e0
Process hotplug (pid: 13, threadinfo 0000010037e78000, task 000001007feb1130)
Stack: ffffffff80163ec0 000001003fff9e50 0000010037e79c58 ffffffffffffffea
       ffffffff80272d7f 0000000000000010 001f00003ffedab8 0000000000000000
       000001003ffedab8 0000000000000000
Call Trace:<ffffffff80163ec0>{kmem_cache_alloc+16} <ffffffff80272d7f>{key_alloc+223}
       <ffffffff80273fc5>{keyring_alloc+37} <ffffffff802759a0>{install_process_keyring+80}
       <ffffffff8017ddae>{filp_close+126} <ffffffff801899d7>{compute_creds+55}
       <ffffffff801abf37>{load_elf_binary+3175} <ffffffff80188666>{copy_strings+486}
       <ffffffff801ab2d0>{load_elf_binary+0} <ffffffff80189c24>{search_binary_handler+276}
       <ffffffff80189ff4>{do_execve+420} <ffffffff80148e90>{__call_usermodehelper+0}
       <ffffffff8010f084>{sys_execve+68} <ffffffff801112f5>{execve+101}
       <ffffffff80148e90>{__call_usermodehelper+0} <ffffffff80148df6>{____call_usermodehelper+182}
       <ffffffff80111287>{child_rip+8} <ffffffff80148e90>{__call_usermodehelper+0}
       <ffffffff80148d40>{____call_usermodehelper+0} <ffffffff8011127f>{child_rip+0}
