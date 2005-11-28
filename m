Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVK1Tus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVK1Tus (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 14:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVK1Tus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 14:50:48 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:2506 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932217AbVK1Tur
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 14:50:47 -0500
Message-ID: <438B600C.1050604@tmr.com>
Date: Mon, 28 Nov 2005 14:52:44 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
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
References: <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214835.GA24044@nevyn.them.org> <Pine.LNX.4.64.0511231416490.13959@g5.osdl.org> <20051123222056.GA25078@nevyn.them.org> <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 23 Nov 2005, Daniel Jacobowitz wrote:
> 
>>Why should we use a silicon based solution for this, when I posit that
>>there are simpler and equally effective userspace solutions?
> 
> 
> Name them.
> 
> In user space, doing things like clever run-time linking things is 
> actually horribly bad. It causes COW faults at startup, and/or makes the 
> compiler have to do indirections unnecessarily.  Both of which actually 
> make caches less effective, because now processes that really effectively 
> do have exactly the same contents have them in different pages.
> 
> The other alternative (which apparently glibc actually does use) is to 
> dynamically branch over the lock prefixes, which actually works better: 
> it's more work dynamically, but it's much cheaper from a startup 
> standpoint and there's no memory duplication, so while it is the "stupid" 
> approach, it's actually better than the clever one.
> 
> The third alternative is to know at link-time that the process never does 
> anything threaded, but that needs more developer attention and 
> non-standard setups, and you _will_ get it wrong (some library will create 
> some thread without the developer even realizing). It also has the 
> duplicated library overhead (but at least now the duplication is just 
> twice, not "each process duplicates its own private pointer")
> 
> In short, there simply isn't any good alternatives. The end result is that 
> thread-safe libraries are always in practice thread-safe even on UP, even 
> though that serializes the CPU altogether unnecessarily.
> 
> I'm sure you can make up alternatives every time you hit one _particular_ 
> library, but that just doesn't scale in the real world.
> 
> In contrast, the simple silicon support scales wonderfully well. Suddenly 
> libraries can be thread-safe _and_ efficient on UP too. You get to eat 
> your cake and have it too.

I believe that a hardware solution would also accomodate the case where 
a program runs unthreaded for most of the processing, and only starts 
threads to do the final stage "report generation" tasks, where that 
makes sense. I don't believe that it helps in the case where init uses 
threads and then reverts to a single thread for the balance of the task. 
I can't think of anything which does that, so it's probably a 
non-critical corner case, or something the thread library could correct.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
