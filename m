Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUC2JiJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 04:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbUC2JiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 04:38:08 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:44425 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S261161AbUC2JiD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 04:38:03 -0500
Message-ID: <4067EE71.4000205@cosmosbay.com>
Date: Mon, 29 Mar 2004 11:37:53 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] small change to fget()
References: <1080541934.1210.5.camel@gaston>	<20040328230351.1a0d0e9c.akpm@osdl.org> <p7365co848r.fsf@nielsen.suse.de>
In-Reply-To: <p7365co848r.fsf@nielsen.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

This one liner patch permits to save 2 instructions in the fget() 
function, at least on x86_64 SMP (only one ref to current->files)

diff -Nru linux-2.6.2/fs/file_table.c linux-2.6.2-custom/fs/file_table.c
--- linux-2.6.2/fs/file_table.c     2004-02-04 17:59:43.000000000 +0100
+++ linux-2.6.2-custom/fs/file_table.c        2004-03-29 
11:26:42.170555000 +0200
@@ -198,7 +198,7 @@
        struct files_struct *files = current->files;

        spin_lock(&files->file_lock);
-       file = fcheck(fd);
+       file = fcheck_files(files,fd) ;
        if (file)
                get_file(file);
        spin_unlock(&files->file_lock);


The assembly code was (oprofile data included) :

ffffffff8016c3d0 <fget>: /* fget total: 921168  0.1624 */
 51191  0.0090 :ffffffff8016c3d0:       mov    %gs:0x0,%rax
 76621  0.0135 :ffffffff8016c3d9:       mov    0x7e8(%rax),%rsi
121592  0.0214 :ffffffff8016c3e0:       lock decb 0x4(%rsi)
 11278  0.0020 :ffffffff8016c3e4:       js     ffffffff8016c5e8 
<.text.lock.file_table+0x20>
122737  0.0216 :ffffffff8016c3ea:       mov    %gs:0x0,%rax
174870  0.0308 :ffffffff8016c3f3:       mov    0x7e8(%rax),%rcx
  2274 4.0e-04 :ffffffff8016c3fa:       xor    %eax,%eax
 77418  0.0137 :ffffffff8016c3fc:       cmp    0x8(%rcx),%edi
  3417 6.0e-04 :ffffffff8016c3ff:       jae    ffffffff8016c40b <fget+0x3b>
  8184  0.0014 :ffffffff8016c401:       mov    0x18(%rcx),%rax
 37585  0.0066 :ffffffff8016c405:       mov    %edi,%edx
  7357  0.0013 :ffffffff8016c407:       mov    (%rax,%rdx,8),%rax
  5817  0.0010 :ffffffff8016c40b:       test   %rax,%rax
 57910  0.0102 :ffffffff8016c40e:       je     ffffffff8016c414 <fget+0x44>
  3401 6.0e-04 :ffffffff8016c410:       lock incl 0x28(%rax)
  7729  0.0014 :ffffffff8016c414:       movb   $0x1,0x4(%rsi)
151787  0.0268 :ffffffff8016c418:       retq



And it is now :

 380:   65 48 8b 04 25 00 00    mov    %gs:0x0,%rax
 387:   00 00
 389:   48 8b 88 e8 07 00 00    mov    0x7e8(%rax),%rcx
 390:   f0 fe 49 04             lock decb 0x4(%rcx)
 394:   0f 88 ee 01 00 00       js     588 <.text.lock.file_table+0x20>
 39a:   31 c0                   xor    %eax,%eax
 39c:   3b 79 08                cmp    0x8(%rcx),%edi
 39f:   73 0a                   jae    3ab <fget+0x2b>
 3a1:   48 8b 41 18             mov    0x18(%rcx),%rax
 3a5:   89 fa                   mov    %edi,%edx
 3a7:   48 8b 04 d0             mov    (%rax,%rdx,8),%rax
 3ab:   48 85 c0                test   %rax,%rax
 3ae:   74 04                   je     3b4 <fget+0x34>
 3b0:   f0 ff 40 28             lock incl 0x28(%rax)
 3b4:   c6 41 04 01             movb   $0x1,0x4(%rcx)
 3b8:   c3                      retq


Thanks

