Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318159AbSHDLoh>; Sun, 4 Aug 2002 07:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318161AbSHDLoh>; Sun, 4 Aug 2002 07:44:37 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:61444 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S318159AbSHDLof>;
	Sun, 4 Aug 2002 07:44:35 -0400
Date: Sun, 4 Aug 2002 00:11:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] automatic module_init ordering
Message-ID: <20020804001147.A9226@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20020802232232.A25583@mars.ravnborg.org> <Pine.LNX.4.44.0208022011490.24984-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208022011490.24984-100000@chaos.physics.uiowa.edu>; from kai@tp1.ruhr-uni-bochum.de on Fri, Aug 02, 2002 at 08:17:17PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2002 at 08:17:17PM -0500, Kai Germaschewski wrote:
> Yeah. Still not exactly clean. Another suggestion I got was
> 
> +     objs="$(sort $(local-objs-y))"; for o in $$objs; do \
> 
> from Alex Riesen. This one looks the nicest to me.
Looks indeed better!
But in order to avoid malfunction for the directories where there
is no initcalls you still need to fiddle with $(if $(local-objs-y)
and similar for subdir-y.
The trick is to add only the needed number of ';', no more no less.
Try playing around with:

$> make mrproper allnoconfig
$> make

Another issue that I noticed after submitting the patch was that
due to the fact the 'echo' in gen_build... always create a .builtin_mods
file, there appear a number of lines only listing an empty directory
witin .allbuiltin_mods.
I would recommend to
1) Use sed to get rid of the empty lines,
2) to do something like this in the Makefile:
init/generated-initcalls.c: $(wildcard $(addsuffix /.builtin_mods,\
$(dir $(CORE_FILES) $(LIBS) $(DRIVERS) $(NETWORKS)))
        $(CONFIG_SHELL) -e scripts/build-initcalls $< $^ $@
And then move the contatenation of the .builtin_mods files to
build-initcalls.

Giving the above a second thought I do not understand the usage of
"$^" when generating .allbuiltin_mods. Don't you miss initcalls in subdirs
that are not being updated?
I would say that an all or nothing approach is more correct.


Another issue:
If I do:
$> find -name '.builtin_mods' | xargs rm -f
$> make
the .builtin_mods files are not regenerated. Some rule are missing...

	Sam
