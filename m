Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbUK0NLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbUK0NLf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 08:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUK0NLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 08:11:35 -0500
Received: from mail.linicks.net ([217.204.244.146]:19972 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261201AbUK0NL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 08:11:28 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: kswapd0 oops -> debug information
Date: Sat, 27 Nov 2004 13:11:25 +0000
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411271311.25997.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I keep getting this oops so randomly, that 'RIGHT, YOU BUGGER' I have 
attempted to supply proper debug info - where I have got is what I learnt 
today, so I am a bit stuck after finding the area of code.

ksymoops provides:

>>EIP; c0151239 <__iget+29/4c>   <=====
Code;  c015120e <init_once+1a/1c>
00000000 <_EIP>:
Code;  c015120e <init_once+1a/1c>
   0:   76 00                     jbe    2 <_EIP+0x2> c0151210 <__iget+0/4c>
Code;  c0151210 <__iget+0/4c>
   2:   53                        push   %ebx
Code;  c0151211 <__iget+1/4c>
   3:   8b 5c 24 08               mov    0x8(%esp,1),%ebx
Code;  c0151215 <__iget+5/4c>
   7:   8b 43 1c                  mov    0x1c(%ebx),%eax
Code;  c0151218 <__iget+8/4c>
   a:   85 c0                     test   %eax,%eax
Code;  c015121a <__iget+a/4c>
   c:   74 05                     je     13 <_EIP+0x13> c0151221 
<__iget+11/4c>
Code;  c015121c <__iget+c/4c>
   e:   ff 43 1c                  incl   0x1c(%ebx)
Code;  c015121f <__iget+f/4c>
  11:   eb 38                     jmp    4b <_EIP+0x4b> c0151259 
<__iget+49/4c>
Code;  c0151221 <__iget+11/4c>

  13:   ff 43 1c                  incl   0x1c(%ebx)
Code;  c0151224 <__iget+14/4c>
  16:   f6 83 1c 01 00 00 0f      testb  $0xf,0x11c(%ebx)
Code;  c015122b <__iget+1b/4c>
  1d:   75 26                     jne    45 <_EIP+0x45> c0151253 
<__iget+43/4c>
Code;  c015122d <__iget+1d/4c>
  1f:   8d 53 08                  lea    0x8(%ebx),%edx
Code;  c0151230 <__iget+20/4c>
  22:   8b 4a 04                  mov    0x4(%edx),%ecx
Code;  c0151233 <__iget+23/4c>
  25:   8b 43 08                  mov    0x8(%ebx),%eax
Code;  c0151236 <__iget+26/4c>
  28:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c0151239 <__iget+29/4c>   <=====
  2b:   89 01                     mov    %eax,(%ecx)   <=====
Code;  c015123b <__iget+2b/4c>
  2d:   a1 6c 9c 30 c0            mov    0xc0309c6c,%eax
Code;  c0151240 <__iget+30/4c>
  32:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c0151243 <__iget+33/4c>
  35:   89 43 08                  mov    %eax,0x8(%ebx)
Code;  c0151246 <__iget+36/4c>
  38:   c7 42 04 6c 9c 30 c0      movl   $0xc0309c6c,0x4(%edx)
Code;  c015124d <__iget+3d/4c>
  3f:   89                        .byte 0x89



I have traced this code to fs/inode.c.  Producing assembler of inode.c gives 
this (snipped):

__iget:
        pushl %ebx
        movl 8(%esp),%ebx
        movl 28(%ebx),%eax
        testl %eax,%eax
        je .L3337
#APP
        incl 28(%ebx)
#NO_APP
        jmp .L3336
        .p2align 4,,7
.L3337:
#APP
        incl 28(%ebx)
#NO_APP
        testb $15,284(%ebx)
        jne .L3340
        leal 8(%ebx),%edx
        movl 4(%edx),%ecx
        movl 8(%ebx),%eax
        movl %ecx,4(%eax)
        movl %eax,(%ecx)   <===== >>EIP; c0151239 <__iget+29/4c>
        movl inode_in_use,%eax
        movl %edx,4(%eax)
        movl %eax,8(%ebx)
        movl $inode_in_use,4(%edx)
        movl %edx,inode_in_use
.L3340:


Which quiet nicely matches the ksymoops output.  My books tell me the inode.s 
file _should_ give me line numbers in inode.c so I can then locate area of 
code - but I can't see how to match the produced assembler to the C source.

Hope this helps someone - and if you know who to get assembler code to match C 
code via line numbers, I would like to know please.

TIA,

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
