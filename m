Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266968AbUBRApp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266962AbUBRAmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:42:15 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:57615 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S266955AbUBRAkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:40:00 -0500
Date: Wed, 18 Feb 2004 01:39:31 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@osdl.org>
cc: Adrian Bunk <bunk@fs.tum.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, GCS <gcs@lsc.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, vandrove@vc.cvut.cz
Subject: Re: Linux 2.6.3-rc4
In-Reply-To: <Pine.LNX.4.58.0402171503150.2154@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0402180129330.7851@serv>
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
 <20040217184543.GA18495@lsc.hu> <Pine.LNX.4.58.0402171107040.2154@home.osdl.org>
 <20040217200545.GP1308@fs.tum.de> <Pine.LNX.4.58.0402171214230.2154@home.osdl.org>
 <20040217225905.GQ1308@fs.tum.de> <Pine.LNX.4.58.0402171503150.2154@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 17 Feb 2004, Linus Torvalds wrote:

> What we actually want to say is something like "select I2C=FB_RADEON",
> which makes the minimal dependency of I2C be the same value as FB_RADEON
> (which is a tristate) rather than FB_RADEON_I2C (boolean).

You can do something similiar:

config FB_RADEON
	select I2C_ALGOBIT if FB_RADEON_I2C

but then you need the patch below to avoid a bogus warning about recursive
dependecies.
Note that the select mechanism is very simple, it's applied to the
selected symbol very late, so it can override any previous selection, but
this also means it ignores any dependencies of the selected symbol. I have
plans to modify the select mechanism for 2.7, but this will be more
complex, so I added something rather simple instead (it was already quite
late during 2.5).

bye, Roman

--- l/scripts/kconfig/symbol.c	8 Sep 2003 21:18:48 -0000	1.1.1.2
+++ l/scripts/kconfig/symbol.c	18 Feb 2004 00:31:00 -0000
@@ -706,7 +706,7 @@ struct symbol *sym_check_deps(struct sym
 		goto out;

 	for (prop = sym->prop; prop; prop = prop->next) {
-		if (prop->type == P_CHOICE)
+		if (prop->type == P_CHOICE || prop->type == P_SELECT)
 			continue;
 		sym2 = sym_check_expr_deps(prop->visible.expr);
 		if (sym2)
