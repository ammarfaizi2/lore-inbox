Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbTESR2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 13:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbTESR2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 13:28:03 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:25477 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262571AbTESR1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 13:27:53 -0400
Subject: Re: CIFS oops in 2.5.69-mm5
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Steven French <sfrench@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF9814E442.D895C05F-ON87256D2B.00571760@us.ibm.com>
References: <OF9814E442.D895C05F-ON87256D2B.00571760@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053366047.17388.48.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 May 2003 19:40:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-19 at 18:10, Steven French wrote:
> 
> 
> Looks like this oops occurred right next to a list_for_each in which I
> demultiplex the received network response from the server and try to match
> it against one of the pending requests in the list.  No obvious reason was
> this should oops and access to the list is spinlock protected.   The
> location reminds me of the problems with prefetch that Jon Grimm and Andi
> were mentioning.

This is an UP x86 machine without preempt so it isn't a locking-problem.

> Although one of the three newer cifs changesets at
> bk://cifs.bkbits.net/linux-2.5cifs (changeset 1.1115) adds missing spinlock
> protection for modifications to the one list that was missing spinlocks
> (the cifs open file list) and changes a list_for_each to list_for_each_safe
> in one case where releasing the spinlock temporarily was necessary, which
> does fix a different oops, none of the three pending cifs vfs changesets
> are likely to affect this problem.   This one looks unrelated and plausibly
> similar to the other two reports of general prefetch problems mentioned in
> earlier posts.

I think you are right, I ran the oops through ksymoops here's the
result:

ksymoops 2.4.8 on i686 2.5.69-mm5.  Options used
     -v /usr/src/2.5/linux-2.5.69-mm5/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.5.69-mm5 (specified)

Unable to handle kernel paging request at virtual address 4fb899ce
eeac8eed
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<eeac8eed>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: eaf21664   ebx: dbe42450   ecx: eaf21600   edx: 00000000
esi: 0000005b   edi: 0000005b   ebp: c1efffec   esp: c1efffa8
ds: 007b   es: 007b   ss: 0068
Stack: eeac8bc4 00000000 00000000 c1efffd0 dfdb5104 c0000000 e4860044 0000005b 
       e486009f 00000000 00000000 00000000 c1efffc8 00000001 00000000 00000000 
       ffffffff 00000000 c0107111 eaf21600 00000000 00000000 
Call Trace:
 [<eeac8bc4>] cifs_demultiplex_thread+0x0/0x4c8 [cifs]
 [<c0107111>] kernel_thread_helper+0x5/0xc
Code: 74 1c 83 3d 84 89 ae ee 00 0f 84 da 00 00 00 68 e0 87 ad ee e9 93 00 00 00 90 8d 74 26 00 31 d2 8b 4d 08 8b 59 64 8b 03 0f 18 00 <00> 89 ce 83 c6 64 39 f3 74 44 8b 4d d4 0f b7 41 22 66 39 43 08 


>>EIP; eeac8eed <_end+2e6f31ad/3fc282c0>   <=====

>>eax; eaf21664 <_end+2ab4b924/3fc282c0>
>>ebx; dbe42450 <_end+1ba6c710/3fc282c0>
>>ecx; eaf21600 <_end+2ab4b8c0/3fc282c0>
>>ebp; c1efffec <_end+1b2a2ac/3fc282c0>
>>esp; c1efffa8 <_end+1b2a268/3fc282c0>

Trace; eeac8bc4 <_end+2e6f2e84/3fc282c0>
Trace; c0107111 <kernel_thread_helper+5/c>

Code;  eeac8ec2 <_end+2e6f3182/3fc282c0>
00000000 <_EIP>:
Code;  eeac8ec2 <_end+2e6f3182/3fc282c0>
   0:   74 1c                     je     1e <_EIP+0x1e>
Code;  eeac8ec4 <_end+2e6f3184/3fc282c0>
   2:   83 3d 84 89 ae ee 00      cmpl   $0x0,0xeeae8984
Code;  eeac8ecb <_end+2e6f318b/3fc282c0>
   9:   0f 84 da 00 00 00         je     e9 <_EIP+0xe9>
Code;  eeac8ed1 <_end+2e6f3191/3fc282c0>
   f:   68 e0 87 ad ee            push   $0xeead87e0
Code;  eeac8ed6 <_end+2e6f3196/3fc282c0>
  14:   e9 93 00 00 00            jmp    ac <_EIP+0xac>
Code;  eeac8edb <_end+2e6f319b/3fc282c0>
  19:   90                        nop    
Code;  eeac8edc <_end+2e6f319c/3fc282c0>
  1a:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  eeac8ee0 <_end+2e6f31a0/3fc282c0>
  1e:   31 d2                     xor    %edx,%edx
Code;  eeac8ee2 <_end+2e6f31a2/3fc282c0>
  20:   8b 4d 08                  mov    0x8(%ebp),%ecx
Code;  eeac8ee5 <_end+2e6f31a5/3fc282c0>
  23:   8b 59 64                  mov    0x64(%ecx),%ebx
Code;  eeac8ee8 <_end+2e6f31a8/3fc282c0>
  26:   8b 03                     mov    (%ebx),%eax
Code;  eeac8eea <_end+2e6f31aa/3fc282c0>
  28:   0f 18 00                  prefetchnta (%eax)
Code;  eeac8eed <_end+2e6f31ad/3fc282c0>   <=====
  2b:   00 89 ce 83 c6 64         add    %cl,0x64c683ce(%ecx)   <=====
Code;  eeac8ef3 <_end+2e6f31b3/3fc282c0>
  31:   39 f3                     cmp    %esi,%ebx
Code;  eeac8ef5 <_end+2e6f31b5/3fc282c0>
  33:   74 44                     je     79 <_EIP+0x79>
Code;  eeac8ef7 <_end+2e6f31b7/3fc282c0>
  35:   8b 4d d4                  mov    0xffffffd4(%ebp),%ecx
Code;  eeac8efa <_end+2e6f31ba/3fc282c0>
  38:   0f b7 41 22               movzwl 0x22(%ecx),%eax
Code;  eeac8efe <_end+2e6f31be/3fc282c0>
  3c:   66 39 43 08               cmp    %ax,0x8(%ebx)


-- 
/Martin
