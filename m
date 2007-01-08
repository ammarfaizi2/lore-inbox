Return-Path: <linux-kernel-owner+w=401wt.eu-S1030374AbXAHWdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbXAHWdY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 17:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbXAHWdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 17:33:24 -0500
Received: from stinky.trash.net ([213.144.137.162]:61570 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964984AbXAHWdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 17:33:23 -0500
Message-ID: <45A2C6AE.5080400@trash.net>
Date: Mon, 08 Jan 2007 23:33:18 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: Linux 2.6.20-rc4
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <m37ivyr1v6.fsf@telia.com> <Pine.LNX.4.64.0701071442580.3661@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701071442580.3661@woody.osdl.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------020301020407010607060308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020301020407010607060308
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> On Sun, 7 Jan 2007, Peter Osterlund wrote:
> 
>>I get kernel panics when doing large ethernet transfers. A loop doing
>>continuous scp transfers of some large (>100MB) files makes the kernel
>>crash after a few minutes. scp runs on a different machine and copies
>>data from the machine that crashes. (The first crash did not happen
>>when scp was used, but scp is an easy way to reproduce the problem.)
>>
>>I've seen this crash also with 2.6.20-rc2-git-something. Previously I
>>ran these kernels quite a lot and used a ppp link without problems.
>>Today I started using eth0 and the crashes started to occur. I have
>>netfilter rules for ppp0, but no rules for eth0. Earlier kernels have
>>been working perfectly for large eth0 transfers on this machine.
>>
>>Hand copied data from the console:
>>
>>  BUG: unable to handle kernel paging request at virtual address 9f5cea9f
>>   printing eip:
>>  c034c729
>>  *pde = 00000000
>>  Ooops: 0000 [#1]
>>  PREEMPT
>>  Modules linked in: ... 8139too ...
>>  CPU: 0
>>  EIP: 0060:[<c034c729>] Not tainted VLI
>>  EFALLGS: 00010206 (2.6.20-rc4 #13)
>>  EIP is at ipv4_conntrack_help+0x6b/0x83
>>  eax: c0475e44 ebx: 9f5cea37 ecx: d1dcebb0 edx: 00000014
>>  esi: d1dcebb0 edi: c0475e44 ebp: c0475dd8 esp: c0475dc4
> 
> 
> That's 
> 
> 	and    $0xf,%dl
> 	movzbl %dl,%edx
> 	lea    (%ecx,%edx,4),%edx
> 	movzbl %bl,%eax
> 	mov    %eax,(%esp)
> 	mov    %esi,%ecx
> 	mov    %edi,%eax
> 	mov    0xfffffff0(%ebp),%ebx
> **	call   *0x68(%ebx)		**
> 	add    $0x8,%esp
> 	pop    %ebx
> 	pop    %esi
> 	pop    %edi
> 	pop    %ebp
> 	ret
> 
> which is ipv4_conntrack_help():
> 
> 	return help->helper->help(pskb,
> 		(*pskb)->nh.raw - (*pskb)->data
> 				+ (*pskb)->nh.iph->ihl*4,
> 		ct, ctinfo);
> 
> and that call instruction is the one that oopses because "help->helper" is 
> corrupt (it's 0x9f5cea37 - not a valid kernel pointer).


I guess its because of an uninitialized helper field in struct
nf_conntrack_expect, which is then copied from the expectation to
the conntrack entry.

Peter, do you have locally generated netbios ns queries on the machine
running nf_conntrack? If so, please try this patch. Otherwise, are
there any other conntrack helpers that are actually used?


--------------020301020407010607060308
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

[NETFILTER]: nf_conntrack_netbios_ns: fix uninitialized member in expectation

->helper is uninitialized in the expectation registered by the netbios_ns
helper and it later copied to the expected connection, which causes invalid
memory dereferences when trying to call the helper.

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit fe6df90eb909a84593b6902e6e4f802687bc4564
tree 113ffbc5cd73dd3a5fe66bc24ba4747b2b5a4c6c
parent fa0035e191e85a2ab31861df9e0a0273e60dc745
author Patrick McHardy <kaber@trash.net> Mon, 08 Jan 2007 23:30:35 +0100
committer Patrick McHardy <kaber@trash.net> Mon, 08 Jan 2007 23:30:35 +0100

 net/netfilter/nf_conntrack_netbios_ns.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netbios_ns.c b/net/netfilter/nf_conntrack_netbios_ns.c
index a5b234e..2a48efd 100644
--- a/net/netfilter/nf_conntrack_netbios_ns.c
+++ b/net/netfilter/nf_conntrack_netbios_ns.c
@@ -89,6 +89,7 @@ static int help(struct sk_buff **pskb, u
 
 	exp->expectfn             = NULL;
 	exp->flags                = NF_CT_EXPECT_PERMANENT;
+	exp->helper               = NULL;
 
 	nf_conntrack_expect_related(exp);
 	nf_conntrack_expect_put(exp);

--------------020301020407010607060308--
