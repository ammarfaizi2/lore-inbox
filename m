Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWFGXUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWFGXUj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 19:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWFGXUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 19:20:39 -0400
Received: from xenotime.net ([66.160.160.81]:26604 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932465AbWFGXUj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 19:20:39 -0400
Date: Wed, 7 Jun 2006 16:23:26 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: jamagallon@ono.com, linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: [PATCH] ignore smp_locks section warnings from init/exit code
Message-Id: <20060607162326.3d2cc76b.rdunlap@xenotime.net>
In-Reply-To: <20060607154054.cf4f2512.akpm@osdl.org>
References: <20060607104724.c5d3d730.akpm@osdl.org>
	<20060608003153.36f59e6a@werewolf.auna.net>
	<20060607154054.cf4f2512.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2006 15:40:54 -0700 Andrew Morton wrote:

> On Thu, 8 Jun 2006 00:31:53 +0200
> "J.A. Magallón" <jamagallon@ono.com> wrote:
> 
> > WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x3c)
> > WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x40)
> > WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x44)
> 
> Yes, that's a false positive - doing locking from within an __init section.
> We need to shut that up somehow.

I currently only see this in an __exit section.
Here is a patch that fixes it for me.
J.A., can you test it?

---
From: Randy Dunlap <rdunlap@xenotime.net>

Add ".smp_locks" section to whitelist as being safe from
init and exit sections.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 scripts/mod/modpost.c |    2 ++
 1 files changed, 2 insertions(+)

--- linux-2617-rc6mm1.orig/scripts/mod/modpost.c
+++ linux-2617-rc6mm1/scripts/mod/modpost.c
@@ -852,6 +852,7 @@ static int init_section_ref_ok(const cha
 		".pci_fixup_final",
 		".pdr",
 		"__param",
+		".smp_locks",
 		NULL
 	};
 	/* Start of section names */
@@ -923,6 +924,7 @@ static int exit_section_ref_ok(const cha
 		".exitcall.exit",
 		".eh_frame",
 		".stab",
+		".smp_locks",
 		NULL
 	};
 	/* Start of section names */
