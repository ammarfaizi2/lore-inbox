Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266518AbUFVCGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266518AbUFVCGO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 22:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266531AbUFVCGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 22:06:14 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:718
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266518AbUFVCGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 22:06:12 -0400
Date: Tue, 22 Jun 2004 04:06:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: 4Front Technologies <dev@opensound.com>
Cc: David Lang <david.lang@digitalinsight.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040622020615.GE14478@dualathlon.random>
References: <40D232AD.4020708@opensound.com> <Pine.LNX.4.58.0406191148570.30038@zeus.compusonic.fi> <Pine.LNX.4.60.0406201506360.6470@dlang.diginsite.com> <40D636EA.7090704@opensound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D636EA.7090704@opensound.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 06:16:26PM -0700, 4Front Technologies wrote:
> You and others can keep suggesting that put the world+kitchen sink into the 
> kernel and have the problems go away but it's not realistic. Many drivers 
> are still maintained outside the kernel and you aren't providing a solution.

Breaking interfaces to drivers gratuitously would be insane, we're
breaking api to drivers only when we *have* to after thinking twice
about the problem and after excluding backwards compatible alternatives.
And normally the worst thing that can happen is that the driver doesn't
compile anymore.

Here I'm not talking about your buildsystem issue you run into, I'm
talking about true sourcelevel breakeage to kernel modules out of the
kernel that you may find too and that are more difficult to solve than
the buildsystem command already described in the readme.suse.

To make the last recent example we had to break the source API with the
drivers to fix the release_pages race that Andrew found and fixed in
mainline too. That changes page->count into page->_count and quite some
drivers broke even outside the kernel. I had the choice of not breaking
the API but that would had forced us to disable irq and take a per-zone
spinlock in every last put_page(), definitely not desiderable in a
enterprise OS where number matters. I appreciate the ability to fix
things right and to boost performance to the maximum whenever possible,
like it happens in the mainline kernel tree. I even had a lengthy
private discussion with Andrew and it was him suggesting me the
local_irq_disable + atomic_dec_and_lock as the only possible
alternative, but it wasn't attractive enough for performance reasons.
Furthermore in a few years people would be more annoyed by page->count
than by page->_count as people moves into more recent mainline releases.

At another time during 2.4 to support databases using >16G of ram and
running thousand of processes I had to break the pte_offset API to
create pte-highmem to avoid the pte to fill the whole lowmem zone and
run the box oom (luckily at around the same time vmalloc_to_page was
created too, so a more generic API that would work with mainline too
could be suggested to driver developers, and in turn even in this case
over time people should have been more confortable with vmalloc_to_page).

These things don't happen often, but they sometime have to happen and
it's good we can fix them right, unlike if we were shipping a
non-open-source OS that forced us to retain the same API to modules to
boot the machine and in turn to introduce ugly and slow hacks to
workaround bugs. These days the kernel is quite mature so hopefully they
won't happen anymore during stable cycles (I mean after 2.6.7 that
already had to break page->_count) but you never know.

NOTE: the source API with the kernel modules must not be confused with
the _binary_ ABI with userspace. the ABI with userspace is a completely
different matter.  The ABI with userspace (like syscalls) must be the
same for all linux versions. That is very important. The kernel API to
modules not being fixed is a feature and not a bug.
