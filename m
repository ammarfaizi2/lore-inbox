Return-Path: <linux-kernel-owner+w=401wt.eu-S965239AbXAGWu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbXAGWu1 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 17:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbXAGWu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 17:50:27 -0500
Received: from smtp.osdl.org ([65.172.181.24]:54414 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965239AbXAGWu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 17:50:27 -0500
Date: Sun, 7 Jan 2007 14:50:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Osterlund <petero2@telia.com>,
       "David S. Miller" <davem@davemloft.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kaber@trash.net
Subject: Re: Linux 2.6.20-rc4
In-Reply-To: <m37ivyr1v6.fsf@telia.com>
Message-ID: <Pine.LNX.4.64.0701071442580.3661@woody.osdl.org>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <m37ivyr1v6.fsf@telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2007, Peter Osterlund wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Patrick McHardy (2):
> >       [NETFILTER]: New connection tracking is not EXPERIMENTAL anymore
> 
> I get kernel panics when doing large ethernet transfers. A loop doing
> continuous scp transfers of some large (>100MB) files makes the kernel
> crash after a few minutes. scp runs on a different machine and copies
> data from the machine that crashes. (The first crash did not happen
> when scp was used, but scp is an easy way to reproduce the problem.)
> 
> I've seen this crash also with 2.6.20-rc2-git-something. Previously I
> ran these kernels quite a lot and used a ppp link without problems.
> Today I started using eth0 and the crashes started to occur. I have
> netfilter rules for ppp0, but no rules for eth0. Earlier kernels have
> been working perfectly for large eth0 transfers on this machine.
> 
> Hand copied data from the console:
> 
>   BUG: unable to handle kernel paging request at virtual address 9f5cea9f
>    printing eip:
>   c034c729
>   *pde = 00000000
>   Ooops: 0000 [#1]
>   PREEMPT
>   Modules linked in: ... 8139too ...
>   CPU: 0
>   EIP: 0060:[<c034c729>] Not tainted VLI
>   EFALLGS: 00010206 (2.6.20-rc4 #13)
>   EIP is at ipv4_conntrack_help+0x6b/0x83
>   eax: c0475e44 ebx: 9f5cea37 ecx: d1dcebb0 edx: 00000014
>   esi: d1dcebb0 edi: c0475e44 ebp: c0475dd8 esp: c0475dc4

That's 

	and    $0xf,%dl
	movzbl %dl,%edx
	lea    (%ecx,%edx,4),%edx
	movzbl %bl,%eax
	mov    %eax,(%esp)
	mov    %esi,%ecx
	mov    %edi,%eax
	mov    0xfffffff0(%ebp),%ebx
**	call   *0x68(%ebx)		**
	add    $0x8,%esp
	pop    %ebx
	pop    %esi
	pop    %edi
	pop    %ebp
	ret

which is ipv4_conntrack_help():

	return help->helper->help(pskb,
		(*pskb)->nh.raw - (*pskb)->data
				+ (*pskb)->nh.iph->ihl*4,
		ct, ctinfo);

and that call instruction is the one that oopses because "help->helper" is 
corrupt (it's 0x9f5cea37 - not a valid kernel pointer).

David, there really *is* something screwy in netfilter. 

			Linus
