Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWC3Bzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWC3Bzk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 20:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWC3Bzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 20:55:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31648 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751424AbWC3Bzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 20:55:39 -0500
Date: Wed, 29 Mar 2006 17:54:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: sho@tnes.nec.co.jp, Laurent.Vivier@bull.net, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit from 8TB to 16TB
Message-Id: <20060329175446.67149f32.akpm@osdl.org>
In-Reply-To: <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	<1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	<20060327131049.2c6a5413.akpm@osdl.org>
	<20060327225847.GC3756@localhost.localdomain>
	<1143530126.11560.6.camel@openx2.frec.bull.fr>
	<1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	<1143623605.5046.11.camel@openx2.frec.bull.fr>
	<1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> The things need to be done to complete this work is the issue with
>  current percpu counter, which could not handle u32 type count well. 

I'm surprised there's much of a problem here.  It is a 32-bit value, so it
should mainly be a matter of treating the return value from
percpu_counter_read() as unsigned long.

However a stickier problem is when dealing with a filesystem which has,
say, 0xffff_ff00 blocks.  Because percpu counters are approximate, and a
counter which really has a value of 0xffff_feee might return 0x00000123. 
What do we do then?

Of course the simple option is to nuke the percpu counters in ext3 and use
atomic_long_t (which is signed, so appropriate treat-it-as-unsigned code
would be needed).  I doubt if the percpu counters in ext3 are gaining us
much.
