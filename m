Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132574AbRDOEVT>; Sun, 15 Apr 2001 00:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132576AbRDOEVK>; Sun, 15 Apr 2001 00:21:10 -0400
Received: from smarty.smart.net ([207.176.80.102]:26885 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S132574AbRDOEUx>;
	Sun, 15 Apr 2001 00:20:53 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200104150428.AAA31247@smarty.smart.net>
Subject: one step up from   vi .config
To: linux-kernel@vger.kernel.org
Date: Sun, 15 Apr 2001 00:28:37 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an example of a minimalist kernel config script using what I call
"subtractive synthesis", rather than the additive synthesis method of
make config and friends. This generates white-noise and then you filter
it, rather than painstakingly constructing your timbre one sinewave at a
time. Kinda. This example is for MCA-related pink noise, so to speak.
I think this may be related in a degenerate-case way to declarative
programming.

This leaves a lot to the user. It is based on the idea that hopefully
people with hardware with configuration interdependancies will be somewhat
cognizant of them.

I think this is close to a minimum for something that can generate any
desired config. I may have broken this somewhat tweaking it a bit to post,
but It's pretty handy when it works.

This is hereby public-domain-ified.

Rick Hohensee
:; cLIeNUX /dev/tty10  16:07:45   /
:;echo $DISTRO
cLIeNUX


.........................................................................

##              cLIeNUX Cheap Quick Dirty kernel config
##              MAD (Microchannel Affection Disorder) example

## dependancies         Linux sources and...
## sh, awk, clear, ed, your $VISUAL editor, rm, ls, mv, date
##   The usual /tmp is /.tm in cLIeNUX

# function declaration

swap () {               ## Last field, CONFIG_*, to second, after #
awk -- '
      {
      ORS=""
      print "\n# "  $NF
      for ( i = 1 ; i < NF ; i++ )  print " "$i
      } ' $1
}

# declarations
ARCH=i386
MCA=ONLY
C_INCLUDE_PATH=$C_INCLUDE_PATH:/source/kernel/$1
DATE=`date`

clear
echo -e "\t\t\tcLIeNUX linux/config\n\n\n\n
\ncollating base config data\n\n"

#### if a bla/Config.in file isn't in this list variable you won't see
###               the options that Config.in file contains.
##                Season to taste.
configlist="
arch/i386/config.in
fs/Config.in
drivers/char/Config.in
drivers/block/Config.in
drivers/scsi/Config.in
drivers/net/Config.in
fs/nls/Config.in
net/ipv4/Config.in
net/Config.in
net/sched/Config.in
net/irda/Config.in
net/irda/compressors/Config.in
drivers/net/hamradio/Config.in
drivers/net/irda/Config.in
drivers/block/paride/Config.in
drivers/char/ftape/Config.in
drivers/char/hfmodem/Config.in
drivers/char/joystick/Config.in
drivers/sound/lowlevel/Config.in
drivers/sound/Config.in
drivers/isdn/Config.in
drivers/video/Config.in
drivers/fc4/Config.in
fs/ncpfs/Config.in
net/ax25/Config.in
net/ipx/Config.in
"

##                      EXCLUDED from the above
## drivers/pnp/Config.in            ## put this back if not MCA
## drivers/cdrom/Config.in          ## put this back if not MCA
## drivers/usb/Config.in
## net/irda/irlpt/Config.in
## net/irda/ircomm/Config.in
## net/irda/irlan/Config.in
## net/irda/irlpt/Config.in
## net/irda/ircomm/Config.in
## net/irda/irlan/Config.in
## net/irda/irlpt/Config.in
## drivers/acorn/net/Config.in          Acorn
## drivers/acorn/scsi/Config.in
## drivers/acorn/block/Config.in
## drivers/acorn/char/Config.in
## drivers/sgi/Config.in                SGI
## drivers/sbus/char/Config.in          Mac
## drivers/sbus/audio/Config.in
## net/ipv6/Config.in
## drivers/fc4/Config.in                Fiber channel

cd linux

###MMMMMMMMMMMAAAAAAAAAAAAAIIIIIIIIIIINNNNNNNNNNNNNNN

echo > /.tm/BASE

## generate bulk CONFIG_ list.
#
for CF in $configlist
do
      echo -en  "\n# CONFIG\n# CONFIG " $CF "# CONFIG\n"  >> /.tm/BASE
      cat $CF >> /.tm/BASE
done

## format, then prune. Prune out experimental up front.
#
swap /.tm/BASE |grep "^# CONFIG" | grep -v -i "XPERIMEN" \
      | cut -b 1-74 >  /.tm/BASE2

rm /.tm/BASE

echo -e "\n\n\npruning...\n\n\n"

## convert choice types to "=y" and "=ym", then prune
#
ed <<HEREDOC   /.tm/BASE2
,s/ tristate '/=ym      #/
,s/ bool '/=y     #/
,s/'$//
g/Sun /d
g/Atari/d
g/Mac /d
g/Sparc/d
g/Amiga/d
wq
HEREDOC

## pro-Microchannel extreme prejudice
#
if test "$MCA" = "ONLY"
then
      ed <<HEREDOC   /.tm/BASE2
      g/PCI/d
      g/IDE/d
      g/PNP/d
      g/ISA/d
      g/_APM_/d
      wq
HEREDOC

fi

## header and assemble CONFIG
#
#
echo "##  " `date` >   CONFIG
cat  <<HEREDOC >>  CONFIG
#
# Assuming you are seeing this via the cqdconfig script, what you do
# now is uncomment (remove the leftmost # from) the kernel options you
# want. Nothing is on now. The variables that are activated by you
# in here are then asserted as kernel sourcecode, and the
# kernel will be built accordingly. Variables can be =y or completely
# unset, and module options can also be m. If an option in here is =y you
# just have to uncomment it to assert it. If it's =ym you have to decide
# if you want it as a module or in the base kernel and pick y or m, IF you
# enable modules, and want that option. These options are additive.
# You can for example build a useless x86 kernel with just CONFIG_M386 and
# maybe a memsize option. In a useful kernel there may be some option
# interdependancies. Your only automated check on them with this
# non-rigorous config method is compiling and running the result. Most
# things that aren't non-interdependant single options will probably be
# known to people that have them. If you have problems use  make config  ,
# or read Documentation/Configuration.help.
#
# The cqdconfig script that generated this file is part of your
# configuration options in and of itself. You can
# tweak it to not include any options here that you're not interested in
# if you have a working knowledge of regular expression match patterns.
# see regex. All that really matters is that the end result be valid. You
# are actually modifying the kernel code when you edit this file, to
# stretch a point a bit, but if you don't use modules, and you don't mind
# an enormous list of options, all you have to know about shell scripting
# is that "#" starts a comment.
#
#                Break a leg   :o)
#                                         Rick
HEREDOC

cat /.tm/BASE2 >> CONFIG

## call an editor, then do what "make config" does to assert the config
#

$VISUAL CONFIG

clear
echo "Clobbering .config.old and linux/include/linux/autoconf.h,
        which asserts your configuration choices.

        make dep    is probably your next move.

"

mv .config .config.old
cp  CONFIG .config
cp .config include/linux/autoconf.h

.......................................................................
