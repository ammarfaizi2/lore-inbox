Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264946AbUELCod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264946AbUELCod (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 22:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264952AbUELCoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 22:44:32 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:22686
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264946AbUELCo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 22:44:28 -0400
Date: Wed, 12 May 2004 04:44:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       Wim Coekaerts <wim.coekaerts@oracle.com>, Andrew Morton <akpm@osdl.org>,
       cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040512024425.GV3829@dualathlon.random>
References: <20040510231146.GA5168@taniwha.stupidest.org> <20040510162818.376b4a55.akpm@osdl.org> <20040510233342.GA5614@taniwha.stupidest.org> <20040510165132.5107472e.akpm@osdl.org> <20040510235312.GA9348@taniwha.stupidest.org> <20040510171413.6c1699b8.akpm@osdl.org> <20040511002426.GD1105@ca-server1.us.oracle.com> <20040510181008.1906ea8a.akpm@osdl.org> <20040511015118.GA4589@ca-server1.us.oracle.com> <20040511072329.D12187@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040511072329.D12187@infradead.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 07:23:29AM +0100, Christoph Hellwig wrote:
> On Mon, May 10, 2004 at 06:51:18PM -0700, Wim Coekaerts wrote:
> > > err, so why did I just merge the hugetlb_shm_group patch?
> > 
> > because of what you mentioned. it takes a long time before that goes
> > out, it's not even tested, and it doesn't apply to those 1000's of
> > existing systems taht will break on upgrade.   exactly what you said, it
> > makes it possible to get to a different way smoothly in time. my
> > comments were not "we can use it today".
> 
> So it's a hack for legacy oracle versions.  nice.  and for that we
> introduce completely alien concepts like magic groups into the kernel..

I don't see why we're trying to complicate the simple things.

I posted a disable_cap_mlock patch several weeks ago, that's the only
needed thing.

Even if there's an attacker on the machine with disable_cap_mlock == 1,
the attacker won't be able to exploit anything, it can only generate a
DoS. The cap-mlock is clearly not nearly as security-critical as most
other capabilities.

There's no reason to get the "hack" any smarter than the disable_cap_mlock
approch, any sysctl will be still an hack anyways. The group thing and
the differentiation between hugetlbfs users and mlock users (like
SHM_LOCK) is a mere attempt to make it more secure, but if you can
change the disable_cap_mlock sysctl from 0 to 1 you for sure can also
change the hugetlb_shm_group from 0 to 500 and the same for the
mlock_group too.  Plus I can want to give mlock to the whole system at
the same time, not just to a single group, and for that
disable_cap_mlock is appropriate.

I'm quite confortable to say that disable_cap_mlock can be dropped in
2.8, by that time a replacement solution will be implemented and I don't
expect any application learning about the disable_cap_mlock name, they
really shouldn't, only the bootup procedure of the OS will know about it
and only the login/su will learn about the future replacement.

So I believe the best "hack" is to use the simple disable_cap_mlock and
to concentrate all the efforts on a more flexible solution involving
userspace changes. The one suggested by Andrew by simply dropping the
capabilities in login and su sounded very appealing to me.
