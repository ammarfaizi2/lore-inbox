Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318799AbSHLTmt>; Mon, 12 Aug 2002 15:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318802AbSHLTms>; Mon, 12 Aug 2002 15:42:48 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:41739 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318799AbSHLTmq>; Mon, 12 Aug 2002 15:42:46 -0400
Date: Mon, 12 Aug 2002 21:45:37 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Greg Banks <gnb@alphalink.com.au>, Peter Samuelson <peter@cadcamlab.org>,
       <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: [patch] config language dep_* enhancements
In-Reply-To: <Pine.LNX.4.44.0208120924320.5882-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0208121959360.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 12 Aug 2002, Kai Germaschewski wrote:

> Of course, this is a 2.5 change, though the only potential for breakage
> are the dep_* statements which are arguably already broken. It shouldn't
> be too hard to come up with a script which points out the dep_* statements
> which reference symbols defined only later (or use gcml2, which I
> understand can do that already?) to see how much breakage there may be.

Most should be fixable. The biggest problem are recursive references like
this:

if [ OLD != y ]; then
  tristate NEW
fi
if [ NEW != y ]; then
  tristate OLD
fi

with the latest modifications this can be written as:

dep_tristate NEW !OLD
dep_tristate OLD !NEW

This still has the back reference and you have to run 'make config'
twice to change NEW from n to y.
It's possible to fix this:

tristate DRV
if [ DRV == y ]; then
  choice OLD NEW
fi
if [ DRV == m ]; then
  dep_tristate NEW DRV
  dep_tristate OLD DRV
fi

That should look interesting in xconfig, but we could define a new
statement for this, but you get a new problem if the drivers had their own
suboptions and you want to arrange them most user friendly directly after
the driver statement like this:

tristate DRV
if [ DRV == y ]; then
  choice OLD NEW
  if [ NEW == y ]; then
    bool ...
  fi
  if [ OLD == y ]; then
    bool ...
  fi
fi
if [ DRV == m ]; then
  dep_tristate NEW DRV
  if [ NEW == y ]; then
    bool ...
  fi
  dep_tristate OLD DRV
  if [ OLD == y ]; then
    bool ...
  fi
fi

This should work quite well with config and menuconfig and maybe someone
fixes xconfig, so a lot can be fixed within cml1, but it won't be
necessarily nice. :) I didn't make up this example, just look at
CONFIG_SCSI_AIC7XXX* which would need fixing like this.
More examples of the cml1 limitations can be found in arch/ppc/config.in -
a single choice statement needs to be splitted into multiple choice
statements.
The current config is really very limited and can not be easily extended
(just try adding the help text or build information). At some point we
have to drop cml1 and replace it with something else. This doesn't has be
very painful, I have a tool that can convert most of the current config
into whatever you want.

bye, Roman

