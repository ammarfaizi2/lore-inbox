Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTHWRAO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbTHWQ7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 12:59:03 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:29872 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S263106AbTHWPhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 11:37:40 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Sat, 23 Aug 2003 17:37:36 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: TeJun Huh <tejun@aratech.co.kr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Race condition in 2.4 tasklet handling (cli() broken?)
Message-Id: <20030823173736.13235adc.skraw@ithnet.com>
In-Reply-To: <20030823151315.GA6781@atj.dyndns.org>
References: <20030823025448.GA32547@atj.dyndns.org>
	<20030823040931.GA3872@atj.dyndns.org>
	<20030823052633.GA4307@atj.dyndns.org>
	<20030823122813.0c90e241.skraw@ithnet.com>
	<20030823151315.GA6781@atj.dyndns.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Aug 2003 00:13:15 +0900
TeJun Huh <tejun@aratech.co.kr> wrote:

> On Sat, Aug 23, 2003 at 12:28:13PM +0200, Stephan von Krawczynski wrote:
> > 
> > If we follow your analysis and say it is broken, do you have a
> > suggestion/patch how to fix both? I am willing to try your proposals, as it
> > seems I am one of very few who really experience stability issues on SMP
> > with the current implementation.
> > 
> 
>  Hello, Stephan.
> [...]
>  It would be helpful if you can tell us more about your lockups.  Have
> you tried sysrq, NMI watchdog, kdb or kgdb?

Hello TeJun,

my first offer for a real bloat of information is my/the/all LKML thread with
"2.4.22-pre lockups" subject (warning: thread is _long_). I have given oopses
and quite an amount of details around what is happening. But up to this day
noone seemed to have reproduced anything. For me it looks pretty "simple" to
produce lockups. All installations are SuSE 8.2 but with standard kernel. My
primary hint for increasing the lockup probability is using reiserfs. Though it
does not seem directly related, because I can do lockups with only ext3, too,
there seems to be more action in areas that are simply hit by the problem more
often.

Up to now I have not been able to crash 2.4.20, but 2.4.21 and anything later
is definitely dying away.
To produce the problem I simply copy around GBs of data (around 100 GB) between
several disks and NFS to and from some clients (test system as nfs server).
Under normal circumstances I need around 2 days to crash the box. I set up
serial console to catch the oopses. They are all on different locations and
mostly related to some weird list corruptions, as an example (taken from
2.4.22-pre10):

Unable to handle kernel NULL pointer dereference at virtual address 00000006
c0144b14
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c0144b14>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: f0f66540   ecx: f0f66540   edx: 00000006
esi: f0f66540   edi: f0f66540   ebp: c2ce0350   esp: c345df24
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c345d000)
Stack: c0147ddf f0f66540 00000000 c2ce0350 0001bcad c02eab68 c0139228 c2ce0350
       000001d0 00000200 000001d0 00000016 00000020 000001d0 00000020 00000006
       c01394b3 00000006 c345c000 c02eab68 000001d0 00000006 c02eab68 00000000
Call Trace:    [<c0147ddf>] [<c0139228>] [<c01394b3>] [<c013952e>] [<c013963c>]
  [<c01396c8>] [<c01397f8>] [<c0139760>] [<c0105000>] [<c010592e>] [<c0139760>]
Code: 89 02 c7 41 30 00 00 00 00 89 4c 24 04 e9 7a ff ff ff 8d 76


>>EIP; c0144b14 <__remove_from_queues+14/30>   <=====

>>ebx; f0f66540 <_end+30bbb320/3852ee40>
>>ecx; f0f66540 <_end+30bbb320/3852ee40>
>>esi; f0f66540 <_end+30bbb320/3852ee40>
>>edi; f0f66540 <_end+30bbb320/3852ee40>
>>ebp; c2ce0350 <_end+2935130/3852ee40>
>>esp; c345df24 <_end+30b2d04/3852ee40>

Trace; c0147ddf <try_to_free_buffers+7f/170>
Trace; c0139228 <shrink_cache+298/3b0>
Trace; c01394b3 <shrink_caches+63/a0>
Trace; c013952e <try_to_free_pages_zone+3e/60>
Trace; c013963c <kswapd_balance_pgdat+4c/b0>
Trace; c01396c8 <kswapd_balance+28/40>
Trace; c01397f8 <kswapd+98/c0>
Trace; c0139760 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c010592e <arch_kernel_thread+2e/40>
Trace; c0139760 <kswapd+0/c0>

Code;  c0144b14 <__remove_from_queues+14/30>
00000000 <_EIP>:
Code;  c0144b14 <__remove_from_queues+14/30>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c0144b16 <__remove_from_queues+16/30>
   2:   c7 41 30 00 00 00 00      movl   $0x0,0x30(%ecx)
Code;  c0144b1d <__remove_from_queues+1d/30>
   9:   89 4c 24 04               mov    %ecx,0x4(%esp,1)
Code;  c0144b21 <__remove_from_queues+21/30>
   d:   e9 7a ff ff ff            jmp    ffffff8c <_EIP+0xffffff8c>
Code;  c0144b26 <__remove_from_queues+26/30>
  12:   8d 76 00                  lea    0x0(%esi),%esi

Somehow related seems a problem with data integrity. If I backup large files to
tape (SDLT) and verify them afterwards (all done with simple tar-command) I get
verification errors most of the time. In about 100 GB of backuped data there
are around 1-4 of those. This test "works" pretty reliable, so in case you have
some equipment around you may try this.
Ah yes: of course all this only happens on SMP. Same kernel versions work
flawlessly on the same box using UP. This is why I entered your thread about
races in SMP...

Feel free to ask anything about the issue, I will try to help however possible.

Regards,
Stephan



