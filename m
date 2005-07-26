Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVGZB0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVGZB0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 21:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVGZB0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 21:26:51 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:30417 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261270AbVGZB0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 21:26:50 -0400
From: Grant Coady <lkml@dodo.com.au>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: 2.6.13-rc3 test: finding compile errors with make randconfig
Date: Tue, 26 Jul 2005 11:26:33 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <cm1be15uqfvur80d1f2s3kfuls9koibsoa@4ax.com>
References: <f8b6e1h2t4tlto7ia8gs8aanpib68mhit6@4ax.com> <20050724091327.GQ3160@stusta.de> <glq7e1ttejp2sh7uuo6nil2vafljdprkpk@4ax.com> <20050724203932.GX3160@stusta.de> <0fv7e11ejvimjkfqib95n93hl34icavnbu@4ax.com> <20050724212721.GA3160@stusta.de>
In-Reply-To: <20050724212721.GA3160@stusta.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2005 23:27:22 +0200, Adrian Bunk <bunk@stusta.de> wrote:
>
>You should edit init/Kconfig to disallow CONFIG_CLEAN_COMPILE=n, since 
>any errors you see with CONFIG_BROKEN=y aren't interesting.

Straight over the top of my head yesterday :)  Is the following 
what you had in mind?  (current script does retry if BROKEN)

grant@sempro:/opt/linux$ diff -u linux-2.6.13-rc3-git6/init/Kconfig~ linux-2.6.13-rc3-git6/init/Kconfig
--- linux-2.6.13-rc3-git6/init/Kconfig~ 2005-07-25 08:23:04.000000000 +1000
+++ linux-2.6.13-rc3-git6/init/Kconfig  2005-07-26 10:25:59.000000000 +1000
@@ -42,7 +42,7 @@

 config BROKEN
        bool
-       depends on !CLEAN_COMPILE
+       depends on !CLEAN_COMPILE && 0
        default y

 config BROKEN_ON_SMP

- - - 
results first run:
------------------
Here http://scatter.mine.nu/test/scripts/counterror-2005-07-26.gz
is post-processing script (work in progress) extracts errors and 
non-deprecated warnings, linked to first triggering .config like so:

grant@sempro:/opt/linux$ cat error-error-list
trial1/run-004:arch/i386/mach-es7000/es7000.h
trial1/run-004:arch/i386/mach-es7000/es7000plat.c
trial1/run-009:drivers/char/ipmi/ipmi_msghandler.c
trial2/run-082:drivers/mtd/maps/nettel.c
trial3/run-018:drivers/pnp/pnpbios/rsparser.c
trial2/run-044:include/asm-i386/mach-default/mach_apic.h
trial1/run-008:include/asm-i386/mach-visws/do_timer.h
trial2/run-081:ipc/shm.c
trial1/run-015:net/rxrpc/main.c
trial2/run-027:sound/core/memalloc.c

then extracts compiler messages:

grant@sempro:/opt/linux$ head error-error-report |cut -c-78
trial1/run-004:arch/i386/mach-es7000/es7000.h:82: error: field `id' has incomp
trial1/run-004:arch/i386/mach-es7000/es7000.h:88: error: field `Header' has in
trial1/run-004:arch/i386/mach-es7000/es7000plat.c: In function `parse_unisys_o
trial1/run-004:arch/i386/mach-es7000/es7000plat.c:154: error: `es7000_rename_g
trial1/run-004:arch/i386/mach-es7000/es7000plat.c: In function `find_unisys_ac
trial1/run-004:arch/i386/mach-es7000/es7000plat.c:168: warning: implicit decla
trial1/run-004:arch/i386/mach-es7000/es7000plat.c:170: error: dereferencing po
trial1/run-004:arch/i386/mach-es7000/es7000plat.c:172: error: dereferencing po
trial1/run-004:arch/i386/mach-es7000/es7000plat.c:175: warning: implicit decla
trial1/run-004:arch/i386/mach-es7000/es7000plat.c:175: error: invalid applicat
^^^^^^^^^^^^^^\
                --> link to .config producing the error / warning:

grant@sempro:/opt/linux$ head trial1/run-004-config
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.13-rc3
# Tue Jul 19 04:31:27 2005
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

Current compile run is with linux-2.6.13-rc3-git6

Datastore is denormalised flat text.  Query language: grep :)

Thanks,
Grant.

