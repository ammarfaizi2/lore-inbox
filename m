Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265816AbTAJR1B>; Fri, 10 Jan 2003 12:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265819AbTAJR1B>; Fri, 10 Jan 2003 12:27:01 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:31755 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265816AbTAJR07>;
	Fri, 10 Jan 2003 12:26:59 -0500
Date: Fri, 10 Jan 2003 18:35:42 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How build dependencies work/are supposed to work in 2.5.5x
Message-ID: <20030110173542.GA1163@mars.ravnborg.org>
Mail-Followup-To: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	linux-kernel@vger.kernel.org
References: <CC66A71361E@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CC66A71361E@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 11:33:32PM +0100, Petr Vandrovec wrote:
>   So I'd like to ask whether current kernel build system is supposed
> to track changes in include files automagically, or whether I'm supposed
> to run 'make dep' from time to time?

Hi Petr,

First of all:
1) kbuild track changes in referenced include files
2) kbuild track changes in relevant CONFIG options

2) is done using the executable split-include.
When run split-include creates a tree of files in:
include/config/*
CONFIG_SND_PCM_OSS creates a file named include/config/snd/pcm, with the
name oss.h. oss.h contains 
#define CONFIG_SND_PCM_OSS 1
split-include uses this to determine if the config option in question
has changed such that only files containing changes are touched.

split-include is run when include/linux/autoconf.h has changed.
And autoconf.h has .config as the prerequisite, so each time the
configuration has changed autoconf.h is generated, and all relevant
files in include/config/* is updated.

1) When a .c/.S file is compiled the option
-Wp,-MD,arch/i386/kernel/.mpparse.o.d
is used to generate a file containing dependencies as gcc sees it.

Now the binary fixdep is used to generate dependencies including references
to all include/config/* files corresponding to all cONfig options used
in a given file.
Try to view a .*.o.cmd file in kernel/ ar similar.

Until now I'm only aware of one set of problems that kbuild does not
handle correct. That is when the timestamp of the files goes backward.
This happens at least in the following situations:
1) A file is saved, and mv is used to restore the original
2) CVS is configured to preserve original timestamp when files are 'dumped'
3) NFS mounted filesystems where the clock is wrong. Timezone
   inconsistency for eaxmple.

I assume you were hit by some flavour of 1) ???

kbuild-2.5 by Keith Ownes included timestamp checks, so that would have
catched the three cases described above.
I do not see any clean way to introduce this in existing kbuild,
and neither do i see a big need for it.
Anyway this belongs to the make problem domain - not kbuild core.

	Sam
