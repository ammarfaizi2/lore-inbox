Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSHAOYB>; Thu, 1 Aug 2002 10:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSHAOYA>; Thu, 1 Aug 2002 10:24:00 -0400
Received: from jalon.able.es ([212.97.163.2]:18064 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S313773AbSHAOYA>;
	Thu, 1 Aug 2002 10:24:00 -0400
Date: Thu, 1 Aug 2002 16:26:23 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc4aa1
Message-ID: <20020801142623.GA4606@junk.cps.unizar.es>
References: <20020801055124.GB1132@dualathlon.random> <20020801141703.GT1132@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020801141703.GT1132@dualathlon.random>; from andrea@suse.de on jue, ago 01, 2002 at 16:17:03 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020801 Andrea Arcangeli wrote:
> On Thu, Aug 01, 2002 at 07:51:24AM +0200, Andrea Arcangeli wrote:
> > This may be the last update for a week (unless there's a quick bug to
> > fix before next morning :). I wanted to ship async-io and largepage
> 
> I would like to thank Randy Hron for reproducing this problem so
> quickly with the ltp testsuite:
> 
> >>EIP; 80132cc2 <shmem_writepage+22/130>   <=====
> 

Can be related to this (which I get on every shm related op, like a pipe in
bzip2 -cd | patch -p1 ):

kernel BUG at page_alloc.c:98!
invalid operand: 0000 2.4.19-rc5-jam0 #1 SMP Thu Aug 1 12:28:09 CEST 2002
CPU:    0
EIP:    0010:[__free_pages_ok+87/752]    Tainted: P 
EIP:    0010:[<8013d227>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210286
eax: 00000000   ebx: 81128b10   ecx: 81128b10   edx: 00000000
esi: 8631fe74   edi: 00000000   ebp: 00000000   esp: 874e1f08
ds: 0018   es: 0018   ss: 0018
Process bonobo-moniker- (pid: 2103, stackpage=874e1000)
Stack: 00000000 8631fee4 8631fee8 00000115 00000000 00000000 8631fdc0 00000115 
       00000115 00000000 8631fdc0 80141c8b 874e1f3c 81128b10 2b331000 00000000 
       00000000 00001000 80141d6b 86fcb660 86fcb680 874e1f60 00000115 00000eeb 
Call Trace:    [do_shmem_file_read+299/432] [shmem_file_read+91/128] [sys_read+150/272] [system_call+51/56]
Call Trace:    [<80141c8b>] [<80141d6b>] [<801454b6>] [<80108e4b>]
Code: 0f 0b 62 00 7d 55 27 80 8b 0d 10 50 32 80 89 d8 29 c8 69 c0 


>>EIP; 8013d227 <__free_pages_ok+57/2f0>   <=====

>>ebx; 81128b10 <_end+ddd614/22c4b04>
>>ecx; 81128b10 <_end+ddd614/22c4b04>

Trace; 80141c8b <do_shmem_file_read+12b/1b0>
Trace; 80141d6b <shmem_file_read+5b/80>
Trace; 801454b6 <sys_read+96/110>
Trace; 80108e4b <system_call+33/38>

Code;  8013d227 <__free_pages_ok+57/2f0>
00000000 <_EIP>:
Code;  8013d227 <__free_pages_ok+57/2f0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  8013d229 <__free_pages_ok+59/2f0>
   2:   62 00                     bound  %eax,(%eax)
Code;  8013d22b <__free_pages_ok+5b/2f0>
   4:   7d 55                     jge    5b <_EIP+0x5b> 8013d282 <__free_pages_ok+b2/2f0>
Code;  8013d22d <__free_pages_ok+5d/2f0>
   6:   27                        daa    
Code;  8013d22e <__free_pages_ok+5e/2f0>
   7:   80 8b 0d 10 50 32 80      orb    $0x80,0x3250100d(%ebx)
Code;  8013d235 <__free_pages_ok+65/2f0>
   e:   89 d8                     mov    %ebx,%eax
Code;  8013d237 <__free_pages_ok+67/2f0>
  10:   29 c8                     sub    %ecx,%eax
Code;  8013d239 <__free_pages_ok+69/2f0>
  12:   69 c0 00 00 00 00         imul   $0x0,%eax,%eax

-- 
J.A. Magallon                           \                 Software is like sex:
junk.able.es                             \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.19-rc4-jam0 (gcc 3.2 (Mandrake Linux 9.0 3.2-0.2mdk))
