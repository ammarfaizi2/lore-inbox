Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263483AbUCTReW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 12:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263484AbUCTReW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 12:34:22 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:30854 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263483AbUCTRd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 12:33:59 -0500
Date: Sat, 20 Mar 2004 09:33:38 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <2698500000.1079804017@[10.10.2.4]>
In-Reply-To: <20040320165500.GW9009@dualathlon.random>
References: <Pine.LNX.4.44.0403190642450.17899-100000@localhost.localdomain> <2663710000.1079716282@[10.10.2.4]> <20040320123009.GC9009@dualathlon.random> <2696050000.1079798196@[10.10.2.4]> <20040320161905.GT9009@dualathlon.random> <2696880000.1079800826@[10.10.2.4]> <20040320165500.GW9009@dualathlon.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Unable to handle kernel NULL pointer dereference at virtual address 00000003
>>  printing eip:
>> c013f504
>> *pde = 2e820001
>> *pte = 00000000
>> Oops: 0000 [#1]
>> SMP 
>> CPU:    15
>> EIP:    0060:[<c013f504>]    Not tainted
>> EFLAGS: 00010292   (2.6.5-rc1-aa2) 
>> EIP is at do_no_page+0xc4/0x45c
>> eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
>> esi: ee5eea60   edi: ee5a3ec8   ebp: ee9c52a0   esp: ee5a3e94
>> ds: 007b   es: 007b   ss: 0068
>> Process sshd (pid: 19069, threadinfo=ee5a2000 task=ee69a870)
>> Stack: 00000000 eeb43340 00000001 ee9c52a0 c3ba2820 00000000 40268000 ee5a3ec8 
>>        ee9c52a0 ee69a870 ee5eea60 00000000 ef6a6134 00000001 c013fa0f ee9c52a0 
>>        ee5eea60 40268000 00000001 eeb43340 eeea8008 ee9c52a0 ee69a870 ee5eea60 
>> Call Trace:
>>  [<c013fa0f>] handle_mm_fault+0xc7/0x190
>>  [<c0114fc3>] do_page_fault+0x13b/0x540
>>  [<c0114e88>] do_page_fault+0x0/0x540
>>  [<c0140feb>] do_mmap_pgoff+0x4b7/0x5fc
>>  [<c010d24b>] sys_mmap2+0x67/0x98
>>  [<c01075f9>] error_code+0x2d/0x38
>> 
>> Code: 0f b6 41 03 8b 14 85 80 a9 35 c0 89 c8 2b 82 84 0b 00 00 69 
> 
> this looks strange:
> 
> Code;  c013f504 <filp_open+24/70>
> 00000000 <_EIP>:
> Code;  c013f504 <filp_open+24/70>   <=====
>    0:   0f b6 41 03               movzbl 0x3(%ecx),%eax   <=====
> Code;  c013f508 <filp_open+28/70>
>    4:   8b 14 85 80 a9 35 c0      mov    0xc035a980(,%eax,4),%edx
> Code;  c013f50f <filp_open+2f/70>
>    b:   89 c8                     mov    %ecx,%eax
> Code;  c013f511 <filp_open+31/70>
>    d:   2b 82 84 0b 00 00         sub    0xb84(%edx),%eax
> Code;  c013f517 <filp_open+37/70>
>   13:   69 00 00 00 00 00         imul   $0x0,(%eax),%eax
> 
> %ecx is zero, not sure what can actually look at a 3 byte offset in
> do_no_page (infact it looks like it was miscompiled), can you send me
> your vmlinux privately (or just the the whole assembler for do_no_page)?

I dumped stuff here:
ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/andrea
but it may take a few minutes to replicate. I'm using gcc 2.95.4, if you're
doing funny gcc 3.x only stuff, that might explain it ;-) I'll try a 3.3
build in a bit to confirm.

 Dump of assembler code for function do_no_page:
0xc013f440 <do_no_page+0>:      sub    $0x28,%esp
0xc013f443 <do_no_page+3>:      push   %ebp
0xc013f444 <do_no_page+4>:      push   %edi
0xc013f445 <do_no_page+5>:      push   %esi
0xc013f446 <do_no_page+6>:      push   %ebx
0xc013f447 <do_no_page+7>:      mov    0x4c(%esp,1),%edi
0xc013f44b <do_no_page+11>:     mov    0x40(%esp,1),%edx
0xc013f44f <do_no_page+15>:     movl   $0x0,0x30(%esp,1)
0xc013f457 <do_no_page+23>:     movl   $0x0,0x2c(%esp,1)
0xc013f45f <do_no_page+31>:     movl   $0x1,0x34(%esp,1)
0xc013f467 <do_no_page+39>:     mov    0x3c(%edx),%eax
0xc013f46a <do_no_page+42>:     test   %eax,%eax
0xc013f46c <do_no_page+44>:     je     0xc013f474 <do_no_page+52>
0xc013f46e <do_no_page+46>:     cmpl   $0x0,0x8(%eax)
0xc013f472 <do_no_page+50>:     jne    0xc013f4a0 <do_no_page+96>
0xc013f474 <do_no_page+52>:     mov    0x44(%esp,1),%ecx
0xc013f478 <do_no_page+56>:     push   %ecx
0xc013f479 <do_no_page+57>:     mov    0x4c(%esp,1),%esi
0xc013f47d <do_no_page+61>:     push   %esi
0xc013f47e <do_no_page+62>:     mov    0x58(%esp,1),%eax
0xc013f482 <do_no_page+66>:     push   %eax
0xc013f483 <do_no_page+67>:     push   %edi
0xc013f484 <do_no_page+68>:     mov    0x50(%esp,1),%edx
0xc013f488 <do_no_page+72>:     push   %edx
0xc013f489 <do_no_page+73>:     mov    0x50(%esp,1),%ecx
0xc013f48d <do_no_page+77>:     push   %ecx
0xc013f48e <do_no_page+78>:     call   0xc013f1d4 <do_anonymous_page>
0xc013f493 <do_no_page+83>:     add    $0x18,%esp
0xc013f496 <do_no_page+86>:     jmp    0xc013f892 <do_no_page+1106>
0xc013f49b <do_no_page+91>:     nop    
0xc013f49c <do_no_page+92>:     lea    0x0(%esi,1),%esi
0xc013f4a0 <do_no_page+96>:     mov    0x3c(%esp,1),%esi
0xc013f4a4 <do_no_page+100>:    movb   $0x1,0x30(%esi)
0xc013f4a8 <do_no_page+104>:    mov    0x40(%esp,1),%edi
0xc013f4ac <do_no_page+108>:    mov    0x44(%edi),%eax
0xc013f4af <do_no_page+111>:    test   %eax,%eax
0xc013f4b1 <do_no_page+113>:    je     0xc013f4c4 <do_no_page+132>
0xc013f4b3 <do_no_page+115>:    mov    0x90(%eax),%eax
0xc013f4b9 <do_no_page+121>:    mov    %eax,0x30(%esp,1)
0xc013f4bd <do_no_page+125>:    mov    0x60(%eax),%eax
0xc013f4c0 <do_no_page+128>:    mov    %eax,0x2c(%esp,1)
0xc013f4c4 <do_no_page+132>:    lock addl $0x0,0x0(%esp,1)
0xc013f4ca <do_no_page+138>:    mov    0x44(%esp,1),%ecx
0xc013f4ce <do_no_page+142>:    lea    0x34(%esp,1),%edx
0xc013f4d2 <do_no_page+146>:    mov    %edx,0x1c(%esp,1)
0xc013f4d6 <do_no_page+150>:    mov    %ecx,0x18(%esp,1)
0xc013f4da <do_no_page+154>:    andl   $0xfffff000,0x18(%esp,1)
0xc013f4e2 <do_no_page+162>:    mov    0x40(%esp,1),%esi
0xc013f4e6 <do_no_page+166>:    mov    0x1c(%esp,1),%edi
0xc013f4ea <do_no_page+170>:    mov    0x3c(%esi),%eax
0xc013f4ed <do_no_page+173>:    push   %edi
0xc013f4ee <do_no_page+174>:    mov    0x1c(%esp,1),%edx
0xc013f4f2 <do_no_page+178>:    push   %edx
0xc013f4f3 <do_no_page+179>:    push   %esi
0xc013f4f4 <do_no_page+180>:    mov    0x8(%eax),%eax
0xc013f4f7 <do_no_page+183>:    call   *%eax
0xc013f4f9 <do_no_page+185>:    mov    %eax,0x20(%esp,1)
0xc013f4fd <do_no_page+189>:    add    $0xc,%esp
0xc013f500 <do_no_page+192>:    mov    0x14(%esp,1),%ecx
0xc013f504 <do_no_page+196>:    movzbl 0x3(%ecx),%eax
0xc013f508 <do_no_page+200>:    mov    0xc035a980(,%eax,4),%edx
0xc013f50f <do_no_page+207>:    mov    %ecx,%eax
0xc013f511 <do_no_page+209>:    sub    0xb84(%edx),%eax
0xc013f517 <do_no_page+215>:    imul   $0xcccccccd,%eax,%eax
0xc013f51d <do_no_page+221>:    sar    $0x3,%eax
0xc013f520 <do_no_page+224>:    add    0xb88(%edx),%eax
0xc013f526 <do_no_page+230>:    cmp    0xc035e360,%eax
0xc013f52c <do_no_page+236>:    jb     0xc013f536 <do_no_page+246>
0xc013f52e <do_no_page+238>:    ud2a   
0xc013f530 <do_no_page+240>:    test   %al,0xc0268680
0xc013f536 <do_no_page+246>:    mov    0x14(%esp,1),%esi
0xc013f53a <do_no_page+250>:    mov    (%esi),%eax
0xc013f53c <do_no_page+252>:    test   $0x200000,%eax
0xc013f541 <do_no_page+257>:    je     0xc013f550 <do_no_page+272>
0xc013f543 <do_no_page+259>:    ud2a   
0xc013f545 <do_no_page+261>:    xchg   %eax,0xc0268680
0xc013f54b <do_no_page+267>:    nop    
0xc013f54c <do_no_page+268>:    lea    0x0(%esi,1),%esi
0xc013f550 <do_no_page+272>:    mov    0x14(%esp,1),%edi
0xc013f554 <do_no_page+276>:    mov    (%edi),%eax
0xc013f556 <do_no_page+278>:    test   $0x100000,%eax
0xc013f55b <do_no_page+283>:    je     0xc013f565 <do_no_page+293>
0xc013f55d <do_no_page+285>:    ud2a   
0xc013f55f <do_no_page+287>:    mov    %eax,0xc0268680
0xc013f565 <do_no_page+293>:    mov    0x40(%esp,1),%edx
0xc013f569 <do_no_page+297>:    mov    0x14(%edx),%eax
0xc013f56c <do_no_page+300>:    mov    %eax,0x28(%esp,1)
0xc013f570 <do_no_page+304>:    andl   $0x80000,0x28(%esp,1)
0xc013f578 <do_no_page+312>:    mov    %eax,%edx
0xc013f57a <do_no_page+314>:    jne    0xc013f598 <do_no_page+344>
0xc013f57c <do_no_page+316>:    mov    0x14(%esp,1),%ecx
0xc013f580 <do_no_page+320>:    cmpl   $0x0,0x1c(%ecx)
0xc013f584 <do_no_page+324>:    je     0xc013f590 <do_no_page+336>
0xc013f586 <do_no_page+326>:    mov    (%ecx),%eax
0xc013f588 <do_no_page+328>:    test   $0x8,%ah
0xc013f58b <do_no_page+331>:    je     0xc013f598 <do_no_page+344>
0xc013f58d <do_no_page+333>:    lea    0x0(%esi),%esi
0xc013f590 <do_no_page+336>:    ud2a   
0xc013f592 <do_no_page+338>:    xchg   %eax,%ebx
0xc013f593 <do_no_page+339>:    add    $0xc0268680,%eax
0xc013f598 <do_no_page+344>:    cmpl   $0x0,0x14(%esp,1)
0xc013f59d <do_no_page+349>:    jne    0xc013f5a6 <do_no_page+358>
0xc013f59f <do_no_page+351>:    xor    %eax,%eax
0xc013f5a1 <do_no_page+353>:    jmp    0xc013f892 <do_no_page+1106>
0xc013f5a6 <do_no_page+358>:    cmpl   $0xffffffff,0x14(%esp,1)
0xc013f5ab <do_no_page+363>:    jne    0xc013f5b6 <do_no_page+374>
0xc013f5ad <do_no_page+365>:    mov    0x14(%esp,1),%eax
0xc013f5b1 <do_no_page+369>:    jmp    0xc013f892 <do_no_page+1106>
0xc013f5b6 <do_no_page+374>:    xor    %ebp,%ebp
0xc013f5b8 <do_no_page+376>:    cmpl   $0x0,0x48(%esp,1)
0xc013f5bd <do_no_page+381>:    je     0xc013f698 <do_no_page+600>
0xc013f5c3 <do_no_page+387>:    test   $0x8,%dl
0xc013f5c6 <do_no_page+390>:    jne    0xc013f698 <do_no_page+600>
0xc013f5cc <do_no_page+396>:    mov    0x40(%esp,1),%eax
0xc013f5d0 <do_no_page+400>:    call   0xc0143a84 <anon_vma_prepare>
0xc013f5d5 <do_no_page+405>:    test   %eax,%eax
0xc013f5d7 <do_no_page+407>:    jne    0xc013f856 <do_no_page+1046>
0xc013f5dd <do_no_page+413>:    mov    $0xffffe000,%eax
0xc013f5e2 <do_no_page+418>:    and    %esp,%eax
0xc013f5e4 <do_no_page+420>:    mov    0x10(%eax),%eax
0xc013f5e7 <do_no_page+423>:    shl    $0x2,%eax
0xc013f5ea <do_no_page+426>:    mov    0xc02b2cc0(%eax),%eax
0xc013f5f0 <do_no_page+432>:    shl    $0x2,%eax
0xc013f5f3 <do_no_page+435>:    mov    0xc0347760(%eax),%ecx
0xc013f5f9 <do_no_page+441>:    add    $0x2588,%ecx
0xc013f5ff <do_no_page+447>:    xor    %edx,%edx
0xc013f601 <do_no_page+449>:    mov    $0xd2,%eax
0xc013f606 <do_no_page+454>:    call   0xc0134eb0 <__alloc_pages>
0xc013f60b <do_no_page+459>:    mov    %eax,%ebp
0xc013f60d <do_no_page+461>:    test   %ebp,%ebp
0xc013f60f <do_no_page+463>:    je     0xc013f856 <do_no_page+1046>
0xc013f615 <do_no_page+469>:    push   $0x3
0xc013f617 <do_no_page+471>:    mov    0x18(%esp,1),%esi
0xc013f61b <do_no_page+475>:    push   %esi
0xc013f61c <do_no_page+476>:    call   0xc0116028 <kmap_atomic>
0xc013f621 <do_no_page+481>:    mov    %eax,%ebx
0xc013f623 <do_no_page+483>:    push   $0x4
0xc013f625 <do_no_page+485>:    push   %ebp
0xc013f626 <do_no_page+486>:    call   0xc0116028 <kmap_atomic>
0xc013f62b <do_no_page+491>:    mov    %eax,0x20(%esp,1)
0xc013f62f <do_no_page+495>:    add    $0x10,%esp
0xc013f632 <do_no_page+498>:    mov    0x10(%esp,1),%edi
0xc013f636 <do_no_page+502>:    mov    $0x400,%ecx
0xc013f63b <do_no_page+507>:    mov    %ebx,%esi
0xc013f63d <do_no_page+509>:    repz movsl %ds:(%esi),%es:(%edi)
0xc013f63f <do_no_page+511>:    push   $0x3
0xc013f641 <do_no_page+513>:    push   %ebx
0xc013f642 <do_no_page+514>:    call   0xc01160b4 <kunmap_atomic>
0xc013f647 <do_no_page+519>:    push   $0x4
0xc013f649 <do_no_page+521>:    mov    0x1c(%esp,1),%eax
0xc013f64d <do_no_page+525>:    push   %eax
0xc013f64e <do_no_page+526>:    call   0xc01160b4 <kunmap_atomic>
0xc013f653 <do_no_page+531>:    add    $0x10,%esp
0xc013f656 <do_no_page+534>:    mov    0x14(%esp,1),%edx
0xc013f65a <do_no_page+538>:    mov    (%edx),%eax
0xc013f65c <do_no_page+540>:    test   $0x8,%ah
0xc013f65f <do_no_page+543>:    jne    0xc013f688 <do_no_page+584>
0xc013f661 <do_no_page+545>:    mov    0x4(%edx),%eax
0xc013f664 <do_no_page+548>:    test   %eax,%eax
0xc013f666 <do_no_page+550>:    jne    0xc013f670 <do_no_page+560>
0xc013f668 <do_no_page+552>:    ud2a   
0xc013f66a <do_no_page+554>:    inc    %ecx
0xc013f66b <do_no_page+555>:    add    %esp,0x8bc02686
0xc013f671 <do_no_page+561>:    dec    %esp
0xc013f672 <do_no_page+562>:    and    $0x14,%al
0xc013f674 <do_no_page+564>:    lock decl 0x4(%ecx)
0xc013f678 <do_no_page+568>:    sete   %al
0xc013f67b <do_no_page+571>:    test   %al,%al
0xc013f67d <do_no_page+573>:    je     0xc013f688 <do_no_page+584>
0xc013f67f <do_no_page+575>:    mov    0x14(%esp,1),%eax
0xc013f683 <do_no_page+579>:    call   0xc01399a0 <__page_cache_release>
0xc013f688 <do_no_page+584>:    mov    %ebp,%eax
0xc013f68a <do_no_page+586>:    call   0xc0139914 <lru_cache_add_active>
0xc013f68f <do_no_page+591>:    mov    %ebp,0x14(%esp,1)
0xc013f693 <do_no_page+595>:    mov    $0x1,%ebp
0xc013f698 <do_no_page+600>:    mov    0x3c(%esp,1),%esi
0xc013f69c <do_no_page+604>:    lock decb 0x30(%esi)
0xc013f6a0 <do_no_page+608>:    js     0xc013fd44 <.text.lock.memory+215>
0xc013f6a6 <do_no_page+614>:    cmpl   $0x0,0x30(%esp,1)
0xc013f6ab <do_no_page+619>:    je     0xc013f704 <do_no_page+708>
0xc013f6ad <do_no_page+621>:    mov    0x30(%esp,1),%edi
0xc013f6b1 <do_no_page+625>:    mov    0x60(%edi),%eax
0xc013f6b4 <do_no_page+628>:    cmp    %eax,0x2c(%esp,1)
0xc013f6b8 <do_no_page+632>:    je     0xc013f704 <do_no_page+708>
0xc013f6ba <do_no_page+634>:    mov    0x60(%edi),%eax
0xc013f6bd <do_no_page+637>:    mov    %eax,0x2c(%esp,1)
0xc013f6c1 <do_no_page+641>:    movb   $0x1,0x30(%esi)
0xc013f6c5 <do_no_page+645>:    mov    0x14(%esp,1),%edx
0xc013f6c9 <do_no_page+649>:    mov    (%edx),%eax
0xc013f6cb <do_no_page+651>:    test   $0x8,%ah
0xc013f6ce <do_no_page+654>:    jne    0xc013f4e2 <do_no_page+162>
0xc013f6d4 <do_no_page+660>:    mov    0x4(%edx),%eax
0xc013f6d7 <do_no_page+663>:    test   %eax,%eax
0xc013f6d9 <do_no_page+665>:    jne    0xc013f6e3 <do_no_page+675>
0xc013f6db <do_no_page+667>:    ud2a   
0xc013f6dd <do_no_page+669>:    inc    %ecx
0xc013f6de <do_no_page+670>:    add    %esp,0x8bc02686
0xc013f6e4 <do_no_page+676>:    dec    %esp
0xc013f6e5 <do_no_page+677>:    and    $0x14,%al
0xc013f6e7 <do_no_page+679>:    lock decl 0x4(%ecx)
0xc013f6eb <do_no_page+683>:    sete   %al
0xc013f6ee <do_no_page+686>:    test   %al,%al
0xc013f6f0 <do_no_page+688>:    je     0xc013f4e2 <do_no_page+162>
0xc013f6f6 <do_no_page+694>:    mov    0x14(%esp,1),%eax
0xc013f6fa <do_no_page+698>:    call   0xc01399a0 <__page_cache_release>
0xc013f6ff <do_no_page+703>:    jmp    0xc013f4e2 <do_no_page+162>
0xc013f704 <do_no_page+708>:    mov    0x50(%esp,1),%esi
0xc013f708 <do_no_page+712>:    mov    (%esi),%eax
0xc013f70a <do_no_page+714>:    mov    0x4(%esi),%edx
0xc013f70d <do_no_page+717>:    shrd   $0xc,%edx,%eax
0xc013f711 <do_no_page+721>:    shr    $0xc,%edx
0xc013f714 <do_no_page+724>:    mov    %eax,%edx
0xc013f716 <do_no_page+726>:    shr    $0x10,%eax
0xc013f719 <do_no_page+729>:    movzbl 0xc02b3400(%eax),%eax
0xc013f720 <do_no_page+736>:    mov    0xc0347760(,%eax,4),%eax
0xc013f727 <do_no_page+743>:    sub    0x2658(%eax),%edx
0xc013f72d <do_no_page+749>:    mov    0x2650(%eax),%eax
0xc013f733 <do_no_page+755>:    lea    (%edx,%edx,4),%edx
0xc013f736 <do_no_page+758>:    lea    (%eax,%edx,8),%edx
0xc013f739 <do_no_page+761>:    push   %edx
0xc013f73a <do_no_page+762>:    call   0xc013cb8c <page_address>
0xc013f73f <do_no_page+767>:    mov    0x48(%esp,1),%ecx
0xc013f743 <do_no_page+771>:    shr    $0x9,%ecx
0xc013f746 <do_no_page+774>:    and    $0xff8,%ecx
0xc013f74c <do_no_page+780>:    lea    (%ecx,%eax,1),%edi
0xc013f74f <do_no_page+783>:    mov    (%edi),%eax
0xc013f751 <do_no_page+785>:    mov    0x4(%edi),%edx
0xc013f754 <do_no_page+788>:    add    $0x4,%esp
0xc013f757 <do_no_page+791>:    xor    %ecx,%ecx
0xc013f759 <do_no_page+793>:    test   %eax,%eax
0xc013f75b <do_no_page+795>:    jne    0xc013f767 <do_no_page+807>
0xc013f75d <do_no_page+797>:    mov    $0x1,%eax
0xc013f762 <do_no_page+802>:    test   %edx,%edx
0xc013f764 <do_no_page+804>:    cmove  %eax,%ecx
0xc013f767 <do_no_page+807>:    test   %ecx,%ecx
0xc013f769 <do_no_page+809>:    je     0xc013f806 <do_no_page+966>
0xc013f76f <do_no_page+815>:    mov    0x14(%esp,1),%edx
0xc013f773 <do_no_page+819>:    mov    (%edx),%eax
0xc013f775 <do_no_page+821>:    test   $0x8,%ah
0xc013f778 <do_no_page+824>:    jne    0xc013f781 <do_no_page+833>
0xc013f77a <do_no_page+826>:    mov    0x3c(%esp,1),%ecx
0xc013f77e <do_no_page+830>:    incl   0x68(%ecx)
0xc013f781 <do_no_page+833>:    mov    0x14(%esp,1),%esi
0xc013f785 <do_no_page+837>:    movzbl 0x3(%esi),%eax
0xc013f789 <do_no_page+841>:    mov    0xc035a980(,%eax,4),%edx
0xc013f790 <do_no_page+848>:    mov    0x40(%esp,1),%ecx
0xc013f794 <do_no_page+852>:    mov    %esi,%eax
0xc013f796 <do_no_page+854>:    sub    0xb84(%edx),%eax
0xc013f79c <do_no_page+860>:    imul   $0xcccccccd,%eax,%eax
0xc013f7a2 <do_no_page+866>:    sar    $0x3,%eax
0xc013f7a5 <do_no_page+869>:    add    0xb88(%edx),%eax
0xc013f7ab <do_no_page+875>:    mov    %eax,%edx
0xc013f7ad <do_no_page+877>:    shr    $0x14,%edx
0xc013f7b0 <do_no_page+880>:    mov    %edx,0x24(%esp,1)
0xc013f7b4 <do_no_page+884>:    shl    $0xc,%eax
0xc013f7b7 <do_no_page+887>:    or     0x10(%ecx),%eax
0xc013f7ba <do_no_page+890>:    mov    %eax,0x20(%esp,1)
0xc013f7be <do_no_page+894>:    mov    0x20(%esp,1),%ecx
0xc013f7c2 <do_no_page+898>:    mov    0x24(%esp,1),%ebx
0xc013f7c6 <do_no_page+902>:    cmpl   $0x0,0x48(%esp,1)
0xc013f7cb <do_no_page+907>:    je     0xc013f7e3 <do_no_page+931>
0xc013f7cd <do_no_page+909>:    mov    0x40(%esp,1),%esi
0xc013f7d1 <do_no_page+913>:    mov    %ebx,%edx
0xc013f7d3 <do_no_page+915>:    mov    %ecx,%eax
0xc013f7d5 <do_no_page+917>:    or     $0x40,%al
0xc013f7d7 <do_no_page+919>:    mov    %eax,%ecx
0xc013f7d9 <do_no_page+921>:    testb  $0x2,0x14(%esi)
0xc013f7dd <do_no_page+925>:    je     0xc013f7e3 <do_no_page+931>
0xc013f7df <do_no_page+927>:    or     $0x2,%al
0xc013f7e1 <do_no_page+929>:    mov    %eax,%ecx
0xc013f7e3 <do_no_page+931>:    mov    %ebx,0x4(%edi)
0xc013f7e6 <do_no_page+934>:    mov    %ecx,(%edi)
0xc013f7e8 <do_no_page+936>:    cmpl   $0x0,0x28(%esp,1)
0xc013f7ed <do_no_page+941>:    jne    0xc013f842 <do_no_page+1026>
0xc013f7ef <do_no_page+943>:    push   %ebp
0xc013f7f0 <do_no_page+944>:    mov    0x48(%esp,1),%ecx
0xc013f7f4 <do_no_page+948>:    mov    0x44(%esp,1),%edx
0xc013f7f8 <do_no_page+952>:    mov    0x18(%esp,1),%eax
0xc013f7fc <do_no_page+956>:    call   0xc0143398 <page_add_rmap>
0xc013f801 <do_no_page+961>:    add    $0x4,%esp
0xc013f804 <do_no_page+964>:    jmp    0xc013f842 <do_no_page+1026>
0xc013f806 <do_no_page+966>:    mov    0x14(%esp,1),%edi
0xc013f80a <do_no_page+970>:    mov    (%edi),%eax
0xc013f80c <do_no_page+972>:    test   $0x8,%ah
0xc013f80f <do_no_page+975>:    jne    0xc013f838 <do_no_page+1016>
0xc013f811 <do_no_page+977>:    mov    0x4(%edi),%eax
0xc013f814 <do_no_page+980>:    test   %eax,%eax
0xc013f816 <do_no_page+982>:    jne    0xc013f820 <do_no_page+992>
0xc013f818 <do_no_page+984>:    ud2a   
0xc013f81a <do_no_page+986>:    inc    %ecx
0xc013f81b <do_no_page+987>:    add    %esp,0x8bc02686
0xc013f821 <do_no_page+993>:    push   %esp
0xc013f822 <do_no_page+994>:    and    $0x14,%al
0xc013f824 <do_no_page+996>:    lock decl 0x4(%edx)
0xc013f828 <do_no_page+1000>:   sete   %al
0xc013f82b <do_no_page+1003>:   test   %al,%al
0xc013f82d <do_no_page+1005>:   je     0xc013f838 <do_no_page+1016>
0xc013f82f <do_no_page+1007>:   mov    0x14(%esp,1),%eax
0xc013f833 <do_no_page+1011>:   call   0xc01399a0 <__page_cache_release>
0xc013f838 <do_no_page+1016>:   mov    0x3c(%esp,1),%ecx
0xc013f83c <do_no_page+1020>:   movb   $0x1,0x30(%ecx)
0xc013f840 <do_no_page+1024>:   jmp    0xc013f850 <do_no_page+1040>
0xc013f842 <do_no_page+1026>:   mov    0x3c(%esp,1),%esi
0xc013f846 <do_no_page+1030>:   movb   $0x1,0x30(%esi)
0xc013f84a <do_no_page+1034>:   lea    0x0(%esi),%esi
0xc013f850 <do_no_page+1040>:   mov    0x34(%esp,1),%eax
0xc013f854 <do_no_page+1044>:   jmp    0xc013f892 <do_no_page+1106>
0xc013f856 <do_no_page+1046>:   mov    0x14(%esp,1),%edi
0xc013f85a <do_no_page+1050>:   mov    (%edi),%eax
0xc013f85c <do_no_page+1052>:   test   $0x8,%ah
0xc013f85f <do_no_page+1055>:   jne    0xc013f888 <do_no_page+1096>
0xc013f861 <do_no_page+1057>:   mov    0x4(%edi),%eax
0xc013f864 <do_no_page+1060>:   test   %eax,%eax
0xc013f866 <do_no_page+1062>:   jne    0xc013f870 <do_no_page+1072>
0xc013f868 <do_no_page+1064>:   ud2a   
0xc013f86a <do_no_page+1066>:   inc    %ecx
0xc013f86b <do_no_page+1067>:   add    %esp,0x8bc02686
0xc013f871 <do_no_page+1073>:   push   %esp
0xc013f872 <do_no_page+1074>:   and    $0x14,%al
0xc013f874 <do_no_page+1076>:   lock decl 0x4(%edx)
0xc013f878 <do_no_page+1080>:   sete   %al
0xc013f87b <do_no_page+1083>:   test   %al,%al
0xc013f87d <do_no_page+1085>:   je     0xc013f888 <do_no_page+1096>
0xc013f87f <do_no_page+1087>:   mov    0x14(%esp,1),%eax
0xc013f883 <do_no_page+1091>:   call   0xc01399a0 <__page_cache_release>
0xc013f888 <do_no_page+1096>:   movl   $0xffffffff,0x34(%esp,1)
0xc013f890 <do_no_page+1104>:   jmp    0xc013f850 <do_no_page+1040>
0xc013f892 <do_no_page+1106>:   pop    %ebx
0xc013f893 <do_no_page+1107>:   pop    %esi
0xc013f894 <do_no_page+1108>:   pop    %edi
0xc013f895 <do_no_page+1109>:   pop    %ebp
0xc013f896 <do_no_page+1110>:   add    $0x28,%esp
0xc013f899 <do_no_page+1113>:   ret    
0xc013f89a <do_no_page+1114>:   mov    %esi,%esi
End of assembler dump.

