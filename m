Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285654AbRLGXQy>; Fri, 7 Dec 2001 18:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285655AbRLGXQg>; Fri, 7 Dec 2001 18:16:36 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:51445 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S285654AbRLGXQU>; Fri, 7 Dec 2001 18:16:20 -0500
Date: Sat, 8 Dec 2001 00:16:07 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: linux-kernel@vger.kernel.org
cc: paulus@samba.org, <dwmw2@infradead.org>, <emoenke@gwdg.de>,
        <jhartmann@precisioninsight.com>,
        Vineet M Abraham <vmabraham@hotmail.com>,
        Dag Brattli <dag@brattli.net>, <mid@auk.cx>, <jochen@scram.de>,
        <becker@scyld.com>, <elmer@ylenurme.ee>, <ajk@iehk.rwth-aachen.de>
Subject: Some compiler warnings in 2.4.17-pre5
Message-ID: <Pine.NEB.4.43.0112070005300.8687-200000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1920110659-1633918769-1007681795=:8687"
Content-ID: <Pine.NEB.4.43.0112070041080.8687@mimas.fachschaften.tu-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1920110659-1633918769-1007681795=:8687
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.NEB.4.43.0112070041081.8687@mimas.fachschaften.tu-muenchen.de>

Hi,

below follow some compiler warnings I got while trying to compile a
kernel with as much as possible statically linked into the kernel with
the snapshot of gcc-2.95.4 that is in Debian unstable. If possible these
should be corrected because either
- there's a bug or
- it confuses to see a warning although there's not a bug

Because the list is very long I've listed only some of the warnings and
one compile error with some comments and suggested patches I made. Others
will come later.

I didn't include the two compile errors in the ISDN code for which there
were already patches sent to this list.

I do send an explicite Cc to all the persons that seem to be responsible
for a piece of code listed below. If you wonder why you got a Cc or if you
disagree with Cc'ing you please send me a private mail.

Any comments are welcome.


...
drivers/net/net.o: In function `deflate':
drivers/net/net.o(.text+0xc3dcc): multiple definition of `deflate'
fs/fs.o(.text+0x10134c): first defined here
drivers/net/net.o: In function `_tr_flush_block':
drivers/net/net.o(.text+0xc633c): multiple definition of `_tr_flush_block'
fs/fs.o(.text+0x1038bc): first defined here
drivers/net/net.o: In function `zlibVersion':
drivers/net/net.o(.text+0xc9c20): multiple definition of `zlibVersion'
fs/fs.o(.text+0x1071a0): first defined here
drivers/net/net.o: In function `inflate_trees_free':
...

[both jffs2 and ppp have own copies of zlib]


...
make[3]: Entering directory `/mnt/kernel/linux/drivers/cdrom'
...
gcc -D__KERNEL__ -I/mnt/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trig
raphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferre
d-stack-boundary=2 -march=k6    -c -o mcdx.o mcdx.c
In file included from mcdx.c:81:
mcdx.h:180: warning: #warning You have not edited mcdx.h
mcdx.h:181: warning: #warning Perhaps irq and i/o settings are wrong.


At about two years ago when I used this driver I made the attached patch
to configure these settings via "make *config". It's perhaps possible to
do it more elegant but it was working and the patch does still apply.


...
make[4]: Entering directory `/mnt/kernel/linux/drivers/char/agp'
...
gcc -D__KERNEL__ -I/mnt/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trig
raphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferre
d-stack-boundary=2 -march=k6    -DEXPORT_SYMTAB -c agpgart_be.c
agpgart_be.c:1543: warning: `intel_820_cleanup' defined but not used

[intel_820_setup calls intel_cleanup instead of intel_820_cleanup;
 is this a bug or is intel_820_cleanup obsolete?]


...
make[4]: Entering directory `/mnt/kernel/linux/drivers/net/fc'
gcc -D__KERNEL__ -I/mnt/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trig
raphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferre
d-stack-boundary=2 -march=k6    -c -o iph5526.o iph5526.c
iph5526.c:227: warning: `driver_template' defined but not used


[all uses of `driver_template' are in an "#ifdef MODULE" section]
--- drivers/net/fc/iph5526.c.~        Sun Sep 30 21:26:08 2001
+++ drivers/net/fc/iph5526.c    Fri Dec  7 00:17:13 2001
@@ -224,7 +224,9 @@
 static int get_scsi_oxid(struct fc_info *fi);
 static void update_scsi_oxid(struct fc_info *fi);

+#ifdef MODULE
 static Scsi_Host_Template driver_template = IPH5526_SCSI_FC;
+#endif /* MODULE  */

 static void iph5526_timeout(struct net_device *dev);


...
make[4]: Entering directory `/mnt/kernel/linux/drivers/net/irda'
...
gcc -D__KERNEL__ -I/mnt/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trig
raphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferre
d-stack-boundary=2 -march=k6    -c -o w83977af_ir.o w83977af_ir.c
w83977af_ir.c:276: warning: `w83977af_close' defined but not used

[all uses of `w83977af_close' are in an "#ifdef MODULE" section]
--- drivers/net/irda/w83977af_ir.c.old	Fri Dec  7 23:44:42 2001
+++ drivers/net/irda/w83977af_ir.c	Fri Dec  7 23:45:52 2001
@@ -90,7 +90,9 @@
 /* Some prototypes */
 static int  w83977af_open(int i, unsigned int iobase, unsigned int irq,
                           unsigned int dma);
+#ifdef MODULE
 static int  w83977af_close(struct w83977af_ir *self);
+#endif /* MODULE */
 static int  w83977af_probe(int iobase, int irq, int dma);
 static int  w83977af_dma_receive(struct w83977af_ir *self);
 static int  w83977af_dma_receive_complete(struct w83977af_ir *self);
@@ -266,6 +268,8 @@
 	return 0;
 }

+#ifdef MODULE
+
 /*
  * Function w83977af_close (self)
  *
@@ -314,6 +318,8 @@

 	return 0;
 }
+
+#endif /* MODULE */

 int w83977af_probe( int iobase, int irq, int dma)
 {



...
make[4]: Entering directory `/mnt/kernel/linux/drivers/net/tokenring'
...
gcc -D__KERNEL__ -I/mnt/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trig
raphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferre
d-stack-boundary=2 -march=k6    -c -o tmsisa.o tmsisa.c
tmsisa.c:44: warning: `portlist' defined but not used


[all uses of `portlist' are in an "#ifdef MODULE" section]
--- drivers/net/tokenring/tmsisa.c.old	Fri Dec  7 23:36:24 2001
+++ drivers/net/tokenring/tmsisa.c	Fri Dec  7 23:37:18 2001
@@ -40,11 +40,15 @@

 #define TMS_ISA_IO_EXTENT 32

+#ifdef MODULE
+
 /* A zero-terminated list of I/O addresses to be probed. */
 static unsigned int portlist[] __initdata = {
 	0x0A20, 0x1A20, 0x0B20, 0x1B20, 0x0980, 0x1980, 0x0900, 0x1900,// SK
 	0
 };
+
+#endif /* MODULE */

 /* A zero-terminated list of IRQs to be probed.
  * Used again after initial probe for sktr_chipset_init, called from sktr_open.



...
make[3]: Entering directory `/mnt/kernel/linux/drivers/net'
...
gcc -D__KERNEL__ -I/mnt/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trig
raphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferre
d-stack-boundary=2 -march=k6    -c -o winbond-840.o winbond-840.c
winbond-840.c:146: warning: `version' defined but not used


[all uses of `version' are in an "#ifdef MODULE" section]
--- drivers/net/winbond-840.c.old	Fri Dec  7 23:38:21 2001
+++ drivers/net/winbond-840.c	Fri Dec  7 23:38:56 2001
@@ -142,10 +142,14 @@
 #include <asm/io.h>
 #include <asm/irq.h>

+#ifdef MODULE
+
 /* These identify the driver base version and may not be removed. */
 static char version[] __devinitdata =
 KERN_INFO DRV_NAME ".c:v" DRV_VERSION " (2.4 port) " DRV_RELDATE "  Donald Becker <becker@scyld.com>\n"
 KERN_INFO "  http://www.scyld.com/network/drivers.html\n";
+
+#endif /* MODULE */

 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("Winbond W89c840 Ethernet driver");



...
gcc -D__KERNEL__ -I/mnt/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trig
raphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferre
d-stack-boundary=2 -march=k6    -DEXPORT_SYMTAB -c arlan.c
arlan.c:26: warning: `probe' defined but not used
arlan.c:1128: warning: `arlan_find_devices' defined but not used


[all uses of `probe' and `arlan_find_devices' are in an
 "#ifdef MODULE" section]
--- drivers/net/arlan.c.old	Fri Dec  7 23:40:00 2001
+++ drivers/net/arlan.c	Fri Dec  7 23:40:52 2001
@@ -23,7 +23,9 @@
 static char *siteName = siteNameUNKNOWN;
 static int mem = memUNKNOWN;
 int arlan_debug = debugUNKNOWN;
+#ifdef MODULE
 static int probe = probeUNKNOWN;
+#endif /* MODULE */
 static int numDevices = numDevicesUNKNOWN;
 static int spreadingCode = spreadingCodeUNKNOWN;
 static int channelNumber = channelNumberUNKNOWN;
@@ -1124,6 +1126,8 @@
 	return -ENODEV;
 }

+#ifdef MODULE
+
 static int __init arlan_find_devices(void)
 {
 	int m;
@@ -1142,6 +1146,7 @@
 	return found;
 }

+#endif /* MODULE */

 static int arlan_change_mtu(struct net_device *dev, int new_mtu)
 {



...
make[3]: Entering directory `/mnt/kernel/linux/drivers/net/hamradio'
...
gcc -D__KERNEL__ -I/mnt/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trig
raphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferre
d-stack-boundary=2 -march=k6    -c -o 6pack.o 6pack.c
6pack.c:703: warning: `msg_invparm' defined but not used

[`msg_invparm' is never used]
--- drivers/net/hamradio/6pack.c.old	Fri Dec  7 23:41:59 2001
+++ drivers/net/hamradio/6pack.c	Fri Dec  7 23:42:19 2001
@@ -700,7 +700,6 @@
 /* Initialize 6pack control device -- register 6pack line discipline */

 static char msg_banner[]  __initdata = KERN_INFO "AX.25: 6pack driver, " SIXPACK_VERSION " (dynamic channels, max=%d)\n";
-static char msg_invparm[] __initdata = KERN_ERR  "6pack: sixpack_maxdev parameter too large.\n";
 static char msg_nomem[]   __initdata = KERN_ERR  "6pack: can't allocate sixpack_ctrls[] array! No 6pack available.\n";
 static char msg_regfail[] __initdata = KERN_ERR  "6pack: can't register line discipline (err = %d)\n";


...
make[3]: Entering directory `/mnt/kernel/linux/drivers/scsi'
...
gcc -D__KERNEL__ -I/mnt/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trig
raphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferre
d-stack-boundary=2 -march=k6    -c -o qla1280.o qla1280.c
qla1280.c:1615: warning: `qla1280_do_dpc' defined but not used

[the only call of this function is in the else path of an
 "#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,95)"; it seems to be a bit
 strange that these "if"s also appears inside qla1280_do_dpc, IOW there's
 code in this function that will neither be called in a kernel < 2.1.95
 nor in a kernel >= 2.1.95]


...
gcc -D__KERNEL__ -I/mnt/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trig
raphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferre
d-stack-boundary=2 -march=k6    -c -o i60uscsi.o i60uscsi.c
i60uscsi.c: In function `__orc_alloc_scb':
i60uscsi.c:643: warning: unused variable `flags'


[`flags' is never used in this function]
--- drivers/scsi/i60uscsi.c.old	Fri Dec  7 23:43:13 2001
+++ drivers/scsi/i60uscsi.c	Fri Dec  7 23:43:34 2001
@@ -640,7 +640,6 @@
 	ULONG idx;
 	UCHAR index;
 	UCHAR i;
-	ULONG flags;

 	Ch = hcsp->HCS_Index;
 	for (i = 0; i < 8; i++) {




cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

--1920110659-1633918769-1007681795=:8687
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="mcdx-patch-2.3.39"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.NEB.4.43.0112070036350.8687@mimas.fachschaften.tu-muenchen.de>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="mcdx-patch-2.3.39"

ZGlmZiAtdSAtciBsaW51eC5vbGQvZHJpdmVycy9jZHJvbS9Db25maWcuaW4g
bGludXgvZHJpdmVycy9jZHJvbS9Db25maWcuaW4NCi0tLSBsaW51eC5vbGQv
ZHJpdmVycy9jZHJvbS9Db25maWcuaW4JVHVlIEphbiAxMSAyMjozMzo0NiAy
MDAwDQorKysgbGludXgvZHJpdmVycy9jZHJvbS9Db25maWcuaW4JVHVlIEph
biAxMSAyMjozODo0MCAyMDAwDQpAQCAtMTksNiArMTksMzIgQEANCiAgICBo
ZXggJ01DRCBJL08gYmFzZScgQ09ORklHX01DRF9CQVNFIDMwMA0KIGZpDQog
dHJpc3RhdGUgJyAgTWl0c3VtaSBbWEEvTXVsdGlTZXNzaW9uXSBDRFJPTSBz
dXBwb3J0JyBDT05GSUdfTUNEWA0KK2lmIFsgIiRDT05GSUdfTUNEWCIgIT0g
Im4iIF07IHRoZW4NCitjaG9pY2UgJ051bWJlciBvZiBDRFJPTSBkcml2ZXMn
IFwNCisgICAgICAgICIxCQkJQ09ORklHX05VTUJFUl9NQ0RYMQlcDQorICAg
ICAgICAgMgkJCUNPTkZJR19OVU1CRVJfTUNEWDIJXA0KKyAgICAgICAgIDMJ
CQlDT05GSUdfTlVNQkVSX01DRFgzCVwNCisgICAgICAgICA0CQkJQ09ORklH
X05VTUJFUl9NQ0RYNAlcDQorICAgICAgICAgNQkJCUNPTkZJR19OVU1CRVJf
TUNEWDUJIiAxDQorICBpbnQgJ01DRFggSVJRIGRyaXZlIDEnIENPTkZJR19N
Q0RYX0lSUTEgMTENCisgIGhleCAnTUNEWCBJL08gYmFzZSBkcml2ZSAxJyBD
T05GSUdfTUNEWF9CQVNFMSAzMDANCisgIGlmIFsgIiRDT05GSUdfTlVNQkVS
X01DRFgxIiA9ICJuIiBdOyB0aGVuDQorICAgIGludCAnTUNEWCBJUlEgZHJp
dmUgMicgQ09ORklHX01DRFhfSVJRMiA1DQorICAgIGhleCAnTUNEWCBJL08g
YmFzZSBkcml2ZSAyJyBDT05GSUdfTUNEWF9CQVNFMiAzMDQNCisgICAgaWYg
WyAiJENPTkZJR19OVU1CRVJfTUNEWDIiID0gIm4iIF07IHRoZW4NCisgICAg
ICBpbnQgJ01DRFggSVJRIGRyaXZlIDMnIENPTkZJR19NQ0RYX0lSUTMgMA0K
KyAgICAgIGhleCAnTUNEWCBJL08gYmFzZSBkcml2ZSAzJyBDT05GSUdfTUNE
WF9CQVNFMyAwMDANCisgICAgICBpZiBbICIkQ09ORklHX05VTUJFUl9NQ0RY
MyIgPSAibiIgXTsgdGhlbg0KKyAgICAgICAgaW50ICdNQ0RYIElSUSBkcml2
ZSA0JyBDT05GSUdfTUNEWF9JUlE0IDANCisgICAgICAgIGhleCAnTUNEWCBJ
L08gYmFzZSBkcml2ZSA0JyBDT05GSUdfTUNEWF9CQVNFNCAwMDANCisgICAg
ICAgIGlmIFsgIiRDT05GSUdfTlVNQkVSX01DRFg0IiA9ICJuIiBdOyB0aGVu
DQorICAgICAgICAgIGludCAnTUNEWCBJUlEgZHJpdmUgNScgQ09ORklHX01D
RFhfSVJRNSAwDQorICAgICAgICAgIGhleCAnTUNEWCBJL08gYmFzZSBkcml2
ZSA1JyBDT05GSUdfTUNEWF9CQVNFNSAwMDANCisgICAgICAgIGZpDQorICAg
ICAgZmkNCisgICAgZmkNCisgIGZpDQorZmkNCiB0cmlzdGF0ZSAnICBPcHRp
Y3MgU3RvcmFnZSBET0xQSElOIDgwMDBBVCBDRFJPTSBzdXBwb3J0JyBDT05G
SUdfT1BUQ0QNCiB0cmlzdGF0ZSAnICBQaGlsaXBzL0xNUyBDTTIwNiBDRFJP
TSBzdXBwb3J0JyBDT05GSUdfQ00yMDYNCiB0cmlzdGF0ZSAnICBTYW55byBD
RFItSDk0QSBDRFJPTSBzdXBwb3J0JyBDT05GSUdfU0pDRA0KZGlmZiAtdSAt
ciBsaW51eC5vbGQvZHJpdmVycy9jZHJvbS9tY2R4LmggbGludXgvZHJpdmVy
cy9jZHJvbS9tY2R4LmgNCi0tLSBsaW51eC5vbGQvZHJpdmVycy9jZHJvbS9t
Y2R4LmgJVHVlIEphbiAxMSAyMjozMzo0NiAyMDAwDQorKysgbGludXgvZHJp
dmVycy9jZHJvbS9tY2R4LmgJVHVlIEphbiAxMSAyMjozNDoyNSAyMDAwDQpA
QCAtNTQsMTMgKzU0LDU3IEBADQogICoJTk9URTogSSBkaWRuJ3QgZ2V0IGEg
ZHJpdmUgYXQgaXJxIDkoMikgd29ya2luZy4gIE5vdCBldmVuIGFsb25lLg0K
ICAqLw0KICNpZiBNQ0RYX0FVVE9QUk9CRSA9PSAwDQotCSNkZWZpbmUgTUNE
WF9ORFJJVkVTIDENCisNCisvKgkNCisgKiAgICAgIFRoZSByaWdodCBDT05G
SUdfTlVNQkVSX01DRFh4IGlzIHNldCBieSB0aGUgQ29uZmlndXJlIHNjcmlw
dC4NCisgKi8NCisjaWYgQ09ORklHX05VTUJFUl9NQ0RYMSANCisgICNkZWZp
bmUgTUNEWF9ORFJJVkVTIDENCisgICNlbHNlDQorICAjaWYgQ09ORklHX05V
TUJFUl9NQ0RYMg0KKyAgICAjZGVmaW5lIE1DRFhfTkRSSVZFUyAyDQorICAg
ICNlbHNlDQorICAgICNpZiBDT05GSUdfTlVNQkVSX01DRFgzDQorICAgICAg
I2RlZmluZSBNQ0RYX05EUklWRVMgMw0KKyAgICAgICNlbHNlDQorICAgICAg
I2lmIENPTkZJR19OVU1CRVJfTUNEWDQNCisgICAgICAgICNkZWZpbmUgTUNE
WF9ORFJJVkVTIDQNCisgICAgICAgICNlbHNlDQorICAgICAgICAjZGVmaW5l
IE1DRFhfTkRSSVZFUyA1DQorICAgICAgI2VuZGlmDQorICAgICNlbmRpZg0K
KyAgI2VuZGlmDQorI2VuZGlmDQorDQorLyoNCisgKiAgICAgIFNvbWUgKHVu
aW1wb3J0YW50KSB2YWx1ZXMgbWF5IGJlIHVuZGVmaW5lZCBhZnRlciBDb25m
aWd1cmUuDQorICovDQorI2lmbmRlZiBDT05GSUdfTUNEWF9CQVNFMg0KKyNk
ZWZpbmUgQ09ORklHX01DRFhfQkFTRTIgMA0KKyNkZWZpbmUgQ09ORklHX01D
RFhfSVJRMiAwDQorI2VuZGlmDQorDQorI2lmbmRlZiBDT05GSUdfTUNEWF9C
QVNFMw0KKyNkZWZpbmUgQ09ORklHX01DRFhfQkFTRTMgMA0KKyNkZWZpbmUg
Q09ORklHX01DRFhfSVJRMyAwDQorI2VuZGlmDQorDQorI2lmbmRlZiBDT05G
SUdfTUNEWF9CQVNFNA0KKyNkZWZpbmUgQ09ORklHX01DRFhfQkFTRTQgMA0K
KyNkZWZpbmUgQ09ORklHX01DRFhfSVJRNCAwDQorI2VuZGlmDQorDQorI2lm
bmRlZiBDT05GSUdfTUNEWF9CQVNFNQ0KKyNkZWZpbmUgQ09ORklHX01DRFhf
QkFTRTUgMA0KKyNkZWZpbmUgQ09ORklHX01DRFhfSVJRNSAwDQorI2VuZGlm
DQorDQogCSNkZWZpbmUgTUNEWF9EUklWRU1BUCB7CQlcDQotCQkJezB4MzAw
LCAxMX0sCVwNCi0JCQl7MHgzMDQsIDA1fSwgIAlcDQotCQkJezB4MDAwLCAw
MH0sICAJXA0KLQkJCXsweDAwMCwgMDB9LCAgCVwNCi0JCQl7MHgwMDAsIDAw
fSwgIAlcDQorCQkJe0NPTkZJR19NQ0RYX0JBU0UxLCBDT05GSUdfTUNEWF9J
UlExfSwJXA0KKwkJCXtDT05GSUdfTUNEWF9CQVNFMiwgQ09ORklHX01DRFhf
SVJRMn0sICAJXA0KKwkJCXtDT05GSUdfTUNEWF9CQVNFMywgQ09ORklHX01D
RFhfSVJRM30sICAJXA0KKwkJCXtDT05GSUdfTUNEWF9CQVNFNCwgQ09ORklH
X01DRFhfSVJRNH0sICAJXA0KKwkJCXtDT05GSUdfTUNEWF9CQVNFNSwgQ09O
RklHX01DRFhfSVJRNX0sICAJXA0KIAkgIAl9DQogI2Vsc2UNCiAJI2Vycm9y
IEF1dG9wcm9iaW5nIGlzIG5vdCBpbXBsZW1lbnRlZCB5ZXQuDQpAQCAtNzQs
MTAgKzExOCw2IEBADQogI2RlZmluZSBNQ0RYX0RFQlVHICAgMA0KICNlbmRp
Zg0KIA0KLS8qICoqKiBtYWtlIHRoZSBmb2xsb3dpbmcgbGluZSB1bmNvbW1l
bnRlZCwgaWYgeW91J3JlIHN1cmUsDQotICogKioqIGFsbCBjb25maWd1cmF0
aW9uIGlzIGRvbmUgKi8NCi0vKiAjZGVmaW5lIElfV0FTX0hFUkUgKi8NCi0N
CiAvKglUaGUgbmFtZSBvZiB0aGUgZGV2aWNlICovDQogI2RlZmluZSBNQ0RY
ICJtY2R4IgkNCiANCkBAIC0xNzQsMTIgKzIxNCw1IEBADQogI2RlZmluZSBN
Q0RYX0UJCTEJCQkvKiB1bnNwZWMgZXJyb3IgKi8NCiAjZGVmaW5lIE1DRFhf
U1RfRU9NIDB4MDEwMAkJLyogZW5kIG9mIG1lZGlhICovDQogI2RlZmluZSBN
Q0RYX1NUX0RSViAweDAwZmYJCS8qIG1hc2sgdG8gcXVlcnkgdGhlIGRyaXZl
IHN0YXR1cyAqLw0KLQ0KLSNpZm5kZWYgSV9XQVNfSEVSRQ0KLSNpZm5kZWYg
TU9EVUxFDQotI3dhcm5pbmcgWW91IGhhdmUgbm90IGVkaXRlZCBtY2R4LmgN
Ci0jd2FybmluZyBQZXJoYXBzIGlycSBhbmQgaS9vIHNldHRpbmdzIGFyZSB3
cm9uZy4NCi0jZW5kaWYNCi0jZW5kaWYNCiANCiAvKiBleDpzZXQgdHM9NCBz
dz00OiAqLw0K
--1920110659-1633918769-1007681795=:8687--
