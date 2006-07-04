Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWGDITJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWGDITJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWGDITJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:19:09 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:31189 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1751209AbWGDITI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:19:08 -0400
Date: Tue, 4 Jul 2006 01:10:55 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH 1/2] x86-64 TIF flags for debug regs and io bitmap in ctxsw
Message-ID: <20060704081055.GD5902@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060704072832.GB5902@frankl.hpl.hp.com> <1151999509.3109.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151999509.3109.6.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 09:51:49AM +0200, Arjan van de Ven wrote:
> > -		}
> > -	}
> > +	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
> > +	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
> > +		__switch_to_xtra(prev_p, next_p, tss);
> 
> well isn't this replacing an if() (which isn't cheap but also not
> expensive, due to unlikely()) with an atomic operation (which *is*
> expensive) ?
> 
> That to me doesn't make this sound like an actual win....
> 
Although the two if were marked unlikely, you had to do the test anyway.
So you had to touch next->debugreg[7], next->io_bitmap_ptr, and prev->io_bitmap_ptr.
Now the first two are collapsed into one cache line in thread_info->flags.

Yet, I see your point about the test_tsk_thread_flag() and I am wondering if we
do need the atomicity in this case and whether we could simplify by using the
same expression as for next, i.e, task_thread_info(prev_p)->flags & TIF_IO_BITMAP?

-- 
-Stephane
