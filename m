Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTHBLzj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 07:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTHBLzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 07:55:39 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:38579 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S262093AbTHBLzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 07:55:37 -0400
Message-ID: <3F2BA671.4070800@sun.com>
Date: Sat, 02 Aug 2003 12:54:25 +0100
From: Calum Mackay <calum.mackay@sun.com>
Organization: Sun Microsystems
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030802 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Calum Mackay <calum.mackay@cdmnet.org>, marcelo@conectiva.com.br,
       mitch.dsouza@sun.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  2.4: export the symbol "mmu_cr4_features" for XFree86
 DRM kernel drivers
References: <3F2A62A2.mailx3G211O2B4@cdmnet.org> <20030801141445.A8186@infradead.org>
In-Reply-To: <20030801141445.A8186@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> Can you explain why they need it and why they magically need it
> because of vmap() ?

Sorry, of course.

[as Mitch has already pointed out privately] e.g the XFree86 DRM radeon 
Makefile includes this:

[xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/Makefile.linux]

	# Check for 4-argument vmap() in some 2.5.x and 2.4.x kernels
	VMAP := $(shell grep -A1 'vmap.*count,$$' 
$(LINUXDIR)/include/linux/vmalloc.h | grep -c prot)

	ifneq ($(VMAP),0)
	EXTRA_CFLAGS += -DVMAP_4_ARGS
	endif

Christoph's vmap() backport introduced this reference in 
linux/vmalloc.h, so the DRM module is now compiled with VMAP_4_ARGS defined.

The radeon kernel driver source includes (via drm_memory.h) 
linux/vmalloc.h, iff VMAP_4_ARGS is defined. The latter includes (on 
i386) asm/asm-i386/pgtable.h, which includes asm/asm-i386/processor.h.

processor.h defines some inline functions [set_in_cr4() & 
clear_in_cr4()] which reference mmu_cr4_features.

mmu_cr4_features is currently declared in arch/i386/kernel/setup.c [and 
also arch/x86_64/kernel/setup.c] but not currently exported.

[The problem is not restricted to the radeon kernel driver; I've just 
used it as an example]

cheers,
Calum.

