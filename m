Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313128AbSDDKZr>; Thu, 4 Apr 2002 05:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313130AbSDDKZi>; Thu, 4 Apr 2002 05:25:38 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:61702 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S313128AbSDDKZU>;
	Thu, 4 Apr 2002 05:25:20 -0500
Date: Thu, 4 Apr 2002 11:22:15 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: <tigran@einstein.homenet>
To: Keith Owens <kaos@ocs.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules... 
In-Reply-To: <22511.1017902599@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.33.0204041041530.1475-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Keith Owens wrote:
> When the flamers and lawyers agree on what they really mean by
> EXPORT_SYMBOL_GPL or its replacement and everybody agrees on what the
> keyword should be, let me know and I will roll a new modutils.
> Otherwise, leave me out of this flamewar.

Let's look at the possible design for 2.5 first, then 2.4.

The meaning of EXPORT_SYMBOL_INTERNAL is that it can be used to export
symbols by base kernel subsystems (static or modular) to other base kernel
subsystems which can be compiled as a module. So, if the symbol is thus
exported by what is thought of as "base kernel" then only modules that
claim to be "base kernel" should use it. Similarly, if it is exported by a
driver, then only modules closely associated with that driver (for drivers
split in multiple modules) should be able to use it.

In other words, exporting symbols should not be based on the consumer's
license because that is technically inappropriate criterion.

As for implementation, perhaps EXPORT_SYMBOL_INTERNAL could look like:

EXPORT_SYMBOL_INTERNAL(runqueue_lock, "scheduler");

and the corresponding module that implements a "scheduler" can claim its
rights by:

MODULE_CLASS("scheduler");

A module should be able to belong to multiple classes, of course, i.e. it
could provide both "scheduler" to get runqueue_lock and "filesystem" to
get register_filesystem().

So, modutils would check module's classes and resolve or deny the
corresponding symbol. And EXPORT_SYMBOL(sym) would mean "disable class
check by modutils for this symbol".

I am not suggesting to throw away MODULE_LICENSE from .modinfo, only that
it should have nothing to do with exporting symbols (i.e. it should be
like author/description etc fields).

Now, all the above does not look like 2.4 matter, it should probably be
implemented in 2.5. As for 2.4 perhaps it should be a simple matter of
changing the actual name EXPORT_SYMBOL_GPL to EXPORT_SYMBOL_INTERNAL which
would place INTERNAL_ instead of GPLONLY_ in .kstrtab. And the thing that
would link with it in the module should not be MODULE_LICENSE but be a
new macro:

MODULE_SYMBOLS_INTERNAL;

A module that doesn't make any special claims (for compatibility) gets
only those exported by EXPORT_SYMBOL, whilst a module that claims access
to MODULE_SYMBOLS_INTERNAL gets also those exported by
EXPORT_SYMBOL_INTERNAL.

There should be no "licensing implications" but simply the (documented)
fact that if a proprietary module writer is stupid enough to make a
MODULE_SYMBOLS_INTERNAL claim his module will break far more often both
with respect to existence _and_ semantics/implemention of those entries
exported only "internally". But that is their own problem -- we should
neither help them nor prevent them from doing their work and earning their
living. That is my opinion. If the vendor has so many resources to spend
on monitoring Linux kernel development (and therefore inevitably getting
involved and _helping_ with it!) to stay uptodate with every
implementation of internal symbols, then that is fine -- so much the
better for Linux. But if they want to write stable and maintainable
modules then they will never put MODULE_SYMBOLS_INTERNALS. We should
be always convincing proprietary software writers by our technical
superiority rather than by making their lives tough based on a whim of
whoever chooses which license to allow exporting his symbol to.

Simple, ethical and makes everyone happy, or, at least those who
understand that the design of a Unix-like operating system should be
driven by technical superiority rather than by using marketroid's weapons
against them (he who lifts up the sword shall fall by the sword).

Regards,
Tigran

