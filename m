Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266887AbUBRAWl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266850AbUBRAWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:22:10 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:53519 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S266906AbUBRAVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:21:14 -0500
Date: Wed, 18 Feb 2004 01:15:16 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, GCS <gcs@lsc.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc4
In-Reply-To: <20040217200545.GP1308@fs.tum.de>
Message-ID: <Pine.LNX.4.58.0402172118510.7851@serv>
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
 <20040217184543.GA18495@lsc.hu> <Pine.LNX.4.58.0402171107040.2154@home.osdl.org>
 <20040217200545.GP1308@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 17 Feb 2004, Adrian Bunk wrote:

> > Which implies a configuration error (but the Kconfig file looks correct,
> > so I wonder if you found a bug in the configurator).
>
> Most likely the problem is CONFIG_I2C=m and the fact that FB_RADEON_I2C
> is a bool.

Try the patch below. I noticed that problem recently and I hoped I could
get away with it after 2.6.3. :)
When calculating the select expression it should only use the config
symbol itself not the complete dependency, otherwise a boolean could be
turned into a tristate.

bye, Roman

--- linux/scripts/kconfig/menu.c	18 Jul 2003 21:22:54 -0000	1.1.1.1
+++ linux/scripts/kconfig/menu.c	17 Feb 2004 20:18:28 -0000
@@ -172,16 +172,16 @@ void menu_finalize(struct menu *parent)
 				if (prop->menu != menu)
 					continue;
 				dep = expr_transform(prop->visible.expr);
-				dep = expr_alloc_and(expr_copy(basedep), dep);
-				dep = expr_eliminate_dups(dep);
-				if (menu->sym && menu->sym->type != S_TRISTATE)
-					dep = expr_trans_bool(dep);
-				prop->visible.expr = dep;
 				if (prop->type == P_SELECT) {
 					struct symbol *es = prop_get_symbol(prop);
 					es->rev_dep.expr = expr_alloc_or(es->rev_dep.expr,
 							expr_alloc_and(expr_alloc_symbol(menu->sym), expr_copy(dep)));
 				}
+				dep = expr_alloc_and(expr_copy(basedep), dep);
+				dep = expr_eliminate_dups(dep);
+				if (menu->sym && menu->sym->type != S_TRISTATE)
+					dep = expr_trans_bool(dep);
+				prop->visible.expr = dep;
 			}
 		}
 		for (menu = parent->list; menu; menu = menu->next)
