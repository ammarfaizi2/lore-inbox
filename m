Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932620AbVKXDYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbVKXDYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 22:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbVKXDYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 22:24:07 -0500
Received: from urtax.ms.mff.cuni.cz ([195.113.20.127]:13486 "EHLO
	urtax.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932620AbVKXDYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 22:24:06 -0500
Date: Thu, 24 Nov 2005 04:23:59 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
X-X-Sender: mikulas@urtax.ms.mff.cuni.cz
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
In-Reply-To: <1132782245.13095.4.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0511240418140.21316@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> 
 <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> 
 <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de> 
 <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de>  <438359D7.7090308@suse.de>
 <p7364qjjhqx.fsf@verdi.suse.de>  <1132764133.7268.51.camel@localhost.localdomain>
  <20051123163906.GF20775@brahms.suse.de>  <1132766489.7268.71.camel@localhost.localdomain>
  <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org>  <4384AECC.1030403@zytor.com>
  <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Nov 2005, Alan Cox wrote:

> On Mer, 2005-11-23 at 10:42 -0800, Linus Torvalds wrote:
>> Of course, if it's in one of the low 12 bits of %cr3, there would have to
>> be a "enable this bit" in %cr4 or something. Historically, you could write
>> any crap in the low bits, I think.
>
> There is a much much better way to do it than just user space and
> without hitting cr3/cr4 - put "lock works" in the PAT and while we'll
> have to add PAT support which we need to do anyway we would get a world
> where on uniprocessor lock prefix only works on addresse targets we want
> it to - ie pci_alloc_consistent() pages.

Given the CPU architecture it is unimplementable. Intructions are split
into microinstuctions and they are executed out of order. PAT is looked up
when LOAD microinstruction is executed. Imagine this

MOV EDX, [address1]
LOCK ADD [address2], EDX

that is translated to

LOAD EDX, [address1]
LOAD TMP1, [address2]
ADD TMP1, EDX
STORE [address2], TMP1

... now LOAD finds LOCK attribute in PAT --- so it locks the bus, however
EDX is still not loaded. Now LOAD EDX can't execute because the bus is
locked and ADD and STORE can't execute because they're waiting for LOAD
EDX. Deadlock.

Locks are so slow not because they are locks (if the target is in L1
cache, they operate only on cache and don't go to bus at all), but because
they need to flush completely microinstruction pool to avoid problems like
this. Of course Intel won't waste silicon in the execution engine for
instructions that execute so rarely, so they microcode them instead. So
lock detection is done at the decoder.

Mikulas

> Alan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
