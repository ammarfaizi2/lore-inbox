Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264926AbUF1Mat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264926AbUF1Mat (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 08:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbUF1Mat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 08:30:49 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:55470 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S264926AbUF1Mar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 08:30:47 -0400
Date: Mon, 28 Jun 2004 07:28:55 -0500
From: Erik Jacobson <erikj@subway.americas.sgi.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@infradead.org>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
In-Reply-To: <20040628085429.C32206@flint.arm.linux.org.uk>
Message-ID: <Pine.SGI.4.53.0406280719080.581376@subway.americas.sgi.com>
References: <Pine.SGI.4.53.0406242153360.343801@subway.americas.sgi.com>
 <20040625083130.GA26557@infradead.org> <Pine.SGI.4.53.0406250742350.377639@subway.americas.sgi.com>
 <20040625124807.GA29937@infradead.org> <Pine.SGI.4.53.0406250751470.377692@subway.americas.sgi.com>
 <20040626235248.GC12761@taniwha.stupidest.org>
 <Pine.SGI.4.53.0406271908390.524706@subway.americas.sgi.com>
 <20040628003311.GA23017@taniwha.stupidest.org> <20040628021439.A17654@flint.arm.linux.org.uk>
 <20040628014443.GA24247@taniwha.stupidest.org> <20040628085429.C32206@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you're going to do that, why not just disable 8250 in the kernels
> configuration?  It has exactly the same effect.  With the change you
> propose, you can't even use 8250 for PCMCIA serial cards.

I know this was touched on - but just to confirm.  We need to be able to
work with standard distributions.

Regarding the "hack" to 8250.c - in fact, I put something very similar in
so I could test the driver out in some ways internally.  It does work.

What would really just solve the problem, in my opinion, is if we could
simply get our major/minor registered.  Then everybody wins, right?

In 2.6.7, someone changed kernel/setup.c that made things worse for us
with our CURRENT char/sn_serial.c driver.  This might be what was mentioned
in this thread earlier.

Bad things happen when 8250 is in the kernel and then our CURRENT
char/sn_serial driver is also in the kernel as of 2.6.7.  Our fix for
that issue was to put back this line (see below).

We were hoping to not propose this as a patch and just have our NEW console
driver get in.

We're in a really bad spot now where, as of 2.6.7, our old driver doesn't
work any more due to the setup.c change and our new driver is getting
resistance - mostly due to lack of registered major/minor.

Here is the fix for the CURRENT driver.  I think we might need to propose
that this change be put back in the kernel if it doesn't look like our
NEW driver (serial/sn_console) will be accepted.  But having this fix
in place does not help us with the problem we're trying to solve with the
NEW driver.  It just makes it so we at least have something that works.

Index: linux/arch/ia64/kernel/setup.c
===================================================================
--- linux.orig/arch/ia64/kernel/setup.c 2004-06-15 11:01:24.000000000 -0500
+++ linux/arch/ia64/kernel/setup.c      2004-06-15 12:02:31.000000000 -0500
@@ -333,7 +333,7 @@ setup_arch (char **cmdline_p)
 #endif
        {
                extern unsigned char acpi_legacy_devices;
-               if (!efi.hcdp)
+               if (!efi.hcdp && !ia64_platform_is("sn2"))
                        setup_serial_legacy();
        }
 #endif


--
Erik Jacobson - Linux System Software - Silicon Graphics - Eagan, Minnesota
