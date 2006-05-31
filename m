Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbWEaWWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbWEaWWI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 18:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbWEaWWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 18:22:08 -0400
Received: from smtp-out.google.com ([216.239.45.12]:53377 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965153AbWEaWWH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 18:22:07 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=FcaJ5D00tMgY1kzT2KPdkZpIS2J4GTuwGpU5B39LJfaO8FDxuL9mf1oiZqSnwoNub
	SslPKwxetdX1/w6f4orNQ==
Message-ID: <447E16E6.7020804@google.com>
Date: Wed, 31 May 2006 15:21:26 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
References: <447DEF47.6010908@google.com> <20060531140823.580dbece.akpm@osdl.org> <20060531211530.GA2716@elte.hu> <447E0A49.4050105@mbligh.org> <20060531213340.GA3535@elte.hu> <447E0DEC.60203@mbligh.org> <20060531215315.GB4059@elte.hu> <447E11B5.7030203@mbligh.org> <20060531221242.GA5269@elte.hu>
In-Reply-To: <20060531221242.GA5269@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>OK. So what's the perf impact of the new version on a 32 cpu machine? 
>>;-) Maybe it's fine, maybe it's not.
> 
> 
> no idea, but it shouldnt be nearly as bad as say SLAB_DEBUG.

The "no idea" is hardly reassuring ;-)
The latter point is definitely valid though, it's not an isolated issue.

>>>i'm wondering, why doesnt your config have DEBUG_MUTEXES disabled? Then 
>>>'make oldconfig' would pick it up automatically.
>>
>>Because it builds off the same config file all the time. It was 
>>created before CONFIG_MUTEXES existed ... creating a situation where 
>>we have to explicitly disable new options all the time becomes a 
>>maintainance nightmare ;-(
> 
> 
> hm, why? Dont you disable DEBUG_SLAB? [that's a default y option too, 
> and in your config it's disabled]
> 
> a oneliner script:
> 
>  sed -i 's/CONFIG_MUTEX_DEBUGGING=y/# CONFIG_MUTEX_DEBUGGING is not set'
> 
> ought to do it, unless i'm missing something.

because it's not maintainable in a fully automated system over time.

> Really, there's an unfortunate friction of interests here:
> 
> on one side, the -mm kernel is about showcasing new code and finding 
> bugs in them as fast as possible. Having new debugging options enabled 
> by default is an important part of the testing effort. Users will care 
> more about having no crashes than about having 0.5% more performance in 
> select benchmarks.
> 
> on the other side, you obviously dont want a 0.5% overhead for select 
> benchmarks, as that would mess up the history! A very fair and valid 
> position too.
> 
> but one side has to give, we cant have both.

Above is a good description of the problem - I really want to get as
much debugging stuff done automatically as possible. However, we can
have both. We just need to do both runs, with an option to turn
whatever the random debug options of the day on or off are. Something
that won't change over time. CONFIG_DEBUG itself would seem ideal,
except it kills lots of standard things like CONFIG_DEBUG_INFO,
alt+sysrq support, and probably KALLSYMS and a few other things I
forget. Need CONFIG_DEBUG_AFFFECTS_PERFORMANCE or something.

>>If we don't want to do performance regression checking on -mm, that's 
>>fine, but I thought it was useful (has caught several things already).
>
> please dont misunderstand my position as being against your efforts - to 
> the contrary, your performance regression testing has proven to be 
> valuable numerous times! But you are a single intelligent person whom i 
> can possibly talk into adding some scripting to ensure that certain 
> options stay off in the .config - but i cannot cat-herd the many -mm 
> testers on the other hand to all enable the debug options ;-) So i'm 
> kind of forced trying to convince you - i cannot convince the basic 
> human testing nature of keeping the defaults ;-)

Is all good, is just frustrating on occcasion, sorry ;-) The problem is
that especially in a remote, distributed system, it's impossible to
maintain a continually changing set of config options for this over
time. If we can get one option to flick off all the perf invasive
stuff, that's a single change. If we have to add CONFIG_SLAB last week,
CONFIG_DEBUG_MUTEX this week, and CONFIG_LOCK_DEBUG_STUFF next week,
that gets much, much harder to maintain.

Hopefully that makes some sort of sense. Sorry, I realise the
requirements are a little strange, but I really think we have to
get testing automated or it just does not happen. The last round
affected Intel, etc as well doing benchmarking.

Adding new runs is easy. Changing the harness is hard ;-)

M.
