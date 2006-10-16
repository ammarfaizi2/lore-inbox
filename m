Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161236AbWJPJ4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161236AbWJPJ4x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 05:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161254AbWJPJ4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 05:56:53 -0400
Received: from cantor.suse.de ([195.135.220.2]:48847 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161236AbWJPJ4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 05:56:52 -0400
From: Andi Kleen <ak@suse.de>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [patch 8/8] stacktrace filtering for fault-injection capabilities
Date: Mon, 16 Oct 2006 11:31:39 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Don Mullis <dwm@meer.net>,
       Valdis.Kletnieks@vt.edu, jbeulich@novell.com
References: <20061010115219.176309702@gmail.com> <20061010115219.176309702@gmail.com>> <20061010115255.902380817@gmail.com>>
In-Reply-To: <20061010115255.902380817@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610161131.39210.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Index: work-fault-inject/lib/Kconfig.debug
> ===================================================================
> --- work-fault-inject.orig/lib/Kconfig.debug
> +++ work-fault-inject/lib/Kconfig.debug
> @@ -401,6 +401,8 @@ config LKDTM
>  
>  config FAULT_INJECTION
>  	bool
> +	select STACKTRACE
> +	select FRAME_POINTER

I'm afraid this won't work fully reliably on i386/x86-64 at least. The problem 
is that if even with frame pointers the new unwinder will try its unwinding
first and if it gets stuck it will log the fallback entries into the stack
trace buffer too. And those fallback entries can be randomly everything left over
from previous stack traces. Then the fault injection will be more
like Russian roulette and could randomly hit other code paths too.

To make this work there would need to be some way to turn off fallback
for these particular stack traces. 

Or maybe just always use frame pointer
there, but even that will likely not help because the few places
where the dwarf2 unwinder still gets stuck (usually assembly code) 
are usually broken with frame pointers too.

-Andi

