Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVDDC0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVDDC0S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 22:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVDDC0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 22:26:17 -0400
Received: from relay02.roc.ny.frontiernet.net ([66.133.182.165]:59570 "EHLO
	relay02.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S262216AbVDDCLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 22:11:14 -0400
Subject: Software Suspend on Sony Vaio R505E
From: Aaron Gaudio <prothonotar@tarnation.dyndns.org>
Reply-To: prothonotar@tarnation.dyndns.org
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-ggylSx1sspMH2uHxhzVm"
Date: Sun, 03 Apr 2005 22:10:59 -0400
Message-Id: <1112580660.5797.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ggylSx1sspMH2uHxhzVm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

(I'm not currently subscribed to the kernel mailing list, please CC any
replies to my account.)

I've been trying hibernate on my Sony Vaio R505E using Software Suspend.
I'm using the following command:
echo -n "disk" > /sys/power/state

The basic suspend/resume seems to be working now (after many failed
attempts at the past). 

However, there are still a few problems...

I'm using Fedora Core 3 with the fedora kernel 2.6.10-1.770 kernel,
rebuilt to enable software suspend (and USB suspend). At some point,
I'll be trying the software suspend 2 patch to see how far that can get
me. Attached is the output of my syslog after the resume.

My wireless adapter doesn't work on resume. It's a built-in using the
orinoco_cs driver. I get the following messages in /var/log/messages:

Apr  3 13:07:12 localhost kernel: NETDEV WATCHDOG: eth1: transmit timed
out
Apr  3 13:07:12 localhost kernel: eth1: Tx timeout! ALLOCFID=00c0,
TXCOMPLFID=00bf, EVSTAT=808b

I also get a bunch of messages about usb problems, though I don't have a
USB device connected at the time:

Apr  3 13:07:25 localhost kernel: usb 3-1: 05-wait_for_sys timed out on
ep0in
Apr  3 13:07:25 localhost kernel: usb 3-1: khubd timed out on ep0in
Apr  3 13:07:30 localhost kernel: usb 3-1: khubd timed out on ep0in
Apr  3 13:07:30 localhost kernel: usb 3-1: string descriptor 0 read
error: -110

... and so forth...

Finally, trying to use 3D fails after resuming (Intel 830 using the i915
DRM module). glxgears gives this error: "intelWaitIrq: drmI830IrqWait:
-16" and syslog has "Apr  3 20:29:53 localhost kernel:
[drm:i915_wait_irq] *ERROR* i915_wait_irq: EBUSY -- rec: 0 emitted: 5".
After restarting X, 3D works as usual.

If there's any further debug or investigation I can do, or any tricks to
try, lemme know. I'll try out Software Suspend 2 when I get a chance.

-- 
Aaron Gaudio <prothonotar@tarnation.dyndns.org>

--=-ggylSx1sspMH2uHxhzVm
Content-Disposition: attachment; filename=suspend.sh
Content-Type: application/x-shellscript; name=suspend.sh
Content-Transfer-Encoding: 7bit

#! /bin/sh
##### DO NOT CHANGE COMMENT LINES WITH start/end STATEMENT
##### DO NOT ADD LINE BEFORE THIS ONE: --install depends on it

VERSION=0.14
if ( echo $@ | grep -e "--version" ) 1> /dev/null; then
    echo "Installation script:     $0"
    echo "suspend script (Version: $VERSION)"
    exit 0
fi


##################### CHANGELOG start #########################################
# ChangeLog:
# 0.14: - Add a --verbose option
#       - Remove ppp0 as default interface to stop (ifdown script cannot
#         work with ppp0).
#       - Change pppd for /usr/sbin/pppd in Mandrake conf (add a distro depending
#         variable for that).
# 0.13: - Add ppp0 as default in interfaces to stop
#       - Add vmware and pppd progs as non compatible progs
#       - Use of tee instead of cat for LOGCMD (problem with redirection char)
#         and redirection to /dev/null for standard output of LOGCMD.
#       - Add beep mention (beta19 and above) in comment of SWSUSP_FORCE_SUSPEND_MODE
#         (default unchanged)
# 0.12: - Add -x c for gcc compilation (roland.stigge@antcom.de)
#       - Change lock dir to /var/lock for Debian
#       - Defaults to VT number 7 if ORIGINAL_VT isn't correct
#       - Fix a return bug in SwitchFromX
#       - Introduce a "| $LOGCMD" instead of "> $VERBOSE". This is first step
#         of a modification that would allow to log to stdout, VT9, /tmp/logfile,
#         etc. in parallel
#       - When compiling usleep, enter directory instead of fullname
# 0.11: - Modification of Mandrake detection
#       - Change order of variables in default configuration file
# 0.10: - Merge with 0.9-go1 version by Gunter Ohrner
#        <G.Ohrner@post.rwth-aachen.de>:
#          - extended the PATH to contain /usr/local/s?bin - why is this script meddeling
#            with the PATH anyway? (OK suppressed)
#          - improved usleep auto generation/installation procedure
#          - fixed incorrect double-start of the fake X if SWSUSP_LEAVE_X_BEFORE_SUSPEND is
#            set to nVidia and incorrect VT switching in other cases. The new logic DEPENDS
#            on the presense of fgconsole but that could easily be conditionalized to
#            get the old behaviour again if fgconsole is not present. (If there ARE systems
#            where it's missing.)
#       - Fix INITDIR/RLVLDIR bug that makes the services not started/stopped.
#       - Change behaviour of SWSUSP_START/STOP_SERVICES to *not* check init states. Some
#         distros (e.g. Mandrake) have scripts called directly by rc.sysinit and we want to
#         force a start/stop.
#       - Change Mandrake defaults to properly restore usb devices.
# 0.9: - Change suspend script name to hibernate upon installation.
#      - Create a suspend.conf.new file to help merging between versions of this script.
#      - Merge version 0.7-cr7 sent by Carsten Rietzschel <cr@daRav.de>
#	  - fixed a typo in RemountDevices() (REMOUNT_S_)
#	  - added kill_prog/start_progs: the apps are killed or started (no need to be an service)
#         - hwclock output directed to $VERBOSE
#         - xinit and xauth output directed to /dev/null
#	  - update for Gentoo (there the script is in /sbin/sw-suspend
#         - no >$VERBOSE in installation part
#         - colorfull ouput
#         - more informations and verbose-console setting (default is console 9)
#     - Merge with changes by Ulrich.Lauther@siemens.com:
#         - install and changelog sections are NOT copied to output script
#         - changed name of generated script to "hibernate" to avoid
#           conflict with bash's suspend command and with (hopefully to come?)
#           suspend to RAM
#         - added check for activated swap-space
#         - added Slackware section
#         - added more explanation to FORCE_SUSPEND_MODE parameter
#         - improved support for systems without usleep
#      - As suggested by Gunter, add a sanity check before using gcc
# 0.8: - Redhat updates sent by Nicolas Appert <Nicolas.Aspert@epfl.ch>
# 0.7: - Fix auto bug in start services with 0.6-go1 version by Gunter Ohrner
#        <G.Ohrner@post.rwth-aachen.de>:
#         - splitted SWSUSP_STOP_SERVICES_BEFORE_SUSPEND/auto into
#           SWSUSP_RESTART_SERVICES, SWSUSP_STOP_SERVICES_BEFORE_SUSPEND
#           and SWSUSP_START_SERVICES_AFTER_RESUME so you can "start but
#           not stop" or "stop but not start" scripts without loosing the
#           "smart" service restart facility (suspend.sh's "auto"
#           behaviour)
#         - Tweaked the init-script-call-order a bit such that
#           incorrectly switched script calls are avoided (I hope...)
#         - A bug in STOP_SERVICES-auto-mode introduced in 0.6 and caused
#           by merging my 0.5-go1 changes into the official script was
#           fixed/removed by these changes.
#         - cleaned up and sorted Debian GNU/Linux's RESTART_SERVICES
#           default list
# 0.6: - Change pcmcia order for redhat (default stuff)
#      - Merge with 0.5-go1 version by Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>:
#        - Fix a bug introduced in RestartServices: one want to restart services in
#          reverse order in auto mode.
# 0.5-go1:
#      - Check for all init scripts mentioned in the config file whether
#        they need to be called and call them in the order specified in the
#        runlevel configuration.
#      - Add support for Debian GNU/Linux
# 0.5: - Fix for multiple ttys by server X (deleted)
#      - Fix uncorrect trick with nvidia option, deal with xauth,
#        and add more user friendly pop-up message
#      - Add an hdparm command to disable cache writing before suspend
# 0.4: - Add a --version option
#      - Add the xinit /bin/false trick for NVidia cards
#      - Suppress vmware in defaults stopped services
#      - Add a sync call
#      - Reverse the default SWSUSP_SAVE_CLOCK_ON_SUSPEND to "no" because
#        if a problem occur and we don't restore clock on resume, then
#	 we'll corrupt the CMOS clock.
#      - Use /bin/echo instead of builtin for suspending. It seems that
#        sometimes echo 4 > /proc/acpi/sleep never returns, so we execute
#        it in background.
#      - Test executables /etc/init.d scripts instead of readable.
#      - Modify Mandrake detection since drakconf place has changed.
#      - Add postfix and nfs to default stop services
#      - /dev/tty may not be available: adding a test and /dev/console output
# 0.3: - Add version, fix typos (french message :-) and add changelog.
#      - Modify hw clock use. Always read on resume, but write before
#        suspend is configurable (to fix drift amplification problem)
#      - Add a diff in install phase when configuration file already exists
#      - Change gpm place in default start/stop services.
#      - Add a test for root id
#      - Add some udelays for proper unloading of modules
#      - Add a lock file to prevent two scripts from running together
#      - Add a configuration option for using acpi interface or
#        enable reboot instead of halt
#      - Change alsa place in default start/stop services, since usb
#        and pcmcia can use snd module to notify events.
#      - Add a check on running of some incompatible programs.
#      - Restore console font
#      - Add a --nosuspend option
#      - Modify --install procedure to suit different distros
# 0.2: - Modification by Florent (fchabaud@free.fr): first version
#        published at sourceforge.net
#      - Add a --install option that installs the script and its
#        configuration file /etc/suspend.conf
#      - Add state control to exactly recover session when suspending
#        is aborted.
#      - Completely reorganize script (sorry Doug :-)
#        - suppress the smbfs and nfs unmounts (rationale: this
#          should be left to configuration - the user can set its samba
#          mount points if he/she wants them to be unmounted)
#        - suppress the grub/lilo alteration (rationale: I don't like
#          the idea that swsusp can modify the boot configuration of a machine ;-)
#        - modify the modules loading/unloading. The script now try to
#          unload all unused modules. On resume the specified modules
#          are loaded, whether they were unloaded or not (rationale:
#          this should be more robust).
# 0.1: First script posted by Doug (doug@tunl.duke.edu)
#
##################### CHANGELOG end #########################################

TMP=/dev/shm/suspend.$$
if ! touch $TMP 2> /dev/null ; then
    TMP=/tmp/suspend.$$
    if ! touch $TMP 2> /dev/null ; then
	echo "Can't open a temporary file in /dev/shm nor /tmp"
	echo "Aborting !"
	exit 1
    fi
fi

ID=`id -u`
if [ "$ID" != "0" ]; then
    echo "You must be root to use this script."
    echo "Use sudo to enable it for users."
    exit 1
fi

if ( echo $@ | grep -e "--silent" ) 1> /dev/null; then
    VERBOSE='/dev/null'
    HWCLKDEBUG=""
else
    if [ -w $VERBOSE_CONSOLE ] ;then
	VERBOSE="$VERBOSE_CONSOLE"
    elif [ -w /dev/tty ] ;then
	VERBOSE='/dev/tty'
    else
	VERBOSE='/dev/console'
    fi
    HWCLKDEBUG="--debug"
fi

LOGCMD="tee -a $VERBOSE"

if ( echo $@ | grep -e "--verbose" ) 1> /dev/null; then
    if [ -w /dev/tty ] ;then
	VERBOSE='/dev/tty'
    else
	VERBOSE='/dev/console'
    fi
else
    VERBOSE='/dev/null'
fi

# This overides failsafe cancellation and forces suspend or installation
if ( echo $@ | grep -e "--force" ) 1> $VERBOSE; then
    FORCE='yes'
else
    FORCE='no'
fi

##################### INSTALL start ###########################################

if ( echo $@ | grep -e "--install" ) 1> $VERBOSE; then
    if ! which usleep ; then
	if ! which gcc > $VERBOSE ; then
	    echo "Warning: neither 'usleep' nor gcc found... suspending will be dead slow"
	else
	    echo "You do not appear to have a 'usleep' command installed but gcc seems to be"
	    echo "present, so I can create one for you. 'usleep' is not strictly neccessary"
	    echo "for this script to work but will speed up suspension a LOT. And, believe"
	    echo "me, I mean that."
	    echo "Would you like me to compile a minimal 'usleep' program? [y/n]"
	    read -e INSTALL
	    if [ "x$INSTALL" == "xY" -o "x$INSTALL" == "xy" ] ; then
		echo "Where would you like the 'usleep' program to be installed? [/usr/local/bin]"
		read -e FULLNAME
		test -z "$FULLNAME" && FULLNAME="/usr/local/bin"
		FULLNAME="$FULLNAME/usleep"
		
		cat << EOF > $TMP.c
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char** argv) {
  unsigned long t = atoi(argv[1]);
  usleep(t);
  return 0;
}
EOF

		gcc -x c -O2 -o "$FULLNAME" $TMP.c || ( echo "Unable to compile $TMP.c in $FULLNAME..."; exit 1 )
		rm $TMP.c
		strip "$FULLNAME"
		echo "Place `dirname $FULLNAME` in your PATH, otherwise suspending will be dead slow."
		echo ""
	    else
		echo ""
		echo -e "\033[1;31m******************************************************************"
		echo -e "You chose not to install a usleep program. Suspending and resuming"
		echo -e "will be dead slow. You have been warned!"
		echo -e "******************************************************************"
		echo -e "\033[0m"
		echo "Press enter to continue." ; read
	    fi
	fi
    fi
    DISTRIB=Unknown
    if [ -d /etc/rc.config.d ] ; then
	DISTRIB=SuSE
    elif [ -f /etc/mandrake-release ] ; then
	DISTRIB=Mandrake
    elif [ -f /etc/debian_version ] ; then
	DISTRIB=Debian
    elif [ -f /etc/redhat-release ] ; then
	DISTRIB=Redhat
    elif [ -f /etc/gentoo-release ] ; then
	DISTRIB=Gentoo
    elif [ -f /etc/slackware-version ] ; then
	DISTRIB=Slackware
    fi
    echo DISTRIB: $DISTRIB
    BINNAME=hibernate
    INSTALLER=`pwd`/$0
    case "$DISTRIB" in
	SuSE)
	    CONFIGFILE=/etc/rc.config.d/suspend.rc.config
	    INITDIR=/etc/init.d
	    RLVLDIR=/etc/rc.d
	    INSTALLDIR=/usr/sbin
	    IFDOWN=$INITDIR/network
	    OPTDOWN=stop
	    IFUP=$INITDIR/network
	    OPTUP=start
	    SHELL=/bin/bash
	    LOCKFILE=/var/lock/subsys/swsusp
	    SETSYSFONT=$INITDIR/kbd
	    OPTSYSFONT=start
	    DEFAULTSTARTSERVICES=
	    DEFAULTRESTARTSERVICES="postfix alsasound irda gpm xntpd inetd nfs dhclient network pcmcia usbmgr"
	    DEFAULTSTOPSERVICES=
	    SWSUSP_UMOUNTS="/floppy /cdrom /var/adm/mount"
	    SWSUSP_INSERTMODS=""
	    SWSUSP_NON_COMPATIBLE_PROGS=""
	;;
	Mandrake)
	    CONFIGFILE=/etc/suspend.conf
	    INITDIR=/etc/init.d
	    RLVLDIR=/etc/rc.d
	    INSTALLDIR=/usr/local/sbin
	    IFDOWN=/etc/sysconfig/network-scripts/ifdown
	    OPTDOWN=
	    IFUP=/etc/sysconfig/network-scripts/ifup
	    OPTUP=
	    SHELL=/bin/bash
	    LOCKFILE=/var/lock/subsys/swsusp
	    SETSYSFONT=/sbin/setsysfont
	    OPTSYSFONT=
	    DEFAULTSTARTSERVICES="usb netfs alsa"
	    DEFAULTRESTARTSERVICES="postfix xntpd xinetd nfs gpm pcmcia irda sound"
	    DEFAULTSTOPSERVICES="alsa netfs usb"
	    SWSUSP_UMOUNTS="/mnt/floppy /mnt/cdrom"
	    SWSUSP_INSERTMODS=""
	    SWSUSP_NON_COMPATIBLE_PROGS="/usr/sbin/pppd"
	;;
	Debian)
	    CONFIGFILE=/etc/suspend.conf
	    INITDIR=/etc/init.d
	    RLVLDIR=/etc
	    INSTALLDIR=/usr/local/sbin
	    IFDOWN=/bin/true
	    OPTDOWN=
	    IFUP=/bin/true
	    OPTUP=
	    SHELL=/bin/sh
	    LOCKFILE=/var/lock/swsusp
	    SETSYSFONT=$INITDIR/console-screen.sh
	    OPTSYSFONT=
	    DEFAULTSTARTSERVICES="mountnfs.sh modutils"
	    DEFAULTRESTARTSERVICES="postfix exim ntpdate xntpd inetd xinetd noflushd sleepd anacron gpm pcmcia irda alsa setserial etc-setserial nfs-common networking ifupdown netenv laptop-net ipsec"
	    DEFAULTSTOPSERVICES="umountnfs.sh"
	    SWSUSP_UMOUNTS="/mnt /floppy /cdrom"
	    SWSUSP_INSERTMODS=""
	    SWSUSP_NON_COMPATIBLE_PROGS=""
	    ;;
         Slackware)
	    CONFIGFILE=/etc/suspend.conf
            INITDIR=/etc/init.d
	    RLVLDIR=/etc
	    INSTALLDIR=/usr/local/sbin
	    IFDOWN=$INITDIR/ifdown
	    OPTDOWN=""
	    IFUP=$INITDIR/ifup
            # note: 
            # you must provide ifdown and ifup, typically just
            # ifconfig eth0 up/down
	    OPTUP=""
	    SHELL=/bin/sh
	    LOCKFILE=/var/lock/subsys/swsusp
	    SETSYSFONT=/usr/bin/fooo
	    OPTSYSFONT=
	    DEFAULTSTARTSERVICES=
	    DEFAULTRESTARTSERVICES="postfix inetd pcmcia irda sound sshd lpd "
	    DEFAULTSTOPSERVICES=""
	    SWSUSP_UMOUNTS="/mnt /floppy /cdrom"
	    SWSUSP_INSERTMODS=""
	    SWSUSP_NON_COMPATIBLE_PROGS=""
	    ;;
	Redhat)
	    CONFIGFILE=/etc/suspend.conf
            INITDIR=/etc/init.d
            RLVDIR=/etc
            INSTALLDIR=/usr/sbin
            IFDOWN=/etc/init.d/network
            OPTDOWN=stop
            IFUP=/etc/init.d/network
            OPTUP=start
            SHELL=/bin/bash
            LOCKFILE=/var/lock/subsys/swsusp
            SETSYSFONT=/sbin/setsysfont
            OPTSYSFONT=
	    DEFAULTSTARTSERVICES=
	    DEFAULTRESTARTSERVICES="postfix ntpd xinetd nfs network pcmcia irda gpm"
	    DEFAULTSTOPSERVICES=""
	    SWSUSP_UMOUNTS="/mnt/floppy /mnt/cdrom"
	    SWSUSP_INSERTMODS=""
	    SWSUSP_NON_COMPATIBLE_PROGS=""
	    ;;
	Gentoo)
	    CONFIGFILE=/etc/suspend.conf
            INITDIR=/etc/init.d
	    RLVLDIR=/etc/init.d
	    INSTALLDIR=/sbin
	    IFDOWN=/etc/init.d/net.eth0
	    OPTDOWN=stop
	    IFUP=/etc/init.d/net.eth0
	    OPTUP=start
	    SHELL=/bin/sh
	    LOCKFILE=/var/lock/swsusp
	    SETSYSFONT=
	    OPTSYSFONT=
	    DEFAULTSTARTSERVICES=""
	    DEFAULTRESTARTSERVICES=""
	    DEFAULTSTOPSERVICES=""
	    SWSUSP_UMOUNTS="/mnt /floppy /cdrom"
	    SWSUSP_INSERTMODS="modules.autoload"
	    SWSUSP_NON_COMPATIBLE_PROGS=""
	    ;;
	*) 
	    CONFIGFILE=/etc/suspend.conf
            INITDIR=/etc/init.d
	    RLVLDIR=/etc/rc.d
	    INSTALLDIR=/usr/local/sbin
	    IFDOWN=/etc/sysconfig/network-scripts/ifdown
	    OPTDOWN=
	    IFUP=/etc/sysconfig/network-scripts/ifup
	    OPTUP=
	    SHELL=/bin/sh
	    LOCKFILE=/var/lock/swsusp
	    SETSYSFONT=/sbin/setsysfont
	    OPTSYSFONT=
	    DEFAULTSTARTSERVICES=
	    DEFAULTRESTARTSERVICES="postfix xntpd inetd xinetd nfs pcmcia network gpm irda sound alsa alsasound kbd usb usbmgr"
	    DEFAULTSTOPSERVICES=
	    SWSUSP_UMOUNTS="/misc/floppy /misc/cd /mnt/floppy /mnt/cdrom /floppy /cdrom"
	    SWSUSP_INSERTMODS=""
	    SWSUSP_NON_COMPATIBLE_PROGS=""
	;;
    esac

    DATE=`date`
    cat > $TMP <<EOF
#! $SHELL

if ( echo \$@ | grep -e "--version" ) 1> $VERBOSE; then
    echo "Script:       \$0"
    echo "Installed by: $INSTALLER"
    echo "Installation: $DATE"
    echo "Distribution: $DISTRIB"
    echo "Version:      $VERSION"
    exit 0
fi

CONFIGFILE=$CONFIGFILE
INITDIR=$INITDIR
RLVLDIR=$RLVLDIR
IFDOWN=$IFDOWN
OPTDOWN=$OPTDOWN
IFUP=$IFUP
OPTUP=$OPTUP
LOCKFILE=$LOCKFILE
SETSYSFONT=$SETSYSFONT
OPTSYSFONT=$OPTSYSFONT
DISTRIB=$DISTRIB

# default: strg-alt-f9 = vt9 = /dev/tty9
VERBOSE_VT='9'
VERBOSE_CONSOLE="/dev/tty\$VERBOSE_VT"

# DO NOT EDIT THIS FILE (change the script `pwd`/$0 and reinstall)
EOF
    awk '
      BEGIN { copy = 1
              # skip first three lines:
              getline
              getline
              getline
      }
      # note: patterns below match twice!! once where they occur in
      # the rest of the script, once right here,
      # that is why we do not set copy, but increment
      # the idea is, NOT to copy install and changelog section to the
      # output script
      /CHANGELOG start/ { copy--; next }
      /CHANGELOG end/   { copy++; next }
      /INSTALL start/   { copy--; next }
      /INSTALL end/     { copy++; next }
      { if (copy > 0) print $0
      } ' $0 >> $TMP
    
    if [ ! -d $INSTALLDIR ] ;then
	echo "Directory $INSTALLDIR doesn't exist: installation aborted"
	rm $TMP
	exit 2
    fi
   
    echo "Creating $INSTALLDIR/$BINNAME"
    if ! (mv -f $TMP $INSTALLDIR/$BINNAME) ;then
	echo "Cannot install $INSTALLDIR/$BINNAME"
	rm $TMP
	exit 1
    fi
    chmod 700 $INSTALLDIR/$BINNAME

    # todo: Maybe create a small function to prevent this code duplication?
    SWSUSP_STOP_SERVICES_BEFORE_SUSPEND=
    for service in $DEFAULTSTOPSERVICES ;do
	if [ -x $INITDIR/$service ] ; then
	    SWSUSP_STOP_SERVICES_BEFORE_SUSPEND="$SWSUSP_STOP_SERVICES_BEFORE_SUSPEND $service"
	fi
    done
    SWSUSP_START_SERVICES_AFTER_RESUME=
    for service in $DEFAULTSTARTSERVICES ;do
	if [ -x $INITDIR/$service ] ; then
	    SWSUSP_START_SERVICES_AFTER_RESUME="$SWSUSP_START_SERVICES_AFTER_RESUME $service"
	fi
    done
    SWSUSP_RESTART_SERVICES=
    for service in $DEFAULTRESTARTSERVICES ;do
	if [ -x $INITDIR/$service ] ; then
	    SWSUSP_RESTART_SERVICES="$SWSUSP_RESTART_SERVICES $service"
	fi
    done

    cat > $TMP <<EOF
#-*-mode: sh-*-
# Configuration of software suspension
#

# If your graphic device is not able to return properly from suspend
# you can switch to textconsole before suspend and return to your
# X-console after resume.
# If you use an nvidia card, you can set this to nvidia. This
# will try to restore your 3D upon resume. This trick may be useful
# for other cards.
# Default: "no"
SWSUSP_LEAVE_X_BEFORE_SUSPEND="no"

# Some services (e.g. network) may cause some hangs if they are not
# stopped before a suspend/resume cycle. You can set
# SWSUSP_RESTART_SERVICES to a list of services to stop before suspend
# and automatically restart after resume.
# If suspending results in killing some application because of lack
# of memory, you may also add here some of your launched services,
# so as to save memory. Good candidates are httpd, nfsserver, sendmail, etc.
# Default: "$SWSUSP_RESTART_SERVICES"
SWSUSP_RESTART_SERVICES="$SWSUSP_RESTART_SERVICES"

# Some services may need to be stopped before a suspend/resume cycle.
# You can set STOP_SERVICES_BEFORE_SUSPEND to a list of services to stop
# before suspend. These services will NOT automatically be restarted after
# the resume, use SWSUSP_RESTART_SERVICES instead if you want this
# behaviour.
# Default: "$SWSUSP_STOP_SERVICES_BEFORE_SUSPEND"
SWSUSP_STOP_SERVICES_BEFORE_SUSPEND="$SWSUSP_STOP_SERVICES_BEFORE_SUSPEND"

# Conversely, you can set START_SERVICES_AFTER_RESUME to a list
# of services to start after resuming.
# Default: "$SWSUSP_START_SERVICES_AFTER_RESUME"
SWSUSP_START_SERVICES_AFTER_RESUME="$SWSUSP_START_SERVICES_AFTER_RESUME"

# Those are programs that prevent from suspending. If they are
# running and --force or --kill option aren't used, suspension
# is aborted.
# Default: "$SWSUSP_NON_COMPATIBLE_PROGS"
SWSUSP_NON_COMPATIBLE_PROGS="$SWSUSP_NON_COMPATIBLE_PROGS"

# You can ask to killall these applications before suspend.
# Default: none
SWSUSP_STOP_PROGS_BEFORE_SUSPEND=""

# You can ask to run some applications after resume using this variable.
# For instance, it may restart your ADSL connection.
# Default: none
SWSUSP_START_PROGS_AFTER_RESUME=""

# Some modules should be unloaded before a suspend/resume cycle. You
# can set UNLOAD_MODULES_BEFORE_SUSPEND to "yes" if you want
# unused modules to be removed from kernel space before suspend. 
# This will be done after stopping services.
# With "no", nothing will be done before suspension.
# Default: "yes"
SWSUSP_UNLOAD_MODULES_BEFORE_SUSPEND="yes"

# If the following mount points cannot be unmounted, 
# then suspension is aborted unless --force or --kill
# option is used on command line
# Default: "$SWSUSP_UMOUNTS"
SWSUSP_UMOUNTS="$SWSUSP_UMOUNTS"

# These mount points should be mounted after suspend
# They should appear in /etc/fstab
# Default: none
SWSUSP_REMOUNTS=""

# If the following interfaces cannot be stopped, 
# then suspension is aborted unless --force or --kill
# option is used on command line
# Default: "eth0"
SWSUSP_DOWNIFS="eth0"

# These interfaces should be started after suspend
# With "auto" the interfaces stopped before suspension
# will be started in reverse order.
# Default: "auto"
SWSUSP_UPIFS="auto"

# These modules should be loaded after suspend
# Default: $SWSUSP_INSERTMODS
SWSUSP_INSERTMODS="$SWSUSP_INSERTMODS"

# Use FORCE_SUSPEND_MODE to reset the behaviour of
# suspension. If empty, this let the suspension
# behaviour unchanged. "0" will force shut off after
# suspension. "1" will force reboot. You can add an optional
# second parameter to tune the suspension display (see swsusp
# documentation for more information).
# Alternatively, you can use the keyword "acpi" to use the
# /proc/acpi/sleep interface in place of /proc/sys/kernel/swsusp
# this will cause echo "1 p1 p2 p3 p4" > /proc/sys/kernel/swsusp"
# 1 for immediate suspension
# p1 = 0 for halt,  p1 = 1 for reboot
# p2 = 2 for progress bar, 18 for progress bar and beeps (swsusp
#        version above beta19 only).
# p3, p4 are optional debugging options for hackers (see swsusp kernel patch documentation).
# Default: "0 2", i.e. halt, progress bar
SWSUSP_FORCE_SUSPEND_MODE="0 2"

# If you have problems with hardware clock drift amplified by
# suspension, try to set SAVE_CLOCK_ON_SUSPEND to "yes". The
# kerneltime will being saved before suspending. If you have
# network access, best is to set this variable to yes and add
# xntpd in services to start/stop below. If you haven't such
# a service permanently available, it is better to leave it
# to no, so that hardware clock remains as a reference for
# the system.
# Default: "no"
SWSUSP_SAVE_CLOCK_ON_SUSPEND="no"

# On some hardware, the power is cut off before the disk has 
# flushed his own hardware cache. Insert the device of your
# swap partition here (e.g. /dev/hda) if you want to issue
# hdparm -W 0 <device>
# before suspension.
# Default: none
SWSUSP_DISABLE_HW_DISK_CACHE=""
EOF
    if [ ! -f $CONFIGFILE -o "$FORCE" = "yes" ] ;then
	echo "Creating file $CONFIGFILE"
	mv $TMP $CONFIGFILE 
    else
	echo "Configuration file $CONFIGFILE exists: not overwritten" 
	echo -e "These are the differences:\n" 
	diff -u $CONFIGFILE $TMP 
	echo "Creating file $CONFIGFILE.new"
	mv $TMP $CONFIGFILE.new
    fi

    exit 0
fi
############################### INSTALL end ##################################

EXE=`basename $0`
cat > $TMP <<EOF
The script file $EXE uses a configuration file $CONFIGFILE.
It is intended to cleanly call software suspension stuff. Its 
options are as follows:
--help		Prints this help.
--install	Install this file in $INSTALLDIR and a configuration
		template as $CONFIGFILE. Existing script will be 
		overwritten, but not configuration file, unless --force
		is used. 
--force		Ignore devices that cannot be stopped or unmounted.
                Overwrite existing configuration file in installation
		procedure. 
--kill		Kill processes that prevent from suspending.
--silent	Be silent on processing
--verbose	Be really verbose on standard output
--nosuspend	Performs everything except actually suspend (configuration
                testing and debugging purpose)
To help suspension, it is strongly advisable to use automount for 
devices like cdrom floppy fat partitions, so that remount will
automatically take place when needed. For the same purpose
autoload of modules in kernel is a good point.
EOF

if [ -f "$CONFIGFILE" ] ; then
    . $CONFIGFILE
else
    echo "No configuration file $CONFIGFILE !!!"
    cat $TMP
    rm $TMP
    exit 1
fi

if ( echo $@ | grep -e "--help" ) 1> $VERBOSE; then
    cat $TMP
    rm $TMP
    exit 0
fi
rm $TMP

[ `cat /proc/swaps | grep partition | wc -l` -lt 1 ] && {
    echo "No swap partition activated, cannot suspend"
    exit 0
}

#Defining a few more command-line options...

if ( echo $@ | grep -e "--kill" ) 1> $VERBOSE; then
    KILL_PROCS='yes'
else
    KILL_PROCS='no'
fi


# This does everything except suspension
if ( echo $@ | grep -e "--nosuspend" ) 1> $VERBOSE; then
    NOSUSPEND='yes'
else
    NOSUSPEND='no'
fi
#############################################################
# Function definitions
#############################################################
T_IFS=

if ! which usleep 1> $VERBOSE 2> $VERBOSE ; then
# fallback function if usleep-utility isn't available
    usleep() {
		# calculate sleep time in seconds
		sleeptime=$((($1)/100000))
		[ $((($1) % 100000)) -ne 0 ] && $sleeptime=$(($sleeptime+1))

		sleep $sleeptime
    }
fi

CheckProgs() {
    ret=0;
    if [ $KILL_PROCS = "yes" ]; then
	for sig in 15 9 ;do
	    for prog in $SWSUSP_NON_COMPATIBLE_PROGS; do
		ps ax > $TMP
		pids=`awk '($5 == "'$prog'"){print $1}' $TMP`
		for pid in $pids; do
		    echo -e "\033[1;32m * \033[0mKilling($sig) $prog($pid)..." | $LOGCMD > $VERBOSE
		    kill -$sig $pid 2> $VERBOSE | $LOGCMD > $VERBOSE
		    usleep 500000
		done
	    done
	done
    fi
    for prog in $SWSUSP_NON_COMPATIBLE_PROGS; do
	ps ax > $TMP
	pids=`awk '($5 == "'$prog'"){print $1}' $TMP`
	if [ "$pids" != "" ];then
	    echo -e "Exception (non compatible) program $prog: $pids" | $LOGCMD > $VERBOSE
	    ret=1
	fi	
    done
    test -f $TMP && rm $TMP
    return $ret
}

KillProgs() {
    for prog in $SWSUSP_STOP_PROGS_BEFORE_SUSPEND; do
	    echo -e "\033[1;32m * \033[0mKilling $prog..." | $LOGCMD > $VERBOSE
	    killall $prog 1> $VERBOSE  2> $VERBOSE
    done
    return 0;
}


ExecuteProgs() {
    for prog in $SWSUSP_START_PROGS_AFTER_RESUME; do
	    echo -e "\033[1;32m * \033[0mStarting $prog..." | $LOGCMD > $VERBOSE
	    $prog 1> $VERBOSE  2> $VERBOSE &
    done
}


SwitchFromX() {
    which fgconsole > $VERBOSE && ORIGINAL_VT=`fgconsole`
    if [ "$SWSUSP_LEAVE_X_BEFORE_SUSPEND" != "yes" -a "$SWSUSP_LEAVE_X_BEFORE_SUSPEND" != "nvidia" ]; then
	return 0;
    fi
    echo -e "\033[1;32m * \033[0mSwitching to suspend console..." | $LOGCMD > $VERBOSE
    chvt $VERBOSE_VT
    ret=$?
    
    usleep 500000 # This to ensure usb mouse is released by X
    return $ret
}

SwitchToX() {
    if [ "$SWSUSP_LEAVE_X_BEFORE_SUSPEND" = "nvidia" ]; then
	export HOME=/dev/shm
	xauth 2> $VERBOSE 1> $VERBOSE <<EOF
add :3 . 00
generate :3.0 .
EOF
	if [ -x /usr/bin/X11/xmessage -a "$DISTRIB" != "Gentoo" ] ;then
	    xinit /usr/bin/X11/xmessage -font huge -display :3.0 -center -timeout 2 "  Fake Xserver for restoring nvidia cards properly  " -- :3
	else
	    xinit /bin/false -- :3 2> $VERBOSE 1> $VERBOSE
	fi
	xauth 2> $VERBOSE 1> $VERBOSE <<EOF
remove :3
remove :3.0
EOF
    fi

    test $SWSUSP_LEAVE_X_BEFORE_SUSPEND != "no" && echo -e "\033[1;32m * \033[0mSwitching back to X..." | $LOGCMD > $VERBOSE

    # if fgconsole is available, the original VT will be stored in this var
    if [ "$ORIGINAL_VT" != "" ]; then
	chvt "$ORIGINAL_VT"
    else
	echo "Original virtual terminal not memorized (trying 7)"
	chvt 7
    fi
    
    return $?
}

ExecuteServices() {
    ret=0
    # What action to execute on init scripts?
    startstop="$1"
    shift
    # What scripts to execute at all?
    services_to_execute=" $@ "

    if [ "$DISTRIB" != "Gentoo" ] ;then
	# in gentoo this does not work       
    	runlevel=`runlevel | cut -d\  -f2`

    	# only start/stop services really active in this runlevel and
    	# do it in the correct order
    	if [ "$startstop" = "start" ] ; then
	    startscripts="$RLVLDIR/rcS.d/S* $RLVLDIR/rc$runlevel.d/S*"
    	elif [ "$startstop" = "stop" ] ; then
	    startscripts="$RLVLDIR/rc$runlevel.d/S*"

	    # stop services - reverse the order in which the scripts are called
	    for script in $startscripts ; do
		tmp_scriptlist="$script $tmp_scriptlist"
	    done
            # (order of rc0.d/S* scripts *must not* be reversed!)
	    startscripts="$tmp_scriptlist $RLVLDIR/rc0.d/S*"
    	fi

    	# execute all needed init scripts
	tmp_scriptlist=""
    	for startscript in $startscripts ; do
	    service=${startscript##*/S??} # strip off directory and startup sequence number
	    if [ -z "${services_to_execute##* $service *}" ] ; then
	    	# service is active, start/stop it
		tmp_scriptlist="$tmp_scriptlist $service"
	    fi
    	done
	if [ "$startstop" = "START" ] ; then
	    startstop="start"
	    tmp_scriptlist=" $services_to_execute "
	elif [ "$startstop" = "STOP" ] ; then
	    startstop="stop"
	    tmp_scriptlist=" $services_to_execute "
	fi
    	echo -e "\033[1;33m$tmp_scriptlist\033[0m" | $LOGCMD > $VERBOSE
    	for service in $tmp_scriptlist ; do
	    test -x /etc/init.d/"$service" || continue
	    /etc/init.d/"$service" "$startstop" 2>&1 | $LOGCMD > $VERBOSE || ret=$? # remember the last error code
	done
    else
    	# gentoo use this
	echo -e "\033[1;33m$services_to_execute\033[0m" | $LOGCMD > $VERBOSE
 
	if [ "$startstop" = "stop" ] ; then
	    # start services - reverse the order in which the scripts are called
	    for script in $services_to_execute ; do
		tmp_scriptlist="$script $tmp_scriptlist"
	    done
	    startscripts="$tmp_scriptlist"
    	else
	    startscripts="$services_to_execute"
	fi
	
    	# execute all needed init scripts
    	for service in $startscripts ; do
	    echo -n " $service" | $LOGCMD > $VERBOSE
	    /etc/init.d/"$service" "$startstop" 2>&1 | $LOGCMD > $VERBOSE  || ret=$? # remember the last error code
    	done

    fi
    echo -e "\033[0m" | $LOGCMD > $VERBOSE
    return $ret # return the last error code
}

StopServices() {
    ExecuteServices "stop" "$SWSUSP_RESTART_SERVICES"
    ExecuteServices "STOP" "$SWSUSP_STOP_SERVICES_BEFORE_SUSPEND"
    return 0 # we don't want to abort if stopping one of the services failed
}

RestartServices() {
    ExecuteServices "start" "$SWSUSP_RESTART_SERVICES"		
    ExecuteServices "START" "$SWSUSP_START_SERVICES_AFTER_RESUME"		
    return $?
}

UmountDevices() {
    ret=0
    if [ $KILL_PROCS = "yes" ]; then
	for MNT in $SWSUSP_UMOUNTS; do
	    if [ `grep -c " $MNT " /proc/mounts` != 0 ]; then
		echo -e "\033[1;32m * \033[0mTerminating users of $MNT..." | $LOGCMD > $VERBOSE
		fuser -s -k -15 $MNT 2> $VERBOSE | $LOGCMD > $VERBOSE
	    fi
	done
#sleep a few seconds before SIGKILL and umount
	sleep 3
    fi

#Now kill procs and do umount
    for MNT in $SWSUSP_UMOUNTS; do
	if [ `grep -c " $MNT " /proc/mounts` != 0 ]; then
	    if [ $KILL_PROCS = "yes" ]; then
		echo -e "\033[1;32m * \033[0mSending SIGKILL to remaining users of $MNT" | $LOGCMD > $VERBOSE
		fuser -s -k -9 $MNT 2> $VERBOSE | $LOGCMD > $VERBOSE
	    fi  
	    echo -e "\033[1;32m * \033[0mUnmounting $MNT" | $LOGCMD > $VERBOSE
# make sure everything really is being unmounted
	    if ! ( umount $MNT ); then
		ret=1
	    fi
	fi
    done
    return $ret
}

RemountDevices() {
    ret=0
    for MNT in $SWSUSP_REMOUNTS ;do
	if [ `grep -c " $MNT " /proc/mounts` = 0 ]; then	    
	    echo -e "\033[1;32m * \033[0mMounting $MNT..." | $LOGCMD > $VERBOSE
	    /bin/mount $MNT
	fi
    done
}

StopInterfaces() {
    ret=0
    for IF in $SWSUSP_DOWNIFS; do
	if [ `ifconfig | grep -c "^$IF "` != 0 ]; then
	    if [ ! -x $IFDOWN ] ;then
		echo -e "\033[1;32m * \033[0mNo script $IFDOWN !!!" | $LOGCMD > $VERBOSE
		return 2
	    else
		echo "Bringing $IF down..." | $LOGCMD > $VERBOSE
		if ! ($IFDOWN $OPTDOWN $IF | $LOGCMD > $VERBOSE) ;then
		    echo -e "\033[1;32m * \033[0mBringing $IF down failed !" | $LOGCMD > $VERBOSE
		    ret=1
		else
		    T_IFS="$IF $T_IFS"
		fi
	    fi
	fi
    done
    return $ret
}

RestartInterfaces() {
    ret=0
    if [ "$SWSUSP_UPIFS" = "auto" ] ;then
	SWSUSP_UPIFS="$T_IFS"
    fi
    for IF in $SWSUSP_UPIFS ;do
	echo -e "\033[1;32m * \033[0mBringing up $IF..." | $LOGCMD > $VERBOSE
	if ! ($IFUP $OPTUP $IF | $LOGCMD > $VERBOSE) ;then
	    ret=1
	fi
    done
    return $ret
}

UnloadModules() {
    if [ "$SWSUSP_UNLOAD_MODULES_BEFORE_SUSPEND" != "yes" ] ;then
	return 0
    fi
    cat /proc/modules | $LOGCMD > $VERBOSE
    modules=`awk '($3==0){print $1}' /proc/modules`
    for module in $modules ;do
	echo -e "\033[1;32m * \033[0mRemoving $module" | $LOGCMD > $VERBOSE
	modprobe -r $module 2> $VERBOSE 1> $VERBOSE
#	usleep 100000
    done
    modaft=`awk '($3==0){print $1}' /proc/modules`
    while [ "$modaft" != "$modules" ] ; do
	#cat /proc/modules | $LOGCMD > $VERBOSE
	modules=$modaft
	usleep 500000
	for module in $modules ;do
	    echo -e "\033[1;32m * \033[0mRemoving $module" | $LOGCMD > $VERBOSE
	    modprobe -r $module 2> $VERBOSE 1> $VERBOSE
#	    usleep 100000
	done
	modaft=`awk '($3==0){print $1}' /proc/modules`	
    done
    echo -e "\033[1;33mmodules failed to unload:\033[0m" | $LOGCMD > $VERBOSE
    cat /proc/modules | $LOGCMD > $VERBOSE
}

ReloadModules() {
    ret=0
    if [ "$SWSUSP_INSERTMODS" = "modules.autoload" ] ;then
    # for gentoo users
	echo -e "\033[1;33mLoading modules listed /etc/modules.autoload\033[0m" | $LOGCMD > $VERBOSE
	# daRav: taken from gentoo's /etc/init.d/modules
        # Loop over every line in /etc/modules.autoload.
        (cat /etc/modules.autoload; echo) | # make sure there is a LF at the end
        while read MOD args
	do
	    case "${MOD}" in
		\#*|"") continue ;;
            esac
	    echo -e "\033[1;32m * \033[0mLoading $MOD..." | $LOGCMD > $VERBOSE
	    modprobe ${MOD} ${args} 2> $VERBOSE 1> $VERBOSE
	    #sleep 1
	done
    else
        for MOD in $SWSUSP_INSERTMODS ;do
	    echo -e "\033[1;32m * \033[0mLoading $MOD..." | $LOGCMD > $VERBOSE
	    if ! (modprobe $MOD 2> $VERBOSE 1> $VERBOSE) ;then
		ret=1
    	    fi
	done
    fi
    return $ret
}

Suspend() {
    ret=0
    if [ "$SWSUSP_SAVE_CLOCK_ON_SUSPEND" = "yes" ] ;then
	echo -e "\033[1;32m * \033[0mSaving clock state..." | $LOGCMD > $VERBOSE
	hwclock --systohc $HWCLKDEBUG
	sleep 1 #This is to be sure that the clock syncing is done
    fi
    if [ -x $SETSYSFONT ];then
	chvt $VERBOSE_VT
    fi

    sync
    if [ "$NOSUSPEND" = "yes" ] ;then
	echo -e "\033[1;31m\nSuspension system call not performed...\n\033[0m" | $LOGCMD > $VERBOSE
	if [ "$SWSUSP_FORCE_SUSPEND_MODE" = "acpi" -o "$SWSUSP_FORCE_SUSPEND_MODE" = "ACPI" ];then
	    echo "/bin/echo 4 > /proc/acpi/sleep" | $LOGCMD > $VERBOSE
	else
	    echo "/bin/echo \"1 $SWSUSP_FORCE_SUSPEND_MODE\" > /proc/sys/kernel/swsusp"
	fi
    else
	if [ -w "$SWSUSP_DISABLE_HW_DISK_CACHE" ] ;then
	    echo -e "\033[1;32m * \033[0mDisabling hardware disk cache on $SWSUSP_DISABLE_HW_DISK_CACHE" | $LOGCMD > $VERBOSE
	    hdparm -W 0 $SWSUSP_DISABLE_HW_DISK_CACHE
	fi
	echo -e "\033[1;33m\nSuspension system call in progress...\n\033[0m" | $LOGCMD > $VERBOSE
	if [ "$SWSUSP_FORCE_SUSPEND_MODE" = "acpi" -o "$SWSUSP_FORCE_SUSPEND_MODE" = "ACPI" ];then
	    if ! (/bin/echo 4 > /proc/acpi/sleep &) ;then
		ret=1
	    fi
	else
	    if ! (/bin/echo "1 $SWSUSP_FORCE_SUSPEND_MODE" > /proc/sys/kernel/swsusp) ;then
		ret=1
	    fi
	fi
    fi
    if [ $ret = 0 ] ;then    
	sleep 5
	ps ax > $TMP
	pids=`awk '($5 == "/bin/echo"){print $1}' $TMP`
	for pid in $pids; do
	    echo -e "\033[1;32m * \033[0mKilling($sig) $prog($pid)..." | $LOGCMD > $VERBOSE
		    #kill -$sig $pid 2> $VERBOSE | $LOGCMD > $VERBOSE
	    usleep 500000
	done
    fi
    if [ -x $SETSYSFONT ];then
	chvt $VERBOSE_VT
	$SETSYSFONT $OPTSYSFONT
    fi
    return $ret
}

RestoreClock() {
    ret=0
    echo -e "\033[1;32m * \033[0mRestoring clock..." | $LOGCMD > $VERBOSE
    hwclock --hctosys $HWCLKDEBUG | $LOGCMD > $VERBOSE
    ret=$?
    sleep 1 #This is to be sure that the clock syncing is done
    return $ret
}


RESUME() {
    state=$1
    resumestate=7
    
    if [ $state -ge $resumestate ];then
	echo -e "\033[1;32mResuming\033[0m (suspend script vers. $VERSION)..." | $LOGCMD > $VERBOSE
	RestoreClock
    fi

    resumestate=$[ $resumestate - 1 ]
    
    if [ $state -ge $resumestate ];then
	echo -e "\033[1;32mReload modules...\033[0m" | $LOGCMD > $VERBOSE
	ReloadModules
    fi

    resumestate=$[ $resumestate - 1 ]
    
    if [ $state -ge $resumestate ];then
	echo -e "\033[1;32mStarting interfaces...\033[0m" | $LOGCMD > $VERBOSE
	RestartInterfaces
    fi

    resumestate=$[ $resumestate - 1 ]
    
    if [ $state -ge $resumestate ];then
	echo -e "\033[1;32mRemounting devices...\033[0m" | $LOGCMD > $VERBOSE
	RemountDevices
    fi

    resumestate=$[ $resumestate - 1 ]
    
    if [ $state -ge $resumestate ];then
	echo -e "\033[1;32mRestarting progs...\033[0m" | $LOGCMD > $VERBOSE
	ExecuteProgs
    fi
        

    resumestate=$[ $resumestate - 1 ]
    
    if [ $state -ge $resumestate ];then
	echo -e "\033[1;32mRestarting services...\033[0m" | $LOGCMD > $VERBOSE
	RestartServices
    fi

    resumestate=$[ $resumestate - 1 ]

    if [ $state -ge $resumestate ];then
	SwitchToX
    fi
    
    resumestate=$[ $resumestate - 1 ]
    # resumestate should be zero at this point
    return $resumestate
}

FAIL(){
   if [ $FORCE = "yes" ]; then
#  Then continue anyway.
     echo | $LOGCMD > $VERBOSE
     echo "WARNING...FAILSAFES OVERIDDEN..." | $LOGCMD > $VERBOSE
     echo "Do not mount shared drives from other OS's while suspended" | $LOGCMD > $VERBOSE
     echo | $LOGCMD > $VERBOSE
   else
     echo | $LOGCMD > $VERBOSE
     echo "         ********* SUSPEND CANCELLED *********" | $LOGCMD > $VERBOSE
     echo | $LOGCMD > $VERBOSE
     RESUME $1
     rm $LOCKFILE
     echo -e "\033[1;31m\nBack! Suspend failed. Try to configure $CONFIGFILE.\033[0m\n\n" | $LOGCMD > $VERBOSE
     exit 255
   fi 
}





SUSPEND() {
    state=0

    if ! CheckProgs ;then
	FAIL $state
    fi

    if ! SwitchFromX ;then
	FAIL $state
    fi

    echo -e "\033[1;31mPreparing to suspend\033[0m (suspend script vers. $VERSION)..." | $LOGCMD > $VERBOSE

    state=$[$state + 1]

    echo -e "\033[1;31mStopping services...\033[0m" | $LOGCMD > $VERBOSE
    if ! StopServices ;then
	FAIL $state
    fi
    
    state=$[$state + 1]

    echo -e "\033[1;31mKilling progs...\033[0m" | $LOGCMD > $VERBOSE
    if ! KillProgs ;then
	FAIL $state
    fi

    state=$[$state + 1]

    echo -e "\033[1;31mUnmounting devices...\033[0m" | $LOGCMD > $VERBOSE
    if ! UmountDevices ;then
	FAIL $state
    fi

    state=$[$state + 1]

    echo -e "\033[1;31mStopping interfaces...\033[0m" | $LOGCMD > $VERBOSE
    if ! StopInterfaces ;then
	FAIL $state
    fi

    state=$[$state + 1]

    echo -e "\033[1;31mUnloading modules...\033[0m" | $LOGCMD > $VERBOSE
    if ! UnloadModules ;then
	FAIL $state
    fi

    state=$[$state + 1]

    if ! Suspend ;then
	FAIL $state
    fi
    state=$[$state + 1]
    return $state
}

#############################################################
# Main 
#############################################################

if [ -f $LOCKFILE ] ;then
    pid=`cat $LOCKFILE`
    if (ps $pid > $VERBOSE 2> $VERBOSE) ;then
	echo "File $LOCKFILE is present. Suspension script `cat $LOCKFILE`"
	echo "should be in progress. If this is not the case, then erase"
	echo "this file"
	exit 1
    fi
fi
echo $$ > $LOCKFILE

SUSPEND
state=$?
RESUME $state
ret=$?
rm $LOCKFILE

echo -e "\033[1;32m\nWelcome back! Suspend done.\033[0m\n\n" | $LOGCMD > $VERBOSE

exit $ret

--=-ggylSx1sspMH2uHxhzVm--

