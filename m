Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbVKWSnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVKWSnP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVKWSnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:43:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37077 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932145AbVKWSnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:43:14 -0500
Date: Wed, 23 Nov 2005 10:42:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
In-Reply-To: <4384AECC.1030403@zytor.com>
Message-ID: <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> 
 <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> 
 <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de> 
 <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de>  <438359D7.7090308@suse.de>
 <p7364qjjhqx.fsf@verdi.suse.de>  <1132764133.7268.51.camel@localhost.localdomain>
  <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain>
 <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Nov 2005, H. Peter Anvin wrote:
>
> Linus Torvalds wrote:
> > What I suggested to Intel at the Developer Days is to have a MSR (or, better
> > yet, a bit in the page table pointer %cr0) that disables "lock" in _user_
> > space. Ie a lock would be a no-op when in CPL3, and only with certain
> > processes.
> 
> You mean %cr3, right?

Yes. 

It _should_ be fairly easy to do something like that - just a simple 
global flag that gets set and makes CPL3 ignore lock prefixes. Even timing 
doesn't matter - it it takes a hundred cycles for the setting to take 
effect, we don't care, since you can't write %cr3 from user space anyway, 
and it will certainly take a hundred cycles (and a few serializing 
instructions) until we get to CPL3.

I'd personally prefer it to be in %cr3, since we'd have to reload it on 
task switching, and that's one of the registers we load anyway. And it 
would make sense. But it could be in an MSR too.

Of course, if it's in one of the low 12 bits of %cr3, there would have to 
be a "enable this bit" in %cr4 or something. Historically, you could write 
any crap in the low bits, I think.

		Linus
