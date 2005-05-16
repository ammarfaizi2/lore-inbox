Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVEPWJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVEPWJX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 18:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVEPWJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 18:09:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:46290 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261926AbVEPWIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 18:08:30 -0400
Date: Mon, 16 May 2005 15:09:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: christoph <christoph@scalex86.org>
Cc: linux-kernel@vger.kernel.org, shai@scalex86.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
Message-Id: <20050516150907.6fde04d3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw>
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christoph <christoph@scalex86.org> wrote:
>
> Make the timer frequency selectable. The timer interrupt may cause bus
> and memory contention in large NUMA systems since the interrupt occurs
> on each processor HZ times per second.
> 
> Signed-off-by: Christoph Lameter <christoph@scale86.org>
> Signed-off-by: Shai Fultheim <shai@scalex86.org>
> 
> Index: linux-2.6.11/arch/i386/Kconfig
> ===================================================================
> --- linux-2.6.11.orig/arch/i386/Kconfig	2005-05-16 12:07:31.000000000 -0700
> +++ linux-2.6.11/arch/i386/Kconfig	2005-05-16 12:39:48.000000000 -0700
> @@ -939,6 +939,20 @@ config SECCOMP
>  
>  	  If unsure, say Y. Only embedded should say N here.
>  
> +config HZ
> +	int "Frequency of the Timer Interrupt (1000 or 100)"
> +	range 100 1000

Linus spat this patch back a couple of years ago.  Last time we discussed
it, a year ago, he said

  On Fri, 21 May 2004, Andrew Morton wrote:
  > 
  > Len, do you have any numbers on this?  Do you think we need to address
  > this?  If so, is there any sane alternative to CONFIG_HZ?

  100Hz is too little for a number of users, and yes, 1kHz is too high - I 
  selected it partly because it made it oh-so-much-more-obvious when 
  some pieces weren't converted. 

  1kHz is also good in that it makes it easy to convert both to USER_HZ and 
  to ms/ns. But maybe something like 250Hz would be better - still high 
  enough that things like multimedia (which really wants higher frequencies 
  in order to be able to sleep for fractional video-frames) should be happy, 
  low enough that we use less CPU.

(The issue being that the latency of entering ACPI low-power mode is of the
order of one millisecond on some machines, so HZ=1000 whacks the battery).

So yes, the time has come around again to work out what we're going to do
about this.  I'd be a bit worried about allowing users to set HZ=724,
simply because nobody tests with that, and it might expose odd timing
relationships and unfortunate arithmetic rounding artifacts.  So if we're
going to do this thing it might be better to just offer 100, 250 and 1000.
