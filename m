Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVA1TMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVA1TMF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbVA1TMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:12:02 -0500
Received: from warden2-p.diginsite.com ([209.195.52.120]:43755 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261522AbVA1TFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:05:14 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jirka Kosina <jikos@jikos.cz>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Date: Fri, 28 Jan 2005 11:02:09 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Patch 4/6  randomize the stack pointer
In-Reply-To: <20050128055835.GA30570@elte.hu>
Message-ID: <Pine.LNX.4.60.0501281051580.8494@dlang.diginsite.com>
References: <20050127101117.GA9760@infradead.org> <20050127101322.GE9760@infradead.org>
 <41F92721.1030903@comcast.net> <Pine.LNX.4.58.0501272323150.9190@twin.jikos.cz>
 <20050128055835.GA30570@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

even requireing a 64k attack to defeat randomization changes an attack 
from N packets to ~45+N packets. This many packets gives a firewall/IDS a 
pretty solid signature to use to identify the difference between an attack 
and legitiamate traffic, it also gives a reactive IDS system a chance to 
terminate the connection before the attack payload (which is in the N 
packets) arrives.

David Lang

On Fri, 28 Jan 2005, Ingo Molnar wrote:

> Date: Fri, 28 Jan 2005 06:58:35 +0100
> From: Ingo Molnar <mingo@elte.hu>
> To: Jirka Kosina <jikos@jikos.cz>
> Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
>     akpm@osdl.org, torvalds@osdl.org
> Subject: Re: Patch 4/6  randomize the stack pointer
> 
>
> * Jirka Kosina <jikos@jikos.cz> wrote:
>
>> Also, besides security implications of stack randomization, there is
>> one more aspect that should not be forgotten - stack randomization
>> (even for quite small range) could be useful to distribute a pressure
>> on cache (which may not be fully associative in all cases), so if
>> everyone runs with stack on the same address, it could impose quite
>> noticeable stress on some cachelines (those representing stack
>> addresses), while other will be idling unused.
>>
>> I thought that this was the original purpose of the "stack
>> randomization" which is shipped for example by RedHat kernels, as the
>> randomization is quite small and easy to bruteforce, so it can't serve
>> too much as a buffer overflow protection.
>
> Fedora kernels have 2MB of stack randomization. If 2MB is easy to
> brute-force then 256MB is easy to brute-force nearly as much. But the
> difference between _zero_ randomisation and 2MB randomisation is much
> bigger than the difference between 2MB and 256MB of randomisation.
>
> example: if there is no randomisation and e.g. there's an up to 100
> bytes buffer-overflow in a UDP based service, then a single-packet
> remote attack may become possible, and an automated worm has an easy
> 'vector to spread'. (worms these days are mainly limited by bandwidth,
> so the number of packets it needs to spread is crutial. Also,
> detection/prevention of a worm is easier if the attacker has to send
> multiple packets in a row.)
>
> some quick calculations about how the economics of attack look like if
> there is randomisation in place:
>
> If the hole has a possibility to inject a 'padding invariant' into the
> attack (either NOPs into the shell code, so that a jump address can be
> 'fuzzy', or e.g. "././././" padding into a pathname/URL attack string),
> so that the attack can use a 'fuzzy' address accurate only to the size
> of padding, then the brute-forcing can be reduced to ~2MB/100bytes==20
> thousand tries. If there is randomisation then a single-packet remote
> attack needs to become a ~20-thousand packets brute-force attack. The
> box is by no means in the clear against attacks, but worms become
> uneconomic.
>
> if the attack needs a specific address (or offset) to the stack and
> there is no invariant then 2MB of of randomisation requires 2 million
> tries to do the brute-force-attack.
>
> with 256MB of randomisation and the possibility of an invariant, the
> same attack would become a 2 million packets brute-force attack. A site
> that didnt notice a 10-thousand packets attack probably wont notice a 2
> million packets attack either. Plus the site is still vulnerable: 2
> million packets (which with a 100 bytes attack size takes ~20 minutes
> over broadband) and it's gone.
>
> with no invariant and 256 million packets needed for an attack, it will
> take over a day (over broadband) to brute-force a box - and security
> purists would still consider the box vulnerable.
>
> conclusion: stack randomisation (and other VM randomisations) are not a
> tool against local attacks (which are much easier and faster to
> brute-force) or against targeted remote attacks, but mainly a tool to
> degrade the economy of automated remote attacks.
>
> 256 MB of stack randomisation negatively impacts the VM layout and
> creates all sorts of problems, so it's really impractical. If your only
> goal is to maximize security, then clearly, the more randomisation, the
> better. If you have other goals as well (e.g. my goal is to make
> security as painless as possible, so that _other_ people who dont
> usually care about security end up using our stuff too) then you will
> settle for somewhere inbetween. We started with 8MB in Fedora but that
> already caused some problems so we decreased it to 2MB and that worked
> pretty well on 32-bit systems. 64K is probably too low but is still a
> good start and much better than nothing.
>
> Note that 64-bit systems are different, there we can do a pretty good
> grade of randomisation as VM space is plenty.
>
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
