Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265130AbTLRNR7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 08:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbTLRNR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 08:17:59 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:39660 "EHLO
	iapetus.localdomain") by vger.kernel.org with ESMTP id S265130AbTLRNR4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 08:17:56 -0500
Date: Thu, 18 Dec 2003 14:16:59 +0100
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 Oops in journal_try_to_free_buffers (fwd)
Message-ID: <20031218131659.GA28450@iapetus.localdomain>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20031211085838.GA22606@iapetus.localdomain> <Pine.LNX.4.44.0312110923130.1314-200000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312110923130.1314-200000@logos.cnet>
User-Agent: Mutt/1.4i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 09:50:23AM -0200, Marcelo Tosatti wrote:
> 
> Frank, 
> 
> Can you please try to revert the attached patch and try to cause the oops 
> again? 

patch -R applied because problems seem to be persistent: plain 2.4.23 just
experienced a pagecache/buffercache corruption: the first 2300 bytes of
/bin/sed appeared to be all zeroes. Reboot and fsck (ext3) did not find
anything and /bin/sed was ok by then. Forgot to save the bad /bin/sed :-(

FYI, this is another Oops trace (plain 2.4.23):
ksymoops 2.4.9 on i686 2.4.23-y91.  Options used
     -V (default)
     -k /var/log/ksyms.1 (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-y91/ (default)
     -m /boot/System.map-2.4.23-x91 (specified)

No modules in ksyms, skipping objects
Dec 18 12:46:03 tornio kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000028
Dec 18 12:46:03 tornio kernel: c0149495
Dec 18 12:46:03 tornio kernel: *pde = 00000000
Dec 18 12:46:03 tornio kernel: Oops: 0000
Dec 18 12:46:03 tornio kernel: CPU:    0
Dec 18 12:46:03 tornio kernel: EIP:    0010:[<c0149495>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec 18 12:46:03 tornio kernel: EFLAGS: 00010217
Dec 18 12:46:03 tornio kernel: eax: 000703ab   ebx: 00000000   ecx: 0000000d   edx: c1190000
Dec 18 12:46:03 tornio kernel: esi: 00000000   edi: 00000000   ebp: c5f75eac   esp: c5f75ea0
Dec 18 12:46:03 tornio kernel: ds: 0018   es: 0018   ss: 0018
Dec 18 12:46:03 tornio kernel: Process xinitrc (pid: 3222, stackpage=c5f75000)
Dec 18 12:46:03 tornio kernel: Stack: 000703ab c11973d8 000703ab c5f75ed4 c014984f c7e31400 000703ab c11973d8
Dec 18 12:46:03 tornio kernel:        00000000 00000000 000703ab c40bd0e4 c40bd0e4 c5f75ef8 c015dc67 c7e31400
Dec 18 12:46:03 tornio kernel:        000703ab 00000000 00000000 fffffff4 c2ab69f4 c07c5168 c5f75f14 c013f918
Dec 18 12:46:03 tornio kernel: Call Trace:    [<c014984f>] [<c015dc67>] [<c013f918>] [<c0140055>] [<c0120536>]
Dec 18 12:46:03 tornio kernel:   [<c01402ed>] [<c014044e>] [<c01406ad>] [<c013d3e2>] [<c0108ab3>]
Dec 18 12:46:03 tornio kernel: Code: 39 46 28 75 36 8b 45 08 39 86 ac 00 00 00 75 2b 85 ff 74 12


>>EIP; c0149495 <find_inode+1d/70>   <=====

Trace; c014984f <iget4+3f/d4>
Trace; c015dc67 <ext3_lookup+57/80>
Trace; c013f918 <real_lookup+58/cc>
Trace; c0140055 <link_path_walk+5d5/850>
Trace; c0120536 <timer_bh+26/388>
Trace; c01402ed <path_walk+1d/24>
Trace; c014044e <path_lookup+1e/2c>
Trace; c01406ad <__user_walk+2d/48>
Trace; c013d3e2 <sys_stat64+1a/74>
Trace; c0108ab3 <system_call+33/40>

Code;  c0149495 <find_inode+1d/70>
00000000 <_EIP>:
Code;  c0149495 <find_inode+1d/70>   <=====
   0:   39 46 28                  cmp    %eax,0x28(%esi)   <=====
Code;  c0149498 <find_inode+20/70>
   3:   75 36                     jne    3b <_EIP+0x3b>
Code;  c014949a <find_inode+22/70>
   5:   8b 45 08                  mov    0x8(%ebp),%eax
Code;  c014949d <find_inode+25/70>
   8:   39 86 ac 00 00 00         cmp    %eax,0xac(%esi)
Code;  c01494a3 <find_inode+2b/70>
   e:   75 2b                     jne    3b <_EIP+0x3b>
Code;  c01494a5 <find_inode+2d/70>
  10:   85 ff                     test   %edi,%edi
Code;  c01494a7 <find_inode+2f/70>
  12:   74 12                     je     26 <_EIP+0x26>


-- 
Frank
