Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbSLaADN>; Mon, 30 Dec 2002 19:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267182AbSLaADN>; Mon, 30 Dec 2002 19:03:13 -0500
Received: from packet.digeo.com ([12.110.80.53]:34191 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267180AbSLaADL>;
	Mon, 30 Dec 2002 19:03:11 -0500
Message-ID: <3E10E0AF.9342B1D7@digeo.com>
Date: Mon, 30 Dec 2002 16:11:27 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: khromy <khromy@lnuxlab.ath.cx>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.53-mm2: scheduling while atomic! + kernel BUG at mm/slab.c:1671!
References: <20021231001518.GA28259@lnuxlab.ath.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Dec 2002 00:11:28.0239 (UTC) FILETIME=[29FA6FF0:01C2B061]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

khromy wrote:
> 
> Running 2.5.53-mm2 I got the following in dmesg.  I have no idea how to
> reproduce them since I wasn't here when they occured..
> 
> bad: scheduling while atomic!

This one is the bug in pte_chain_alloc().   It _should_ look like
this:

struct pte_chain *pte_chain_alloc(int gfp_flags)
{
	int cpu;
	struct pte_chain *ret;
	struct pte_chain **pte_chainp;

	cpu = get_cpu();
	pte_chainp = &per_cpu(local_pte_chain, cpu);
	if (*pte_chainp) {
		ret = *pte_chainp;
		*pte_chainp = NULL;
		put_cpu();
	} else {
		put_cpu();
		ret = kmem_cache_alloc(pte_chain_cache, gfp_flags);
	}
	return ret;
}


> kernel BUG at mm/slab.c:1671!
> invalid operand: 0000
> CPU:    0
> EIP:    0060:[<c012d2eb>]    Not tainted
> EFLAGS: 00010a02
> EIP is at kmalloc+0xbb/0x114
> eax: c3ff9518   ebx: cffff440   ecx: 00000000   edx: cfff3bc3
> esi: cfff3b40   edi: cfff3b40   ebp: c360f1f4   esp: c6367e70
> ds: 007b   es: 007b   ss: 0068
> Process find (pid: 1563, threadinfo=c6366000 task=c3e326e0)
> Stack: c1546364 cc3a28f4 cc3a295c c01517ec 00000070 000001d0 00000000 cc3a28f4
>        cc3a295c c360f1f4 00000066 c01492fc c360f1f4 c6367f14 00000000 c6367f54
>        cfff7324 c6367f14 c01495a0 c360f1f4 c6367f14 00000004 c6367f0c 00000000
> Call Trace:
>  [<c01517ec>] d_alloc+0x48/0x194
>  [<c01492fc>] real_lookup+0x38/0xc0

This means that someone altered a dentry after freeing it.  Could
be a problem in the new dcache_rcu code, or it could be a random
memory scribble.  hmm.
