Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130565AbQK1IjH>; Tue, 28 Nov 2000 03:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130490AbQK1Ii4>; Tue, 28 Nov 2000 03:38:56 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:19672 "EHLO
        mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
        id <S130229AbQK1Iip>; Tue, 28 Nov 2000 03:38:45 -0500
Date: Tue, 28 Nov 2000 00:09:59 +0000
From: David Brownell <david-b@pacbell.net>
Subject: sample /sbin/hotplug script
To: linux-kernel@vger.kernel.org
Message-id: <00a701c058cf$8c7f4740$6600000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
Content-type: multipart/mixed;
 boundary="----=_NextPart_000_00A4_01C058CF.8BA513E0"
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_00A4_01C058CF.8BA513E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I've been quite pleased to see many recent improvement in hotplug
support ... 2.4 test11 is now hotplugging USB network adapters for
me when I need that!  And many other devices at least get their
driver modules autoloaded (using modutils support) even if some
devices still need hand setup before they're usable.

To make a long story short, if you'd like to try it out I strongly
encourage you to put the attached shell script into /sbin/hotplug
and see if it does the right things when you plug in USB devices
or Cardbus adapters into your system.  (And configure HOTPLUG;
see its config.help for more information.)

The test11 release has hotplug support for PCI, USB, and also for
networking interfaces.  (Though I've not tested the Cardbus/PCI
support myself, and know it can't support class-based driver binding
without a small patch I'll resubmit.)

This script should handle all three.  It's a start!  Improvements
should be easy enough ... :-)

- Dave

p.s. I'm particularly aware of contributions to the Linux
    hotplugging effort from Keith Owens, Adam Richter, and
    Jeff Garzik.




------=_NextPart_000_00A4_01C058CF.8BA513E0
Content-Type: application/octet-stream;
	name="hotplug.sh"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hotplug.sh"

#!/bin/bash=0A=
#=0A=
# This is a reference implementation for /sbin/hotplug, which works=0A=
# on most GNU/Linux systems without ANY additional software.=0A=
#=0A=
# This implementation delegates to type-specific agents, such as=0A=
# "/etc/hotplug/network.agent", where they exist.  Otherwise it=0A=
# uses built-in in support for USB and PCI hotplug events, trying=0A=
# to load a module that appears to handle this device.=0A=
#=0A=
# /proc/sys/kernel/hotplug controls the program invoked by the kernel.=0A=
# /sbin/hotplug is the default value, which you may change.  (A null=0A=
# string prevents the kernel from invoking a hotplug program.)  To make=0A=
# this functionality available, your kernel config must include HOTPLUG=0A=
# (and currently KMOD).=0A=
#=0A=
#=0A=
# HISTORY:=0A=
#=0A=
# 24-Nov-2000 Update matching a test12 prepatch=0A=
# 21-Nov-2000 Update for 2.4.0-test11 "net", "pci" support (needs=0A=
#	another kernel fix for pci/cardbus)=0A=
# 06-Nov-2000 Build in support for modules.{usb,pci}map; Cardbus may=0A=
#	now work, with a kernel patch.  /etc/hotplug directory hooks.=0A=
# 09-Jul-2000 Initial version; kernel USB hotplugging starts, using=0A=
#	the existing USB scripts=0A=
#=0A=
=0A=
# DEBUG=3Dyes export DEBUG=0A=
PATH=3D/bin:/sbin:/usr/sbin:/usr/bin=0A=
=0A=
if [ -t -o ! -x /usr/bin/logger ]; then=0A=
    mesg () {=0A=
	echo "$@"=0A=
    }=0A=
else=0A=
    mesg () {=0A=
	/usr/bin/logger -t $0 "$@"=0A=
    }=0A=
fi=0A=
=0A=
usage ()=0A=
{=0A=
    # Only one parameter (event type) is mandatory.=0A=
    # Everything else is type-specific.=0A=
=0A=
    if [ -t ]; then=0A=
	echo "Usage: $0 {usb,pci,net,...} ..."=0A=
	echo "Environment parameters are also type-specific."=0A=
# FIXME: list non-builtin agents (/etc/hotplug/*.agent)=0A=
    else=0A=
	mesg "illegal usage $*"=0A=
    fi=0A=
    exit 1=0A=
}=0A=
=0A=
if [ "$DEBUG" !=3D "" ]; then=0A=
    mesg "arguments ($*) env (`env`)"=0A=
fi=0A=
=0A=
=0A=
# Only one required argument:  event type type being dispatched.=0A=
# Examples:  usb, pci, isapnp, net, ieee1394, printer, disk, ... =0A=
if [ $# -lt 1 ]; then=0A=
    usage=0A=
elif [ $1 =3D help -o $1 =3D '--help' ]; then=0A=
    usage=0A=
=0A=
# Prefer to delegate event handling:=0A=
#   /sbin/hotplug FOO ..args.. =3D=3D> /etc/hotplug/FOO.agent ..args..=0A=
#=0A=
elif [ -x /etc/hotplug/$1.agent ]; then=0A=
    shift=0A=
    exec /etc/hotplug/$1.agent "$@"=0A=
fi=0A=
=0A=
=0A=
####################################################################=0A=
#=0A=
# Builtin agent code -- "80% solution" fallbacks.=0A=
#=0A=
# For USB and PCI, this directly processes modutils (2.3.20+)=0A=
# output for MODULE_DEVICE_TABLE entries, so that you can hotplug=0A=
# after installing only this script.=0A=
#=0A=
# For network interfaces, if you've got "ifup" it'll try to=0A=
# bring the interface up.  Otherwise, update for your distro.=0A=
#=0A=
=0A=
#=0A=
# This module loading uses BASH ("declare -i") and some version of=0A=
# AWK, typically /bin/gawk.  Most GNU/Linux distros have these,=0A=
# but some specialized ones (floppy based, etc) may not.=0A=
#=0A=
# NOTE:  The match algorithms here aren't any smarter than those=0A=
# in the kernel; they take the first match available, even if=0A=
# it's not the "best" (most specific) match.  That's not really=0A=
# a feature.  Agents written in other language can more easily=0A=
# support sophisticated driver selection algorithms, prioritize=0A=
# (or add) administrator-specified bindings, and so on.=0A=
#=0A=
# FIXME: can we avoid using '<<' to parse composite variables?=0A=
# That may require a writable /tmp; do we fail cleanly in=0A=
# that phase of system bootstrapping?=0A=
=0A=
AWK=3Dgawk=0A=
MODDIR=3D/lib/modules/`uname -r`=0A=
=0A=
# ISAPNP_MAP=3D$MODDIR/modules.isapnpmap=0A=
PCI_MAP=3D$MODDIR/modules.pcimap=0A=
USB_MAP=3D$MODDIR/modules.usbmap=0A=
=0A=
=0A=
####################################################################=0A=
#=0A=
# Kernel USB params are:=0A=
#	=0A=
#	ACTION=3D%s [add or remove]=0A=
#	PRODUCT=3D%x/%x/%x=0A=
#	INTERFACE=3D%d/%d/%d=0A=
#	TYPE=3D%d/%d/%d=0A=
#=0A=
# And if usbdevfs is configured, also:=0A=
#=0A=
#	DEVFS=3D/proc/bus/usb=0A=
#	DEVICE=3D/proc/bus/usb/%03d/%03d=0A=
#=0A=
# If usbdevfs is mounted on /proc/bus/usb, $DEVICE is a file which=0A=
# can be read to get the device's current configuration descriptor.=0A=
#=0A=
declare -i usb_idVendor usb_idProduct usb_bcdDevice=0A=
declare -i usb_bDeviceClass usb_bDeviceSubClass usb_bDeviceProtocol=0A=
declare -i usb_bInterfaceClass usb_bInterfaceSubClass =
usb_bInterfaceProtocol=0A=
=0A=
usb_convert_vars ()=0A=
{=0A=
    local XPROD=0A=
    XPROD=3D`echo $PRODUCT | $AWK -F/ '{print "0x" $1, "0x" $2, "0x" $3 =
}'`=0A=
    read usb_idVendor usb_idProduct usb_bcdDevice << EOT=0A=
$XPROD=0A=
EOT=0A=
=0A=
    if [ x$TYPE !=3D x ]; then=0A=
    IFS=3D/ read usb_bDeviceClass usb_bDeviceSubClass =
usb_bDeviceProtocol << EOT=0A=
$TYPE=0A=
EOT=0A=
    else=0A=
	# out-of-range values=0A=
	usb_bDeviceClass=3D1000=0A=
	usb_bDeviceSubClass=3D1000=0A=
	usb_bDeviceProtocol=3D1000=0A=
    fi=0A=
=0A=
    if [ x$INTERFACE !=3D x ]; then=0A=
    IFS=3D/ read usb_bInterfaceClass usb_bInterfaceSubClass =
usb_bInterfaceProtocol << EOT=0A=
$INTERFACE=0A=
EOT=0A=
    else=0A=
	# out-of-range values=0A=
	usb_bInterfaceClass=3D1000=0A=
	usb_bInterfaceSubClass=3D1000=0A=
	usb_bInterfaceProtocol=3D1000=0A=
    fi=0A=
}=0A=
=0A=
declare -i USB_ANY=0A=
USB_ANY=3D0=0A=
=0A=
# stdin is "modules.usbmap" syntax=0A=
usb_map_modules ()=0A=
{=0A=
    # convert the usb_device_id fields to integers as we read them =0A=
    local module ignored=0A=
    declare -i idVendor idProduct bcdDevice_lo bcdDevice_hi=0A=
    declare -i bDeviceClass bDeviceSubClass bDeviceProtocol=0A=
    declare -i bInterfaceClass bInterfaceSubClass bInterfaceProtocol=0A=
=0A=
    # comment line lists (current) usb_device_id field names=0A=
    read ignored=0A=
=0A=
    # look at each usb_device_id entry=0A=
    while read module idVendor idProduct bcdDevice_lo bcdDevice_hi =
bDeviceClass bDeviceSubClass bDeviceProtocol bInterfaceClass =
bInterfaceSubClass bInterfaceProtocol ignored=0A=
    do=0A=
	: checkmatch $module=0A=
=0A=
	: idVendor $idVendor $usb_idVendor=0A=
	if [ $idVendor -ne $USB_ANY -a $idVendor -ne $usb_idVendor ]; then=0A=
	    continue=0A=
	fi=0A=
	# NOTE: zero product code isn't the wildcard! =0A=
	: idProduct $idProduct $usb_idProduct=0A=
	if [ $idVendor -ne $USB_ANY -a $idProduct -ne $usb_idProduct ]; then=0A=
	    continue=0A=
	fi=0A=
=0A=
	: bcdDevice range $bcdDevice_hi $bcdDevice_lo actual $usb_bcdDevice=0A=
	if [ $bcdDevice_lo -ge $usb_bcdDevice ]; then=0A=
	    continue=0A=
	fi=0A=
	if [ $bcdDevice_hi -ne $USB_ANY -a $bcdDevice_hi -ge $usb_bcdDevice ]; =
then=0A=
	    continue=0A=
	fi=0A=
=0A=
	: bDeviceClass $bDeviceClass $usb_bDeviceClass=0A=
	if [ $bDeviceClass -ne $USB_ANY -a $bDeviceClass -ne $usb_bDeviceClass =
]; then=0A=
	    continue=0A=
	fi=0A=
	: bDeviceSubClass $bDeviceSubClass $usb_bDeviceSubClass=0A=
	if [ $bDeviceSubClass -ne $USB_ANY -a $bDeviceSubClass -ne =
$usb_bDeviceSubClass ]; then=0A=
	    continue=0A=
	fi=0A=
	: bDeviceProtocol $bDeviceProtocol $usb_bDeviceProtocol=0A=
	if [ $bDeviceProtocol -ne $USB_ANY -a $bDeviceProtocol -ne =
$usb_bDeviceProtocol ]; then=0A=
	    continue=0A=
	fi=0A=
=0A=
	# NOTE:  for now, this only checks the first of perhaps=0A=
	# several interfaces for this device.=0A=
=0A=
	: bInterfaceClass $bInterfaceClass $usb_bInterfaceClass=0A=
	if [ $bInterfaceClass -ne $USB_ANY -a $bInterfaceClass -ne =
$usb_bInterfaceClass ]; then=0A=
	    continue=0A=
	fi=0A=
	: bInterfaceSubClass $bInterfaceSubClass $usb_bInterfaceSubClass=0A=
	if [ $bInterfaceSubClass -ne $USB_ANY -a $bInterfaceSubClass -ne =
$usb_bInterfaceSubClass ]; then=0A=
	    continue=0A=
	fi=0A=
	: bInterfaceProtocol $bInterfaceProtocol $usb_bInterfaceProtocol=0A=
	if [ $bInterfaceProtocol -ne $USB_ANY -a $bInterfaceProtocol -ne =
$usb_bInterfaceProtocol ]; then=0A=
	    continue=0A=
	fi=0A=
=0A=
	# It was a match!=0A=
	DRIVER=3D$module=0A=
	: driver $DRIVER=0A=
	break;=0A=
    done=0A=
}=0A=
=0A=
=0A=
####################################################################=0A=
#=0A=
# Kernel Cardbus/PCI params are (current patch):=0A=
#	=0A=
#	PCI_CLASS=3D%X=0A=
#	PCI_ID=3D%X/%X=0A=
#	PCI_SLOT_NAME=3D%s=0A=
#	PCI_SUBSYS_ID=3D%X/%X=0A=
#=0A=
# If /proc is mounted, /proc/bus/pci/$PCI_SLOT_NAME is almost the name=0A=
# of the binary device descriptor file ... just change ':' to '/'.=0A=
#=0A=
declare -i pci_class=0A=
declare -i pci_id_vendor pci_id_device=0A=
declare -i pci_subid_vendor pci_subid_device=0A=
=0A=
pci_convert_vars ()=0A=
{=0A=
    XID=3D`echo $PCI_ID | $AWK -F/ '{print "0x" $1, "0x" $2 }'`=0A=
    read pci_class pci_id_vendor pci_id_device << EOT=0A=
0x$PCI_CLASS $XID=0A=
EOT=0A=
=0A=
    XID=3D`echo $PCI_SUBSYS_ID | $AWK -F/ '{print "0x" $1, "0x" $2 }'`=0A=
    read pci_subid_vendor pci_subid_device << EOT=0A=
$XID=0A=
EOT=0A=
}=0A=
=0A=
declare -i PCI_ANY=0A=
PCI_ANY=3D0xffffffff=0A=
=0A=
# stdin is "modules.pcimap" syntax=0A=
pci_map_modules ()=0A=
{=0A=
    # convert the usb_device_id fields to integers as we read them =0A=
    local module ignored=0A=
    declare -i vendor device=0A=
    declare -i subvendor subdevice=0A=
    declare -i class class_mask=0A=
    declare -i class_temp=0A=
=0A=
    # comment line lists (current) pci_device_id field names=0A=
    read ignored=0A=
=0A=
    # look at each pci_device_id entry=0A=
    while read module vendor device subvendor subdevice class class_mask =
ignored=0A=
    do=0A=
	: checkmatch $module=0A=
=0A=
	: vendor $vendor $pci_id_vendor=0A=
	if [ $vendor -ne $PCI_ANY -a $vendor -ne $pci_id_vendor ]; then=0A=
	    continue=0A=
	fi=0A=
	: device $device $pci_id_device=0A=
	if [ $device -ne $PCI_ANY -a $device -ne $pci_id_device ]; then=0A=
	    continue=0A=
	fi=0A=
	: sub-vendor $subvendor $pci_subid_vendor=0A=
	if [ $subvendor -ne $PCI_ANY -a $subvendor -ne $pci_subid_vendor ]; then=0A=
	    continue=0A=
	fi=0A=
	: sub-device $subdevice $pci_subid_device=0A=
	if [ $subdevice -ne $PCI_ANY -a $subdevice -ne $pci_subid_device ]; then=0A=
	    continue=0A=
	fi=0A=
=0A=
	class_temp=3D"$pci_class & $class_mask"=0A=
	if [ $class_temp -eq $class ]; then=0A=
	    DRIVER=3D$module=0A=
	    : driver $DRIVER=0A=
	    break;=0A=
	fi=0A=
    done=0A=
}=0A=
=0A=
####################################################################=0A=
#=0A=
# usage: load_driver type filename description=0A=
#=0A=
# (always) modprobes a single driver module, and optionally=0A=
# invokes a module-specific setup script.=0A=
#=0A=
load_driver ()=0A=
{=0A=
    # find the driver using modutils output=0A=
    if [ -f $2 ]; then=0A=
	$1_convert_vars=0A=
	$1_map_modules < $2=0A=
    else=0A=
	mesg "$2 missing"=0A=
	exit 1=0A=
    fi=0A=
    if [ x$DRIVER =3D x ]; then=0A=
	mesg "... no driver for $3"=0A=
	exit 2=0A=
    fi=0A=
=0A=
    if [ "$DEBUG" !=3D "" ]; then=0A=
	mesg Module $DRIVER matches $3=0A=
    fi=0A=
=0A=
    # maybe the driver needs loading=0A=
    if ! lsmod | grep "^$DRIVER "=0A=
    then=0A=
	if ! modprobe $DRIVER=0A=
	then=0A=
	    mesg "... can't load module $DRIVER"=0A=
	    exit 3=0A=
	fi=0A=
    fi=0A=
=0A=
    # NOTE:  this assumes that driver bound to=0A=
    # this device; it'd be better to check ...=0A=
=0A=
    # run any setup script; no /etc/modules.conf changes needed=0A=
    if [ -x /etc/hotplug/$1/$DRIVER ]; then=0A=
	if [ "$DEBUG" !=3D "" ]; then=0A=
	    mesg Driver setup: $DRIVER=0A=
	fi=0A=
	exec /etc/hotplug/$1/$DRIVER=0A=
    else=0A=
	exit 0=0A=
    fi=0A=
}=0A=
=0A=
####################################################################=0A=
#=0A=
# Two basic policy agents are now built in:  they try to load the=0A=
# USB or PCI driver module corresponding to newly added devices.=0A=
# They're used as backup, in case no smarter tools are available.=0A=
#=0A=
if [ $1 =3D usb ]; then=0A=
    # Until all kernel USB drivers get updated, you need:=0A=
    # http://www.linux-usb.org/policy.html=0A=
=0A=
    if [ -f /etc/usb/policy ]; then=0A=
	exec /etc/usb/policy=0A=
    fi=0A=
=0A=
    if [ x$PRODUCT =3D x ]; then=0A=
	mesg Bad USB invocation=0A=
	exit 1=0A=
    fi=0A=
=0A=
    # no more commandline params=0A=
    case x$ACTION in=0A=
    xadd)=0A=
	load_driver usb $USB_MAP "USB product $PRODUCT"=0A=
	# won't return=0A=
	;;=0A=
    xremove)=0A=
	: USB remove, ignored=0A=
	exit 0;;=0A=
    x*|xhelp)=0A=
	usage $* ;;=0A=
    esac=0A=
=0A=
elif [ $1 =3D pci ]; then=0A=
    # NOTE: PCI includes CardBus=0A=
=0A=
    if [ x$PCI_CLASS =3D x ]; then=0A=
	mesg Bad PCI invocation=0A=
	exit 1=0A=
    fi=0A=
=0A=
    case x$ACTION in=0A=
    xadd)=0A=
	if [ "$DEBUG" !=3D "" -a -x /sbin/lspci ]; then=0A=
	    mesg New PCI Device: `/sbin/lspci -s $PCI_SLOT_NAME`=0A=
	fi=0A=
	load_driver pci $PCI_MAP "PCI device at slot $PCI_SLOT_NAME"=0A=
	# won't return=0A=
	;;=0A=
    xremove)=0A=
	: PCI remove, ignored=0A=
	exit 0;;=0A=
    *|help)=0A=
	usage $* ;;=0A=
    esac=0A=
=0A=
elif [ $1 =3D net ]; then=0A=
    if [ x$INTERFACE =3D x ]; then=0A=
	mesg Bad NET invocation=0A=
	exit 1=0A=
    fi=0A=
=0A=
    if [ x$ACTION =3D xregister -a -x /sbin/ifup ]; then=0A=
	/sbin/ifup $INTERFACE &=0A=
	exit 0=0A=
    fi=0A=
fi=0A=
=0A=
mesg "$0: event type '$1' unsupported"=0A=
exit 1=0A=

------=_NextPart_000_00A4_01C058CF.8BA513E0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
