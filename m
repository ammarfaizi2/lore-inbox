Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbUBEABa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbUBDX7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:59:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:40915 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265125AbUBDX6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:58:04 -0500
Date: Wed, 4 Feb 2004 15:58:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>, kmannth@us.ibm.com
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm subsystem involving
 X  (fwd)
In-Reply-To: <51080000.1075936626@flay>
Message-ID: <Pine.LNX.4.58.0402041539470.2086@home.osdl.org>
References: <51080000.1075936626@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Feb 2004, Martin J. Bligh wrote:
> 
> So there have been alot of X issue with Red Hat and 2.6 kernels.  I managed to
> get the system to panic and I decide it was time to open this bug.  I got this
> on boot up. 

Hmm. Compiler? Why would AS-3 in particular have problems?

> Unable to handle kernel paging request at virtual address 0264d000
>  printing eip:
> c0147af4
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    7
> EIP:    0060:[<c0147af4>]    Not tainted
> EFLAGS: 00013206
> EIP is at remap_page_range+0x193/0x26c
> eax: 0264d000   ebx: 000f5200   ecx: 00000001   edx: dad0fa80
> esi: 001fe000   edi: d87c9ff0   ebp: f5200000   esp: d8835ee4
> ds: 007b   es: 007b   ss: 0068
> Process X (pid: 1285, threadinfo=d8834000 task=d9474ce0)
> Stack: d961d580 001ff000 001ff000 40000000 f5002000 001fe000 d9578000 d961d580
>        401ff000 d9576508 00000000 f5200000 d961d580 00000001 c0247055 d87d62c0
>        401fe000 b5002000 00001000 00000027 d9388e80 00001000 c014a7fd d9388e80
> Call Trace:
>  [<c0247055>] mmap_mem+0x71/0xd4
>  [<c014a7fd>] do_mmap_pgoff+0x362/0x70d
>  [<c0156f65>] filp_open+0x67/0x69
>  [<c0111c4d>] sys_mmap2+0x7a/0xaa
>  [<c010aced>] sysenter_past_esp+0x52/0x71
> 
> Code: 8b 00 a9 00 08 00 00 74 10 89 d8 8b 54 24 4c c1 e8 14 09 ea

This _seems_ to be the code

		...
                if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
                        set_pte(pte, pfn_pte(pfn, prot));
		...

in particular, it disassembles to

	0x8048490 <insn>:       mov    (%eax),%eax
	0x8048492 <insn+2>:     test   $0x800,%eax
	0x8048497 <insn+7>:     je     0x80484a9
	0x8048499 <insn+9>:     mov    %ebx,%eax
	0x804849b <insn+11>:    mov    0x4c(%esp,1),%edx
	0x804849f <insn+15>:    shr    $0x14,%eax

which seems to be the "PageReserved(pfn_to_page(pfn))" test.

This implies that you have either:
 - a buggy "pfn_valid()" macro (do you use CONFIG_DISCONTIGMEM?)
 - or a buggy compiler (it sure ain't the compiler I use, since that one 
   will generate a "testb $8,%ah" instead)

It might help if you disassembled the code (in your kernel) around that 
point, since that might give a clue about it.

Quite honestly, to me it looks like the address being remapped is likely 
in %ebp (0xf5200000), and that pfn is in %ebx (0x000f5200), and that your 
pfn_valid() is buggered, causing a totally bogus "struct page *" from 
"pfn_to_page()".

		Linus
