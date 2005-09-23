Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbVIWFOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVIWFOl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 01:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVIWFOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 01:14:41 -0400
Received: from mf01.sitadelle.com ([212.94.174.68]:33944 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751295AbVIWFOk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 01:14:40 -0400
Message-ID: <43338F30.6070601@cosmosbay.com>
Date: Fri, 23 Sep 2005 07:14:24 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
Cc: Harald Welte <laforge@netfilter.org>, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 2/3] netfilter : 3 patches to boost ip_tables performance
References: <432EF0C5.5090908@cosmosbay.com> <200509191948.55333.ak@suse.de>	<432FDAC5.3040801@cosmosbay.com> <200509201830.20689.ak@suse.de>	<433082DE.3060308@cosmosbay.com> <43308324.70403@cosmosbay.com>	<4331D168.6090604@cosmosbay.com>	<20050922124803.GH26520@sunbeam.de.gnumonks.org>	<4332AC2E.8000607@cosmosbay.com> <20050923040234.GC595@alpha.home.local>
In-Reply-To: <20050923040234.GC595@alpha.home.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau a écrit :
> On Thu, Sep 22, 2005 at 03:05:50PM +0200, Eric Dumazet wrote:
> (...) 
> 
>>It was necessary to get the best code with gcc-3.4.4 on i386 and 
>>gcc-4.0.1 on x86_64
>>
>>For example :
>>
>>bool1 = FWINV(ret != 0, IPT_INV_VIA_OUT);
>>if (bool1) {
>>
>>gives a better code than :
>>
>>if (FWINV(ret != 0, IPT_INV_VIA_OUT)) {
>>
>>(one less conditional branch)
>>
>>Dont ask me why, it is shocking but true :(
> 
> 
> I also noticed many times that gcc's optimization of "if (complex condition)"
> is rather poor and it's often better to put it in a variable before. I even
> remember that if you use an intermediate variable, it can often generate a
> CMOV instruction on processors which support it, while it produces cond tests
> and jumps without the variable. Generally speaking, if you want fast code,
> you have to write it as a long sequence of small instructions, just as if
> you were writing assembly. As you said, shocking but true.

Even without CMOV support, the suggested patch helps :

Here is the code generated with gcc-3.4.4  on a pentium4 (i686) for :

/********************/
bool1 = ((ip->saddr&ipinfo->smsk.s_addr) != ipinfo->src.s_addr);
bool1 ^= !!(ipinfo->invflags & IPT_INV_SRCIP);

bool2 = ((ip->daddr&ipinfo->dmsk.s_addr) != ipinfo->dst.s_addr);
bool2 ^= !!(ipinfo->invflags & IPT_INV_DSTIP);

if ((bool1 | bool2) != 0) {

/********************/
cb:       0f b6 56 53          movzbl 0x53(%esi),%edx
cf:       8b 46 08             mov    0x8(%esi),%eax #ip->saddr
d2:       23 47 0c             and    0xc(%edi),%eax #ipinfo->smsk.s_addr
d5:       0f b6 da             movzbl %dl,%ebx
d8:       3b 06                cmp    (%esi),%eax #ipinfo->src.s_addr
da:       88 55 cf             mov    %dl,0xffffffcf(%ebp)
dd:       89 da                mov    %ebx,%edx
df:       0f 95 c0             setne  %al
e2:       c1 ea 03             shr    $0x3,%edx
e5:       31 c2                xor    %eax,%edx
e7:       8b 46 0c             mov    0xc(%esi),%eax #ip->daddr&ipinfo
ea:       23 47 10             and    0x10(%edi),%eax #ipinfo->dmsk.s_addr
ed:       3b 46 04             cmp    0x4(%esi),%eax #ipinfo->dst.s_addr
f0:       89 d8                mov    %ebx,%eax
f2:       0f 95 c1             setne  %cl
f5:       c1 e8 04             shr    $0x4,%eax
f8:       31 c8                xor    %ecx,%eax
fa:       09 d0                or     %edx,%eax
fc:       a8 01                test   $0x1,%al
fe:       0f 85 95 00 00 00    jne    dest // only one conditional branch

As you can see the whole sequence is rather good : only one conditional branch
(No CMOV instructions as you can see, so even on a i486 the code should be 
roughly the same)

Now here is the code generated for the original code :
/********************/
	if (FWINV((ip->saddr&ipinfo->smsk.s_addr) != ipinfo->src.s_addr,
			IPT_INV_SRCIP)
	  || FWINV((ip->daddr&ipinfo->dmsk.s_addr) != ipinfo->dst.s_addr,
			IPT_INV_DSTIP)) {
/********************/
       cb:       0f b6 4e 53             movzbl 0x53(%esi),%ecx
       cf:       f6 c1 08                test   $0x8,%cl
       d2:       0f 84 af 01 00 00       je     287 <ipt_do_table+0x25d>
       d8:       8b 46 08                mov    0x8(%esi),%eax
       db:       23 47 0c                and    0xc(%edi),%eax
       de:       3b 06                   cmp    (%esi),%eax
       e0:       0f 84 b0 01 00 00       je     296 <ipt_do_table+0x26c>
       e6:       f6 c1 10                test   $0x10,%cl
       e9:       0f 84 d4 01 00 00       je     2c3 <ipt_do_table+0x299>
       ef:       8b 46 0c                mov    0xc(%esi),%eax
       f2:       23 47 10                and    0x10(%edi),%eax
       f5:       3b 46 04                cmp    0x4(%esi),%eax
       f8:       0f 84 98 01 00 00       je     296 <ipt_do_table+0x26c>

...

      287:       8b 46 08                mov    0x8(%esi),%eax
      28a:       23 47 0c                and    0xc(%edi),%eax
      28d:       3b 06                   cmp    (%esi),%eax
      28f:       2e 0f 84 50 fe ff ff    je,pn  e6 <ipt_do_table+0xbc>
      296:       0f b7 46 5a             movzwl 0x5a(%esi),%eax
      29a:       01 c6                   add    %eax,%esi
      29c:       8b 4d f0                mov    0xfffffff0(%ebp),%ecx
      29f:       85 c9                   test   %ecx,%ecx
      2a1:       0f 84 24 fe ff ff       je     cb <ipt_do_table+0xa1>

...

      2c3:       8b 46 0c                mov    0xc(%esi),%eax
      2c6:       23 47 10                and    0x10(%edi),%eax
      2c9:       3b 46 04                cmp    0x4(%esi),%eax
      2cc:       75 c8                   jne    296 <ipt_do_table+0x26c>
      2ce:       e9 2b fe ff ff          jmp    fe <ipt_do_table+0xd4>


/******************/
	As you can see, that a lot of conditional branches, that cannot be predicted 
correctly by the cpu, unless consecutives iptables rules generate the same flow.


Eric
