Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbTGGITX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 04:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTGGITX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 04:19:23 -0400
Received: from dyn-ctb-210-9-243-115.webone.com.au ([210.9.243.115]:6418 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262984AbTGGITU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 04:19:20 -0400
Message-ID: <3F093044.3080004@cyberone.com.au>
Date: Mon, 07 Jul 2003 18:33:08 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: "James H. Cloos Jr." <cloos@jhcloos.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anticipatory scheduler merged
References: <20030705133334.4cc7e11b.akpm@osdl.org> <m3fzli4udq.fsf@lugabout.jhcloos.org>
In-Reply-To: <m3fzli4udq.fsf@lugabout.jhcloos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like you are hitting the same bug as reported in
"[OOPS] 2.5.74-bk4 in __lookup_hash". I think wli would like
to see your .config, lspci, dmesg, and what the box was doing
before crashing.

At this stage you probably haven't hit an AS bug.


James H. Cloos Jr. wrote:

>>>>>>"Andrew" == Andrew Morton <akpm@osdl.org> writes:
>>>>>>
>
>Andrew> - These changes have been well tested, but it is five months
>Andrew> work and over 100 patches.  There's probably a bug or two.  If
>Andrew> you suspect that something has gone wrong at the block layer
>Andrew> (lots of tasks stuck in D state) then please retest with
>Andrew> `elevator=deadline'.
>
>Looks like I got hit by such a bug.¹  It left a strip(1) in __down,
>and a subsequent rm(1) recursing to that file also is in __down.
>
>I’ll give a try after sleep w/ deadline....
>
>The dumps I still have² are:
>
>Unable to handle kernel NULL pointer dereference at virtual address 00000000
> printing eip:
>00000000
>*pde = 00000000
>Oops: 0000 [#2]
>CPU:    0
>EIP:    0060:[<00000000>]    Not tainted
>EFLAGS: 00010286
>EIP is at 0x0
>eax: c04b0d20   ebx: fffffff4   ecx: d87bcd3c   edx: d87bcd3c
>esi: ca6466c4   edi: d0f55e00   ebp: c9b51f70   esp: c9b51f08
>ds: 007b   es: 007b   ss: 0068
>Process strip (pid: 18461, threadinfo=c9b50000 task=c40a32a0)
>Stack: c01675f6 ca6466c4 d0f55e00 c9b51f70 ffffffd8 d87bcd20 00000242 c9b51f70 
>       c0167f24 c9b51f78 d87bcd20 c9b51f70 c9b50000 c9b51f78 00000001 00000002 
>       cad39d60 00000241 00000002 c520e000 c9b50000 c015734b c520e000 00000242 
>Call Trace:
> [<c01675f6>] __lookup_hash+0xc6/0xe0
> [<c0167f24>] open_namei+0x334/0x460
> [<c015734b>] filp_open+0x3b/0x70
> [<c015786b>] sys_open+0x5b/0xa0
> [<c010b379>] sysenter_past_esp+0x52/0x71
>
>Code:  Bad EIP value.
>
>ksymoops adds this bit:
>
>
>>>EIP; 00000000 Before first symbol
>>>
>
>>>eax; c04b0d20 <ext3_file_inode_operations+0/60>
>>>ebx; fffffff4 <TSS_ESP0_OFFSET+1f0/????>
>>>ecx; d87bcd3c <_end+181db9b8/3fa1cc7c>
>>>edx; d87bcd3c <_end+181db9b8/3fa1cc7c>
>>>esi; ca6466c4 <_end+a065340/3fa1cc7c>
>>>edi; d0f55e00 <_end+10974a7c/3fa1cc7c>
>>>ebp; c9b51f70 <_end+9570bec/3fa1cc7c>
>>>esp; c9b51f08 <_end+9570b84/3fa1cc7c>
>>>
>
>and the next oops is:
>
>Unable to handle kernel NULL pointer dereference at virtual address 00000000
> printing eip:
>c0142ef0
>*pde = 00000000
>Oops: 0000 [#3]
>CPU:    0
>EIP:    0060:[<c0142ef0>]    Not tainted
>EFLAGS: 00010006
>EIP is at kfree+0x30/0x70
>eax: 00140000   ebx: ce0afaa0   ecx: dd7127b0   edx: 00000000
>esi: 00000100   edi: 00000206   ebp: dd7127b0   esp: cad1bf48
>ds: 007b   es: 007b   ss: 0068
>Process lsof (pid: 18589, threadinfo=cad1a000 task=c40a26a0)
>Stack: 00000000 ce0afab8 ce0afaa0 c8df17a0 dd7127b0 c0178635 00000100 00000000 
>       c8df17a0 c0178610 dffd61e0 c015951a dd7127b0 c8df17a0 d1389d40 c8df17a0 
>       d3e403e0 00000000 cad1a000 c015792d c8df17a0 d3e403e0 d3e403e0 c8df17a0 
>Call Trace:
> [<c0178635>] seq_release_private+0x25/0x48
> [<c0178610>] seq_release_private+0x0/0x48
> [<c015951a>] __fput+0x12a/0x170
> [<c015792d>] filp_close+0x4d/0x90
> [<c01579cb>] sys_close+0x5b/0x90
> [<c010b379>] sysenter_past_esp+0x52/0x71
>
>Code: 8b 1a 8b 03 3b 43 04 73 18 89 74 83 10 ff 03 57 9d 8b 5c 24 
>
>ksymoops adds:
>
>
>>>EIP; c0142ef0 <kfree+30/70>   <=====
>>>
>
>>>ebx; ce0afaa0 <_end+dace71c/3fa1cc7c>
>>>ecx; dd7127b0 <_end+1d13142c/3fa1cc7c>
>>>ebp; dd7127b0 <_end+1d13142c/3fa1cc7c>
>>>esp; cad1bf48 <_end+a73abc4/3fa1cc7c>
>>>
>
>Trace; c0178635 <seq_release_private+25/48>
>Trace; c0178610 <seq_release_private+0/48>
>Trace; c015951a <__fput+12a/170>
>Trace; c015792d <filp_close+4d/90>
>Trace; c01579cb <sys_close+5b/90>
>Trace; c010b379 <sysenter_past_esp+52/71>
>
>Code;  c0142ef0 <kfree+30/70>
>00000000 <_EIP>:
>Code;  c0142ef0 <kfree+30/70>   <=====
>   0:   8b 1a                     mov    (%edx),%ebx   <=====
>Code;  c0142ef2 <kfree+32/70>
>   2:   8b 03                     mov    (%ebx),%eax
>Code;  c0142ef4 <kfree+34/70>
>   4:   3b 43 04                  cmp    0x4(%ebx),%eax
>Code;  c0142ef7 <kfree+37/70>
>   7:   73 18                     jae    21 <_EIP+0x21>
>Code;  c0142ef9 <kfree+39/70>
>   9:   89 74 83 10               mov    %esi,0x10(%ebx,%eax,4)
>Code;  c0142efd <kfree+3d/70>
>   d:   ff 03                     incl   (%ebx)
>Code;  c0142eff <kfree+3f/70>
>   f:   57                        push   %edi
>Code;  c0142f00 <kfree+40/70>
>  10:   9d                        popf   
>Code;  c0142f01 <kfree+41/70>
>  11:   8b 5c 24 00               mov    0x0(%esp,1),%ebx
>
>
>I presume there was another Oops: 0000, but it is lost².
>
>-JimC
>
>¹ And I didn’t even know I was running the new scheduler; the
>  bk-commits-head email lagged enough behind the push to
>  linux.bkbits.net that I received it after booting
>  the new kernel....  I guess that answers the
>  question of which comes first. ;-/
>
>² Turns out msyslogd(8)’s im_linux(8)’ is not too
>  happy w/ 2.5’s lack of /proc/ksyms.  [SIGH]
>
>
>  
>

