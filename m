Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSIEAId>; Wed, 4 Sep 2002 20:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSIEAId>; Wed, 4 Sep 2002 20:08:33 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:40459 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316683AbSIEAI0>; Wed, 4 Sep 2002 20:08:26 -0400
Message-ID: <3D76A13F.8BDC8E8C@linux-m68k.org>
Date: Thu, 05 Sep 2002 02:11:43 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: linux kernel conf 0.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At http://www.xs4all.nl/~zippel/lc/lkc-0.4.tar.gz you can find the
latest version of my config system. It slowly is becoming completely
usable, so it's time for a new release.
A lot has changed since the last official release, so here only some
highlights:
- correct dependencies for the config files are now generated, "make
oldconfig" isn't needed anymore in many cases (you should try it before
making any comments about it).
- config rulebase is with some small (known) exceptions the same in the
old and new syntax, even comments are now preserved.
- menuconfig is working again. Except of xconfig the user interface is
almost as before, anything you could do before, you still can do.
- it's much faster in the common case.
- clean separation between frontends and backend.

Installation is very simple with "make install KERNELSRC=<..>", where
KERNELSRC points to a 2.5.33 kernel tree. "make uninstall
KERNELSRC=<..>" will deinstall everything.
I think the new system is ready for wider testing, so any feedback is
very much appreciated. Most important is probably the new syntax, until
it it's integrated I can easily change the converter to generate
whatever syntax. I still have to update the documentation, but the
syntax should be easily understandable even without it. For the lazy
guys out there, here is an (already advanced) example:

choice
  prompt "Adaptec AIC7xxx support"
  optional
  depends SCSI

config SCSI_AIC7XXX
  tristate "New driver"
  help
  ...

config AIC7XXX_CMDS_PER_DEVICE
  int "Maximum number of TCQ commands per device"
  depends SCSI_AIC7XXX
  default "253"
  help
  ...

config AIC7XXX_RESET_DELAY_MS
  int "Initial bus reset delay in milli-seconds"
  depends SCSI_AIC7XXX
  default "15000"
  help
  ...

config AIC7XXX_BUILD_FIRMWARE
  boolean "Build Adapter Firmware with Kernel Build"
  depends SCSI_AIC7XXX

config SCSI_AIC7XXX_OLD
  tristate "Old driver"
  help
  ...

config AIC7XXX_OLD_TCQ_ON_BY_DEFAULT
  boolean "Enable Tagged Command Queueing (TCQ) by default"
  depends SCSI_AIC7XXX_OLD
  help
  ...

config AIC7XXX_OLD_CMDS_PER_DEVICE
  int "Maximum number of TCQ commands per device"
  depends SCSI_AIC7XXX_OLD
  default "8"
  help
  ...

config AIC7XXX_OLD_PROC_STATS
  boolean "Collect statistics to report in /proc"
  depends SCSI_AIC7XXX_OLD
  help
  ...

endchoice

This new syntax basically fixes the recursive dependencies in the old
syntax:

if [ "$CONFIG_SCSI_AIC7XXX_OLD" != "y" ]; then
   dep_tristate 'Adaptec AIC7xxx support' CONFIG_SCSI_AIC7XXX
$CONFIG_SCSI
   if [ "$CONFIG_SCSI_AIC7XXX" != "n" ]; then
      ...
   fi
fi
if [ "$CONFIG_SCSI_AIC7XXX" != "y" ]; then
   dep_tristate 'Old Adaptec AIC7xxx support' CONFIG_SCSI_AIC7XXX_OLD
$CONFIG_SCSI
   if [ "$CONFIG_SCSI_AIC7XXX_OLD" != "n" ]; then
      ...
   fi
fi

The most important thing here is that you now always see that there is a
choice between two drivers. For example in menuconfig you had to know
that you have to disable one option to see the other option or if you
have an old .config, which doesn't contain CONFIG_SCSI_AIC7XXX_OLD, but
has CONFIG_SCSI_AIC7XXX set to 'y', "make oldconfig" won't tell you
about the new option.

Anyway, back to the new syntax. One thing I'm not yet completely sure
about is indention, as it might help to make above more easily readable.
The parser automatically recognizes the suboptions (by analyzing the
dependencies) and the frontends present them accordingly (how exactly
you should try yourself :) ). The problem here are the help texts, they
should be easily editable, but on the other hand the parser has to find
where it ends (and possibly reformat it a bit). Right now the help text
simply ends at the first line that doesn't start with a white-space. So
I'm toying with various ideas to make the suboption more easily
recognizable, e.g. they could also be put within an "if FOO" ... "endif"
block.

Something else above example demonstrates is the default value, first,
bool and tristate symbols can have default values as well and second,
something like this is possible:

config FOO
  bool 'bar' if BAR
  default y

The default value has two meanings here, first it's used as default
value for the prompt and if the prompt isn't visible, FOO is set to it.
This is quite useful for some of the advanced config options.

That's it for now, so have fun and complain _now_, not when it's too
late. :)

bye, Roman
