Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVL1BlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVL1BlN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 20:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVL1BlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 20:41:13 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:57546 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S932390AbVL1BlM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 20:41:12 -0500
Date: Wed, 28 Dec 2005 02:40:07 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Gerhard Mack <gmack@innerfire.net>
cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: ati X300 support?
In-Reply-To: <Pine.LNX.4.64.0512271927130.5956@innerfire.net>
Message-ID: <Pine.LNX.4.60.0512280229530.30594@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.64.0512261858200.28109@innerfire.net>
 <200512270149.24440.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0512270817340.15649@innerfire.net>
 <200512271545.31224.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0512271047260.2104@innerfire.net>
 <Pine.LNX.4.60.0512280103100.29982@kepler.fjfi.cvut.cz>
 <Pine.LNX.4.64.0512271927130.5956@innerfire.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="546507526-250795050-1135734007=:30594"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--546507526-250795050-1135734007=:30594
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 27 Dec 2005, Gerhard Mack wrote:

> On Wed, 28 Dec 2005, Martin Drab wrote:
> 
> > Date: Wed, 28 Dec 2005 01:20:42 +0100 (CET)
> > From: Martin Drab <drab@kepler.fjfi.cvut.cz>
> > To: Gerhard Mack <gmack@innerfire.net>
> > Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
> >     linux-kernel@vger.kernel.org
> > Subject: Re: ati X300 support?
> > 
> > On Tue, 27 Dec 2005, Gerhard Mack wrote:
> > 
> > > I have it working in X.org with no problem.  I just can't get the drm
> > > module working in the kernel.  Last time I tried to just add my PCI ids 
> > > the problem was a lack of PCIE support in the drm drivers. 
> > > 
> > > FYI the fglrx drivers suck badly.  ATI hasn't bothered to keep their 
> > > drivers up to date at all and the result is that they finally have  
> > > working 2.6.14 drivers but only for 32 bit machines.  x86_64 is still 
> > > broken on any recent kernel and it's been that way for months.  ATI's tech 
> > > support basically gave up after several days and just informed me it 
> > > wasn't really supported and there is nothing they could do for me.
> > 
> > I don't want to defend ATI here or anything, but I use the 64-bit fglrx 
> > 8.19.10 with 2.6.15-rc5 and it works (except for the minor patch for 
> > 2.6.15-rc2-git3 and later that we came out with with Hugh Dickins and that 
> > was sent to the list not long ago).
...
> Where is this patch? does it re add the obsolete interfaces dropped by the 
> kernel?  On my system it won't even compile.

Here:

------------------------------------------------------------------------------------
diff -Napur fglrx64.orig/build_mod/firegl_public.c fglrx64/build_mod/firegl_public.c
--- fglrx64.orig/build_mod/firegl_public.c      2005-11-14 02:35:45.000000000 +0100
+++ fglrx64/build_mod/firegl_public.c   2005-12-08 01:25:27.000000000 +0100
@@ -2586,7 +2586,7 @@ static __inline__ vm_nopage_ret_t do_vm_

     pMmPage = virt_to_page(kaddr);

-#if 0
+#if LINUX_VERSION_CODE >= 0x02060f
     // WARNING WARNINIG WARNNING WARNNING WARNNING WARNNING WARNNING WARNNING
     // Don't increment page usage count, cause ctx pages are allocated
     // with drm_alloc_pages, which marks all pages as reserved. Reserved
-------------------------------------------------------------------------------------

And no, this one doesn't add the missing interfaces, but the attached 
ones do.

I'm resending what I sent to Hugh. The above patch (which is the one I 
was talking about) is not included there, so you need to apply afterwards. 
Also it's made for the fglrx 8.19.20. I haven't had time to experiment 
with 8.20.8, yet.

---

The script that extracts the kernel module sources and the user space 
binaries is attached in the fglrx64-assemble_scripts.tar.bz2 archive. Just 
copy the 64-bit ATI Driver Installer from the link above to the
fglrx64-assemble_scripts directory and run the "assemble" script. It will
extract the kernel module sources into the 
"./fglrx-8.19.10-x86_64-kernel-module" directory and the user space
binaries into the "./fglrx-8.19.10-x86_64-userspace" directory.

The kernel module sources while extracted are also patched by the three
patches that I've placed into the "patched" subdirectory.

The first patch is necessary in order to compile the 64-bit fglrx cleanly
using the GCC 4.x. There's nothing intrusive, as you can see for
yourself. It also adds the script "c" and "b" to its top directory. Using
"c" you compile the module (resulting "fglrx.ko" should be created in the
"build_mod/2.6.x" subdirectory). Using the "b" script you do the cleanup
(kind of a "make mrproper" equivalent). (Simple and easy, just what I
like! :)

The second patch fixes the ATI's wrong SMP detection in their compilation
script "make.sh" (which is called by my "c" script). They are using lots
of different approaches to try to detect an SMP kernel, which I guess is
pointless, wrong, and not working (it detects my UP notebook with
old single core Athlon64 3000+ that is using a UP configured kernel as an
SMP ;). I think the only reliable way to detect an SMP kernel is to look
at its linux/autoconf.h and search for the "#define CONFIG_SMP" (right? -
the kernel sources have to be present for the compilation anyway, so why
all the other fuss?). So the patch removes all the other approaches from
the script and only does this. It's only influence is on either generating
or not generating the SMP=1 macro on the gcc command-line. So you may
safely ignore it with respect to the bug.

The third patch also influences the gcc command-line generated by the
"make.sh" script. It defines the PAGE_ATTR_FIX as 1 if it is undefined. I
kind of don't know what exactly is this good for. It seems to fix some
AMD AthlonXP page attributes releated bug. By default the value is not
defined anywhere, and gcc preprocessor is unable to handle it due to the
incomplete condition (in)equations. So I set it to 1. If you look at the
sources, it is not used on x86_64 anyway.

I hope it helps,
Martin
--546507526-250795050-1135734007=:30594
Content-Type: APPLICATION/x-bzip2; name="fglrx64-assemble_scripts.tar.bz2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.60.0512280240070.30594@kepler.fjfi.cvut.cz>
Content-Description: Scripts for extracting files out of ATI Driver Installer
Content-Disposition: attachment; filename="fglrx64-assemble_scripts.tar.bz2"

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
u96SB/4u5IpwoSEgkfXq

--546507526-250795050-1135734007=:30594--
