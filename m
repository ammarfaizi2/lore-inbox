Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbTIZRFJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 13:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbTIZRFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 13:05:08 -0400
Received: from zero.aec.at ([193.170.194.10]:26887 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261489AbTIZRFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 13:05:03 -0400
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
From: Andi Kleen <ak@muc.de>
Date: Fri, 26 Sep 2003 19:04:30 +0200
In-Reply-To: <A317.6GH.7@gated-at.bofh.it> (David Mosberger's message of
 "Fri, 26 Sep 2003 17:50:09 +0200")
Message-ID: <m37k3viiqp.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <A2yd.64p.31@gated-at.bofh.it> <A2yd.64p.29@gated-at.bofh.it>
	<A317.6GH.7@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> writes:

> Why would that be?  Slower, yes, but very slow?

It depends on your architecture I guess. On K8/x86-64 it isn't that big
a deal (one cycle penalty for unaligned accesses), but if you take an
exception for each unaligned read it will be incredible slow. 

Of course the copy in the driver has the same problem, so it's not
much better. 

My point was basically that the header access are peanuts compared to
the unaligned copy. It would be much better to optimize the copy than
the header access. The proposal of just copying the header does not
address this. And copying the packet in the driver has the same problem,
so IMHO it's useless.

The solution proposed by Ivan sounds much better. The basic problem
is that the Ethernet header is not a multiple of 4 and that misaligns
everything after it. Use one receive descriptor for the MAC header and 
another for the rest (IP/TCP/payload) In the rest everything is aligned and 
there are no problems with misaligned data types (ignoring exceptional cases 
like broken timestamp options which can be handled slowly). Fixing the 
stack to handle separate MAC headers should not be that much work, the 
code is fairly limited. Drawback is that it requires bigger changes to the 
network drivers and maybe some special case code for non standard MAC
headers.

-Andi
