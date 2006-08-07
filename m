Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWHGW1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWHGW1u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 18:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWHGW1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 18:27:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49059 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932128AbWHGW1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 18:27:50 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Andi Kleen <ak@suse.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	<20060807085924.72f832af.rdunlap@xenotime.net>
	<m1wt9kcv2n.fsf@ebiederm.dsl.xmission.com>
	<20060807105537.08557636.rdunlap@xenotime.net>
	<m1psfcbcnk.fsf@ebiederm.dsl.xmission.com>
	<20060807194047.GM3691@stusta.de>
Date: Mon, 07 Aug 2006 16:26:07 -0600
In-Reply-To: <20060807194047.GM3691@stusta.de> (Adrian Bunk's message of "Mon,
	7 Aug 2006 21:40:48 +0200")
Message-ID: <m1mzag9o8w.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> On Mon, Aug 07, 2006 at 12:53:35PM -0600, Eric W. Biederman wrote:
>>...
>> --- a/arch/x86_64/Kconfig
>> +++ b/arch/x86_64/Kconfig
>> @@ -384,6 +384,20 @@ config NR_CPUS
>>  	  This is purely to save memory - each supported CPU requires
>>  	  memory in the static kernel configuration.
>>  
>> +config NR_IRQS
>> +	int "Maximum number of IRQs (224-57344)"
>
> 	int "Maximum number of IRQs (224-57344)" depends on SMP
>
> This way, people with SMP=n will not see this question.

I doubt it will be interesting but it might be, it is certainly
well defined what happens when you have more irqs that a cpu
has irq destinations.

>> +	range 224 57344
>> +	default "4096" if SMP
>> +	default "224" if !SMP
>
> Why not always
>          default "224"
> ?

A couple of reasons.
- Things still need shaking out at the > 256 irq level and since
  this is going into -mm it is reasonable to have a large default.

- It is silly to have a default that won't work on some hardware,
  that we can support without unreasonable overhead.

- There are major simplicity gains to be had from a slight sparse
  irq space.

- I haven't a clue what the irq numbers look like in the real world
  that we should be supporting since there was code in x86_64 and
  i386 to hack them up terribly.  All I have a clue about are
  the really big machines.  So I wouldn't be surprised if there
  were some small but I/O heavy machines that found 224 too limiting.
  I know of at least one uniprocessor machine that would have used
  almost all 224 irqs.

- I want people to realize that we can easily have more than 256 irqs.
  With pure software interrupt sources and networking drivers allocating
  one irq per cpu the chances of us using our maximum allotment of irqs
  is much more likely in the next couple of years.

- 4096 is the number I expect distribution vendors will ship.  Why set
  a different default than what you expect most people will use?

Eric
