Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbSKNWaJ>; Thu, 14 Nov 2002 17:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbSKNWaJ>; Thu, 14 Nov 2002 17:30:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18703 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id <S261799AbSKNWaI>;
	Thu, 14 Nov 2002 17:30:08 -0500
Date: Thu, 14 Nov 2002 14:37:01 -0800
From: Richard Henderson <rth@twiddle.net>
To: rusty@rustcorp.com.au
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: in-kernel linking issues
Message-ID: <20021114143701.A30355@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So you said you had a userland test harness?

Some problems I've seen browsing the code:

 (1) You make no provision for sections to be loaded in any order
      except the order they appear in the object file.  This is bad.
      You *really* need to replicate something akin to obj_load_order_prio
      from the 2.4 modutils, lest small data sections be placed incorrectly
      wrt the GOT section.

 (2) I see no provision for small COMMON symbols to be placed in the
      .sbss section rather than in the .bss section.  Unless you are
      sorting your allocation of COMMON symbols by size, which I also
      don't see, this can result in link errors due to SCOMMON symbols
      not being reachable from the GP.

 These will affect at least Alpha, IA-64, and MIPS.

 (3) Alpha and MIPS64 absolutely require that the core and init allocations
     are "close" (within 2GB).  I don't see how this can be guaranteed with
     two different vmalloc calls.

     Allocating the two together would also allow us to only have
     one flush_icache_range call.  Not that I consider module
     loading particularly performance critical, but it'd be nice.


That's all I can think of at the moment.


r~
