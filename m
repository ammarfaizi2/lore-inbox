Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290806AbSBFVAv>; Wed, 6 Feb 2002 16:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290807AbSBFVAd>; Wed, 6 Feb 2002 16:00:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49159 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290806AbSBFVAZ>; Wed, 6 Feb 2002 16:00:25 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel: ldt allocation failed
Date: 6 Feb 2002 13:00:12 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a3s5gs$94v$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0112070057480.20196-100000@tombigbee.pixar.com.suse.lists.linux.kernel> <200202061402.g16E2Nt32223@Port.imtp.ilyichevsk.odessa.ua> <20020206101231.X21624@devserv.devel.redhat.com> <20020206132144.A29162@hq.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020206132144.A29162@hq.fsmlabs.com>
By author:    yodaiken@fsmlabs.com
In newsgroup: linux.dev.kernel
>
> On Wed, Feb 06, 2002 at 10:12:31AM -0500, Jakub Jelinek wrote:
> > Most sane architectures reserve a thread pointer register (%g6 resp. %g7 on
> > sparc, tp on ia64, ppc will use %r2, alpha uses a fast pall call as thread
> > "register", s390 uses user access register 0 (and s390x uar 0 and 1), etc.).
> > On register starved ia32 there aren't too many spare registers, so %gs is
> > used instead.
> 
> So the x86 designers have provided all sorts of shadow registers and extensive
> high speed caches and the glibc developers deliberately choose to defeat all that
> expensive optimization?
> 

Uhm... none of that "expensive optimization" will help you here,
because you need *architectural storage*.  Archtectural storage is
always a fundamentally limited resource, regardless of how many shadow
registers you add.

However, an x86 has a whole additional register file which is rarely
used these days -- the segment register file.  The segment register
file is mainly useful when the main usage is address offsetting, since
it provides an extra input into the address adder.  For this
particular purpose, using it is very much the sane thing to do.

As far as %gs switching is concerned, using %gs doesn't automatically
mean using the LDT.  There are two ways you can avoid setting up LDTs
in single-threaded apps, and still allow an ABI compatible with the
threaded apps:

a) For single-threaded apps, define %gs == %ds.  Less than ideal for
   several reasons, but no kernel mods needed.

b) Have the kernel provide another GDT value which can be used by the
   single-threaded apps.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
