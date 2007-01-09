Return-Path: <linux-kernel-owner+w=401wt.eu-S932164AbXAIPno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbXAIPno (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 10:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbXAIPno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 10:43:44 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:43751 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932164AbXAIPnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 10:43:43 -0500
Date: Tue, 9 Jan 2007 10:43:42 -0500
To: takada <takada@mbf.nifty.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: fix typo in geode_configre()@cyrix.c
Message-ID: <20070109154342.GB17269@csclub.uwaterloo.ca>
References: <20070109.184156.260789378.takada@mbf.nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109.184156.260789378.takada@mbf.nifty.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 06:41:56PM +0900, takada wrote:
> In kernel 2.6, write back wrong register when configure Geode processor.
> Instead of storing to CCR4, it stores to CCR3.
> 
> --- linux-2.6.19/arch/i386/kernel/cpu/cyrix.c.orig	2007-01-09 16:45:21.000000000 +0900
> +++ linux-2.6.19/arch/i386/kernel/cpu/cyrix.c	2007-01-09 17:10:13.000000000 +0900
> @@ -173,7 +173,7 @@ static void __cpuinit geode_configure(vo
>  	ccr4 = getCx86(CX86_CCR4);
>  	ccr4 |= 0x38;		/* FPU fast, DTE cache, Mem bypass */
>  	
> -	setCx86(CX86_CCR3, ccr3);
> +	setCx86(CX86_CCR4, ccr4);
>  	
>  	set_cx86_memwb();
>  	set_cx86_reorder();	

Any idea what the consequence of this would be?  Any chance that while
fixing this file anyhow, adding a missing variant could be done?

The patch I currently run with is this (To cyrix.c):
@@ -257,6 +257,8 @@
                break;

        case 4: /* MediaGX/GXm or Geode GXM/GXLV/GX1 */
+       case 11: /* SC1200 seems to return 11 or something but it is a geode gx1 too as far as I know */
+               dir0_msn = 4;
 #ifdef CONFIG_PCI
                /* It isn't really a PCI quirk directly, but the cure is the
                   same. The MediaGX has deep magic SMM stuff that handles the

After the patch I get this:

# cat /proc/cpuinfo
processor       : 0
vendor_id       : CyrixInstead
cpu family      : 5
model           : 9
model name      : Geode(TM) Integrated Processor by National Semi
stepping        : 1
cpu MHz         : 266.759
cache size      : 16 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu tsc msr cx8 cmov mmx cxmmx
bogomips        : 535.09

Before that the cpu type was unknown, the cache size wasn't there,
and a number of fixups were not being applied as far as I could tell.

I know I have had to fix the jsm serial driver which uses memcpy_toio,
and I got characters out of order on transmit on the geode, while on a
pentium 4 or athlon it works perfectly fine with the same card and driver.

My workaround (which of course isn't good for efficiency) has been:
-               memcpy_toio(&ch->ch_neo_uart->txrxburst, ch->ch_wqueue + tail, s);
+               for(i=0;i<s;i++) {
+                       memcpy_toio(&(ch->ch_neo_uart->txrxburst[i]), ch->ch_wqueue + tail + i, 1);
+               }
+               /*memcpy_toio(&ch->ch_neo_uart->txrxburst, ch->ch_wqueue + tail, s);*/

Could the wrong register being saved have anything to do with that?

Without my fix a burst transfer of the data 0123456789ABCDEF results in
the other end receiving: 123056749AB8DEFC

--
Len Sorensen
