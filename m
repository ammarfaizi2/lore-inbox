Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266068AbTGDQZj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 12:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266071AbTGDQZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 12:25:38 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:62340 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S266068AbTGDQZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 12:25:37 -0400
Subject: Re: [2.4][2.5][Trivial Patch] Bug in i386/kernel/process.c?
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1057249575.2372.18.camel@slappy>
References: <1057249575.2372.18.camel@slappy>
Content-Type: text/plain
Message-Id: <1057336804.1317.58.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 04 Jul 2003 12:40:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Er, that patch won't apply to 2.5 - the code is the same, but its moved
to reboot.c.

Same change, diff't file/offset.

On Thu, 2003-07-03 at 12:26, Disconnect wrote:
> I was poking into how to force a warm boot (found it easily enough) and
> started reading process.c, where the details live.
> 
> We have:
> static int reboot_mode;
> int reboot_thru_bios;
>                                                                                 
> static int __init reboot_setup(char *str)
> {
> ...set reboot_mode/reboot_thru_bios according to reboot=...
> }
> __setup("reboot=", reboot_setup);
> 
> Farther down:
>         /* Write 0x1234 to absolute memory location 0x472.  The BIOS
> reads
>            this on booting to tell it to "Bypass memory test (also warm
>            boot)".  This seems like a fairly standard thing that gets
> set by
>            REBOOT.COM programs, and the previous reset routine did this
>            too. */
>                                                                                 
>         *((unsigned short *)0x472) = reboot_mode;
>                                                                                 (similar code farther down in !reboot_thru_bios)
> 
> ....but reboot_mode doesn't seem to be initialized if you don't set it
> via reboot=...? (Same for reboot_thru_bios)
> 
> A simple patch to use the defaults (according to the code comments) is
> below; if this is right please push accordingly:
> 
> Its against 2.4 but should apply to 2.5 as well.
> --- build-dis5-final/arch/i386/kernel/process.c.orig    2003-07-03 12:15:36.000000000 -0400
> +++ build-dis5-final/arch/i386/kernel/process.c 2003-07-03 12:16:46.000000000 -0400
> @@ -152,8 +152,8 @@
>  __setup("idle=", idle_setup);
>   
>  static long no_idt[2];
> -static int reboot_mode;
> -int reboot_thru_bios;
> +static int reboot_mode = 0x1234;
> +int reboot_thru_bios = 1;
>   
>  #ifdef CONFIG_SMP
>  int reboot_smp = 0;
-- 
Disconnect <lkml@sigkill.net>

