Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbWBVR0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbWBVR0e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbWBVR0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:26:34 -0500
Received: from ns.suse.de ([195.135.220.2]:40160 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030317AbWBVR0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:26:33 -0500
To: Jan Beulich <jbeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: actively synchronize vmalloc area when registering certain callbacks
References: <200602221203.23561.jbeulich@novell.com>
From: Andi Kleen <ak@suse.de>
Date: 22 Feb 2006 18:26:29 +0100
In-Reply-To: <200602221203.23561.jbeulich@novell.com>
Message-ID: <p73y8032tkq.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Beulich <jbeulich@novell.com> writes:

> Registering a callback handler through register_die_notifier() is
> obviously primarily intended for use by modules. However, the way these
> currently get called it is basically impossible for them to actually be
> used by modules, as there is, on non-PAE configurationes, a good chance
> (the larger the module, the better) for the system to crash as a
> result. This is because the callback gets invoked
> (a) in the page fault path before the top level page table propagation
> gets carried out (hence a fault to propagate the top level page table
> entry/entries mapping to module's code/data would nest infinitly) and
> (b) in the NMI path, where nested faults must absolutely not happen,
> since otherwise the IRET from the nested fault re-enables NMIs,
> potentially resulting in nested NMI occurences.
> Besides the modular aspect, similar problems would even arise for in-
> kernel consumers of the API if they touched ioremap()ed or vmalloc()ed
> memory inside their handlers.
> 
> Signed-Off-By: Jan Beulich <jbeulich@novell.com>

The patch is relatively complicated, but it's such a nasty corner case
(thanks Jan for discovering that one) that could easily hit in kernel
users like kprobes too so I think it's it's good fix it. I did the corresponding
change on x86-64 too.

Actually I tried to simplify it, but failed.

Acked-by: Andi Kleen <ak@suse.de>
