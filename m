Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUCQQvp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 11:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbUCQQvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 11:51:45 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:59102 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261238AbUCQQvn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 11:51:43 -0500
Date: Wed, 17 Mar 2004 17:51:42 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thomas Schlichter <thomas.schlichter@web.de>
Cc: Philippe Elie <phil.el@wanadoo.fr>, Andrew Morton <akpm@osdl.org>,
       Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.4-rc2] bogus semicolon behind if()
In-Reply-To: <200403091208.20556.thomas.schlichter@web.de>
Message-ID: <Pine.LNX.4.55.0403171734090.14525@jurand.ds.pg.gda.pl>
References: <200403090014.03282.thomas.schlichter@web.de>
 <20040308162947.4d0b831a.akpm@osdl.org> <20040309070127.GA2958@zaniah>
 <200403091208.20556.thomas.schlichter@web.de>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2004, Thomas Schlichter wrote:

> 2. To fix my problem, timer_ack must be set to 1 for my (integrated) APIC, and 
> as my CPU has a TSC, this cannot be correct for me:
> -	timer_ack = 1;
> +	if (nmi_watchdog == NMI_IO_APIC && !APIC_INTEGRATED(ver))
> +		timer_ack = 1;
> +	else
> +		timer_ack = !cpu_has_tsc;
> 
> I changed that if(...) to
> 	if (nmi_watchdog == NMI_IO_APIC || APIC_INTEGRATED(ver))
> which works fine for me here, but I am not 100% sure if this is what the 
> author of the original patch ment and if it still fixes the original 
> problem...

 You need timer_ack set to one when either:

1. you use the I/O APIC NMI watchdog and you have a discrete APIC chip
(i.e. the 82489DX),

or:

2. the timer interrupt (IRQ 0) goes through one of the APICs (whatever
way; we check three variations) and the TSC is non-functional (absent or 
disabled).

Since you have an integrated APIC and you use the TSC, you may have 
timer_ack set to zero.  That saves a few (possibly slow) I/O accesses and 
works around problems that may arise due 8259A clone (in)compatibility or 
bugs in SMM firmware.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
