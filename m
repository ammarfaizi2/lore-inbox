Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbSJPA2D>; Tue, 15 Oct 2002 20:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264633AbSJPA2D>; Tue, 15 Oct 2002 20:28:03 -0400
Received: from due.stud.ntnu.no ([129.241.56.71]:24235 "EHLO due.stud.ntnu.no")
	by vger.kernel.org with ESMTP id <S263333AbSJPA1t>;
	Tue, 15 Oct 2002 20:27:49 -0400
Date: Wed, 16 Oct 2002 02:33:42 +0200
From: Thomas =?iso-8859-1?Q?Lang=E5s?= <tlan@stud.ntnu.no>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: Unable to kill processes in D-state
Message-ID: <20021016003341.GA15756@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
References: <1033841462.1247.3716.camel@phantasy> <20021006164228.GB17170@vagabond> <20021006170932.GA23134@stud.ntnu.no> <200210070731.g977VAp17211@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210070731.g977VAp17211@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko:
> Please provide info about:
> * automounter startup options

/etc/init.d/autofs (Standard file that comes with RedHat, at least):
#!/bin/bash
#
# $Id: rc.autofs.in,v 1.4 2000/01/22 22:17:34 hpa Exp $
#
# rc file for automount using a Sun-style "master map".
# We first look for a local /etc/auto.master, then a YP
# map with that name
#
# On most distributions, this file should be called:
# /etc/rc.d/init.d/autofs or /etc/init.d/autofs
#

# For Redhat-ish systems
#
# chkconfig: 345 28 72
# processname: /usr/sbin/automount
# config: /etc/auto.master
# description: Automounts filesystems on demand

# This is used in the Debian distribution to determine the proper
# location for the S- and K-links to this init file.
# The following value is extracted by debstd to figure out how to
# generate the postinst script. Edit the field to change the way the
# script is registered through update-rc.d (see the manpage for
# update-rc.d!)
#
FLAGS="defaults 21"

#
# Location of the automount daemon and the init directory
#
DAEMON=/usr/sbin/automount
prog=`basename $DAEMON`
initdir=/etc/init.d

#
# Determine which kind of configuration we're using
#
system=unknown
if [ -f /etc/debian_version ]; then
    system=debian
elif [ -f /etc/redhat-release ]; then
    system=redhat
else
    echo "$0: Unknown system, please port and contact autofs@linux.kernel.org" 1>&2
    exit 1
fi

if [ $system = redhat ]; then
    . $initdir/functions
fi

test -e $DAEMON || exit 0

if [ $system = debian ]; then
    thisscript="$0"
    if [ ! -f "$thisscript" ]; then
        echo "$0: Cannot find myself" 1>&2
        exit 1
    fi
fi

PATH=/sbin:/usr/sbin:/bin:/usr/bin
export PATH

#
# We can add local options here
# e.g. localoptions='rsize=8192,wsize=8192'
#
localoptions=''

# Daemon options
# e.g. --timeout 60
#
daemonoptions=''

#
# Check for all maps that are to be loaded
#
function getschemes()
{
    grep ^automount: /etc/nsswitch.conf | sed -e 's/^.*://' -e 's/\[.*\]/ /g'
}
function catnismap()
{
    if [ -z "$1" ] ; then
        map="auto_master"
    else
        map="$1"
    fi
    /usr/bin/ypcat -k "$map" 2> /dev/null | sed -e '/^#/d' -e '/^$/d'
}
function getfilemounts()
{
    if [ -f /etc/auto.master ] ; then
        cat /etc/auto.master | grep -v '^\+' | sed -e '/^#/d' -e '/^$/d'
        for nismap in `cat /etc/auto.master | grep '^\+' | sed -e '/^#/d' -e '/^$/d'`; do
            catnismap `echo "$nismap" | sed -e 's/^\+//'`
        done
    fi
}
function getnismounts()
{
    catnismap auto.master
}
function getldapmounts()
{
    /usr/lib/autofs/autofs-ldap-auto-master 2> /dev/null
}
function getrawmounts()
{
    for scheme in `getschemes` ; do
        case "$scheme" in
            files)
                if [ -z "$filescheme" ] ; then
                    getfilemounts
                    filescheme=1
                    export filescheme
                fi
                ;;
            nis)
                if [ -z "$nisscheme" ] ; then
                    getnismounts
                    nisscheme=1
                    export nisscheme
                fi
                ;;
            ldap*)
                if [ -z "$ldapscheme" ] ; then
                    getldapmounts
                    ldapscheme=1
                    export ldapscheme
                fi
                ;;
        esac
    done
}


#
# This function will build a list of automount commands to execute in
# order to activate all the mount points. It is used to figure out
# the difference of automount points in case of a reload
#
function getmounts()
{
        knownmaps=" "
        getrawmounts | (
        while read dir map options
        do
            # These checks screen out duplicates and skip over directories
            # where the map is '-'.
            # We can't do empty or direct host maps, so don't bother trying.
            if [ ! -z "$map" -a "$map" = "-hosts" ] ; then
                continue
            fi
            if [ ! -z "$dir" -a ! -z "$map" \
                        -a x`echo "$map" | cut -c1` != 'x-' \
                        -a "`echo "$knownmaps" | grep $dir/`" = "" ]
            then
                # If the options include a -t or --timeout parameter, then
                # pull those particular options out.
                : echo DAEMONOPTIONS OPTIONS $daemonoptions $options
                startupoptions=
                if echo $options | grep -q -- '-t' ; then
                    startupoptions="--timeout $(echo $daemonoptions $options | \
                      sed 's/.*--*t\(imeout\)*[ \t=]*\([0-9][0-9]*\).*$/\2/g')"
                fi
                # Other option flags are intended for maps.
                mapoptions="$(echo "$daemonoptions $options" |\
                      sed   's/--*t\(imeout\)*[ \t=]*\([0-9][0-9]*\)//g')"
                # Break up the maptype and map, if the map type is specified
                maptype=`echo $map | cut -f1 -d:`
                # Handle degenerate map specifiers
                if [ "$maptype" = "$map" ] ; then
                    if [ -x "$map" ]; then
                        maptype=program
                    elif [ -x "/etc/$map" ]; then
                        maptype=program
                        map=`echo /etc/$map | sed 's^//^/^g'`
                    elif [ -f "$map" ]; then
                        maptype=file
                    elif [ -f "/etc/$map" ]; then
                        maptype=file
                        map=`echo /etc/$map | sed 's^//^/^g'`
                    elif [ "$map" = "hesiod" -o "$map" = "userhome" ] ; then
                        maptype=$map
                        map=
                    elif [ "$map" = "multi" ] ; then
                        maptype=$map
                        map=
                    else
                        maptype=yp
                        map=`basename $map | sed -e s/^auto_home/auto.home/ -e s/^auto_mnt/auto.mnt/`
                fi
                fi
                map=`echo $map | cut -f2- -d:`

                : echo STARTUPOPTIONS $startupoptions
                : echo DIR $dir
                : echo MAPTYPE $maptype
                : echo MAP $map
                : echo MAPOPTIONS $mapoptions
                : echo LOCALOPTIONS $localoptions

                echo "$DAEMON $startupoptions $dir $maptype $map $mapoptions $localoptions" | sed -e 's/        / /g' -e 's/  
/ /g'

                : echo ------------------------
            fi
            knownmaps=" $dir/ $knownmaps"
        done
    )
}

#
# Status lister.
#
function status()
{
        echo $"Configured Mount Points:"
        echo  "------------------------"
        getmounts
        echo ""
        echo $"Active Mount Points:"
        echo  "--------------------"
        ps axwww|grep "[0-9]:[0-9][0-9] $DAEMON " | (
                while read pid tt stat time command; do echo $command; done
        )
}


#
# Redhat start/stop function.
#
function redhat()
{

#
# See how we were called.
#
case "$1" in
  start)
        # Make sure the autofs filesystem type is available.
        (grep -q autofs /proc/filesystems || /sbin/modprobe -k autofs || /sbin/modprobe -k autofs4) 2> /dev/null
        echo -n $"Starting $prog:"
        TMP=`mktemp /tmp/autofs.XXXXXX` || { echo $"could not make temp file" >& 2; exit 1; }
        getmounts | tee $TMP | sh
        RETVAL=$?
        if [ -s $TMP ] ; then
            success "$prog startup" || failure "$prog startup"
            [ $RETVAL = 0 ] && touch /var/lock/subsys/autofs
        else
            echo -n "" $"No Mountpoints Defined"
            success "$prog startup"
        fi
        rm -f $TMP
        echo
        ;;
  stop)
        echo -n $"Stopping $prog:"
        if [ -z "`pidofproc $prog`" -a -z "`getmounts`" ]; then
                success $"$prog shutdown"
                RETVAL=0
        else
                killproc $DAEMON -USR2
                RETVAL=$?
        fi
        count=0
        while [ -n "`/sbin/pidof $DAEMON`" -a $count -lt 8 ] ; do
            killproc $DAEMON -USR2
            RETVAL=$?
            [ $RETVAL = 0 -a -z "`/sbin/pidof $DAEMON`" ] || sleep ${count+1}
            count=`expr $count + 1`
        done
        umount -a -f -t autofs
        rm -f /var/lock/subsys/autofs
        echo
        ;;
  restart)
        redhat stop
        redhat start
        ;;
  reload)
        if [ ! -f /var/lock/subsys/autofs ]; then
                echo $"$prog not running"
                RETVAL=1
                return
        fi
        echo $"Checking for changes to /etc/auto.master ...."
        TMP1=`mktemp /tmp/autofs.XXXXXX` || { echo $"could not make temp file" >& 2; exit 1; }
        TMP2=`mktemp /tmp/autofs.XXXXXX` || { echo $"could not make temp file" >& 2; exit 1; }
        getmounts > $TMP1
        ps axwww|grep "[0-9]:[0-9][0-9] $DAEMON" | (
            while read pid tt stat time command; do
                echo "$command" >>$TMP2
                if ! grep -q "^$command" $TMP1; then
                    if ! echo "$command" | grep -q -e --submount; then
                        kill -USR2 $pid
                        echo $"Stop $command"
                    fi
                fi
            done
        )
        cat $TMP1 | ( while read x; do
                if ! grep -q "^$x" $TMP2; then
                        $x
                        echo $"Start $x"
                fi
        done )
        rm -f $TMP1 $TMP2
        ;;
  status)
        status
        ;;
  condrestart)
        [ -f /var/lock/subsys/autofs ] && redhat restart
        RETVAL=0
        ;;
  *)
        echo $"Usage: $0 {start|stop|restart|reload|condrestart|status}"
        RETVAL=0
esac
}

#
# Debian start/stop functions.
#
function debian()
{
#
# See how we were called.
#
case "$1" in
    start)
        echo -n 'Starting automounter:'
        getmounts | while read cmd mnt rest
        do
                echo -n " $mnt"
                pidfile=/var/run/autofs`echo $mnt | sed 's/\//./'`.pid
                start-stop-daemon --start --pidfile $pidfile --quiet \
                        --exec $DAEMON -- $mnt $rest
                #
                #       Automount needs a '--pidfile' or '-p' option.
                #       For now we look for the pid ourself.
                #
                ps ax | grep "[0-9]:[0-9][0-9] $DAEMON $mnt" | (
                        read pid rest
                        echo $pid > $pidfile
                        echo "$mnt $rest" >> $pidfile
                )
        done
        echo "."
        ;;
    stop)
        echo 'Stopping automounter.'
        start-stop-daemon --stop --quiet --signal USR2 --exec $DAEMON
        ;;
    reload|restart)
        echo "Reloading automounter: checking for changes ... "
        TMP=/var/run/autofs.tmp
        getmounts >$TMP
        for i in /var/run/autofs.*.pid
        do
                pid=`head -n 1 $i 2>/dev/null`
                [ "$pid" = "" ] && continue
                command=`tail +2 $i`
                if ! grep -q "^$command" $TMP
                then
                        echo "Stopping automounter: $command"
                        kill -USR2 $pid
                fi
        done
        rm -f $TMP
        $thisscript start
        ;;
    status)
        status
        ;;
    *)
        echo "Usage: $initdir/autofs {start|stop|restart|reload|status}" >&2
        exit 1
        ;;
esac
}

RETVAL=0
if [ $system = debian ]; then
        debian "$@"
elif [ $system = redhat ]; then
        redhat "$@"
fi

exit $RETVAL



> * automounter configuration file(s)

# $Source: /root/rdist/automount/RCS/master.m4,v $
#

/home/others            /etc/auto.home.stud     -rw,hard,intr,nosuid
/Stores                 /etc/auto.store         -soft,intr
/Units                  /etc/auto.unit          -soft,intr
/usr/local/others       /etc/auto.local         -rw,hard,intr,nosuid

/home/pvv/a             /etc/auto.home.pvv.a    -rw,hard,intr,nosuid
/home/pvv/c             /etc/auto.home.pvv.c    -rw,hard,intr,nosuid
/home/pvv/e             /etc/auto.home.pvv.e    -rw,hard,intr,nosuid
/home/pvv/f             /etc/auto.home.pvv.f    -rw,hard,intr,nosuid
/home/pvv/g             /etc/auto.home.pvv.g    -rw,hard,intr,nosuid
/home/pvv/h             /etc/auto.home.pvv.h    -rw,hard,intr,nosuid
/home/pvv/i             /etc/auto.home.pvv.i    -rw,hard,intr,nosuid
/home/pvv/j             /etc/auto.home.pvv.j    -rw,hard,intr,nosuid
/home/pvv/k             /etc/auto.home.pvv.k    -rw,hard,intr,nosuid


Do you need the mountpoints too?

> * client/server kernel version and .config

2.4.19 kernel, .config for server see below.

> * ksymoopsed SysRq-T dump of a couple of hung processes
>   (no, not all processes! please select 2-5 hung processes _only_
>   before feeding dump to ksymoops :-)

SysRq-T didn't give any info on the D-state processes, but it did give info
on all the rest of the processes, any ideas?

-- 
Thomas


.config for server:
#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_MULTIQUAD is not set
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
# CONFIG_PM is not set
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
# CONFIG_IP_NF_NAT_LOCAL is not set
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_IDEDISK is not set
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CMD680 is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
CONFIG_BLK_DEV_SVWKS=y
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
CONFIG_SCSI_AACRAID=y
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
CONFIG_SCSI_QLOGIC_QLA2XXX=y
# CONFIG_SCSI_QLOGIC_QLA2XXX_QLA2100 is not set
CONFIG_SCSI_QLOGIC_QLA2XXX_QLA2200=m
# CONFIG_SCSI_QLOGIC_QLA2XXX_QLA2300 is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_LAN=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_TC35815 is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=y
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_NEW_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
CONFIG_TIGON3=y
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
CONFIG_NET_FC=y
# CONFIG_IPHASE5526 is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=y
CONFIG_ZLIB_FS_INFLATE=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set


#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_FRAME_POINTER is not set




