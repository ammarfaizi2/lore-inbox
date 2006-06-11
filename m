Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161059AbWFKAvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbWFKAvc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 20:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbWFKAvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 20:51:32 -0400
Received: from aun.it.uu.se ([130.238.12.36]:30080 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1161059AbWFKAvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 20:51:31 -0400
Date: Sun, 11 Jun 2006 02:51:21 +0200 (MEST)
Message-Id: <200606110051.k5B0pLBI010621@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: rdunlap@xenotime.net
Subject: Re: [PATCH] [2.6.17-rc6] Section mismatch in drivers/net/ne.o during modpost
Cc: akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2006 12:13:35 -0700, Randy.Dunlap wrote:
>On Sat, 10 Jun 2006 14:11:42 +0200 (MEST) Mikael Pettersson wrote:
>
>> While compiling 2.6.17-rc6 for a 486 with an NE2000 ISA ethernet card, I got:
>> 
>> WARNING: drivers/net/ne.o - Section mismatch: reference to .init.data:isapnp_clone_list from .text between 'init_module' (at offset 0x158) and 'ne_block_input'
>> WARNING: drivers/net/ne.o - Section mismatch: reference to .init.data:isapnp_clone_list from .text between 'init_module' (at offset 0x176) and 'ne_block_input'
>> WARNING: drivers/net/ne.o - Section mismatch: reference to .init.data:isapnp_clone_list from .text between 'init_module' (at offset 0x183) and 'ne_block_input'
>> WARNING: drivers/net/ne.o - Section mismatch: reference to .init.data:isapnp_clone_list from .text between 'init_module' (at offset 0x1ea) and 'ne_block_input'
>> WARNING: drivers/net/ne.o - Section mismatch: reference to .init.data:isapnp_clone_list from .text between 'init_module' (at offset 0x251) and 'ne_block_input'
>> WARNING: drivers/net/ne.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x266) and 'ne_block_input'
>> WARNING: drivers/net/ne.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x29b) and 'ne_block_input'
>> 
>> Not sure how serious this is; the driver seems to work fine later on.
>
>Doesn't look serious.  init_module() is not __init, but it calls
>some __init functions and touches some __initdata.
>
>BTW, I would be happy to see some consistent results from modpost
>section checking.  I don't see all of these warnings (I see only 1)
>when using gcc 3.3.6.  What gcc version are you using?
>Does that matter?  (not directed at anyone in particular)

The messages above are from when I used gcc-4.1.1.
With gcc-3.2.3 I only see a single warning.

>Patch below fixes it for me.  Please test/report.

Worked for me too. Thanks.

/Mikael

>---
>
>From: Randy Dunlap <rdunlap@xenotime.net>
>
>Fix section mismatch warnings:
>WARNING: drivers/net/ne.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x396) and 'cleanup_card'
>WARNING: drivers/net/ne2.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x483) and 'cleanup_card'
>
>Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
>---
> drivers/net/ne.c  |    2 +-
> drivers/net/ne2.c |    2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>--- linux-2617-rc6.orig/drivers/net/ne.c
>+++ linux-2617-rc6/drivers/net/ne.c
>@@ -829,7 +829,7 @@ that the ne2k probe is the last 8390 bas
> is at boot) and so the probe will get confused by any other 8390 cards.
> ISA device autoprobes on a running machine are not recommended anyway. */
> 
>-int init_module(void)
>+int __init init_module(void)
> {
> 	int this_dev, found = 0;
> 
>--- linux-2617-rc6.orig/drivers/net/ne2.c
>+++ linux-2617-rc6/drivers/net/ne2.c
>@@ -780,7 +780,7 @@ MODULE_PARM_DESC(bad, "(ignored)");
> 
> /* Module code fixed by David Weinehall */
> 
>-int init_module(void)
>+int __init init_module(void)
> {
> 	struct net_device *dev;
> 	int this_dev, found = 0;
>
