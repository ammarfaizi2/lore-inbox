Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWFHSgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWFHSgA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 14:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWFHSgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 14:36:00 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:37599 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964862AbWFHSf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 14:35:59 -0400
Date: Thu, 8 Jun 2006 20:35:49 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       jamagallon@ono.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ignore smp_locks section warnings from init/exit code
Message-ID: <20060608183549.GB18815@mars.ravnborg.org>
References: <20060607104724.c5d3d730.akpm@osdl.org> <20060608003153.36f59e6a@werewolf.auna.net> <20060607154054.cf4f2512.akpm@osdl.org> <20060607162326.3d2cc76b.rdunlap@xenotime.net> <20060608021149.GA5567@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060608021149.GA5567@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 10:11:49PM -0400, Jeff Dike wrote:
> On Wed, Jun 07, 2006 at 04:23:26PM -0700, Randy.Dunlap wrote:
> > I currently only see this in an __exit section.
> > Here is a patch that fixes it for me.
> 
> Cool, something equivalent makes the UML link a lot quieter.  I had to
> add ".plt" and ".bss".  I'm guessing mine are false positives as well,
> but have no idea how to check that.

The check is there to catch situations where a function is marked
__init but referenced after a potential discard of the it sections.
So if there is no-one discarding the .plt section then we should be all
safe.

Browsing the um code I could not see how .plt was thought used so I
added it to the ignorelist in modpost.

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 94047bc..a70f5dd 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -822,6 +822,7 @@ static int init_section_ref_ok(const cha
 		".pdr",
 		"__param",
 		".smp_locks",
+		".plt",  /* seen on ARCH=um build on x86_64. Harmless */
 		NULL
 	};
 	/* Start of section names */
@@ -894,6 +895,7 @@ static int exit_section_ref_ok(const cha
 		".eh_frame",
 		".stab",
 		".smp_locks",
+		".plt",  /* seen on ARCH=um build on x86_64. Harmless */
 		NULL
 	};
 	/* Start of section names */

As for .bss this is a much more generic section - so for now this is not
added. Can you explain why there is a reference to do_mount_root from
.bss or is this a bug in modpost pointing out something wrong?

With the above patch we are down to two section mismatch warnings for
a defconfig build on x86_64.

	Sam
