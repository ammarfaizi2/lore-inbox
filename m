Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269557AbTG1NZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 09:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269589AbTG1NZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 09:25:38 -0400
Received: from visp12-175.visp.co.nz ([210.54.175.12]:21766 "EHLO
	mdew.dyndns.org") by vger.kernel.org with ESMTP id S269557AbTG1NZL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 09:25:11 -0400
Subject: USB BADPAD Quirk broken again
From: mdew <mdew@mdew.dyndns.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-hnXqRWhsG4FFKCvVSTVz"
Message-Id: <1059399610.18913.8.camel@mdew>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 29 Jul 2003 01:40:11 +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hnXqRWhsG4FFKCvVSTVz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

"BADPAD quirk handling", is currently broken in 2.4.22-pre7-8, the
patches
you gave me worked fine (before its inclusion into 2.4), but for
somereason (in Mame) the joypad will not properly center. In other
words, its being being force UP without any input. If you need more
debug info, gimme a yell.

mdew:~# jscal -c /dev/input/js0
Joystick has 2 axes and 8 buttons.
Correction for axis 0 is broken line, precision is 0.
Coeficients are: 112, 142, 5534751, 5534751
Correction for axis 1 is broken line, precision is 0.
Coeficients are: 112, 142, 5534751, 5534751
 
Calibrating precision: wait and don't touch the joystick.
Done. Precision is:
Axis: 0:     0
Axis: 1:     0
 
Move axis 0 to minimum position and push any button.
Hold ... OK.
Move axis 0 to center position and push any button.
Hold ... OK.
Move axis 0 to maximum position and push any button.
Hold ... OK.
Move axis 1 to minimum position and push any button.
Hold ... OK.
Move axis 1 to center position and push any button.
Hold ... OK.
Move axis 1 to maximum position and push any button.
Hold ... OK.
 
Setting correction to:
Correction for axis 0: broken line, precision: 0.
Coeficients: 0, 0, -4194176, 2105312
Correction for axis 1: broken line, precision: 0.
Coeficients: 255, 255, 2105312, -4227201

in xmame, what happens, the gamepad will initially point to one side,
tho after a little more use (all while playing the one game) it'll
correct itself. this is repeated, often.

Ive attached your orginal patches to the email..
hid-badpad.diff/hid-badpad-2.diff are the orginal working patches.

-- 
mdew <mdew@mdew.dyndns.org>

--=-hnXqRWhsG4FFKCvVSTVz
Content-Disposition: attachment; filename=hid-badpad.diff
Content-Type: text/plain; name=hid-badpad.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.719, 2002-06-16 18:54:33+02:00, vojtech@twilight.ucw.cz
  Add a quirk and handling of gamepads with broken logical minimum
  and maximum on the X and Y axes.


 hid-core.c |   20 ++++++++++++++++++++
 hid.h      |    1 +
 2 files changed, 21 insertions(+)


diff -Nru a/drivers/usb/hid-core.c b/drivers/usb/hid-core.c
--- a/drivers/usb/hid-core.c	Sun Jun 16 18:54:50 2002
+++ b/drivers/usb/hid-core.c	Sun Jun 16 18:54:50 2002
@@ -1086,6 +1086,9 @@
 #define USB_DEVICE_ID_ATEN_2PORTKVM	0x2204
 #define USB_DEVICE_ID_ATEN_4PORTKVM	0x2205
 
+#define USB_VENDOR_ID_TOPMAX		0x0663
+#define USB_DEVICE_ID_TOPMAX_COBRAPAD	0x0103
+
 struct hid_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -1115,6 +1118,7 @@
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVM, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
 	{ 0, 0 }
 };
 
@@ -1172,6 +1176,22 @@
 	}
 
 	hid->quirks = quirks;
+
+
+	if (hid->quirks & HID_QUIRK_BADPAD) {
+
+		struct hid_field *field;	
+
+		if (!hid_find_field(hid, EV_ABS, ABS_X, &field)) {
+			field->logical_minimum = 0;
+			field->logical_maximum = 255;
+		}
+
+		if (!hid_find_field(hid, EV_ABS, ABS_Y, &field)) {
+			field->logical_minimum = 0;
+			field->logical_maximum = 255;
+		}
+	}
 
 	for (n = 0; n < interface->bNumEndpoints; n++) {
 
diff -Nru a/drivers/usb/hid.h b/drivers/usb/hid.h
--- a/drivers/usb/hid.h	Sun Jun 16 18:54:50 2002
+++ b/drivers/usb/hid.h	Sun Jun 16 18:54:50 2002
@@ -186,6 +186,7 @@
 #define HID_QUIRK_NOTOUCH	0x02
 #define HID_QUIRK_IGNORE	0x04
 #define HID_QUIRK_NOGET		0x08
+#define HID_QUIRK_BADPAD	0x10
 
 /*
  * This is the global enviroment of the parser. This information is

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch29749
M'XL(`-K"##T``[56;6_;-A#^+/Z*&PH4S6K+?!$E686#V+&Q!NT6SUF"%BA@
M4!)E:;:E5)*=K%7_^TCY)6FFIE[6V8(,WAT?'GG//?0SN"QD[AGK[,]2!C%Z
M!J^SHO2,\B99)+.X-%?!C1E\4O9)EBE[)\Z6LK.-[OCSSJKPV]2TD(H8BS*(
M82WSPC.(R?:6\J]KZ1F3T2^7;_L3A'H].(U%.I,7LH1>#_GSDW`E%^8\ST1L
M9OFLVKLKBC'!'!/*+!O3"CN8\,IV0N%8#'<YMT(B"8H68IW(]&0A?9'[TDS5
MS*\P*+8)HXP3BU3,[7*&AD!,AW0!TPZV.\0&XGK<\AA[B:F',6QW>/+@'.`E
MA39&`_CO29^B`/IA"`(^KI)\#B(-04&$BR2=01;!3"SEM0@+N$G*&/P\F\L4
M%MDL"<0"EDF:+%=+!:&G+<6M'D&60AE+>%<;WX.XE86)WH"%7=M%X[M31^U_
M^4$("XR.&W8=YHDNN*9!)TY",[ZW>T[4[BW.K&[E=YV(,LF([P0^"_QOG6\S
MGBZ?^G*+.A7&EDL/2B5XF`KK*IS*CEQ*F2-HY+J<1^ZAJ;2#+)<;T/OY4(=3
M7I.Z.;Z9X4_,%<UR.3O9P`39\M$4.>UBQAS+K;AC6Z1F/&4/"4^=[Q(>_VC&
M;_B^YWJ4Y0>17;-:(>S(GF8EY+*XED&I433Q<ZFBUV*QD@6HXZG!\VP)26FJ
MB2_V>.+6`T*=UOT5/&@3ZK8V&'4$Y7PWU&Y\I%II4^US:.<W]:-:8_R-PC^A
MR<X(=EU0PAG**$DE7%X,IE>CWX;GD^G9</K'^?C7_CO#P+?8MK\.&HZNSDY'
M=T'3T_/!I#_N#W4PP0Q]4-B$.$"0\;D1MO4X3@M>*^/OEV>3-]-!?Z@L\*6E
M,1T+B*W@/R`CB>"%WOYQ7=\"GO]CSA%\UH%&4>:KH`05/(T2N0CAY_KGE5%[
M-<Y/&U^Z#="X+1A=3?N#BQ:HUU0E_+QV'6E0PS#J0?MX6]'ICC,]P*^:W%L2
M]725=<"7PY=^_\.75D^#@)CQ8=IQH.1^1SMV2FMA3AQL45K9S&5.+1OD";)!
M_J][4LM%+15E+!2'Q%J"+\(FL=C9[HG&5APT1N--J:Z6QYO;C)_4UZJMR;YC
@'[:%:E*"[_Y`!;$,YL5JV:,.D[[?9>AOB;[(BJ4)````
`
end

--=-hnXqRWhsG4FFKCvVSTVz
Content-Disposition: attachment; filename=hid-badpad-2.diff
Content-Type: text/plain; name=hid-badpad-2.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.720, 2002-06-17 21:53:12+02:00, vojtech@twilight.ucw.cz
  Move BADPAD quirk handling to hid-input.


 hid-core.c  |   16 ----------------
 hid-input.c |    5 +++++
 2 files changed, 5 insertions(+), 16 deletions(-)


diff -Nru a/drivers/usb/hid-core.c b/drivers/usb/hid-core.c
--- a/drivers/usb/hid-core.c	Mon Jun 17 21:54:52 2002
+++ b/drivers/usb/hid-core.c	Mon Jun 17 21:54:52 2002
@@ -1177,22 +1177,6 @@
 
 	hid->quirks = quirks;
 
-
-	if (hid->quirks & HID_QUIRK_BADPAD) {
-
-		struct hid_field *field;	
-
-		if (!hid_find_field(hid, EV_ABS, ABS_X, &field)) {
-			field->logical_minimum = 0;
-			field->logical_maximum = 255;
-		}
-
-		if (!hid_find_field(hid, EV_ABS, ABS_Y, &field)) {
-			field->logical_minimum = 0;
-			field->logical_maximum = 255;
-		}
-	}
-
 	for (n = 0; n < interface->bNumEndpoints; n++) {
 
 		struct usb_endpoint_descriptor *endpoint = &interface->endpoint[n];
diff -Nru a/drivers/usb/hid-input.c b/drivers/usb/hid-input.c
--- a/drivers/usb/hid-input.c	Mon Jun 17 21:54:52 2002
+++ b/drivers/usb/hid-input.c	Mon Jun 17 21:54:52 2002
@@ -280,6 +280,11 @@
 		int a = field->logical_minimum;
 		int b = field->logical_maximum;
 
+		if ((device->quirks & HID_QUIRK_BADPAD) && (usage->code == ABS_X || usage->code == ABS_Y)) {
+                       	a = field->logical_minimum = 0;
+                       	b = field->logical_maximum = 255;
+                 }      
+
 		input->absmin[usage->code] = a;
 		input->absmax[usage->code] = b;
 		input->absfuzz[usage->code] = (b - a) >> 8;

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch12609
M'XL(`(P^#CT``\55:6O;0!#]K/T5`X&0$"3-[FIU%8<X<6E,6NHZ!%HH&'FU
MME0?2G4X/=3_7DEVDS:1DR8M9"40S,X\O9GW5MJ!BTREOK9*/N5*1F0'3I,L
M][7\*I['TR@W"GEER&]5?)@D5=R,DH4R-]GF>&86V5AGAD6JC$&0RPA6*LU\
MC1K\.I)_O52^-GSYZN)U=TA(IP,G4;"<JG.50Z=#QK.CL%!S8Y8F060DZ;2\
MWBX9(D6!E''+1E:B@U24MA,&CL71$\(*J:)D0^?H%ND_<1C:M+J$Q7EIH6N[
MI`?4<!@",A-MDSK`J"^X3]D!,A\1ML#"`0,=R3'\._$3(N%-LE)PW.T-NCWX
M7,3I#"J0<!XOIY`G$,6A'B\OB]P@9V!1)I`,;L9']$<N0C!`<@B7M3!'H<IF
MO[$/T[@6KY;4O'FO7/?B40N9Y5A>R;E'O9*Y**2P%?6XK:3C;9O6?:BU)`[U
M!*=8UNBL8G9WJ+<`?A%JABMH-5SN53BE/7$9XT[`)JXKQ,3]:T(R2=5=/LAM
M6S1F;<]O=^X3N6YU\/U<&SLSIV2.8**Q,[/NN!D?<C."3NWGL',SX;>@IU?-
M7;ESL&783_!YCU(7H6JL3<*-!VL-__])>#QDM6I%+8N73'!<2\D?KZ1XKN]2
M<W8?4'+3\!.D[#.7@2":%D]@;R]4JU@J_;#AE,$NG/9[HW<7_>'9:,UV'W9W
M8:_(@FF5)9-053)#]_A\]![*$EKB'_;WX3N!]J4%T(%)K.:A?CA/IK$,YJ-%
MO(P7Q:+:P!=;Z\8M=<&731T3HJ7RQ_I!/M[\366DY"PK%IU)@)RZ7)&?S@$T
%:[('````
`
end

--=-hnXqRWhsG4FFKCvVSTVz
Content-Disposition: attachment; filename=dmesg
Content-Type: text/plain; name=dmesg; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98288
zone(0): 4096 pages.
zone(1): 94192 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux24-new root=2101
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 599.421 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1196.03 BogoMIPS
Memory: 386184k/393152k available (1538k kernel code, 6584k reserved, 310k data, 272k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Celeron (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 599.4292 MHz.
..... host bus clock speed is 66.6030 MHz.
cpu: 0, clocks: 666030, slice: 333015
CPU0<T0:666016,T1:332992,D:9,S:333015,C:666030>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb240, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
udf: registering filesystem
i2c-core.o: i2c core module
pty: 256 Unix98 ptys configured
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 10 for device 00:0b.0
eth0: RealTek RTL8139 Fast Ethernet at 0xd885d000, 00:30:4f:0b:43:a8, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
PDC20262: IDE controller at PCI slot 00:0e.0
PCI: Found IRQ 9 for device 00:0e.0
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
PDC20262: ROM enabled at 0xe7000000
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xc000-0xc007, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xc008-0xc00f, BIOS settings: hdg:DMA, hdh:pio
hda: ASUS CRW-2410A, ATAPI CD/DVD-ROM drive
hdb: ASUS DVD-ROM E608, ATAPI CD/DVD-ROM drive
hde: ST330630A, ATA DISK drive
blk: queue c033ef88, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xb000-0xb007,0xb402 on irq 9
hde: attached ide-disk driver.
hde: 59777640 sectors (30606 MB) w/2048KiB Cache, CHS=59303/16/63, UDMA(66)
Partition check:
 hde: hde1 hde2
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/usb-uhci.c: $Revision: 1.275 $ time 21:12:00 Jul 22 2003
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: USB UHCI at I/O 0xa000, IRQ 10
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF c142df80, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: a000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c142df80
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb.c: registered new driver usbscanner
scanner.c: 0.4.13:USB Scanner Driver
stv680.c: [proc_stv680_create:598] STV(e): /proc/video/ doesn't exist!
Linux video capture interface: v1.00
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
UDF-fs DEBUG lowlevel.c:65:udf_get_last_session: CDROMMULTISESSION not supported: rc=-22
UDF-fs DEBUG super.c:1421:udf_read_super: Multi-session=0
UDF-fs DEBUG super.c:410:udf_vrs: Starting at sector 16 (2048 byte sectors)
UDF-fs: No VRS found
kmod: failed to exec /sbin/modprobe -s -k nls_iso8859-1, errno = 2
VFS: Mounted root (jfs filesystem) readonly.
Freeing unused kernel memory: 272k freed
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 103, change 0, 12 Mb/s
hub.c: new USB device 00:07.2-1, assigned address 2
usb.c: kmalloc IF d7e49380, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=0
usb.c: USB device number 2 default language ID 0x409
Product: Standard USB Hub
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 100ms
hub.c: hub controller current requirement: 64mA
hub.c: port removable status: RRRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface d7e49380
hub.c: port 2, portstatus 101, change 1, 12 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 101, change 1, 12 Mb/s
hub.c: port 2, portstatus 101, change 0, 12 Mb/s
hub.c: port 2, portstatus 101, change 0, 12 Mb/s
hub.c: port 2, portstatus 101, change 0, 12 Mb/s
hub.c: port 2, portstatus 101, change 0, 12 Mb/s
hub.c: port 2, portstatus 103, change 0, 12 Mb/s
hub.c: new USB device 00:07.2-2, assigned address 3
usb.c: kmalloc IF d7e49500, numif 1
usb.c: new device strings: Mfr=0, Product=1, SerialNumber=0
usb.c: USB device number 3 default language ID 0x409
Product: USB HUB
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: standalone hub
hub.c: individual port power switching
hub.c: individual port over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 128ms
hub.c: hub controller current requirement: 100mA
hub.c: port removable status: RRRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface d7e49500
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 103, change 10, 12 Mb/s
hub.c: new USB device 00:07.2-2.1, assigned address 4
usb.c: kmalloc IF d7e49660, numif 1
usb.c: new device strings: Mfr=0, Product=0, SerialNumber=0
scanner.c: USB scanner device (0x055f/0x0006) now attached to scanner0
usb.c: usbscanner driver claimed interface d7e49660
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
hub.c: port 3, portstatus 100, change 0, 12 Mb/s
hub.c: port 4, portstatus 100, change 0, 12 Mb/s
hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
Adding Swap: 396640k swap-space (priority -1)
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 303, change 10, 1.5 Mb/s
hub.c: new USB device 00:07.2-1.1, assigned address 5
usb.c: kmalloc IF d7e494e0, numif 1
usb.c: skipped 1 class/vendor specific interface descriptors
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 5 default language ID 0x409
Manufacturer: A4Tech
Product: USB Optical Mouse
input: USB HID v1.00 Mouse [A4Tech USB Optical Mouse] on usb1:5.0
usb.c: hid driver claimed interface d7e494e0
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
hub.c: port 3, portstatus 101, change 1, 12 Mb/s
hub.c: port 3 connection change
hub.c: port 3, portstatus 101, change 1, 12 Mb/s
hub.c: port 3, portstatus 101, change 0, 12 Mb/s
hub.c: port 3, portstatus 101, change 0, 12 Mb/s
hub.c: port 3, portstatus 101, change 0, 12 Mb/s
hub.c: port 3, portstatus 101, change 0, 12 Mb/s
hub.c: port 3, portstatus 103, change 10, 12 Mb/s
hub.c: new USB device 00:07.2-1.3, assigned address 6
usb.c: kmalloc IF d7e49800, numif 1
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 6 default language ID 0x409
Manufacturer: STMicroelectronics
Product: USB Dual-mode Camera
usb.c: unhandled interfaces on device
usb.c: USB device 6 (vend/prod 0x553/0x202) is not claimed by any active driver.  Length              = 18
  DescriptorType      = 01
  USB version         = 1.10
  Vendor:Product      = 0553:0202
  MaxPacketSize0      = 8
  NumConfigurations   = 1
  Device version      = 0.00
  Device Class:SubClass:Protocol = ff:00:00
    Vendor class
Configuration:
  bLength             =    9
  bDescriptorType     =   02
  wTotalLength        = 0022
  bNumInterfaces      =   01
  bConfigurationValue =   01
  iConfiguration      =   00
  bmAttributes        =   a0
  MaxPower            =   70mA
 
  Interface: 0
  Alternate Setting:  0
    bLength             =    9
    bDescriptorType     =   04
    bInterfaceNumber    =   00
    bAlternateSetting   =   00
    bNumEndpoints       =   00
    bInterface Class:SubClass:Protocol =   ff:00:00
    iInterface          =   00
  Alternate Setting:  1
    bLength             =    9
    bDescriptorType     =   04
    bInterfaceNumber    =   00
    bAlternateSetting   =   01
    bNumEndpoints       =   01
    bInterface Class:SubClass:Protocol =   ff:00:00
    iInterface          =   00
    Endpoint:
      bLength             =    7
      bDescriptorType     =   05
      bEndpointAddress    =   82 (in)
      bmAttributes        =   02 (Bulk)
      wMaxPacketSize      = 0040
      bInterval           =   00
hub.c: port 4, portstatus 301, change 1, 1.5 Mb/s
hub.c: port 4 connection change
hub.c: port 4, portstatus 301, change 1, 1.5 Mb/s
hub.c: port 4, portstatus 301, change 0, 1.5 Mb/s
Real Time Clock Driver v1.10e
hub.c: port 4, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 4, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 4, portstatus 301, change 0, 1.5 Mb/s
hub.c: port 4, portstatus 303, change 10, 1.5 Mb/s
hub.c: new USB device 00:07.2-1.4, assigned address 7
usb.c: kmalloc IF d7e49980, numif 1
usb.c: skipped 1 class/vendor specific interface descriptors
usb.c: new device strings: Mfr=0, Product=0, SerialNumber=0
host/usb-uhci.c: interrupt, status 2, frame# 1438
i2c-algo-bit.o: i2c bit algorithm module
bttv: driver version 0.7.107 loaded
bttv: using 4 buffers with 2080k (8320k total) for capture
bttv: Host bridge is Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
bttv: Host bridge needs ETBF enabled.
bttv: Bt8xx card found (0).
PCI: Found IRQ 11 for device 00:0c.0
PCI: Sharing IRQ 11 with 00:0c.1
bttv0: Bt878 (rev 2) at 00:0c.0, irq: 11, latency: 64, mmio: 0xe802a000
bttv0: detected: (Askey Magic/others) TView99 CPH06x [card=38], PCI subsystem ID is 144f:3000
bttv0: using: BT878(Askey CPH06X TView99) [card=38,insmod option]
bttv0: enabling ETBF (430FX/VP3 compatibilty)
i2c-algo-bit.o: Adapter: bt848 #0 scl: 1  sda: 1 -- testing...
i2c-algo-bit.o:1 scl: 1  sda: 0
i2c-algo-bit.o:2 scl: 1  sda: 1
i2c-algo-bit.o:3 scl: 0  sda: 1
i2c-algo-bit.o:4 scl: 1  sda: 1
i2c-algo-bit.o: bt848 #0 passed test.
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: using tuner=1
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951),ta8874z
i2c-core.o: driver generic i2c audio driver registered.
i2c-core.o: driver i2c TV tuner driver registered.
tuner: chip found @ 0xc0
tuner(bttv): type forced to 0 (Temic PAL (4002 FH5)) [insmod]
tuner: type already set (0)
i2c-core.o: client [Temic PAL (4002 FH5)] registered to adapter [bt848 #0](pos. 0).
bttv0: PLL: 28636363 => 35468950 .. ok
bttv0: registered device video0
bttv0: registered device vbi0
SCSI subsystem driver Revision: 1.00
hda: attached ide-scsi driver.
hdb: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: ASUS      Model: CRW-2410A         Rev: 1.0
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: ASUS      Model: DVD-ROM E608      Rev: 1.30
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
loop: loaded (max 8 devices)
PCI: Found IRQ 5 for device 00:09.0
usb_control/bulk_msg: timeout
host/usb-uhci.c: interrupt, status 3, frame# 302
input: USB HID v1.00 Joystick [0663:0103] on usb1:7.0
usb.c: hid driver claimed interface d7e49980
hub.c: port 1, portstatus 303, change 0, 1.5 Mb/s
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
hub.c: port 3, portstatus 103, change 0, 12 Mb/s
hub.c: port 4, portstatus 303, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 103, change 0, 12 Mb/s
hub.c: port 2, portstatus 103, change 0, 12 Mb/s
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4363  Sat Apr 19 17:46:46 PDT 2003
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.

--=-hnXqRWhsG4FFKCvVSTVz--

