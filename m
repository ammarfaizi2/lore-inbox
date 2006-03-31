Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWCaWm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWCaWm1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 17:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWCaWm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 17:42:27 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:36018 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751462AbWCaWm0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 17:42:26 -0500
Subject: Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit from 8TB to 16TB
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: sho@tnes.nec.co.jp, Laurent.Vivier@bull.net, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
In-Reply-To: <20060329175446.67149f32.akpm@osdl.org>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	 <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	 <20060327131049.2c6a5413.akpm@osdl.org>
	 <20060327225847.GC3756@localhost.localdomain>
	 <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	 <1143623605.5046.11.camel@openx2.frec.bull.fr>
	 <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
	 <20060329175446.67149f32.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 31 Mar 2006 14:42:23 -0800
Message-Id: <1143844943.3944.22.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-29 at 17:54 -0800, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > The things need to be done to complete this work is the issue with
> >  current percpu counter, which could not handle u32 type count well. 
> 
> I'm surprised there's much of a problem here.  It is a 32-bit value, so it
> should mainly be a matter of treating the return value from
> percpu_counter_read() as unsigned long.
> 
> However a stickier problem is when dealing with a filesystem which has,
> say, 0xffff_ff00 blocks.  Because percpu counters are approximate, and a
> counter which really has a value of 0xffff_feee might return 0x00000123. 
> What do we do then?
> 

Hmm... I think we had this issue already even with today's 2**31 ext3.
Since ext2/3 always use percpu_counter_read_positive() to get the total
number of free blocks, so if the real free blocks is 0x0fff_feee, and
the approximate value from the percpu counter is 0xf000_0123, the
percpu_counter_read_positive() will return back 0x0000123.

> Of course the simple option is to nuke the percpu counters in ext3 and use
> atomic_long_t (which is signed, so appropriate treat-it-as-unsigned code
> would be needed).  I doubt if the percpu counters in ext3 are gaining us
> much.

Sounds like the simple solution so far.

Mingming

