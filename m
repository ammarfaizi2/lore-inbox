Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUCEKcK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 05:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbUCEKcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 05:32:10 -0500
Received: from mx1.elte.hu ([157.181.1.137]:16066 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261786AbUCEKcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 05:32:07 -0500
Date: Fri, 5 Mar 2004 11:33:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zaitsev <peter@mysql.com>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de, riel@redhat.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040305103308.GA5092@elte.hu>
References: <20040228072926.GR8834@dualathlon.random> <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com> <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078371876.3403.810.camel@abyss.local>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zaitsev <peter@mysql.com> wrote:

> > > For Disk Bound workloads (200 Warehouse) I got 1250TPM for "hugemem" vs
> > > 1450TPM for "smp" kernel, which is some 14% slowdown.
> > 
> > Please define these terms.  What is the difference between "hugemem" and
> > "smp"?
> 
> Sorry if I was unclear.  These are suffexes from RH AS 3.0 kernel
> namings.  "SMP" corresponds to normal SMP kernel they have, "hugemem"
> is kernel with 4G/4G split.

the 'hugemem' kernel also has config_highpte defined which is a bit
redundant - that complexity one could avoid with the 4/4 split. Another
detail: the hugemem kernel also enables PAE, which adds another 2 usecs
to every syscall (!). So these performance numbers only hold if you are
running mysql on x86 using more than 4GB of RAM. (which, given mysql's
threaded design, doesnt make all that much of a sense.)

But no doubt, the 4/4 split is not for free. If a workload does lots of
high-frequency system-calls then the cost can be pretty high.

vsyscall-sys_gettimeofday and vsyscall-sys_time could help quite some
for mysql. Also, the highly threaded nature of mysql on the same MM
which is pretty much the worst-case for the 4/4 design. If it's an
issue, there are multiple ways to mitigate this cost.

but 4/4 is mostly a life-extender for the high end of the x86 platform -
which is dying fast. If i were to decide between some of the highly
intrusive architectural highmem solutions (which all revolve about the
concept of dynamically mapping back and forth) and the simplicity of
4/4, i'd go for 4/4 unless forced otherwise.

	Ingo
