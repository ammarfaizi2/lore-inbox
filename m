Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266120AbTAMNMV>; Mon, 13 Jan 2003 08:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267357AbTAMNMV>; Mon, 13 Jan 2003 08:12:21 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:61420 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S266120AbTAMNMU>; Mon, 13 Jan 2003 08:12:20 -0500
Date: Mon, 13 Jan 2003 14:20:45 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: davidm@hpl.hp.com, Mike Stephens <mike.stephens@intel.com>,
       linux-kernel@vger.kernel.org, bjornw@axis.com, geert@linux-m68k.org,
       ralf@gnu.org, mkp@mkp.net, willy@debian.org, anton@samba.org,
       gniibe@m17n.org, kkojima@rr.iij4u.or.jp, Jeff Dike <jdike@karaya.com>
Subject: Re: Userspace Test Framework for module loader porting 
In-Reply-To: <20030113011128.76CDC2C052@lists.samba.org>
Message-ID: <Pine.GSO.3.96.1030113114240.25230B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, Rusty Russell wrote:

> > I'm also a bit worried about changing module loaders so often.  Yeah,
> > once you switch to a kernel-loader, presumably users won't be
> > affected, but (kernel-module) developers will be.
> 
> While ET_DYN modules are a reasonably serious win for ia64 (and
> probably hppa) (ie. -300 lines or so), they're a minor win for alpha
> and ppc64 (-100 lines or so), and no real change for arm, i386, ppc,
> sparc, and sparc64.  It's a lose for x86_64 (toolchain fixes, unless
> they want to use -fPIC for modules), mips and mips64 (major toolchain
> fixes, unless they want to use -fPIC for modules and stop using r28
> for current inside modules).

 Hmm, what's the gain from using shared objects as opposed to relocatables
and why is there any for non-PIC objects at all?  After all, the reason
for using shared objects is to handle shared PIC code, for which
relocation is indeed easier to perform -- you only need to relocate the
GOT and data sections, the latter being rare and with a limited number of
relocation types.  For non-PIC shared objects the GOT and data sections
still need to be relocated, but text sections do as well, introducting all
the relocation types back.  The end result is almost no different from
operating on relocatables. 

 From the MIPS pov, adding non-PIC support to tools would mean defining
R_MIPS_26 (with some effort these could mostly be avoided for modules less
than 128kB in size), R_MIPS_32, R_MIPS_HI16 and R_MIPS_LO16 for shared
objects.  Additionally R_MIPS_64, R_MIPS_HIGHEST and R_MIPS_HIGHER for
MIPS64.  A few ABI issues should be resolved, specifically how to create
the GOT and the dynamic section, possibly others, as the MIPS ABI
supplement doesn't define handling of non-PIC shared objects.  An
implementation for the BFD, though likely tiresome, shouldn't be difficult
in principle, but tricky issues may arrise due to BFD's subtleties.  And
the overall processing gain would be questionable, IMO. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

