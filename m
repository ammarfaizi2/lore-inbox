Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWH1TQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWH1TQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 15:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWH1TQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 15:16:56 -0400
Received: from mail.suse.de ([195.135.220.2]:40898 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751374AbWH1TQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 15:16:55 -0400
To: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RBP save and restore on x86-64 system calls
References: <3B326087ABEA7940953BF629CAA40E17035BE455@azsmsx402>
From: Andi Kleen <ak@suse.de>
Date: 28 Aug 2006 21:16:53 +0200
In-Reply-To: <3B326087ABEA7940953BF629CAA40E17035BE455@azsmsx402>
Message-ID: <p733bbg7jru.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hanson, Jonathan M" <jonathan.m.hanson@intel.com> writes:

> 	This may not be a kernel question per se but I was hoping someone on
> this list might be able to shed some light into where RBP is saved to on an
> x86-64 system when a non-tracing system call is made.

It might not be saved at all. The entry code relies on the C ABI
of the kernel code to save it somewhere or just not clobber it.

> 	An ioctl() triggers my kernel module and I need to have a way to
> reliably retrieve what RBP was immediately before the system call. RBP is
> not saved on the process' stack on kernel entry. The code in entry.S says
> that it's up to the C code (which I'm taking to mean glibc)

No, it's the kernel C code. RBP isn't callee clobbered register
so it's not saved.

What you can do is to use the new dwarf2 unwinder that will be in 2.6.18.
It can figure out all the register contents for you if you unwind until
it hits user space. This will require a kernel built with CONFIG_STACK_UNWIND.

There are also still some quirks with it, but for ioctls it should
work.

-Andi
