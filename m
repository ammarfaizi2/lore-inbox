Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263216AbSKCUSU>; Sun, 3 Nov 2002 15:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263280AbSKCUSU>; Sun, 3 Nov 2002 15:18:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7949 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263216AbSKCUSS>; Sun, 3 Nov 2002 15:18:18 -0500
Date: Sun, 3 Nov 2002 20:24:46 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5: troubles with piping make output
Message-ID: <20021103202446.F5589@flint.arm.linux.org.uk>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Sam Ravnborg <sam@ravnborg.org>,
	Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	linux-kernel@vger.kernel.org
References: <200211031122.gA3BMbp27805@Port.imtp.ilyichevsk.odessa.ua> <20021103182805.GA1057@mars.ravnborg.org> <200211031946.gA3JkIp29186@Port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.44.0211032106010.6949-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211032106010.6949-100000@serv>; from zippel@linux-m68k.org on Sun, Nov 03, 2002 at 09:10:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 09:10:54PM +0100, Roman Zippel wrote:
> > Looks like fflush() got forgotten somewhere ;)
> 
> What shell are you using?
> This is what should happen:
> 
> $ make 2>&1 | tee
> make[1]: `scripts/kconfig/conf' is up to date.
> ./scripts/kconfig/conf -s arch/i386/Kconfig
> #
> # using defaults found in .config
> #
> *
> * Restart config...
> *
> *
> * Processor type and features
> *
> Processor family (386, 486, 586/K5/5x86/6x86/6x86MX, Pentium-Classic, Pentium-MMX, Pentium-Pro/Celeron/Pentium-II, Pentium-III/Celeron(Coppermine), Pentium-4, K6/K6-II/K6-III, Athlon/Duron/K7, Elan, Crusoe, Winchip-C6, Winchip-2, Winchip-2A/Winchip-3, CyrixIII/VIA-C3) [Pentium-Pro/Celeron/Pentium-II] (NEW) aborted!
> 
> Console input/output is redirected. Run 'make oldconfig' to update configuration.
> 
> make: *** [include/linux/autoconf.h] Error 1

No thanks.  That breaks my build scripts.  I don't want to go logging into
multiple machines just to run make oldconfig when the old system worked
perfectly well.

"perfectly well" here means that make oldconfig worked over ssh, with the
local end logging the stdout to a file as well as the terminal, with stdin
from the terminal.  It is quite reasonable to expect the configuration to
continue as normal.

So, here's a patch that adds the necessary fflush to make this situation
work (for me at least.)

diff -u orig/scripts/kconfig/conf.c linux/scripts/kconfig/conf.c
--- orig/scripts/kconfig/conf.c	Sat Nov  2 18:58:34 2002
+++ linux/scripts/kconfig/conf.c	Fri Nov  1 17:02:19 2002
@@ -115,6 +115,7 @@
 			exit(1);
 		}
 	case ask_all:
+		fflush(stdout);
 		fgets(line, 128, stdin);
 		return;
 	case set_default:


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

