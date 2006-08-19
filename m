Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWHSERs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWHSERs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 00:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbWHSERs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 00:17:48 -0400
Received: from smtp-out.google.com ([216.239.45.12]:5054 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030235AbWHSERr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 00:17:47 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=FmqXsZ0OMltd1bFjShtkAwbYcgH77gEuwVuaslotTneJDHJ0+H8icOFgEtv9nuNQn
	GivzXyRyxH7qF4a52FnEQ==
Message-ID: <44E69011.4080604@google.com>
Date: Fri, 18 Aug 2006 21:14:09 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, riel@redhat.com, tgraf@suug.ch,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: Network receive stall avoidance (was [PATCH 2/9] deadlock prevention
 core)
References: <20060808211731.GR14627@postel.suug.ch>	<44DBED4C.6040604@redhat.com>	<44DFA225.1020508@google.com>	<20060813.165540.56347790.davem@davemloft.net>	<44DFD262.5060106@google.com>	<20060813185309.928472f9.akpm@osdl.org>	<1155530453.5696.98.camel@twins>	<20060813215853.0ed0e973.akpm@osdl.org>	<44E3E964.8010602@google.com>	<20060816225726.3622cab1.akpm@osdl.org>	<44E5015D.80606@google.com>	<20060817230556.7d16498e.akpm@osdl.org>	<44E62F7F.7010901@google.com>	<20060818153455.2a3f2bcb.akpm@osdl.org>	<44E650C1.80608@google.com> <20060818194435.25bacee0.akpm@osdl.org>
In-Reply-To: <20060818194435.25bacee0.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>>handwaving
> 
> - The mmap(MAP_SHARED)-the-whole-world scenario should be fixed by
>   mm-tracking-shared-dirty-pages.patch.  Please test it and if you are
>   still able to demonstrate deadlocks, describe how, and why they
>   are occurring.

OK, but please see "atomic 0 order allocation failure" below.

> - We expect that the lots-of-dirty-anon-memory-over-swap-over-network
>   scenario might still cause deadlocks.  
> 
>   I assert that this can be solved by putting swap on local disks.  Peter
>   asserts that this isn't acceptable due to disk unreliability.  I point
>   out that local disk reliability can be increased via MD, all goes quiet.
> 
>   A good exposition which helps us to understand whether and why a
>   significant proportion of the target user base still wishes to do
>   swap-over-network would be useful.

I don't care much about swap-over-network, Peter does.  I care about
reliable remote disks in general, and reliable nbd in particular.

> - Assuming that exposition is convincing, I would ask that you determine
>   at what level of /proc/sys/vm/min_free_kbytes the swap-over-network
>   deadlock is no longer demonstrable.

Earlier, I wrote: "we need to actually fix the out of memory
deadlock/performance bug right now so that remote storage works
properly."  It is actually far more likely that memory reclaim stuffups
will cause TCP to drop block IO packets here and there than that we
will hit some endless retransmit deadlock.  But dropping packets and
thus causing TCP stalls during block writeout is a very bad thing too,
I do not think you could call a system that exhibits such behavior a
particularly reliable one.

So rather than just the word deadlock, let us add "or atomic 0 order
alloc failure during TCP receive" to the challenge.  Fair?

On the client send side, Peter already showed an easily reproducable
deadlock which we avoid by using elevator-noop.  The bug is still
there, it is just under a different rock now.

Regards,

Daniel
