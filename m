Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265073AbTGHRo7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 13:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265074AbTGHRo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 13:44:58 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:60681 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S265073AbTGHRoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 13:44:55 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.5.74 - BUG in kfree during sys_close from netstat
Date: Tue, 8 Jul 2003 21:59:50 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307082155.49404.arvidjaar@mail.ru>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mandrake 9.1, kernel 2.5.74. Started kmail, started kppp, connected, attempted 
to send or receive - nothing happened. Run netstat -an - and got

------------[ cut here ]------------
kernel BUG at mm/slab.c:1537!
invalid operand: 0000 [#2]
CPU:    0
EIP:    0060:[<c014c530>]    Tainted: P
EFLAGS: 00010002
EIP is at kfree+0x2e0/0x2f0
eax: 0000002c   ebx: 00040000   ecx: cf1fe670   edx: 00000001
esi: c02b9ee0   edi: 00000100   ebp: c6443f34   esp: c6443f14
ds: 007b   es: 007b   ss: 0068
Process netstat (pid: 10138, threadinfo=c6442000 task=c2e2ad40)
Stack: c6443f28 c02752fe cdcc0908 00000001 00000206 cdcc0908 c34438d4 c245537c
       c6443f4c c01881b8 00000100 c34438d4 c34438d4 cffdf8e4 c6443f70 c0165089
       c245537c c34438d4 c245537c c996fa98 c34438d4 c69ee724 00000000 c6443f98
Call Trace:
 [<c02752fe>] raw_seq_start+0x4e/0x60
 [<c01881b8>] seq_release_private+0x18/0x32
 [<c0165089>] __fput+0x129/0x130
 [<c0163703>] filp_close+0xc3/0x110
 [<c01637e2>] sys_close+0x92/0x120
 [<c010b527>] syscall_call+0x7/0xb

Code: 0f 0b 01 06 d1 93 2b c0 e9 44 fd ff ff 8d 76 00 55 89 e5 57

this happened more than once; previous stack (I do not know actually what 
triggered it - I did not run netstat for sure) looked like:

PPP BSD Compression module registered
PPP Deflate Compression module registered
kfree_debugcheck: out of range ptr 100h.
------------[ cut here ]------------
kernel BUG at mm/slab.c:1537!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c014c530>]    Tainted: P
EFLAGS: 00010002
EIP is at kfree+0x2e0/0x2f0
eax: 0000002c   ebx: 00040000   ecx: cf1fe670   edx: 00000001
esi: c02b9ee0   edi: 00000100   ebp: c7789f34   esp: c7789f14
ds: 007b   es: 007b   ss: 0068
Process netstat (pid: 8509, threadinfo=c7788000 task=c2c4d2f0)
Stack: c7789f28 c02752fe c32d1dc8 00000001 00000206 c32d1dc8 c462c414 c245537c
       c7789f4c c01881b8 00000100 c462c414 c462c414 cffdf8e4 c7789f70 c0165089
       c245537c c462c414 c245537c c996fa98 c462c414 c2c3b8d4 00000000 c7789f98
Call Trace:
 [<c02752fe>] raw_seq_start+0x4e/0x60
 [<c01881b8>] seq_release_private+0x18/0x32
 [<c0165089>] __fput+0x129/0x130
 [<c0163703>] filp_close+0xc3/0x110
 [<c01637e2>] sys_close+0x92/0x120
 [<c010b527>] syscall_call+0x7/0xb

Code: 0f 0b 01 06 d1 93 2b c0 e9 44 fd ff ff 8d 76 00 55 89 e5 57
 <3>kfree_debugcheck: out of range ptr 100h.

Just tried and when connection is done while kmail is not started it works. I 
am not sure what kmail does - except that it actually is the only application 
to actively use IP here most of the time.

-andrey
