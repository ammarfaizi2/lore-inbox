Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286179AbSBUKta>; Thu, 21 Feb 2002 05:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292326AbSBUKtU>; Thu, 21 Feb 2002 05:49:20 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:25867 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S286179AbSBUKtG>; Thu, 21 Feb 2002 05:49:06 -0500
Date: Thu, 21 Feb 2002 11:48:59 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: linux kernel config converter
Message-ID: <Pine.LNX.4.21.0202210011080.32476-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After all the flam^Wdiscussion about cml2 I decided to something more
constructive and try to do the impossible (and as lkml was dead I hadn't 
much choice :) ).
At http://www.xs4all.nl/~zippel/lkcc.tar.gz there is a small program which
converts the config files into an alternative format. The tool expects a
Configure.help in the root of the kernel tree, so a "find -name
Config.help | xargs cat >> Configure.help" is needed, then start it with
"lc arch/<arch>/config.in".
The output is completely unsorted, so all menu information isn't there
(but that is easy to change), Otherwise it has the same information for
every symbol as the normal config files.
The current output looks like this:

config: ULTRIX_PARTITION
  define_bool
    default: y
    dep: ((!PARTITION_ADVANCED?) && DECSTATION=y)
  bool
    prompt:   Ultrix partition table support
    dep: PARTITION_ADVANCED?
  help:
  Say Y here if you would like to be able to read the hard disk
  partition table format used by DEC (now Compaq) Ultrix machines.
  Otherwise, say N.

Now I'm curious what advantages cml2 has. I'm seeing a quite complex
specification with lots of features and I'm not sure whether all this is
really required. IMO Eric tries to solve a more complex problem and I
think this problem isn't relevant for the kernel configuration, so what
we can do is to reduce the problem complexity. This means we can make sure
that dependencies are strictly hierarchical (the tool checks for that),
this would make working with the rules far easier (implementing a 'make
oldconfig' would be very simple).
What am I missing now, that we can't convert the current configs into
something like above and add new features later to it? I don't know if
above can be changed into something that looks more like cml2, but the
most important property of this is that we don't have to do all the
conversion at once. Some things can/should already be fixed in cml1, so
that the generated files only needs minimal changes and both can be tested
and used at the same time until we abandon cml1. After that we can think
about new features, like including build information.

Some technical notes about the tool:
- I implemented a few simple optimizations to make the dependencies easier
readable, there of course far more possible, but some changes could be
done at the original config files to make this easier, e.g. dependencies
can there already be simplified. Another problem is that one can set some
tristate symbols to 'y' although another dependent symbol is set to 'm'
(e.g. for CONFIG_FB_MATROX/CONFIG_FB_MATROX_G450 it goes wrong). This is
something that IMO should be checked and fixed in cml1 first.
- The output for choices represents the internal implementation, so that
definitely needs a new syntax. On the other hand the remaining syntax of
course needs to be improved as well.
- Dependencies include the type of the symbol if possible ('?' - boolean,
'??' - tristate, '*' - data), it isn't complete yet, since some symbols
are only defined for some architectures. A complete dependency graph for
all archs would certainly be interesting. :)
- The program is just a small hack done within a dew days, please keep
this in mind, when looking at it. :) So don't expect any comments and the 
structure is still quite chaotic. On the other hand the program isn't
supposed to be used forever.

bye, Roman

