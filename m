Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131065AbQKLUQ0>; Sun, 12 Nov 2000 15:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131142AbQKLUQR>; Sun, 12 Nov 2000 15:16:17 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:34261 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S131065AbQKLUQA>; Sun, 12 Nov 2000 15:16:00 -0500
Date: Sun, 12 Nov 2000 12:13:19 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Fw: [linux-usb-devel] 2.4.0-test11-pre3: Compile error in
 drivers/usb/usb.c
To: linux-kernel@vger.kernel.org, wollny@cns.mpg.de
Message-id: <008d01c04ce5$049b1cf0$6500000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: multipart/mixed;
 boundary="----=_NextPart_000_008A_01C04CA1.F1EB7700"
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_008A_01C04CA1.F1EB7700
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

See the attached patch.

Also, for LKML readers, you may be interested in the attached
/sbin/hotplug script; it's pretty current, even if it may not
be the latest from CVS (at http://linux-usb.sourceforge.net/).

- Dave


----- Original Message -----
From: "David Brownell" <david-b@pacbell.net>
To: <linux-usb-devel@lists.sourceforge.net>
Cc: "Dunlap, Randy" <randy.dunlap@intel.com>
Sent: Sunday, 12 November, 2000 11:57 AM
Subject: Re: [linux-usb-devel] 2.4.0-tst11-pre3 fails compiling "usb.c":723: `hotplug_path'
undeclared


> OK, try this patch (AFAICT suitable for pre3++), which does
> the following:
>
>     - You can compile USB without CONFIG_HOTPLUG again.
>       (I don't know who broke that; likely it came with
>       the kernel/kmod.c cleanup.)
>
>     - Restores interface altsetting if no kernel driver
>       claims the device ... fixes a problem I noticed
>       when hotplugging a printer cable (likely the same
>       problem Stephen Gowdy has reported).
>
>     - Restores accidentally-deleted code to pass INTERFACE,
>       also needed to hotplug that printer cable.
>
>     - Deletes the fixed point BCD formatting for product
>       version code -- messy, and not needed.  (This should
>       at most affect /etc/usb/drivers/usb-storage, but
>       that'll go away anyway with a MODULE_DEVICE_TABLE.)
>
>     - Adds Documentation/usb/hotplug.txt ... half relates
>       to generic hotplug stuff, the rest is USB-specific;
>       just gives an overview to tie things together.
>
> FWIW I've tried most of the USB devices I have handy, and
> they all hotplugged OK using just "modules.usbmap" contents
> except that "keybdev" didn't load for a keyboard.  (That's
> after those two interface related fixes.)
>
> - Dave
>
>
>

------=_NextPart_000_008A_01C04CA1.F1EB7700
Content-Type: application/octet-stream;
	name="pre3-usb-hotplug.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pre3-usb-hotplug.patch"

--- linux/drivers/usb-pre3/usb.c	Sun Nov 12 07:52:36 2000=0A=
+++ linux/drivers/usb/usb.c	Sun Nov 12 10:55:16 2000=0A=
@@ -635,6 +635,9 @@=0A=
 						break;=0A=
 				}=0A=
 			}=0A=
+			/* if driver not bound, leave defaults unchanged */=0A=
+			if (private =3D=3D NULL)=0A=
+				interface->act_altsetting =3D 0;=0A=
 		}=0A=
 		else /* "old style" driver */=0A=
 			private =3D driver->probe(dev, ifnum, NULL);=0A=
@@ -650,58 +653,15 @@=0A=
 }=0A=
 =0A=
 =0A=
-#if	defined(CONFIG_KMOD)=0A=
+#ifdef	CONFIG_HOTPLUG=0A=
 =0A=
 /*=0A=
  * USB hotplugging invokes what /proc/sys/kernel/hotplug says=0A=
  * (normally /sbin/hotplug) when USB devices get added or removed.=0A=
- */=0A=
-=0A=
-static int to_bcd (char *buf, __u16 *bcdValue)=0A=
-{=0A=
-	int	retval =3D 0;=0A=
-	char	*value =3D (char *) bcdValue;=0A=
-	int	temp;=0A=
-=0A=
-	/* digits are 0-9 then ":;<=3D>?" for devices using=0A=
-	 * non-bcd (non-standard!) values here ... */=0A=
-=0A=
-	/* No leading (or later, trailing) zeroes since scripts do=0A=
-	 * literal matches, and that's how they're doing them. */=0A=
-	if ((temp =3D value [1] & 0xf0) !=3D 0) {=0A=
-		temp >>=3D 4;=0A=
-		temp +=3D '0';=0A=
-		*buf++ =3D (char) temp;=0A=
-		retval++;=0A=
-	}=0A=
-=0A=
-	temp =3D value [1] & 0x0f;=0A=
-	temp +=3D '0';=0A=
-	*buf++ =3D (char) temp;=0A=
-	retval++;=0A=
-=0A=
-	*buf++ =3D '.';=0A=
-	retval++;=0A=
-=0A=
-	temp =3D value [0] & 0xf0;=0A=
-	temp >>=3D 4;=0A=
-	temp +=3D '0';=0A=
-	*buf++ =3D (char) temp;=0A=
-	retval++;=0A=
-=0A=
-	if ((temp =3D value [0] & 0x0f) !=3D 0) {=0A=
-		temp +=3D '0';=0A=
-		*buf++ =3D (char) temp;=0A=
-		retval++;=0A=
-	}=0A=
-	*buf++ =3D 0;=0A=
-=0A=
-	return retval;=0A=
-}=0A=
-=0A=
-/*=0A=
+ *=0A=
  * This invokes a user mode policy agent, typically helping to load =
driver=0A=
- * or other modules, configure the device, or both.=0A=
+ * or other modules, configure the device, and more.  Drivers can =
provide=0A=
+ * a MODULE_DEVICE_TABLE to help with module loading subtasks.=0A=
  *=0A=
  * Some synchronization is important: removes can't start processing=0A=
  * before the add-device processing completes, and vice versa.  That =
keeps=0A=
@@ -772,9 +732,7 @@=0A=
 	 * all the device descriptors we don't tell them about.  Or=0A=
 	 * even act as usermode drivers.=0A=
 	 *=0A=
-	 * XXX how little intelligence can we hardwire?=0A=
-	 * (a) mount point: /devfs, /dev, /proc/bus/usb etc.=0A=
-	 * (b) naming convention: bus1/device3, 001/003 etc.=0A=
+	 * FIXME reduce hardwired intelligence here=0A=
 	 */=0A=
 	envp [i++] =3D "DEVFS=3D/proc/bus/usb";=0A=
 	envp [i++] =3D scratch;=0A=
@@ -782,14 +740,14 @@=0A=
 		dev->bus->busnum, dev->devnum) + 1;=0A=
 #endif=0A=
 =0A=
-	/* per-device configuration hacks are often necessary */=0A=
+	/* per-device configuration hacks are common */=0A=
 	envp [i++] =3D scratch;=0A=
-	scratch +=3D sprintf (scratch, "PRODUCT=3D%x/%x/",=0A=
+	scratch +=3D sprintf (scratch, "PRODUCT=3D%x/%x/%x",=0A=
 		dev->descriptor.idVendor,=0A=
-		dev->descriptor.idProduct);=0A=
-	scratch +=3D to_bcd (scratch, &dev->descriptor.bcdDevice) + 1;=0A=
+		dev->descriptor.idProduct,=0A=
+		dev->descriptor.bcdDevice) + 1;=0A=
 =0A=
-	/* otherwise, use a simple (so far) generic driver binding model */=0A=
+	/* class-based driver binding models */=0A=
 	envp [i++] =3D scratch;=0A=
 	scratch +=3D sprintf (scratch, "TYPE=3D%d/%d/%d",=0A=
 			    dev->descriptor.bDeviceClass,=0A=
@@ -798,17 +756,18 @@=0A=
 	if (dev->descriptor.bDeviceClass =3D=3D 0) {=0A=
 		int alt =3D dev->actconfig->interface [0].act_altsetting;=0A=
 =0A=
-		/* simple/common case: one config, one interface, one driver=0A=
-		 * unsimple cases:  everything else=0A=
+		/* a simple/common case: one config, one interface, one driver=0A=
+		 * with current altsetting being a reasonable setting.=0A=
+		 * everything needs a smart agent and usbdevfs; or can rely on=0A=
+		 * device-specific binding policies.=0A=
 		 */=0A=
+		envp [i++] =3D scratch;=0A=
 		scratch +=3D sprintf (scratch, "INTERFACE=3D%d/%d/%d",=0A=
 			dev->actconfig->interface [0].altsetting [alt].bInterfaceClass,=0A=
 			dev->actconfig->interface [0].altsetting [alt].bInterfaceSubClass,=0A=
 			dev->actconfig->interface [0].altsetting [alt].bInterfaceProtocol)=0A=
 			+ 1;=0A=
 		/* INTERFACE-0, INTERFACE-1, ... ? */=0A=
-	} else {=0A=
-		/* simple/common case: generic device, handled generically */=0A=
 	}=0A=
 	envp [i++] =3D 0;=0A=
 	/* assert: (scratch - buf) < sizeof buf */=0A=
--- linux/Documentation.pre3/usb/hotplug.txt	Sun Nov 12 10:53:27 2000=0A=
+++ linux/Documentation/usb/hotplug.txt	Sun Nov 12 10:51:28 2000=0A=
@@ -0,0 +1,124 @@=0A=
+USB HOTPLUGGING=0A=
+=0A=
+In hotpluggable busses like USB (and Cardbus PCI), end-users plug =
devices=0A=
+into the bus with power on.  In most cases, users expect the devices to =
become=0A=
+immediately usable.  That means the system must do many things, =
including:=0A=
+=0A=
+    - Find a driver that can handle the device.  That may involve=0A=
+      loading a kernel module; newer drivers can use modutils to=0A=
+      publish their device (and class) support to user utilities.=0A=
+=0A=
+    - Bind a driver to that device.  That's done using the USB=0A=
+      device driver's probe() routine.=0A=
+    =0A=
+    - Tell other subsystems to configure the new device.  Print=0A=
+      queues may need to be enabled, networks brought up, disk=0A=
+      partitions mounted, and so on.  In some cases these will=0A=
+      be driver-specific actions.=0A=
+=0A=
+This involves a mix of kernel mode and user mode actions.  Making =
devices=0A=
+be immediately usable means that any user mode actions can't wait for an=0A=
+administrator to do them:  the kernel must trigger them, either =
passively=0A=
+(triggering some monitoring daemon to invoke a helper program) or=0A=
+actively (calling such a user mode helper program directly).=0A=
+=0A=
+Those triggered actions must support a system's administrative policies;=0A=
+such programs are called "policy agents" here.  Typically they involve=0A=
+shell scripts that dispatch to more familiar administration tools.=0A=
+=0A=
+=0A=
+KERNEL HOTPLUG HELPER (/sbin/hotplug)=0A=
+=0A=
+When you compile with CONFIG_HOTPLUG, you get a new kernel parameter:=0A=
+/proc/sys/kernel/hotplug, which normally holds the pathname =
"/sbin/hotplug".=0A=
+That parameter names a program which the kernel may invoke at various =
times.=0A=
+=0A=
+The /sbin/hotplug program can be invoked by any subsystem as part of its=0A=
+reaction to a configuration change, from a thread in that subsystem.=0A=
+Only one parameter is required: the name of a subsystem being notified =
of=0A=
+some kernel event.  That name is used as the first key for further event=0A=
+dispatch; any other argument and environment parameters are specified by=0A=
+the subsystem making that invocation.=0A=
+=0A=
+A reference implementation of a /sbin/hotplug script is available at the=0A=
+http://www.linux-usb.org website, which works USB for but also knows =
how to=0A=
+delegate to any /etc/hotplug/$TYPE.agent policy agent present.=0A=
+=0A=
+=0A=
+USB POLICY AGENT=0A=
+=0A=
+The USB subsystem currently invokes /sbin/hotplug when USB devices=0A=
+are added or removed from system.  The invocation is done by the kernel=0A=
+hub daemon thread [khubd], or else as part of root hub initialization=0A=
+(done by init, modprobe, kapmd, etc).  Its single command line parameter=0A=
+is the string "usb", and it passes these environment variables:=0A=
+=0A=
+    ACTION ... "add", "remove"=0A=
+    PRODUCT ... USB vendor, product, and version codes (hex)=0A=
+    TYPE ... device class codes (decimal)=0A=
+    INTERFACE ... interface 0 class codes (decimal)=0A=
+=0A=
+If "usbdevfs" is configured, DEVICE and DEVFS are also passed.  DEVICE =
is=0A=
+the pathname of the device, and is useful for devices with multiple =
and/or=0A=
+alternate interfaces that complicate driver selection.=0A=
+=0A=
+Currently available policy agent implementations can load drivers for=0A=
+modules, and can invoke driver-specific setup scripts.  The newest ones=0A=
+leverage USB modutils support.  Later agents might unload drivers.=0A=
+=0A=
+=0A=
+USB MODUTILS SUPPORT=0A=
+=0A=
+Current versions of modutils will create a "modules.usbmap" file which=0A=
+contains the entries from each driver's MODULE_DEVICE_TABLE.  Such files=0A=
+can be used by various user mode policy agents to make sure all the =
right=0A=
+driver modules get loaded, either at boot time or later. =0A=
+=0A=
+See <linux/usb.h> for full information about such table entries; or look=0A=
+at existing drivers.  Each table entry describes one or more criteria to=0A=
+be used when matching a driver to a device or class of devices.=0A=
+=0A=
+A short example, for a driver that supports several specific USB devices=0A=
+and their quirks, might have a MODULE_DEVICE_TABLE like this:=0A=
+=0A=
+    static const struct usb_device_id mydriver_id_table =3D {=0A=
+	{ idVendor: 0x9999, idProduct 0xaaaa, driver_info: QUIRK_X },=0A=
+	{ idVendor: 0xbbbb, idProduct 0x8888, driver_info: QUIRK_Y|QUIRK_Z },=0A=
+	...=0A=
+	{ } /* end with an all-zeroes entry */=0A=
+    }=0A=
+    MODULE_DEVICE_TABLE (usb, mydriver_id_table);=0A=
+=0A=
+Most USB device drivers should pass these tables to the USB subsystem as=0A=
+well as to the module management subsystem.  Not all, though: some =
driver=0A=
+frameworks connect using interfaces layered over USB, and so they won't=0A=
+need such a "struct usb_driver".=0A=
+=0A=
+Drivers that connect directly to the USB subsystem should be declared=0A=
+something like this:=0A=
+=0A=
+    static struct usb_driver mydriver =3D {=0A=
+	name:		"mydriver",=0A=
+	id_table:	mydriver_id_table,=0A=
+	probe:		my_probe,=0A=
+	disconnect:	my_disconnect,=0A=
+=0A=
+	/*=0A=
+	if using the usb chardev framework:=0A=
+	    minor:		MY_USB_MINOR_START,=0A=
+	    fops:		my_file_ops,=0A=
+	if exposing any operations through usbdevfs:=0A=
+	    ioctl:		my_ioctl,=0A=
+	*/=0A=
+    }=0A=
+=0A=
+When the USB subsystem knows about a driver's device ID table, it's =
used when=0A=
+choosing drivers to probe().  The thread doing new device processing =
checks=0A=
+drivers' device ID entries from the MODULE_DEVICE_TABLE against =
interface and=0A=
+device descriptors for the device.  It will only call probe() if there =
is a=0A=
+match, and the third argument to probe() will be the entry that matched.=0A=
+=0A=
+If you don't provide an id_table for your driver, then your driver may =
get=0A=
+probed for each new device; the third parameter to probe() will be null.=0A=
+=0A=
+=0A=

------=_NextPart_000_008A_01C04CA1.F1EB7700
Content-Type: application/octet-stream;
	name="hotplug"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hotplug"

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
	echo "Usage: $0 type [...]"=0A=
	echo "  $0 pci [add|remove]"=0A=
	echo "  $0 usb"=0A=
	echo "Environment parameters are also type-specific."=0A=
# FIXME: list non-builtin agents (/etc/hotplug/*.agent)=0A=
    else=0A=
	mesg "illegal usage $*"=0A=
    fi=0A=
    exit 1=0A=
}=0A=
=0A=
if [ "$DEBUG" !=3D "" ]; then=0A=
    mesg "arguments ($*)"=0A=
fi=0A=
=0A=
=0A=
# Only one required argument:  event type type being dispatched.=0A=
# Examples:  usb, pci, isapnp, network, ieee1394, printer, disk, ... =0A=
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
# Builtin agent code -- directly processes modutils (2.3.20+)=0A=
# output for MODULE_DEVICE_TABLE entries, so that you can hotplug=0A=
# after installing only this script.=0A=
#=0A=
# This requires BASH ("declare -i") and needs some version of=0A=
# AWK, typically /bin/gawk.  Most GNU/Linux distros have these,=0A=
# but some specialized ones (floppy based, etc) may not.=0A=
#=0A=
# NOTE:  The match algorithms here aren't any smarter than those=0A=
# in the kernel; they take the first match available, even if=0A=
# it's not the "best" (most specific) match.  That's NOT really=0A=
# a feature.  Agents written in "real" languages can more easily=0A=
# support sophisticated driver selection algorithms, prioritize=0A=
# (or add) administrator-specified bindings, override kernel=0A=
# defaults, and so on.=0A=
#=0A=
# FIXME: can we avoid using '<<' to parse composite variables?=0A=
# That may require a writable /tmp.=0A=
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
#	PRODUCT=3D%x/%x/%s [last string is like '1.2' ]=0A=
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
    local XPROD version=0A=
    XPROD=3D`echo $PRODUCT | $AWK -F/ '{print "0x" $1, "0x" $2, $3 }'`=0A=
    read usb_idVendor usb_idProduct version << EOT=0A=
$XPROD=0A=
EOT=0A=
=0A=
    # FIXME:  Parse this right; it's BCD ... version "1.08" breaks here=0A=
    # usb_bcdDevice=3D$(( ( ${version%.*} * 256 ) + ${version#*.} ))=0A=
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
	: idProduct $idProduct $usb_idProduct=0A=
	if [ $idProduct -ne $USB_ANY -a $idProduct -ne $usb_idProduct ]; then=0A=
	    continue=0A=
	fi=0A=
=0A=
	# : bcdDevice range $bcdDevice_hi $bcdDevice_lo actual $usb_bcdDevice=0A=
	# if [ $bcdDevice_lo -ge $usb_bcdDevice ]; then=0A=
	#     continue=0A=
	# fi=0A=
	# if [ $bcdDevice_hi -ne $USB_ANY -a $bcdDevice_hi -ge $usb_bcdDevice =
]; then=0A=
	#     continue=0A=
	# fi=0A=
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
# Kernel Cardbus/PCI params are:=0A=
#	=0A=
#	PCI_CLASS=3D%X=0A=
#	PCI_ID=3D%X/%X=0A=
#	PCI_SLOT=3D%s=0A=
#	PCI_SUBSYS_ID=3D%X/%X=0A=
#=0A=
# If /proc is mounted, /proc/bus/pci/$PCI_SLOT is almost the name=0A=
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
    # run any setup script=0A=
    # OR: /etc/modules.conf "post-install $DRIVER cmd ..."=0A=
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
    if [ x$PCI_SLOT =3D x ]; then=0A=
	mesg Bad PCI invocation=0A=
	exit 1=0A=
    fi=0A=
=0A=
    # one more commandline param=0A=
    case $2 in=0A=
    add)=0A=
	if [ "$DEBUG" !=3D "" -a -x /sbin/lspci ]; then=0A=
	    mesg New PCI Device: `/sbin/lspci -s $PCI_SLOT`=0A=
	fi=0A=
	load_driver pci $PCI_MAP "PCI device at slot $PCI_SLOT"=0A=
	# won't return=0A=
	;;=0A=
    remove)=0A=
	: PCI remove, ignored=0A=
	exit 0;;=0A=
    *|help)=0A=
	usage $* ;;=0A=
    esac=0A=
fi=0A=
=0A=
mesg "$0: event type '$1' unsupported"=0A=
exit 1=0A=

------=_NextPart_000_008A_01C04CA1.F1EB7700--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
