Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWERPcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWERPcI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWERPcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:32:07 -0400
Received: from cantor.suse.de ([195.135.220.2]:53963 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751356AbWERPcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:32:06 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH 1/3] reliable stack trace support
Date: Thu, 18 May 2006 17:32:01 +0200
User-Agent: KMail/1.9.1
Cc: "Jan Beulich" <jbeulich@novell.com>, linux-kernel@vger.kernel.org
References: <4469FC07.76E4.0078.0@novell.com> <200605161704.15028.ak@suse.de> <446C95CD.76E4.0078.0@novell.com>
In-Reply-To: <446C95CD.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605181732.01602.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 May 2006 15:42, Jan Beulich wrote:
> >> +#ifdef CONFIG_STACK_UNWIND
> >> +#include <asm/unwind.h>
> >> +#else
> >> +#include <asm-generic/unwind.h>
> >> +#endif
> >
> >Normally the other archs should get stub includes that include asm-generic/unwind.h
> 
> This would make them appear kind of supporting unwind, even though they really don't, wouldn't it?

Stubs or something calling the normal unwinder are fine.


> >> +#define DW_CFA_nop                          0x00
> >
> >I guess it would be useful to have them in some include.
> >Maybe linux/dwarf2.h ?
> 
> Do you think they might be re-used by anyone else? I generally prefer keeping stuff used only in a single place out of
> sight for anyone else.

At some point they will probably, but ok - keep them private for now.

> >In general please replace all uintN_t with uN 
> 
> Why that? What are these types for then? After all, they're standard mandated, and one more of my preferences is to use
> standard types where-ever possible.

Linux is not written in ISO-C, it's Linux C. And in that uN types are used, not uintN_t

> 
> >> +
> >> +static struct unwind_table *
> >> +find_table(unsigned long pc)
> >
> >Should be on one line. More further down.
> 
> Make the code uglier in my opinion, especially when the parameter declarations are quite long.

Well it's like this all over the kernel. You can run Lindent if you prefer, but
usually it takes more work to clean up after it. It's also part of that "Linux C" thing.
 
> >> +				atomic_inc(&table->users);
> >> +				break;
> >> +			}
> >> +		atomic_dec(&lookups);
> >> +	} while (atomic_read(&removals) != old_removals);
> >
> >This looks like a seq lock? Use the real thing? 
> 
> The code here should get away without taking *any* locks, otherwise you may end up not seeing any backtrace at all when
> the system dies.

seqlock doesn't really take a look in the classical sense. The only way to make it 
lock up would be to have another CPU livelocking on this in a loop.

Anyways most likely it isn't needed because of the stop_machine and can be removed
> 
> >> +	table = kmalloc(sizeof(*table), GFP_USER);
> >
> >GFP_KERNEL.
> 
> Not sure about the significance - I took this from respective ia64 code.

GFP_USER is for user space pages only.

> >> +#ifdef UNW_FP
> >
> >This should be CONFIG_FRAME_POINTER
> 
> No - there are arch-s (ia64, while clearly not going to be getting here, immediately comes to mind) where you cannot
> define what register the frame pointer is in. I rather think x86 is special in that you actually can.

Those never set CONFIG_FP
 
-Andi
