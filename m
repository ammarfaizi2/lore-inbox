Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSFXPeP>; Mon, 24 Jun 2002 11:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSFXPeO>; Mon, 24 Jun 2002 11:34:14 -0400
Received: from mail.scs.ch ([212.254.229.5]:32913 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S314138AbSFXPeB>;
	Mon, 24 Jun 2002 11:34:01 -0400
Subject: [PATCH] Re: make-3.79.1 bug breaks
	linux-2.5.24/drivers/net/hamradio/soundmodem
From: Thomas Sailer <sailer@scs.ch>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: bug-make@gnu.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
In-Reply-To: <200206220657.XAA21563@adam.yggdrasil.com>
References: <200206220657.XAA21563@adam.yggdrasil.com>
Content-Type: multipart/mixed; boundary="=-y8LoilXaTyB4B5AUiN5L"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 24 Jun 2002 17:33:27 +0200
Message-Id: <1024932807.19284.26.camel@watermelon.scs.ch>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y8LoilXaTyB4B5AUiN5L
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2002-06-22 at 08:57, Adam J. Richter wrote:
> 	linux-2.5.24/drivers/net/hamradio/soundmodem/Makefile contains
> the following rule:
> 
> $(obj)/sm_tbl_%: $(obj)/gentbl
>         $<
> 
> 	obj was set to "." /usr/src/linux/Rules.make, which was included
> earlier in the Makefile.
> 
> 	The problem is that when make executes this rule it executes
> "gentbl" rather than "./gentbl".  This causes the command to fail if
> you do not have "." in your path.  Make-3.79.1 is apparently being too
> clever in expanding file names.  I think this is a make bug.

Thanks for investigating this, but I propose another fix, namely to
remove soundmodem altogether. Linus, please do:

rm -rf drivers/net/hamradio/soundmodem
and then apply the attached patch.

Why?
* There is a usermode only replacement now (and for several years
already), which works with most OSS interface sound drivers
* The kernel stuff is limited to a few ISA cards, and nowadays
mainboards with ISA slots almost ceased to exist, same with ISA
soundcards

Thanks

Tom


--=-y8LoilXaTyB4B5AUiN5L
Content-Disposition: inline; filename=soundmodem_remove.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=soundmodem_remove.diff; charset=ISO-8859-1

--- linux-2.5.24/drivers/net/hamradio/Config.in.sm	Mon Jun 24 17:22:03 2002
+++ linux-2.5.24/drivers/net/hamradio/Config.in	Mon Jun 24 17:22:44 2002
@@ -18,18 +18,5 @@
 dep_tristate 'BAYCOM picpar and par96 driver for AX.25' CONFIG_BAYCOM_PAR =
$CONFIG_PARPORT $CONFIG_AX25
 dep_tristate 'BAYCOM epp driver for AX.25' CONFIG_BAYCOM_EPP $CONFIG_PARPO=
RT $CONFIG_AX25
=20
-dep_tristate 'Soundcard modem driver' CONFIG_SOUNDMODEM $CONFIG_PARPORT $C=
ONFIG_AX25
-if [ "$CONFIG_SOUNDMODEM" !=3D "n" ]; then
-   bool '  soundmodem support for Soundblaster and compatible cards' CONFI=
G_SOUNDMODEM_SBC
-   bool '  soundmodem support for WSS and Crystal cards' CONFIG_SOUNDMODEM=
_WSS
-   bool '  soundmodem support for 1200 baud AFSK modulation' CONFIG_SOUNDM=
ODEM_AFSK1200
-   bool '  soundmodem support for 2400 baud AFSK modulation (7.3728MHz cry=
stal)' CONFIG_SOUNDMODEM_AFSK2400_7
-   bool '  soundmodem support for 2400 baud AFSK modulation (8MHz crystal)=
' CONFIG_SOUNDMODEM_AFSK2400_8
-   bool '  soundmodem support for 2666 baud AFSK modulation' CONFIG_SOUNDM=
ODEM_AFSK2666
-   bool '  soundmodem support for 4800 baud HAPN-1 modulation' CONFIG_SOUN=
DMODEM_HAPN4800
-   bool '  soundmodem support for 4800 baud PSK modulation' CONFIG_SOUNDMO=
DEM_PSK4800
-   bool '  soundmodem support for 9600 baud FSK G3RUH modulation' CONFIG_S=
OUNDMODEM_FSK9600
-fi
-
 dep_tristate 'YAM driver for AX.25' CONFIG_YAM $CONFIG_AX25
=20
--- linux-2.5.24/drivers/net/hamradio/Makefile.sm	Mon Jun 24 17:22:07 2002
+++ linux-2.5.24/drivers/net/hamradio/Makefile	Mon Jun 24 17:22:30 2002
@@ -22,6 +22,5 @@
 obj-$(CONFIG_BAYCOM_SER_HDX)	+=3D baycom_ser_hdx.o	hdlcdrv.o
 obj-$(CONFIG_BAYCOM_PAR)	+=3D baycom_par.o		hdlcdrv.o
 obj-$(CONFIG_BAYCOM_EPP)	+=3D baycom_epp.o		hdlcdrv.o
-obj-$(CONFIG_SOUNDMODEM)	+=3D soundmodem/		hdlcdrv.o
=20
 include $(TOPDIR)/Rules.make
--- linux-2.5.24/drivers/net/hamradio/Config.help.sm	Mon Jun 24 17:23:49 20=
02
+++ linux-2.5.24/drivers/net/hamradio/Config.help	Mon Jun 24 17:24:13 2002
@@ -161,87 +161,3 @@
   say M here and read <file:Documentation/modules.txt>.  This is
   recommended.  The module will be called baycom_ser_hdx.o.
=20
-CONFIG_SOUNDMODEM
-  This experimental driver allows a standard Sound Blaster or
-  WindowsSoundSystem compatible sound card to be used as a packet
-  radio modem (NOT as a telephone modem!), to send digital traffic
-  over amateur radio.
-
-  To configure the driver, use the sethdlc, smdiag and smmixer
-  utilities available in the standard ax25 utilities package. For
-  information on how to key the transmitter, see
-  <http://www.ife.ee.ethz.ch/~sailer/pcf/ptt_circ/ptt.html> and
-  <file:Documentation/networking/soundmodem.txt>.
-
-  If you want to compile this driver as a module ( =3D code which can be
-  inserted in and removed from the running kernel whenever you want),
-  say M here and read <file:Documentation/modules.txt>.  This is
-  recommended.  The module will be called soundmodem.o.
-
-CONFIG_SOUNDMODEM_SBC
-  This option enables the soundmodem driver to use Sound Blaster and
-  compatible cards. If you have a dual mode card (i.e. a WSS cards
-  with a Sound Blaster emulation) you should say N here and Y to
-  "Sound card modem support for WSS and Crystal cards", below, because
-  this usually results in better performance. This option also
-  supports SB16/32/64 in full-duplex mode.
-
-CONFIG_SOUNDMODEM_WSS
-  This option enables the soundmodem driver to use WindowsSoundSystem
-  compatible cards. These cards feature a codec chip from either
-  Analog Devices (such as AD1848, AD1845, AD1812) or Crystal
-  Semiconductors (such as CS4248, CS423x). This option also supports
-  the WSS full-duplex operation which currently works with Crystal
-  CS423x chips. If you don't need full-duplex operation, do not enable
-  it to save performance.
-
-CONFIG_SOUNDMODEM_AFSK1200
-  This option enables the soundmodem driver 1200 baud AFSK modem,
-  compatible to popular modems using TCM3105 or AM7911. The
-  demodulator requires about 12% of the CPU power of a Pentium 75 CPU
-  per channel.
-
-CONFIG_SOUNDMODEM_AFSK2400_7
-  This option enables the soundmodem driver 2400 baud AFSK modem,
-  compatible to TCM3105 modems (over-)clocked with a 7.3728MHz
-  crystal. Note that the availability of this driver does _not_ imply
-  that I recommend building such links. It is only here since users
-  especially in eastern Europe have asked me to do so. In fact this
-  modulation scheme has many disadvantages, mainly its incompatibility
-  with many transceiver designs and the fact that the TCM3105 (if
-  used) is operated widely outside its specifications.
-
-CONFIG_SOUNDMODEM_AFSK2400_8
-  This option enables the soundmodem driver 2400 baud AFSK modem,
-  compatible to TCM3105 modems (over-)clocked with an 8MHz crystal.
-  Note that the availability of this driver does _not_ imply that I
-  recommend building such links. It is only here since users
-  especially in eastern Europe have asked me to do so. In fact this
-  modulation scheme has many disadvantages, mainly its incompatibility
-  with many transceiver designs and the fact that the TCM3105 (if
-  used) is operated widely outside its specifications.
-
-CONFIG_SOUNDMODEM_AFSK2666
-  This option enables the soundmodem driver 2666 baud AFSK modem.
-  This modem is experimental, and not compatible to anything
-  else I know of.
-
-CONFIG_SOUNDMODEM_PSK4800
-  This option enables the soundmodem driver 4800 baud 8PSK modem.
-  This modem is experimental, and not compatible to anything
-  else I know of.
-
-CONFIG_SOUNDMODEM_HAPN4800
-  This option enables the soundmodem driver 4800 baud HAPN-1
-  compatible modem. This modulation seems to be widely used 'down
-  under' and in the Netherlands. Here, nobody uses it, so I could not
-  test if it works. It is compatible to itself, however :-)
-
-CONFIG_SOUNDMODEM_FSK9600
-  This option enables the soundmodem driver 9600 baud FSK modem,
-  compatible to the G3RUH standard. The demodulator requires about 4%
-  of the CPU power of a Pentium 75 CPU per channel. You can say Y to
-  both 1200 baud AFSK and 9600 baud FSK if you want (but obviously you
-  can only use one protocol at a time, depending on what the other end
-  can understand).
-
--- linux-2.5.24/Makefile.sm	Mon Jun 24 17:23:00 2002
+++ linux-2.5.24/Makefile	Mon Jun 24 17:23:20 2002
@@ -599,10 +599,6 @@
 # 	files removed with 'make mrproper'
 MRPROPER_FILES +=3D \
 	include/linux/autoconf.h include/linux/version.h \
-	drivers/net/hamradio/soundmodem/sm_tbl_{afsk1200,afsk2666,fsk9600}.h \
-	drivers/net/hamradio/soundmodem/sm_tbl_{hapn4800,psk4800}.h \
-	drivers/net/hamradio/soundmodem/sm_tbl_{afsk2400_7,afsk2400_8}.h \
-	drivers/net/hamradio/soundmodem/gentbl \
 	sound/oss/*_boot.h sound/oss/.*.boot \
 	sound/oss/msndinit.c \
 	sound/oss/msndperm.c \

--=-y8LoilXaTyB4B5AUiN5L--
