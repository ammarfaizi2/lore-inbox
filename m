Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265478AbUBPKYy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 05:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265506AbUBPKYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 05:24:54 -0500
Received: from gizmo05bw.bigpond.com ([144.140.70.15]:39884 "HELO
	gizmo05bw.bigpond.com") by vger.kernel.org with SMTP
	id S265478AbUBPKYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 05:24:49 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 Paging Fault, Cache tries to swap with no swap partition
Date: Mon, 16 Feb 2004 20:25:11 +1000
User-Agent: KMail/1.5.1
Cc: vda@port.imtp.ilyichevsk.odessa.ua
References: <200402150306.35704.ross@datscreative.com.au> <200402142233.23740.vda@port.imtp.ilyichevsk.odessa.ua> <200402152349.36136.ross@datscreative.com.au>
In-Reply-To: <200402152349.36136.ross@datscreative.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402162025.11540.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 February 2004 23:49, Ross Dickson wrote:
> On Sunday 15 February 2004 06:33, you wrote:
> > On Saturday 14 February 2004 19:06, Ross Dickson wrote:
> > > I have an imaging system writing files to removable hard drives.
> > > Compact Flash boot with ram drives so I usually have no swap partition or
> > > file.
> > >
> > > Recently I upgraded kernel from 2.4.20 to 2.4.24.
Is KM18G Pro (nforce2 dual memory mode), AMD 2400XP, Preempt, Low latency,
64Bit jiffies 1000Hz patched.

I found some articles about memory overcommitment, checked the source and saw
strict in use for arm systems - no swap- so this time I thought I would try 

echo 1 > /proc/sys/vm/overcommit_memory

I got another oops under equivalent circumstances to earlier (no swap).  
I ran oops through ksymoops on another machine with same kernel , results below.
At this point I think the trigger may be a slow (bad blocks?) 80Gb hard drive the files
are being written to. The PCI bus is quite busy with imaging from 3 cameras on two
capture cards (bttv and meteor II mc).

> > > Can the paging cache be tuned in /proc or somewhere to prevent it being so
> > > greedy as to want more memory than the machine has?
> > 
> > Maybe. But you should concentrate on finding where exactly it oopsed.
...snip...
> ......I added a 16mb ram drive swap (see earlier posting)
> I note memfree stabilises at around 4Mb when running OK, given it only wanted
> an extra 1Mb cache swap, can I cat something to /proc/sys/vm/????? to force
> it to stabilise at around 10Mb or 20Mb? Otherwise can I change a constant
> and recompile kernel to achieve same? It might help give more headroom when
> the event occurs.
> 
> > 
> > > Is the quickest fix to give it more ram. I read on another posting that
> > > with greater than 512Mb the cache won't grab any more?
> > 
> > Please don't succumb to 'add more RAM' syndrome. 460 megs should be fine
> > for you. I'd say better find the root of the problem.
...snip...
> > vda
> > 

Thanks for the response
Regards
Ross.

Was run "mem=450" with this Oops

ksymoops 2.4.8 on i686 2.4.24-rd.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -L (specified)
     -o /lib/modules/2.4.24-rd/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel paging request at virtual address 6a65656a
c0133f20
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0133f20>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010883
eax: 6a65656a   ebx: 000000f5   ecx: c14dfdd4   edx: c14dfde4
esi: 00000000   edi: 00000008   ebp: c14dfe40   esp: dc16df38
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=dc16d000)
Stack: 000001d0 00000001 c14dfdd4 00000000 00000005 00000005 00000020 000001d0 
       c032c4d8 c032c4d8 c0134ebc dc16df84 000001d0 0000003c 00000020 c0134f58 
       dc16df84 dc16c000 00000000 00000000 c032c4d8 dc16c000 c032c400 00000000 
Call Trace:    [<c0134ebc>] [<c0134f58>] [<c01350f6>] [<c0135169>] [<c013529d>]
  [<c0135210>] [<c0105000>] [<c01057db>] [<c0135210>]
Code: 8b 00 43 39 d0 75 f9 8b 44 24 08 89 da 8b 70 24 8b 40 44 89 


>>EIP; c0133f20 <kmem_cache_reap+80/1f0>   <=====

>>ecx; c14dfdd4 <_end+1115228/1e4db4b4>
>>edx; c14dfde4 <_end+1115238/1e4db4b4>
>>ebp; c14dfe40 <_end+1115294/1e4db4b4>
>>esp; dc16df38 <_end+1bda338c/1e4db4b4>

Trace; c0134ebc <shrink_caches+1c/60>
Trace; c0134f58 <try_to_free_pages_zone+58/e0>
Trace; c01350f6 <kswapd_balance_pgdat+56/b0>
Trace; c0135169 <kswapd_balance+19/30>
Trace; c013529d <kswapd+8d/b0>
Trace; c0135210 <kswapd+0/b0>
Trace; c0105000 <_stext+0/0>
Trace; c01057db <arch_kernel_thread+2b/40>
Trace; c0135210 <kswapd+0/b0>

Code;  c0133f20 <kmem_cache_reap+80/1f0>
00000000 <_EIP>:
Code;  c0133f20 <kmem_cache_reap+80/1f0>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c0133f22 <kmem_cache_reap+82/1f0>
   2:   43                        inc    %ebx
Code;  c0133f23 <kmem_cache_reap+83/1f0>
   3:   39 d0                     cmp    %edx,%eax
Code;  c0133f25 <kmem_cache_reap+85/1f0>
   5:   75 f9                     jne    0 <_EIP>
Code;  c0133f27 <kmem_cache_reap+87/1f0>
   7:   8b 44 24 08               mov    0x8(%esp,1),%eax
Code;  c0133f2b <kmem_cache_reap+8b/1f0>
   b:   89 da                     mov    %ebx,%edx
Code;  c0133f2d <kmem_cache_reap+8d/1f0>
   d:   8b 70 24                  mov    0x24(%eax),%esi
Code;  c0133f30 <kmem_cache_reap+90/1f0>
  10:   8b 40 44                  mov    0x44(%eax),%eax
Code;  c0133f33 <kmem_cache_reap+93/1f0>
  13:   89 00                     mov    %eax,(%eax)

Mem starts like this when programs have been started.
Was run "mem=460" for these mem readings.
        total:    used:    free:  shared: buffers:  cached:
Mem:  473899008 22151168 451747840        0   327680  7737344
Swap:        0        0        0
MemTotal:       462792 kB
MemFree:        441160 kB
MemShared:           0 kB
Buffers:           320 kB
Cached:           7556 kB
SwapCached:          0 kB
Active:           2320 kB
Inactive:         7072 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       462792 kB
LowFree:        441160 kB
SwapTotal:           0 kB
SwapFree:            0 kB

And is like this near to Oops time
        total:    used:    free:  shared: buffers:  cached:
Mem:  473899008 469348352  4550656        0   831488 420454400
Swap:        0        0        0
MemTotal:       462792 kB
MemFree:          4444 kB
MemShared:           0 kB
Buffers:           812 kB
Cached:         410600 kB
SwapCached:          0 kB
Active:           5064 kB
Inactive:       410968 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       462792 kB
LowFree:          4444 kB
SwapTotal:           0 kB
SwapFree:            0 kB

