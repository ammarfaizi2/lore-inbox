Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267397AbSKSVuk>; Tue, 19 Nov 2002 16:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267399AbSKSVuk>; Tue, 19 Nov 2002 16:50:40 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:12563 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267397AbSKSVui>;
	Tue, 19 Nov 2002 16:50:38 -0500
Date: Tue, 19 Nov 2002 22:57:41 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: Larry McVoy <lm@bitmover.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [RFC/CFT] Separate obj/src dir
Message-ID: <20021119215741.GA4308@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	Larry McVoy <lm@bitmover.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
References: <20021119123115.C16028@work.bitmover.com> <Pine.LNX.4.44.0211191444400.24137-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211191444400.24137-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 02:48:09PM -0600, Kai Germaschewski wrote:
> Wrt the original patch, I like it, one preliminary comment is that I think
> symlinks are nicer than copying. They are faster, shouldn't cause any
> trouble on NFS, make uses "stat" and not "lstat", so it gets the
> timestamps right, too. And if you edit a Makefile/Kconfig in the source
> tree, you rather want that to take effect immediately, I guess ;)

Second try on the script.
Create symlinks as suggested, and optimised find a liitle.

	Sam

#!/bin/sh
#
# This script is used to build a kernel from a separate directory.
# The location of this script is assumed to be the root of
# the kernel tree.
# Usage:
# kernel src located in:
# ~/kernelsrc
# compile in:
# ~/compile
# cd ~/compile   <= Change to the directory where the compile shall take place
# ../kernelsrc/kbuild
#
# Arguments to kbuild is the same as used to make in the kernel build
# kbuild prints out SRCTREE and OBJTREE when started, and then makes a mirror
# of relevant files from the kernelsrc.

# files we do not care about in the kernel src
RCS_FIND_IGNORE="-name SCCS -o -name BitKeeper -o -name .svn -o -name CVS"

OBJTREE=$PWD
cd `dirname $0`
SRCTREE=$PWD
cd $OBJTREE
echo OBJTREE $OBJTREE
echo SRCTREE $SRCTREE
if [ "$SRCTREE" != "$OBJTREE" ]; then
  if [ -f $SRCTREE/.config -o -d $SRCTREE/include/asm ]; then
    echo '$SRCTREE contains generated files, please run "make mrproper" in the SRCTREE'
  else
    for a in `cd $SRCTREE; \
      find \( $RCS_FIND_IGNORE \) -prune -o -name Makefile\* -o -name Kconfig\* -o -name defconfig`; do
      if [ ! -d `dirname $a` ]; then
        mkdir -p $a
      fi
      ln -fs $SRCTREE/$a $a
    done

    ( echo "srctree := $SRCTREE";
      echo "objtree := $OBJTREE";
    ) > .tmp_make_config
    touch Rules.make
  make $*
  fi
else
  rm -f .tmp_make_config
  make $*
fi
