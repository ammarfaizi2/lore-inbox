Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbVJSTCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbVJSTCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 15:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVJSTCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 15:02:04 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:31659
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751228AbVJSTCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 15:02:03 -0400
Subject: Re: kernel/timer.c design
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Tim Bird <tim.bird@am.sony.com>
Cc: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, george@mvista.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com, paulmck@us.ibm.com,
       hch@infradead.org, oleg@tv-sign.ru
In-Reply-To: <435689B0.7020100@am.sony.com>
References: <Pine.LNX.4.61.0510171948040.1386@scrub.home>
	 <4353F936.3090406@am.sony.com>
	 <Pine.LNX.4.61.0510172138210.1386@scrub.home>
	 <20051017201330.GB8590@elte.hu>
	 <Pine.LNX.4.61.0510172227010.1386@scrub.home>
	 <20051018084655.GA28933@elte.hu> <Pine.LNX <20051019104938.GA30185@elte.hu>
	 <435689B0.7020100@am.sony.com>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 19 Oct 2005 21:04:26 +0200
Message-Id: <1129748666.19559.283.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 11:00 -0700, Tim Bird wrote:
> > But there's a hidden win as well from this approach: if a timer is 
> > removed before it expires, we've saved the remaining cascading steps!  
> > This happens surprisingly often: on a busy networked server, the 
> > majority of the timers never expire, and are removed before they have to 
> > be cascaded even once.
> 
> Unfortunately, this means that the actual costs of the wheel
> implementation vary depending on the relationship between HZ,
> the average timeout duration, and the bucket mappings (which,
> as you say, can be adjusted for size reasons.)  This is one of
> the downsides of the wheel implementation.  It's very difficult
> to tell in advance whether a particular timer load
> will cascade or not, making the costs (although bounded)
> unexpectedly variable.

Thats exactly the problem we described earlier in the ktimer discussion:

Changing HZ from 100 to 1000 while keeping the primary wheel size
unchanged caused increased cascading load.

HZ     CONFIG_BASE_SMALL=n     CONFIG_BASE_SMALL=y
 100    2560 ms                 640 ms
 250    1024 ms                 256 ms
 1000    256 ms                  64 ms

A lot of timeouts are in the range of 500ms. While the HZ=100 and HZ=250
settings keep them in the primary wheel either until expiry or early
removal, HZ=1000 and CONFIG_BASE_SMALL with HZ > 100 make cascading more
likely when the system load goes up.

Thats hard to balance for sure.

	tglx


