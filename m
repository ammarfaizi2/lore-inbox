Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265724AbUHAPvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265724AbUHAPvj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 11:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265732AbUHAPvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 11:51:37 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:62643 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S265724AbUHAPvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 11:51:33 -0400
Date: Sun, 1 Aug 2004 17:51:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: secure computing for 2.6.7
Message-ID: <20040801155128.GG6295@dualathlon.random>
References: <20040801102231.GB6295@dualathlon.random> <E1BrHkZ-0004hd-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BrHkZ-0004hd-00@calista.eckenfels.6bone.ka-ip.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 04:55:47PM +0200, Bernd Eckenfels wrote:
> Personally I think it is better to keep that in the utsname.release. If you
> realy want to have an integer, then add it for easy parsing and allow it to
> have multiple parallel issuers:
> 
> For example like:
> 
> 2.6.9_XXX(linux26.3501,MM.123)

I think it's overkill to pollue the `uname -r` with that detail. The
`uname -r` is about the release version nothing else.

> where this has applied fix 3501 in the 2.6 branch and 123 according to
> vendor MM, so you do not need to understand vendors XXX schema. However I am

if all vendors uses different numbers (i.e. vendor MM.123) then I can as
well build the ugly database in function of the `uname -r`
vendorization, building a database of uname -r or a database of
MM/linux-26/whatever isn't going to be any different.

> not sure if you are willing to accept the fact, that backporters will then
> raise the level to a value you will only expect for more recent versions,
> i.e.:
> 
> 2.6.9(linux26.3501)
> -> security bug1 is discoverd and fixed
> 2.6.10pre1(linux26.3502)
> -> security bug2 is discoverd and fixed
> -> features are added
> 2.6.10(linux26.3503)
> 
> Now  somebody  decides to backport the bug1 fix:
> 
> 2.6.9-2(linux26.3502)
> 
> and the bug2 fix:
> 
> 2.6.9-3(linux26.3503) <- is level 3503 but does not have all 2.6.10 features?!
> 
> And it gets even more hairy: if only the bug2 fix is
> backported, how can an application state that it needs that (without
> impliciteley also reling on bug1 to be fixed)

note this isn't a build number (the features in 2.6.10 don't matter at
all, the only thing it matters is that all security bugs up to 3503 are
included). This would be kernel wide for 2.4, 2.2 and 2.6. If 2.6 has a
bug and 2.4 not, then 2.4 can bump the number without any other
modification. because this isn't a build number, there are very few
fixes that would require bumping the security_sequence number, so it's
not like we're going to ever see 3503 in our life. The last one that
would require bumping the sequence number was probably fnclex months
ago, previously there was mremap (mremap wasn't relevant for seccomp but
some app might want to know about it). the the only one relevant for
seccomp mode 1 was fnclex and the only previous one I can recall
relevant for seccomp was the mmx sniffing a few years ago.

If a vendor ships you a kernel with security_sequence 3502 but it misses
the _few_ needed bugfixes that are supposedly included in a kernel with
security sequence 3502, than such a vendor could as well ship you a
kernel with seccomp mode 1 doing nothing or if you prefer they could
ship a kernel with a bug in the tcp stack that gains root by sending an
escape sequence on the wire, you get the idea. Then you could just
prefer to change vendor and run a secure OS ;). I exclude that a vendor
could intentionally not want to backport all needed fixes that requires
bumping the sequence number.  And if they don't want to ship a "secure"
kernel they've simply not to touch the value of their security_sequence
and everything will work securely, they can just delete the rejects on
the sequence number modifications. You will definitely get a reject if
you apply a fix that bumps the sequence number and you miss the previous
fix that bumped the sequence number, so it can't go unnoticed (and
vendors are required to check rejects while applying patches). If
everyone bumps the number with security fixes this would actually _help_
increasing security, since even people self compiling kernels would
notice they miss some bugfix as they get the reject.

If people don't like the idea no problem, as worse I can build a
vendor-tuned security database in function of `uname -r` but it'll be
less secure and it'll be less finegrined than it could. I just thought a
sequence_number could be useful to something more than just knowing when
I can run safely in seccomp mode. Or if you prefer I can rename it to
seccomp_security_sequence, this way it would need a change only once
every few years at most and none of the kernel developers will have to
care about it and I'll take care to update it myself when needed (i.e.
ideally never ;).
