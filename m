Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbUKKWXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbUKKWXS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbUKKWXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:23:17 -0500
Received: from fmr06.intel.com ([134.134.136.7]:21953 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261485AbUKKWXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:23:11 -0500
Subject: Re: [PATCH] fix  platform_rename_gsi related ia32 build breakage
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>
In-Reply-To: <Pine.LNX.4.58.0411101621020.2301@ppc970.osdl.org>
References: <4192A959.9020806@conectiva.com.br>
	 <4192A9BF.2080606@conectiva.com.br> <4192ADF4.1050907@conectiva.com.br>
	 <Pine.LNX.4.58.0411101621020.2301@ppc970.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1100211749.5510.753.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 Nov 2004 17:22:29 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-10 at 19:24, Linus Torvalds wrote:

> Quite frankly, I think the whole thing is broken. #ifdef's inside code
> is _evil_, and "platform_rename_gsi()" doesn't make sense as a name.
> I'll apply your patch, but quite frankly, I think the ACPI layer is
> doing crap.
> 
> Len, can you please use a more descriptive name, and have it be always
> defined (make it an inline function that just becomes a no-op or
> something).

This is already fixed in the latest ACPI patch, included in the current
-mm tree.  So I've gone ahead and excluded the two csets you applied
adding the #ifdefs.

I used a function pointer here because the same kernel binary must be
able to run on an ES7000 or a non-ES7000, so the compile-time inline
idiom doesn't work.  Originally we called it es7000-something, but since
the mechanism is general it could be used just as well by any non-ES7000
system, so we settled on a more generic name -- platform_rename_gsi().

What this routine does is accomodate exotic hardware.  On the ES7000 the
hardware designers decided to connect their legacy devices to interrupt
pins > 15.  Getting Linux to handle this was goodness because it forced
me to go through and clean up some old interrupt-source-override code
that basically worked by accident.  But on the ES7000, the problem
remained for what to do about the PCI devices connected to interrupt
pins < 16, including pin0.  Without platform_rename_gsi, these pins are
given identity-mapped IRQ#'s below 16, and Linux lives with lots of
legacy code that assumes that IRQ's below 16 are special.  So
platform_rename_gsi() on the ES7000 simply gives these pins new IRQ#'s
starting above what would normally be the highest GSI in the system. 
These number are not subject to any legacy special cases and MSI etc.
work fine.

Finally, there were two places this technicaue is used.  ACPI-mode has
been in for a while.  The one that broke the !ACPI MPS+IOAPIC build
yesterday was new -- it replaced a hack in the MPS code that that was
downright scary because it could potentially break any non-ES7000
system.

If you read this far and have suggestions for a more descriptive name
than platform_rename_gsi(), just let me know.

thanks,
-Len


