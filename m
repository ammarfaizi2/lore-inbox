Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWGDJfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWGDJfj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 05:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWGDJfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 05:35:39 -0400
Received: from aun.it.uu.se ([130.238.12.36]:20186 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932108AbWGDJfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 05:35:38 -0400
Date: Tue, 4 Jul 2006 11:20:24 +0200 (MEST)
Message-Id: <200607040920.k649KOeN028707@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: arjan@infradead.org, eranian@hpl.hp.com
Subject: Re: [PATCH 1/2] x86-64 TIF flags for debug regs and io bitmap in ctxsw
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
>On Tue, 4 Jul 2006 01:14:13 -0700, Stephane Eranian wrote:
>>On Tue, Jul 04, 2006 at 09:51:49AM +0200, Arjan van de Ven wrote:
>>> > -		}
>>> > -	}
>>> > +	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
>>> > +	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
>>> > +		__switch_to_xtra(prev_p, next_p, tss);
>>> 
>>> well isn't this replacing an if() (which isn't cheap but also not
>>> expensive, due to unlikely()) with an atomic operation (which *is*
>>> expensive) ?
>>> 
>>Andi is right. I double checked the test_tsk_thread_flag() and it does not
>>use atomic ops.
>
>The test_tsk_thread_flag() does not, but what about all the
>other places in the patch where currently unsychronised loads
>or stores of ->io_bitmap_ptr or ->debugreg7 get replaced or
>extended with locked-on-SMP {set,clear}_{tsk_,}thread_flag()
>operations?
>
>They should all just be plain C bitops (&, |, ^, etc).

Scratch that. You're stuffing bits in the ->flags field which
already is accessed concurrently and thus synchronised. Mea culpa.
As long as the accesses in __switch_to() aren't locked I'm OK with it.
