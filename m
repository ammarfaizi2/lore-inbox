Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289922AbSAWRP3>; Wed, 23 Jan 2002 12:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289918AbSAWRPR>; Wed, 23 Jan 2002 12:15:17 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:29645 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S289907AbSAWROg>; Wed, 23 Jan 2002 12:14:36 -0500
From: <benh@kernel.crashing.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        "David S. Miller" <davem@redhat.com>
Cc: <drobbins@gentoo.org>, <linux-kernel@vger.kernel.org>, <andrea@suse.de>,
        <alan@redhat.com>, <akpm@zip.com.au>, <vherva@niksula.hut.fi>,
        <lwn@lwn.net>, <paulus@samba.org>
Subject: Re: Athlon/AGP issue update
Date: Wed, 23 Jan 2002 18:14:19 +0100
Message-Id: <20020123171419.29358@mailhost.mipsys.com>
In-Reply-To: <200201231631.g0NGVcS426406@saturn.cs.uml.edu>
In-Reply-To: <200201231631.g0NGVcS426406@saturn.cs.uml.edu>
X-Mailer: CTM PowerMail 3.1.1 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>AGP might be non-coherent. If so, then the CPU should use a
>non-coherent mapping to avoid useless memory bus traffic.
>User code has access to some cache control instructions,
>so one may mark the memory cacheable for better performance
>even when it is non-coherent. ("flush when you're done")

That's unfortunately not enough. The mapping of the page to
userland and the in-kernel mapping of the AGP aperture are done
with non-cacheable attribute. _BUT_, that same memory is also
mapped as part of the RAM linear mapping of the kernel (the
BAT mapping on PPC). The problem happens when some code working
near the end of a different page via this linear mapping cause
a speculative access to happen on the next page. This will have
the side-effect of loading the cache with a line from the page
used by AGP.

I think PPC does only speculative reads, but even those (non dirty
cache lines) may cause trouble in our case.

Now, we have to check if the PPC is allowed to do speculative
reads accross page boundaries. If it's the case, then we are screwed
and I will have to cleanup the code allowing the kernel to run without
the BAT mapping (with a performance impact unfortunately).

Ben.



