Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSIHSDE>; Sun, 8 Sep 2002 14:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSIHSDD>; Sun, 8 Sep 2002 14:03:03 -0400
Received: from CPE00606767ed59.cpe.net.cable.rogers.com ([24.112.38.222]:55050
	"EHLO cpe00606767ed59.cpe.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S311885AbSIHSDA>; Sun, 8 Sep 2002 14:03:00 -0400
Date: Sun, 8 Sep 2002 14:09:00 -0400 (EDT)
From: "D. Hugh Redelmeier" <hugh@mimosa.com>
Reply-To: "D. Hugh Redelmeier" <hugh@mimosa.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: clean before or after dep?
In-Reply-To: <1031490782.26902.4.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0209081206590.21724-100000@redshift.mimosa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| From: Alan Cox <alan@lxorguk.ukuu.org.uk>

| > Which is the right order for clean and dep?
| 
| The "kernel-howto" has been badly broken for years. The world would
| actually be better without that document IMHO

OK, but then where is the right documentation?

The top level README mentions "clean" only one place, and it is not
relevant.

The top level Makefile does not explain the semantics and constraints of
the targets in question.

A grep through Documentation leads to apparent contradictions (this is
from Red Hat LINUX 7.3's linux-2.4.18-10 source):

Files suggesting dep ; clean:

Documentation/DocBook/sis900.tmpl:476:make clean
Documentation/cdrom/cm206:59:	make dep; make clean; make zImage; make modules
Documentation/filesystems/devfs/README:713:make xconfig) and then make dep; make clean and then
Documentation/filesystems/devfs/README:1546:Forgetting to run make dep; make clean after changing the
Documentation/kbuild/bug-list.txt:13:  on, do a 'make dep' followed by 'make clean' before you try anything
Documentation/modules.txt:27:	make clean
Documentation/networking/arcnet.txt:112:	make clean
Documentation/networking/arcnet.txt:191:	make clean	
Documentation/networking/sis900.txt:220:make clean
Documentation/smp.txt:18:   time -v sh -c 'make dep ; make clean install modules modules_install'
Documentation/telephony/ixj.txt:366:    4.	make dep;make clean;make bzImage;make modules;make modules_install


Files suggesting clean ; dep:

Documentation/isdn/README.HiSax:486:     make clean; make dep; make zImage; make modules; make modules_install
Documentation/moxa-smartio:256:	   b. make clean			     /* take a few minutes */
Documentation/networking/DLINK.txt:95:	  # make clean


What are the ordering constraints on mrproper, clean, dep, and
*config?  I'd like to characterise all sequences that properly prepare
for a kernel build.

What these targets do, according to README:

	mrproper: removes stale .o files and dependencies lying around
	clean: ? seems to remove files built by the build process
	*config: configure the kernel [build a .config]
	dep: set up dependencies

The normal sequence seems to be:
	mrproper && *config && dep && build
I'm not sure where clean comes in this sequence.  mrproper includes
clean, so this sequence will do it once.  Is it needed somewhere after
the *config too?

Is it safe to combine some or all targets in one make command, eg:
	make mrproper *config dep build
I've done this for some targets, but I wonder if it is safe to
have dep combined with any following targets since it computes
dependencies.

These issues come up when iteratively trying a kernel build that
fails.  What kinds of changes require an mrproper? a clean? a dep?

- is it safe to do an mrproper after a *config?  In other words, does
  mrproper affect/damage/undo anything done by *config?

- an mrproper undoes dep, so it must be followed by a dep


- is it safe to do a clean after a *config?  In other words, does clean
  affect/damage/undo anything done by *config?  Surely it is safe:
  many of us have done this for years.

- is it necessary to do a clean after a *config?  (README suggests no;
  many things in Documentation suggest yes.)
  One reason might be that dep requires this -- is this the case?
  <http://www.van-dijk.net/linuxkernel/200223/0432.html> suggests yes.
  Experience suggests no, at least until very recently.
  Or is there some other way in which dep now requires that
  it be preceded by a clean, perhaps after a failed build?

- is it safe to do a clean after a dep?  In other words, does clean
  affect/damage/undo anything done by dep?

- is it necessary to do a clean after a dep?  (README suggests no;
  many things in Documentation suggest yes.)  Does dep affect
  subsequent cleans?

- theory: a clean should be done after a failing build so that
  a subsequent build won't use the results of the failing build.

Hugh Redelmeier
hugh@mimosa.com  voice: +1 416 482-8253

