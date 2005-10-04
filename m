Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbVJDVMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbVJDVMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 17:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbVJDVMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 17:12:13 -0400
Received: from mf01.sitadelle.com ([212.94.174.68]:40022 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S964978AbVJDVMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 17:12:12 -0400
Message-ID: <4342F022.3060509@cosmosbay.com>
Date: Tue, 04 Oct 2005 23:12:02 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [NUMA , x86_64] Why memnode_shift is chosen with the lowest possible
 value ?
References: <1127939141.26401.32.camel@localhost.localdomain> <433C1D6F.1030605@cosmosbay.com> <433D00BC.2070001@cosmosbay.com> <200510041913.26332.ak@suse.de>
In-Reply-To: <200510041913.26332.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen a écrit :
> On Friday 30 September 2005 11:09, Eric Dumazet wrote:
> 
>>+       while (populate_memnodemap(nodes, numnodes, shift + 1) >= 0)
>>+               shift++;
> 
> 
> 
> Why shift+1 here? 

Thank you Andi fo r reviewing this stuff

The idea it to find the highest shift value, and to break the loop as soon as 
the (shift + 1) value gives us an "shift too big" error.

Maybe you want to write :

         while (populate_memnodemap(nodes, numnodes, ++shift) >= 0) ;
	shift--;

Well, thats only style...


> 
> 
>>+               if ((end >> shift) >= NODEMAPSIZE)
>>+                       return 0;
> 
> 
> This should be >, not >= shouldn't it?

Let's take an example

end   = 0xffffffff;
start = 0xfff00000;
shift = 20
Suppose that NODEMAPSIZE == (end >> shift) == 0xfff

If the test is changed to :

if ((end >> shift) > NODEMAPSIZE)
	return 0;

We could do one of the iteration with (addr < end) but (addr >> shift) == 
NODEMAPSIZE

if (memnodemap[NODEMAPSIZE] != 0xff)
	return -1;
memnodemap[NODMAPSIZE] = i;

Thats bound violation of memnodemap[]

AFAIK, I wonder why NODEMAPSIZE is 0xfff and not 0x1000, because this off by 
one make half of memnodemap[] to be unused for power of two ram size.


> 
> -Andi
> 
> P.S.: Please cc x86-64 patches to discuss@x86-64.org

Ah thank you

Eric
