Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVKOOMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVKOOMW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 09:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVKOOMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 09:12:22 -0500
Received: from ns.suse.de ([195.135.220.2]:55178 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932391AbVKOOMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 09:12:22 -0500
Message-ID: <4379ECC1.20005@suse.de>
Date: Tue, 15 Nov 2005 15:12:17 +0100
From: Gerd Knorr <kraxel@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com> <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com> <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org> <4374FB89.6000304@vmware.com> <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org> <20051113074241.GA29796@redhat.com> <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 14 Nov 2005, Gerd Knorr wrote:
>> Throwing another patch into the discussion ;)
> 
> Ouch, this one is really ugly.

I somehow expected that answer, it took me quite some time to figure 
what the patch does.  It certainly needs at least a number of cleanups 
before I'd consider it mergable.  The alternative() macro is much easier 
to read.

> If you want to go this way, then you should instead add an X86_FEATURE_SMP 
> that gets cleared on UP and on SMP with just one core (and detect when CPU 
> hotplug ain't gonna happen ;), and then do

Well, the "no hotplug" probably is exactly the reason why the patch 
doesn't use the existing alternatives mechanism, it's a boot-time 
one-way ticket.  The xenified linux kernel actually switches both ways 
at runtime if you plug in/out a second virtual CPU.

> 	#ifdef CONFIG_SMP
> 	#define smp_alternative(x,y) alternative(x,y,X86_FEATURE_SMP)
> 	#else
> 	#define smp_alternative(x,y) asm(x)
> 	#endif

I don't like the idea very much.  That covers only 50% of what the patch 
does, you can patch SMP => UP but not the other way around.  Doesn't 
matter much on real hardware, but for virtual it is quite useful.

> or something similar, instead of creating a totally new infrastructure to 
> do the thing that "alternative()" already does.

Yep, extending alternatives is probably better than duplicating the 
code.  Maybe having some alternative_smp() macro which places both code 
versions into the .altinstr_replacement table?  If that sounds ok I'll 
try to come up with a experimental patch.  If not: other ideas are welcome.

cheers,

   Gerd

