Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbUBWVHg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 16:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbUBWVGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 16:06:38 -0500
Received: from mail.convergence.de ([212.84.236.4]:45802 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261972AbUBWVE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 16:04:58 -0500
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       hunold@linuxtv.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 1/9] Update the DVB subsystem docs
In-Reply-To: <1077570281877@convergence.de>
Message-Id: <10775702813893@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Mon, 23 Feb 2004 16:04:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] dvb docs: added a nice howto on how to get Avermedia DVB-T running - nice tutorial for DVB newbie, too
- [DVB] dvb docs: fix various incorrect informations in cards.txt, faq.txt, firmware.txt
diff -uNrwB --new-file xx-linux-2.6.3/Documentation/dvb/avermedia.txt linux-2.6.3.p/Documentation/dvb/avermedia.txt
--- xx-linux-2.6.3/Documentation/dvb/avermedia.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.3.p/Documentation/dvb/avermedia.txt	2004-02-02 19:28:29.000000000 +0100
@@ -0,0 +1,324 @@
+
+HOWTO: Get An Avermedia DVB-T working under Linux
+           ______________________________________________
+
+   Table of Contents
+   Assumptions and Introduction
+   The Avermedia DVB-T
+   Getting the card going
+   Getting the Firmware
+   Receiving DVB-T in Australia
+   Known Limitations
+   Further Update
+
+Assumptions and Introduction
+
+   It  is assumed that the reader understands the basic structure
+   of  the Linux Kernel DVB drivers and the general principles of
+   Digital TV.
+
+   One  significant difference between Digital TV and Analogue TV
+   that  the  unwary  (like  myself)  should  consider  is  that,
+   although  the  component  structure  of budget DVB-T cards are
+   substantially  similar  to Analogue TV cards, they function in
+   substantially different ways.
+
+   The  purpose  of  an  Analogue TV is to receive and display an
+   Analogue  Television  signal. An Analogue TV signal (otherwise
+   known  as  composite  video)  is  an  analogue  encoding  of a
+   sequence  of  image frames (25 per second) rasterised using an
+   interlacing   technique.   Interlacing  takes  two  fields  to
+   represent  one  frame.  Computers today are at their best when
+   dealing  with  digital  signals,  not  analogue  signals and a
+   composite  video signal is about as far removed from a digital
+   data stream as you can get. Therefore, an Analogue TV card for
+   a PC has the following purpose:
+
+     * Tune the receiver to receive a broadcast signal
+     * demodulate the broadcast signal
+     * demultiplex  the  analogue video signal and analogue audio
+       signal  (note some countries employ a digital audio signal
+       embedded  within the modulated composite analogue signal -
+       NICAM.)
+     * digitize  the analogue video signal and make the resulting
+       datastream available to the data bus.
+
+   The  digital  datastream from an Analogue TV card is generated
+   by  circuitry on the card and is often presented uncompressed.
+   For  a PAL TV signal encoded at a resolution of 768x576 24-bit
+   color pixels over 25 frames per second - a fair amount of data
+   is  generated and must be proceesed by the PC before it can be
+   displayed  on the video monitor screen. Some Analogue TV cards
+   for  PC's  have  onboard  MPEG2  encoders which permit the raw
+   digital  data  stream  to be presented to the PC in an encoded
+   and  compressed  form  -  similar  to the form that is used in
+   Digital TV.
+
+   The  purpose of a simple budget digital TV card (DVB-T,C or S)
+   is to simply:
+
+     * Tune the received to receive a broadcast signal.
+     * Extract  the encoded digital datastream from the broadcast
+       signal.
+     * Make  the  encoded digital datastream (MPEG2) available to
+       the data bus.
+
+   The  significant  difference between the two is that the tuner
+   on  the analogue TV card spits out an Analogue signal, whereas
+   the  tuner  on  the  digital  TV  card  spits out a compressed
+   encoded   digital   datastream.   As  the  signal  is  already
+   digitised,  it  is  trivial  to pass this datastream to the PC
+   databus  with  minimal  additional processing and then extract
+   the  digital  video  and audio datastreams passing them to the
+   appropriate software or hardware for decoding and viewing.
+     _________________________________________________________
+
+The Avermedia DVB-T
+
+   The Avermedia DVB-T is a budget PCI DVB card. It has 3 inputs:
+
+     * RF Tuner Input
+     * Composite Video Input (RCA Jack)
+     * SVIDEO Input (Mini-DIN)
+
+   The  RF  Tuner  Input  is the input to the tuner module of the
+   card.  The  Tuner  is  otherwise known as the "Frontend" . The
+   Frontend of the Avermedia DVB-T is a Microtune 7202D. A timely
+   post  to  the  linux-dvb  mailing  list  ascertained  that the
+   Microtune  7202D  is  supported  by the sp887x driver which is
+   found in the dvb-hw CVS module.
+
+   The  DVB-T card is based around the BT878 chip which is a very
+   common multimedia bridge and often found on Analogue TV cards.
+   There is no on-board MPEG2 decoder, which means that all MPEG2
+   decoding  must  be done in software, or if you have one, on an
+   MPEG2 hardware decoding card or chipset.
+     _________________________________________________________
+
+Getting the card going
+
+   In order to fire up the card, it is necessary to load a number
+   of modules from the DVB driver set. Prior to this it will have
+   been  necessary to download these drivers from the linuxtv CVS
+   server and compile them successfully.
+
+   Depending on the card's feature set, the Device Driver API for
+   DVB under Linux will expose some of the following device files
+   in the /dev tree:
+
+     * /dev/dvb/adapter0/audio0
+     * /dev/dvb/adapter0/ca0
+     * /dev/dvb/adapter0/demux0
+     * /dev/dvb/adapter0/dvr0
+     * /dev/dvb/adapter0/frontend0
+     * /dev/dvb/adapter0/net0
+     * /dev/dvb/adapter0/osd0
+     * /dev/dvb/adapter0/video0
+
+   The  primary  device  nodes that we are interested in (at this
+   stage) for the Avermedia DVB-T are:
+
+     * /dev/dvb/adapter0/dvr0
+     * /dev/dvb/adapter0/frontend0
+
+   The dvr0 device node is used to read the MPEG2 Data Stream and
+   the frontend0 node is used to tune the frontend tuner module.
+
+   At  this  stage,  it  has  not  been  able  to  ascertain  the
+   functionality  of the remaining device nodes in respect of the
+   Avermedia  DVBT.  However,  full  functionality  in respect of
+   tuning,  receiving  and  supplying  the  MPEG2  data stream is
+   possible  with the currently available versions of the driver.
+   It  may be possible that additional functionality is available
+   from  the  card  (i.e.  viewing the additional analogue inputs
+   that  the card presents), but this has not been tested yet. If
+   I get around to this, I'll update the document with whatever I
+   find.
+
+   To  power  up  the  card,  load  the  following modules in the
+   following order:
+
+     * insmod dvb-core.o
+     * modprobe bttv.o
+     * insmod bt878.o
+     * insmod dvb-bt8xx.o
+     * insmod sp887x.o
+
+   Insertion  of  these  modules  into  the  running  kernel will
+   activate the appropriate DVB device nodes. It is then possible
+   to start accessing the card with utilities such as scan, tzap,
+   dvbstream etc.
+
+   The  current version of the frontend module sp887x.o, contains
+   no firmware drivers?, so the first time you open it with a DVB
+   utility  the driver will try to download some initial firmware
+   to  the card. You will need to download this firmware from the
+   web,  or  copy  it from an installation of the Windows drivers
+   that probably came with your card, before you can use it.
+
+   The  default  Linux  filesystem  location for this firmware is
+   /usr/lib/hotplug/firmware/sc_main.mc .
+     _________________________________________________________
+
+Getting the Firmware
+
+   As the firmware for the card is no longer contained within the
+   driver,  it  is  necessary  to  extract  it  from  the windows
+   drivers.
+
+   The  Windows  drivers  for the Avermedia DVB-T can be obtained
+   from: http://babyurl.com/H3U970 and you can get an application
+   to extract the firmware from:
+   http://www.kyz.uklinux.net/cabextract.php.
+     _________________________________________________________
+
+Receiving DVB-T in Australia
+
+   I  have  no  experience of DVB-T in other countries other than
+   Australia,  so  I will attempt to explain how it works here in
+   Melbourne  and how this affects the configuration of the DVB-T
+   card.
+
+   The  Digital  Broadcasting  Australia  website has a Reception
+   locatortool which provides information on transponder channels
+   and  frequencies.  My  local  transmitter  happens to be Mount
+   Dandenong.
+
+   The frequencies broadcast by Mount Dandenong are:
+
+   Table 1. Transponder Frequencies Mount Dandenong, Vic, Aus.
+   Broadcaster Channel Frequency
+   ABC         VHF 12  226.5 MHz
+   TEN         VHF 11  219.5 MHz
+   NINE        VHF 8   191.625 MHz
+   SEVEN       VHF 6   177.5 MHz
+   SBS         UHF 29  536.5 MHz
+
+   The Scan utility has a set of compiled-in defaults for various
+   countries and regions, but if they do not suit, or if you have
+   a pre-compiled scan binary, you can specify a data file on the
+   command  line which contains the transponder frequencies. Here
+   is a sample file for the above channel transponders:
+# Data file for DVB scan program
+#
+# C Frequency SymbolRate FEC QAM
+# S Frequency Polarisation SymbolRate FEC
+# T Frequency Bandwidth FEC FEC2 QAM Mode Guard Hier
+T 226500000 7MHz 2/3 NONE QAM64 8k 1/8 NONE
+T 191625000 7MHz 2/3 NONE QAM64 8k 1/8 NONE
+T 219500000 7MHz 2/3 NONE QAM64 8k 1/8 NONE
+T 177500000 7MHz 2/3 NONE QAM64 8k 1/8 NONE
+T 536500000 7MHz 2/3 NONE QAM64 8k 1/8 NONE
+
+   The   defaults   for   the  transponder  frequency  and  other
+   modulation parameters were obtained from www.dba.org.au.
+
+   When  Scan  runs, it will output channels.conf information for
+   any  channel's transponders which the card's frontend can lock
+   onto.  (i.e.  any  whose  signal  is  strong  enough  at  your
+   antenna).
+
+   Here's my channels.conf file for anyone who's interested:
+ABC HDTV:226500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_3_4:FEC_3_4:QAM_64
+:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_16:HIERARCHY_NONE:2307:0:560
+ABC TV Melbourne:226500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_3_4:FEC_3_
+4:QAM_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_16:HIERARCHY_NONE:512:65
+0:561
+ABC TV 2:226500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_3_4:FEC_3_4:QAM_64
+:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_16:HIERARCHY_NONE:512:650:562
+ABC TV 3:226500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_3_4:FEC_3_4:QAM_64
+:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_16:HIERARCHY_NONE:512:650:563
+ABC TV 4:226500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_3_4:FEC_3_4:QAM_64
+:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_16:HIERARCHY_NONE:512:650:564
+ABC DiG Radio:226500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_3_4:FEC_3_4:Q
+AM_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_16:HIERARCHY_NONE:0:2311:56
+6
+TEN Digital:219500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_3_4:FEC_1_2:QAM
+_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_16:HIERARCHY_NONE:512:650:158
+5
+TEN Digital 1:219500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_3_4:FEC_1_2:Q
+AM_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_16:HIERARCHY_NONE:512:650:1
+586
+TEN Digital 2:219500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_3_4:FEC_1_2:Q
+AM_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_16:HIERARCHY_NONE:512:650:1
+587
+TEN Digital 3:219500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_3_4:FEC_1_2:Q
+AM_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_16:HIERARCHY_NONE:512:650:1
+588
+TEN Digital:219500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_3_4:FEC_1_2:QAM
+_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_16:HIERARCHY_NONE:512:650:158
+9
+TEN Digital 4:219500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_3_4:FEC_1_2:Q
+AM_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_16:HIERARCHY_NONE:512:650:1
+590
+TEN Digital:219500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_3_4:FEC_1_2:QAM
+_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_16:HIERARCHY_NONE:512:650:159
+1
+TEN HD:219500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_3_4:FEC_1_2:QAM_64:T
+RANSMISSION_MODE_8K:GUARD_INTERVAL_1_16:HIERARCHY_NONE:514:0:1592
+TEN Digital:219500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_3_4:FEC_1_2:QAM
+_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_16:HIERARCHY_NONE:512:650:159
+3
+Nine Digital:191625000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_3_4:FEC_1_2:QA
+M_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_16:HIERARCHY_NONE:513:660:10
+72
+Nine Digital HD:191625000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_3_4:FEC_1_2
+:QAM_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_16:HIERARCHY_NONE:512:0:1
+073
+Nine Guide:191625000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_3_4:FEC_1_2:QAM_
+64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_16:HIERARCHY_NONE:514:670:1074
+7 Digital:177500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_2_3:FEC_2_3:QAM_6
+4:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_8:HIERARCHY_NONE:769:770:1328
+7 Digital 1:177500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_2_3:FEC_2_3:QAM
+_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_8:HIERARCHY_NONE:769:770:1329
+7 Digital 2:177500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_2_3:FEC_2_3:QAM
+_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_8:HIERARCHY_NONE:769:770:1330
+7 Digital 3:177500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_2_3:FEC_2_3:QAM
+_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_8:HIERARCHY_NONE:769:770:1331
+7 HD Digital:177500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_2_3:FEC_2_3:QA
+M_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_8:HIERARCHY_NONE:833:834:133
+2
+7 Program Guide:177500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_2_3:FEC_2_3
+:QAM_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_8:HIERARCHY_NONE:865:866:
+1334
+SBS HD:536500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_2_3:FEC_2_3:QAM_64:T
+RANSMISSION_MODE_8K:GUARD_INTERVAL_1_8:HIERARCHY_NONE:102:103:784
+SBS DIGITAL 1:536500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_2_3:FEC_2_3:Q
+AM_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_8:HIERARCHY_NONE:161:81:785
+SBS DIGITAL 2:536500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_2_3:FEC_2_3:Q
+AM_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_8:HIERARCHY_NONE:162:83:786
+SBS EPG:536500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_2_3:FEC_2_3:QAM_64:
+TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_8:HIERARCHY_NONE:163:85:787
+SBS RADIO 1:536500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_2_3:FEC_2_3:QAM
+_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_8:HIERARCHY_NONE:0:201:798
+SBS RADIO 2:536500000:INVERSION_OFF:BANDWIDTH_7_MHZ:FEC_2_3:FEC_2_3:QAM
+_64:TRANSMISSION_MODE_8K:GUARD_INTERVAL_1_8:HIERARCHY_NONE:0:202:799
+     _________________________________________________________
+
+Known Limitations
+
+   At  present  I can say with confidence that the frontend tunes
+   via /dev/dvb/adapter{x}/frontend0 and supplies an MPEG2 stream
+   via   /dev/dvb/adapter{x}/dvr0.   I   have   not   tested  the
+   functionality  of any other part of the card yet. I will do so
+   over time and update this document.
+
+   There  are some limitations in the i2c layer due to a returned
+   error message inconsistency. Although this generates errors in
+   dmesg  and  the  system logs, it does not appear to affect the
+   ability of the frontend to function correctly.
+     _________________________________________________________
+
+Further Update
+
+   dvbstream  and  VideoLAN  Client on windows works a treat with
+   DVB,  in  fact  this  is  currently  serving as my main way of
+   viewing  DVB-T  at  the  moment.  Additionally, VLC is happily
+   decoding  HDTV  signals,  although  the PC is dropping the odd
+   frame here and there - I assume due to processing capability -
+   as all the decoding is being done under windows in software.
+
+   Many  thanks to Nigel Pearson for the updates to this document
+   since the recent revision of the driver.
+
+   January 29th 2004
diff -uNrwB --new-file xx-linux-2.6.3/Documentation/dvb/cards.txt linux-2.6.3.p/Documentation/dvb/cards.txt
--- xx-linux-2.6.3/Documentation/dvb/cards.txt	2004-01-09 09:22:32.000000000 +0100
+++ linux-2.6.3.p/Documentation/dvb/cards.txt	2004-02-23 12:52:31.000000000 +0100
@@ -8,7 +8,7 @@
   DVB-S/DVB-C/DVB-T. Thus the frontend drivers are listed seperately.
 
   Note 1: There is no guarantee that every frontend driver works
-  out-of-the box with every card, because of different wiring.
+  out of the box with every card, because of different wiring.
 
   Note 2: The demodulator chips can be used with a variety of
   tuner/PLL chips, and not all combinations are supported. Often
@@ -19,13 +19,13 @@
 o Frontends drivers: 
   - dvb_dummy_fe: for testing...
   DVB-S:
-   - alps_bsrv2		: Alps BSRV2 (ves1893 demodulator)
+   - ves1x93		: Alps BSRV2 (ves1893 demodulator) and dbox2 (ves1993)
    - cx24110		: Conexant HM1221/HM1811 (cx24110 or cx24106 demod, cx24108 PLL)
    - grundig_29504-491	: Grundig 29504-491 (Philips TDA8083 demodulator), tsa5522 PLL
    - mt312		: Zarlink mt312 or Mitel vp310 demodulator, sl1935 or tsa5059 PLL
    - stv0299		: Alps BSRU6 (tsa5059 PLL), LG TDQB-S00x (tsa5059 PLL),
    			  LG TDQF-S001F (sl1935 PLL), Philips SU1278 (tua6100 PLL), 
-			  Philips SU1278SH (tsa5059 PLL)
+			  Philips SU1278SH (tsa5059 PLL), Samsung TBMU24112IMB
   DVB-C:
    - ves1820		: various (ves1820 demodulator, sp5659c or spXXXX PLL)
    - at76c651		: Atmel AT76c651(B) with DAT7021 PLL
@@ -37,6 +37,9 @@
    - nxt6000 		: Alps TDME7 (MITEL SP5659 PLL), Alps TDED4 (TI ALP510 PLL),
                		  Comtech DVBT-6k07 (SP5730 PLL)
                		  (NxtWave Communications NXT6000 demodulator)
+   - sp887x		: Microtune 7202D
+  DVB-S/C/T:
+   - dst		: TwinHan DST Frontend
 
 
 o Cards based on the Phillips saa7146 multimedia PCI bridge chip:
@@ -48,16 +51,17 @@
     - SATELCO Multimedia PCI
     - KNC1 DVB-S
 
-o Cards based on the B2C2 Inc. FlexCopII:
-  - Technisat SkyStar2 PCI DVB
+o Cards based on the B2C2 Inc. FlexCopII/IIb/III:
+  - Technisat SkyStar2 PCI DVB card revision 2.3, 2.6B, 2.6C
 
 o Cards based on the Conexant Bt8xx PCI bridge:
   - Pinnacle PCTV Sat DVB
   - Nebula Electronics DigiTV
+  - TwinHan DST
+  - Avermedia DVB-T
 
 o Technotrend / Hauppauge DVB USB devices:
   - Nova USB
-  - DEC 2000-T
-
-o Preliminary support for the analog module of the Siemens DVB-C PCI card
+  - DEC 2000-T, 3000-S, 2540-T
 
+o Experimental support for the analog module of the Siemens DVB-C PCI card
diff -uNrwB --new-file xx-linux-2.6.3/Documentation/dvb/faq.txt linux-2.6.3.p/Documentation/dvb/faq.txt
--- xx-linux-2.6.3/Documentation/dvb/faq.txt	2004-01-09 09:22:32.000000000 +0100
+++ linux-2.6.3.p/Documentation/dvb/faq.txt	2004-02-02 19:28:29.000000000 +0100
@@ -99,11 +99,57 @@
 	If you are using a Technotrend/Hauppauge DVB-C card *without* analog
 	module, you might have to use module parameter adac=-1 (dvb-ttpci.o).
 
-5. The dvb_net device doesn't give me any multicast packets
+5. The dvb_net device doesn't give me any packets at all
+
+	Run tcpdump on the dvb0_0 interface. This sets the interface
+	into promiscous mode so it accepts any packets from the PID
+	you have configured with the dvbnet utility. Check if there
+	are any packets with the IP addr and MAC addr you have
+	configured with ifconfig.
+
+	If tcpdump doesn't give you any output, check the statistics
+	which ifconfig outputs. (Note: If the MAC address is wrong,
+	dvb_net won't get any input; thus you have to run tcpdump
+	before checking the statistics.) If there are no packets at
+	all then maybe the PID is wrong. If there are error packets,
+	then either the PID is wrong or the stream does not conform to
+	the MPE standard (EN 301 192, http://www.etsi.org/). You can
+	use e.g. dvbsnoop for debugging.
+
+6. The dvb_net device doesn't give me any multicast packets
 
 	Check your routes if they include the multicast address range.
 	Additionally make sure that "source validation by reversed path
 	lookup" is disabled:
 	  $ "echo 0 > /proc/sys/net/ipv4/conf/dvb0/rp_filter"
 
+7. What the hell are all those modules that need to be loaded?
+         
+	For a dvb-ttpci av7110 based full-featured card the following
+	modules are loaded:
+
+	- videodev: Video4Linux core module. This is the base module that
+	  gives you access to the "analog" tv picture of the av7110 mpeg2
+	  decoder.
+	  
+	- v4l2-common: common functions for Video4Linux-2 drivers
+	
+	- v4l1-compat: backward compatiblity layer for Video4Linux-1 legacy
+	  applications
+
+	- dvb-core: DVB core module. This provides you with the
+	  /dev/dvb/adapter entries
+	
+	- saa7146: SAA7146 core driver. This is need to access any SAA7146
+	  based card in your system.
+	
+	- saa7146_vv: SAA7146 video and vbi functions. These are only needed
+	  for full-featured cards.
+
+	- video-buf: capture helper module for the saa7146_vv driver. This
+	  one is responsible to handle capture buffers.
+
+	- dvb-ttpci: The main driver for AV7110 based, full-featued
+	  DVB-S/C/T cards
+
 eof
diff -uNrwB --new-file xx-linux-2.6.3/Documentation/dvb/firmware.txt linux-2.6.3.p/Documentation/dvb/firmware.txt
--- xx-linux-2.6.3/Documentation/dvb/firmware.txt	2004-01-09 09:22:32.000000000 +0100
+++ linux-2.6.3.p/Documentation/dvb/firmware.txt	2004-02-09 18:30:22.000000000 +0100
@@ -20,7 +20,7 @@
 		extracted from the Windows driver (Sc_main.mc).
 - tda1004x: firmware is loaded from path specified in
 		DVB_TDA1004X_FIRMWARE_FILE kernel config
-		variable (default /etc/dvb/tda1004x.bin); the
+		variable (default /usr/lib/hotplug/firmware/tda1004x.bin); the
 		firmware binary must be extracted from the windows
 		driver
 - ttusb-dec: see "ttusb-dec.txt" for details
@@ -76,11 +76,15 @@
 Step c) Getting a usable firmware file for the dvb-ttpci driver/av7110 card.
 
 You can download the firmware files from
-http://www.linuxtv.org/download/dvb/
+http://linuxtv.org/download/dvb/
 
 Please note that in case of the dvb-ttpci driver this is *not* the "Root"
 file you probably know from the 2.4 DVB releases driver.
 
+The ttpci-firmware utility from linuxtv.org CVS can be used to
+convert Dpram and Root files into a usable firmware image.
+See dvb-kerrnel/scripts/ in http://linuxtv.org/cvs/.
+
 > wget http://www.linuxtv.org/download/dvb/dvb-ttpci-01.fw
 gets you the version 01 of the firmware fot the ttpci driver.
 


