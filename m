Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266071AbUFWCFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266071AbUFWCFR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 22:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266075AbUFWCFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 22:05:17 -0400
Received: from holomorphy.com ([207.189.100.168]:39808 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266071AbUFWCFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 22:05:08 -0400
Date: Tue, 22 Jun 2004 19:05:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, rddunlap@osdl.org, akpm@osdl.org
Subject: Re: [profile]: [0/23] mmap() support for /proc/profile
Message-ID: <20040623020506.GA1832@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
	rddunlap@osdl.org, akpm@osdl.org
References: <0406220816.1a3aYaLbLbXaKbKb1aWa4a1a3a2a3aIb2a0aZaWaHb4aXaXaZa1aKbZaWa5aHb3a15250@holomorphy.com> <20040622231646.GA17387@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040622231646.GA17387@krispykreme>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 09:16:46AM +1000, Anton Blanchard wrote:
> Interesting stuff. FYI we did some analysis of the hottest addresses in
> the kernel and profile_lock featured very high up:
> void profile_hook(struct pt_regs * regs)
> {
>         read_lock(&profile_lock);
>         notifier_call_chain(&profile_listeners, 0, regs);
>         read_unlock(&profile_lock);
> }
> Thats 2 atomic operations to the same cacheline per timer interrupt per
> cpu. Considering how rarely timer based profiling is used, perhaps RCU
> or even just a profiling_enabled sysctl flag would help here. Id prefer
> not to compile it out in distro kernels if possible, its a very useful
> feature when required.
> In the mean time, how about this quick fix?

Well, this is a little different. I was more concerned about the
"Heisenberg effect" that the in-kernel copies to fetch profiling data
had upon the data fetched. i.e. instead of idle time and the stuff I
was looking for, I saw copy_to_user() and all kinds of vfs and /proc/
crap instead, which blew what I was looking for completely out of the
top 20. The profiling I did was on UP, which was done in part to
eliminate lock contention as the cause of the phenomena I had observed.

Also, Randy said I should mention that my kerneltop-like thingie is
about 5 times faster (well, uses about 20% of the cpu time) as the
read()-based kerneltop. Which is all well and good, but the reason I
actually needed this was to get rid of the Heisenberg problem.


-- wli
