Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266484AbUHBKbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266484AbUHBKbt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 06:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266458AbUHBKYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 06:24:55 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:20867 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S266469AbUHBKTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 06:19:46 -0400
Date: Mon, 2 Aug 2004 12:19:05 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: secure computing for 2.6.7
Message-ID: <20040802101905.GJ6295@dualathlon.random>
References: <2ejhQ-4lc-5@gated-at.bofh.it> <2fqhq-1RU-45@gated-at.bofh.it> <2olLt-4wI-5@gated-at.bofh.it> <m3ekmq2ym7.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3ekmq2ym7.fsf@averell.firstfloor.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Mon, Aug 02, 2004 at 02:05:20AM +0200, Andi Kleen wrote:
> I don't think a sequence number is a good idea. Consider a
> vendor/third party kernel fixing a security bug, but mainline hasn't
> taken the patch yet for some reason.

does this really happen? The thing I'm thinking about here is the fnclex
and f00f kind of bugs. Or even worse ones. Those bugs area _always_
fixed in mainline too. Maybe I should simply rename it to
seccomp_security_sequence instead so nobody has to touch it for years
(ideally forever ;).

Also note, not increasing the sequence number isn't fatal, false
positives are fine, what I cannot accept are false negatives. So if
mainline didn't issue the new number yet, nobody would be forced to
increase that number. As far as I'm concerned (for my usage) I would
take care of pushing the fix into mainline myself, so I'm not worried
about mainline not including the security fixes.

This is all about disaster recovery, it doesn't necessairly need to be
efficient if the thing is difficult to fix (like workarounding future
nasty hardware bugs, which may take time), it only must be safe. Even if
mainline increases the number after months I don't mind as far as no
false negatives are generated.

For relatively easy things like fnclex that didn't clear the exceptions,
vendor-sec would be the place assigned to increase the numbers so that
new kernels would be synchronized and released with a new number all at
the same time (including mainline).

> The vendor kernel could not safely increase this number, because it 
> could conflict with some other security bug fixed in mainline at the 
> same time. 

Yep. But the vendor kernel isn't forced to increase it, as far as it
doesn't create false negatives that's fine, it's not that urgent to
increase it.

> A safe solution would be a file in /proc that lists CAN idenitifiers of
> fixed bugs or similar, but that may be quite some overhead to maintain
> and parse.

this would be perfectly fine too, the only bad thing is the wasting of
kernel memory for that. 1 byte of securty_sequence was a minor issue. If
we go this way, then we should be build knowledge into the boot process
so that this information is dumped into /var/log/kernel_security as
world readable during boot time, and then released from the kernel (this
shouldn't be too difficult to implement).

building the `uname -r` universal vendor database for every possible
distro version is doable too, I don't strictly need to add this
security_sequence (or even better a CAN list to dump in a
kernel_security directory), but I feel much safer (and I'd be a lot
simpler) in having a vendor neutral standard way to check if the kernel
is secure enough to run stuff in seccomp mode than to relay on `uname
-r` checks.
