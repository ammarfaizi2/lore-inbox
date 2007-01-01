Return-Path: <linux-kernel-owner+w=401wt.eu-S1754708AbXAAV1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708AbXAAV1q (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 16:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754709AbXAAV1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 16:27:46 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:32852 "HELO
	smtp107.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754708AbXAAV1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 16:27:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=eVmNKhd96PopsmcPgGX1AHcWg2Px38eiNJeGrOTf49D9uZ9RMaJsrChLKKBa95EMBn3qccCQbCHNKAKmcVlTdF+KhnglB2wui8fPEeN7dLQ6wMw2V23rOHYYmnouXMDtb1nptiBd186Qxh2bLnSGkUzXv0b1Z00kc4/Y45J7h9M=  ;
X-YMail-OSG: MMwmAaEVM1mKlHWZkYU0nOmixFexy78bpklD7LMPRrOGH68TPjdfIbzAXOPNlESXndz.KemFaQtSBTFblVOXLfLazu28cNAchcJVXn.VH7SvOIN0o3NMW1mqax3N_DnnkHsD98PCxpsHUCbxbuTWU7S.BQ5CZQpaWhpZIYxFAzyqZmCLbgdQPzKCT12j
From: David Brownell <david-b@pacbell.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 2.6.20-rc1 1/6] GPIO core
Date: Mon, 1 Jan 2007 13:27:32 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
References: <200611111541.34699.david-b@pacbell.net> <200612291718.34494.david-b@pacbell.net> <20070101205521.GB4901@elf.ucw.cz>
In-Reply-To: <20070101205521.GB4901@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701011327.33771.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 January 2007 12:55 pm, Pavel Machek wrote:

> > Think of it as "cookies represented by integers" if you like.
> 
> typedef int gpio_t would hurt, and would serve as a useful
> documentation hint.

Yes, I agree that such needless obfuscation hurts.  ;)

Plus, such a typedef would disagree with Documentation/CodingStyle
which says "... the rule should basically be to NEVER EVER use a
typedef" (with some exceptions not matched here).


> > Should it instead say that's an (obviously unchecked) error?
> 
> Saying it is an error would be okay by me. (Or "Behaviour of these calls for
> GPIOs that can't be safely accessed without sleeping is undefined.").

See the appended doc patch ... better?

- Dave


=================	CUT HERE
Index: at91/Documentation/gpio.txt
===================================================================
--- at91.orig/Documentation/gpio.txt	2006-12-29 00:00:28.000000000 -0800
+++ at91/Documentation/gpio.txt	2006-12-29 15:47:18.000000000 -0800
@@ -78,7 +78,8 @@ Identifying GPIOs
 -----------------
 GPIOs are identified by unsigned integers in the range 0..MAX_INT.  That
 reserves "negative" numbers for other purposes like marking signals as
-"not available on this board", or indicating faults.
+"not available on this board", or indicating faults.  Code that doesn't
+touch the underlying hardware treats these integers as opaque cookies.
 
 Platforms define how they use those integers, and usually #define symbols
 for the GPIO lines so that board-specific setup code directly corresponds
@@ -139,8 +140,8 @@ issues including wire-OR and output late
 The get/set calls have no error returns because "invalid GPIO" should have
 been reported earlier in gpio_set_direction().  However, note that not all
 platforms can read the value of output pins; those that can't should always
-return zero.  Also, these calls will be ignored for GPIOs that can't safely
-be accessed wihtout sleeping (see below).
+return zero.  Also, using these calls for GPIOs that can't safely be accessed
+without sleeping (see below) is an error.
 
 Platform-specific implementations are encouraged to optimise the two
 calls to access the GPIO value in cases where the GPIO number (and for
@@ -239,7 +240,8 @@ options are part of the IRQ interface, e
 system wakeup capabilities.
 
 Non-error values returned from irq_to_gpio() would most commonly be used
-with gpio_get_value().
+with gpio_get_value(), for example to initialize or update driver state
+when the IRQ is edge-triggered.
 
 
 
@@ -262,7 +264,8 @@ like the aforementioned options for inpu
 Hardware may support reading or writing GPIOs in gangs, but that's usually
 configuration dependednt:  for GPIOs sharing the same bank.  (GPIOs are
 commonly grouped in banks of 16 or 32, with a given SOC having several such
-banks.)  Code relying on such mechanisms will necessarily be nonportable.
+banks.)  Some systems can trigger IRQs from output GPIOs.  Code relying on
+such mechanisms will necessarily be nonportable.
 
 Dynamic definition of GPIOs is not currently supported; for example, as
 a side effect of configuring an add-on board with some GPIO expanders.
