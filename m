Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUHYJ2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUHYJ2q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 05:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUHYJ2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 05:28:46 -0400
Received: from [212.209.10.220] ([212.209.10.220]:37341 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S264726AbUHYJOB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 05:14:01 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>
Cc: <Sam@ravnborg.org>
Subject: [2.6 PATCH 6/6] CRIS architecture update
Date: Wed, 25 Aug 2004 11:13:55 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C66818F518@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The scipt and patch below moves the CRIS ethernet, ide and serial drivers
to drivers/ instead of arch/cris/drivers. 

This patch has been requested by a few on the list. Personally I can't see
the point of doing this and would like to keep it as it is. People say
that they will keep my drivers updated if they are in the correct
directory. I am not convinced that this will happen or that it would
make my life easier if it does.

/Mikael

#!/bin/sh

mkdir -p drivers/net/cris/v10/
mkdir -p drivers/ide/cris/v10/
mkdir -p drivers/char/cris/v10/
mv arch/cris/arch-v10/drivers/ethernet.c drivers/net/cris/v10/
mv arch/cris/arch-v10/drivers/ide.c drivers/ide/cris/v10/
mv arch/cris/arch-v10/drivers/serial.* drivers/serial/cris/v10/


diff -Nur ../orig/arch/cris/arch-v10/drivers/Kconfig
./arch/cris/arch-v10/drivers/Kconfig
--- ../orig/arch/cris/arch-v10/drivers/Kconfig	Mon May 24 14:01:22 2004
+++ ./arch/cris/arch-v10/drivers/Kconfig	Wed Aug 25 09:51:04 2004
@@ -1,618 +1,3 @@
-config ETRAX_ETHERNET
-	bool "Ethernet support"
-	depends on ETRAX_ARCH_V10
-	help
-	  This option enables the ETRAX 100LX built-in 10/100Mbit Ethernet
-	  controller.
-
-# this is just so that the user does not have to go into the
-# normal ethernet driver section just to enable ethernetworking
-config NET_ETHERNET
-	bool
-	depends on ETRAX_ETHERNET
-	default y
-
-choice
-	prompt "Network LED behavior"
-	depends on ETRAX_ETHERNET
-	default ETRAX_NETWORK_LED_ON_WHEN_ACTIVITY
-
-config ETRAX_NETWORK_LED_ON_WHEN_LINK
-	bool "LED_on_when_link"
-	help
-	  Selecting LED_on_when_link will light the LED when there is a 
-	  connection and will flash off when there is activity. 
-
-	  Selecting LED_on_when_activity will light the LED only when 
-	  there is activity.
-
-	  This setting will also affect the behaviour of other activity LEDs

-	  e.g. Bluetooth. 
-
-config ETRAX_NETWORK_LED_ON_WHEN_ACTIVITY
-	bool "LED_on_when_activity"
-	help
-	  Selecting LED_on_when_link will light the LED when there is a 
-	  connection and will flash off when there is activity. 
-
-	  Selecting LED_on_when_activity will light the LED only when 
-	  there is activity.
-
-	  This setting will also affect the behaviour of other activity LEDs

-	  e.g. Bluetooth. 
-
-endchoice
-
-config ETRAX_SERIAL
-	bool "Serial-port support"
-	depends on ETRAX_ARCH_V10
-	help
-	  Enables the ETRAX 100 serial driver for ser0 (ttyS0)
-	  You probably want this enabled.
-
-config ETRAX_SERIAL_FAST_TIMER
-	bool "Use fast timers for serial DMA flush (experimental)"
-	depends on ETRAX_SERIAL
-	help
-	  Select this to have the serial DMAs flushed at a higher rate than
-	  normally, possible by using the fast timer API, the timeout is
-	  approx. 4 character times.
-	  If unsure, say N.
-
-config ETRAX_SERIAL_FLUSH_DMA_FAST
-	bool "Fast serial port DMA flush"
-	depends on ETRAX_SERIAL && !ETRAX_SERIAL_FAST_TIMER
-	help
-	  Select this to have the serial DMAs flushed at a higher rate than
-	  normally possible through a fast timer interrupt (currently at
-	  15360 Hz).
-	  If unsure, say N.
-
-config ETRAX_SERIAL_RX_TIMEOUT_TICKS
-	int "Receive flush timeout (ticks) "
-	depends on ETRAX_SERIAL && !ETRAX_SERIAL_FAST_TIMER &&
!ETRAX_SERIAL_FLUSH_DMA_FAST
-	default "5"
-	help
-	  Number of timer ticks between flush of receive fifo (1 tick =
10ms).
-	  Try 0-3 for low latency applications.  Approx 5 for high load
-	  applications (e.g. PPP).  Maybe this should be more adaptive some
-	  day...
-
-config ETRAX_SERIAL_PORT0
-	bool "Serial port 0 enabled"
-	depends on ETRAX_SERIAL
-	help
-	  Enables the ETRAX 100 serial driver for ser0 (ttyS0)
-	  Normally you want this on, unless you use external DMA 1 that uses
-	  the same DMA channels.
-
-choice
-	prompt "Ser0 DMA out assignment"
-	depends on ETRAX_SERIAL_PORT0
-	default ETRAX_SERIAL_PORT0_DMA6_OUT
-
-config CONFIG_ETRAX_SERIAL_PORT0_NO_DMA_OUT
-       bool "No DMA out"
-
-config CONFIG_ETRAX_SERIAL_PORT0_DMA6_OUT
-       bool "DMA 6"
-
-endchoice
-
-choice
-	prompt "Ser0 DMA in assignment"
-	depends on ETRAX_SERIAL_PORT0
-	default ETRAX_SERIAL_PORT0_DMA7_IN
-
-config CONFIG_ETRAX_SERIAL_PORT0_NO_DMA_IN
-       bool "No DMA in"
-
-config CONFIG_ETRAX_SERIAL_PORT0_DMA7_IN
-       bool "DMA 7"
-
-endchoice
-
-choice
-	prompt "Ser0 DTR, RI, DSR and CD assignment"
-	depends on ETRAX_SERIAL_PORT0
-	default ETRAX_SER0_DTR_RI_DSR_CD_ON_NONE
-
-config ETRAX_SER0_DTR_RI_DSR_CD_ON_NONE
-	bool "No_DTR_RI_DSR_CD"
-
-config ETRAX_SER0_DTR_RI_DSR_CD_ON_PA
-	bool "DTR_RI_DSR_CD_on_PA"
-
-config ETRAX_SER0_DTR_RI_DSR_CD_ON_PB
-	bool "DTR_RI_DSR_CD_on_PB"
-	help
-	  Enables the status and control signals DTR, RI, DSR and CD on PB
for
-	  ser0.
-
-config ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	bool "DTR_RI_DSR_CD_mixed_on_PA_and_PB"
-
-endchoice
-
-config ETRAX_SER0_DTR_ON_PA_BIT
-	int "Ser0 DTR on PA bit (-1 = not used)" if
ETRAX_SER0_DTR_RI_DSR_CD_ON_PA || ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT0
-	default "-1" if !ETRAX_SER0_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	default "4" if ETRAX_SER0_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-
-config ETRAX_SER0_RI_ON_PA_BIT
-	int "Ser0 RI  on PA bit (-1 = not used)" if
ETRAX_SER0_DTR_RI_DSR_CD_ON_PA || ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT0
-	default "-1" if !ETRAX_SER0_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	default "5" if ETRAX_SER0_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-
-config ETRAX_SER0_DSR_ON_PA_BIT
-	int "Ser0 DSR on PA bit (-1 = not used)" if
ETRAX_SER0_DTR_RI_DSR_CD_ON_PA || ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT0
-	default "-1" if !ETRAX_SER0_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	default "6" if ETRAX_SER0_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-
-config ETRAX_SER0_CD_ON_PA_BIT
-	int "Ser0 CD  on PA bit (-1 = not used)" if
ETRAX_SER0_DTR_RI_DSR_CD_ON_PA || ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT0
-	default "-1" if !ETRAX_SER0_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	default "7" if ETRAX_SER0_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-
-config ETRAX_SER0_DTR_ON_PB_BIT
-	int "Ser0 DTR on PB bit (-1 = not used)" if
ETRAX_SER0_DTR_RI_DSR_CD_ON_PB || ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT0
-	default "-1" if !ETRAX_SER0_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	default "4" if ETRAX_SER0_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	help
-	  Specify the pin of the PB port to carry the DTR signal for serial
-	  port 0.
-
-config ETRAX_SER0_RI_ON_PB_BIT
-	int "Ser0 RI  on PB bit (-1 = not used)" if
ETRAX_SER0_DTR_RI_DSR_CD_ON_PB || ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT0
-	default "-1" if !ETRAX_SER0_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	default "5" if ETRAX_SER0_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	help
-	  Specify the pin of the PB port to carry the RI signal for serial
-	  port 0.
-
-config ETRAX_SER0_DSR_ON_PB_BIT
-	int "Ser0 DSR on PB bit (-1 = not used)" if
ETRAX_SER0_DTR_RI_DSR_CD_ON_PB || ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT0
-	default "-1" if !ETRAX_SER0_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	default "6" if ETRAX_SER0_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	help
-	  Specify the pin of the PB port to carry the DSR signal for serial
-	  port 0.
-
-config ETRAX_SER0_CD_ON_PB_BIT
-	int "Ser0 CD  on PB bit (-1 = not used)" if
ETRAX_SER0_DTR_RI_DSR_CD_ON_PB || ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT0
-	default "-1" if !ETRAX_SER0_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	default "7" if ETRAX_SER0_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER0_DTR_RI_DSR_CD_MIXED
-	help
-	  Specify the pin of the PB port to carry the CD signal for serial
-	  port 0.
-
-config ETRAX_SERIAL_PORT1
-	bool "Serial port 1 enabled"
-	depends on ETRAX_SERIAL
-	help
-	  Enables the ETRAX 100 serial driver for ser1 (ttyS1).
-
-choice
-	prompt "Ser1 DMA out assignment"
-	depends on ETRAX_SERIAL_PORT1
-	default ETRAX_SERIAL_PORT1_DMA8_OUT
-
-config CONFIG_ETRAX_SERIAL_PORT1_NO_DMA_OUT
-       bool "No DMA out"
-
-config CONFIG_ETRAX_SERIAL_PORT1_DMA8_OUT
-       bool "DMA 8"
-
-endchoice
-
-choice
-	prompt "Ser1 DMA in assignment"
-	depends on ETRAX_SERIAL_PORT1
-	default ETRAX_SERIAL_PORT1_DMA9_IN
-
-config CONFIG_ETRAX_SERIAL_PORT1_NO_DMA_IN
-       bool "No DMA in"
-
-config CONFIG_ETRAX_SERIAL_PORT1_DMA9_IN
-       bool "DMA 9"
-
-endchoice
-
-choice
-	prompt "Ser1 DTR, RI, DSR and CD assignment"
-	depends on ETRAX_SERIAL_PORT1
-	default ETRAX_SER1_DTR_RI_DSR_CD_ON_NONE
-
-config ETRAX_SER1_DTR_RI_DSR_CD_ON_NONE
-	bool "No_DTR_RI_DSR_CD"
-
-config ETRAX_SER1_DTR_RI_DSR_CD_ON_PA
-	bool "DTR_RI_DSR_CD_on_PA"
-
-config ETRAX_SER1_DTR_RI_DSR_CD_ON_PB
-	bool "DTR_RI_DSR_CD_on_PB"
-	help
-	  Enables the status and control signals DTR, RI, DSR and CD on PB
for
-	  ser1.
-
-config ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	bool "DTR_RI_DSR_CD_mixed_on_PA_and_PB"
-
-endchoice
-
-config ETRAX_SER1_DTR_ON_PA_BIT
-	int "Ser1 DTR on PA bit (-1 = not used)" if
ETRAX_SER1_DTR_RI_DSR_CD_ON_PA || ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT1
-	default "-1" if !ETRAX_SER1_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	default "4" if ETRAX_SER1_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-
-config ETRAX_SER1_RI_ON_PA_BIT
-	int "Ser1 RI  on PA bit (-1 = not used)" if
ETRAX_SER1_DTR_RI_DSR_CD_ON_PA || ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT1
-	default "-1" if !ETRAX_SER1_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	default "5" if ETRAX_SER1_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-
-config ETRAX_SER1_DSR_ON_PA_BIT
-	int "Ser1 DSR on PA bit (-1 = not used)" if
ETRAX_SER1_DTR_RI_DSR_CD_ON_PA || ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT1
-	default "-1" if !ETRAX_SER1_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	default "6" if ETRAX_SER1_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-
-config ETRAX_SER1_CD_ON_PA_BIT
-	int "Ser1 CD  on PA bit (-1 = not used)" if
ETRAX_SER1_DTR_RI_DSR_CD_ON_PA || ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT1
-	default "-1" if !ETRAX_SER1_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	default "7" if ETRAX_SER1_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-
-config ETRAX_SER1_DTR_ON_PB_BIT
-	int "Ser1 DTR on PB bit (-1 = not used)" if
ETRAX_SER1_DTR_RI_DSR_CD_ON_PB || ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT1
-	default "-1" if !ETRAX_SER1_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	default "4" if ETRAX_SER1_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	help
-	  Specify the pin of the PB port to carry the DTR signal for serial
-	  port 1.
-
-config ETRAX_SER1_RI_ON_PB_BIT
-	int "Ser1 RI  on PB bit (-1 = not used)" if
ETRAX_SER1_DTR_RI_DSR_CD_ON_PB || ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT1
-	default "-1" if !ETRAX_SER1_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	default "5" if ETRAX_SER1_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	help
-	  Specify the pin of the PB port to carry the RI signal for serial
-	  port 1.
-
-config ETRAX_SER1_DSR_ON_PB_BIT
-	int "Ser1 DSR on PB bit (-1 = not used)" if
ETRAX_SER1_DTR_RI_DSR_CD_ON_PB || ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT1
-	default "-1" if !ETRAX_SER1_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	default "6" if ETRAX_SER1_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	help
-	  Specify the pin of the PB port to carry the DSR signal for serial
-	  port 1.
-
-config ETRAX_SER1_CD_ON_PB_BIT
-	int "Ser1 CD  on PB bit (-1 = not used)" if
ETRAX_SER1_DTR_RI_DSR_CD_ON_PB || ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT1
-	default "-1" if !ETRAX_SER1_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	default "7" if ETRAX_SER1_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER1_DTR_RI_DSR_CD_MIXED
-	help
-	  Specify the pin of the PB port to carry the CD signal for serial
-	  port 1.
-
-comment "Make sure you dont have the same PB bits more than once!"
-	depends on ETRAX_SERIAL && ETRAX_SER0_DTR_RI_DSR_CD_ON_PB &&
ETRAX_SER1_DTR_RI_DSR_CD_ON_PB
-
-config ETRAX_SERIAL_PORT2
-	bool "Serial port 2 enabled"
-	depends on ETRAX_SERIAL
-	help
-	  Enables the ETRAX 100 serial driver for ser2 (ttyS2).
-
-choice
-	prompt "Ser2 DMA out assignment"
-	depends on ETRAX_SERIAL_PORT2
-	default ETRAX_SERIAL_PORT2_DMA2_OUT
-
-config CONFIG_ETRAX_SERIAL_PORT2_NO_DMA_OUT
-       bool "No DMA out"
-
-config CONFIG_ETRAX_SERIAL_PORT2_DMA2_OUT
-       bool "DMA 2"
-
-endchoice
-
-choice
-	prompt "Ser2 DMA in assignment"
-	depends on ETRAX_SERIAL_PORT2
-	default ETRAX_SERIAL_PORT2_DMA3_IN
-
-config CONFIG_ETRAX_SERIAL_PORT2_NO_DMA_IN
-       bool "No DMA in"
-
-config CONFIG_ETRAX_SERIAL_PORT2_DMA3_IN
-       bool "DMA 3"
-
-endchoice
-
-choice
-	prompt "Ser2 DTR, RI, DSR and CD assignment"
-	depends on ETRAX_SERIAL_PORT2
-	default ETRAX_SER2_DTR_RI_DSR_CD_ON_NONE
-
-config ETRAX_SER2_DTR_RI_DSR_CD_ON_NONE
-	bool "No_DTR_RI_DSR_CD"
-
-config ETRAX_SER2_DTR_RI_DSR_CD_ON_PA
-	bool "DTR_RI_DSR_CD_on_PA"
-	help
-	  Enables the status and control signals DTR, RI, DSR and CD on PA
for
-	  ser2.
-
-config ETRAX_SER2_DTR_RI_DSR_CD_ON_PB
-	bool "DTR_RI_DSR_CD_on_PB"
-
-config ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	bool "DTR_RI_DSR_CD_mixed_on_PA_and_PB"
-
-endchoice
-
-config ETRAX_SER2_DTR_ON_PA_BIT
-	int "Ser2 DTR on PA bit (-1 = not used)" if
ETRAX_SER2_DTR_RI_DSR_CD_ON_PA || ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT2
-	default "-1" if !ETRAX_SER2_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	default "4" if ETRAX_SER2_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	help
-	  Specify the pin of the PA port to carry the DTR signal for serial
-	  port 2.
-
-config ETRAX_SER2_RI_ON_PA_BIT
-	int "Ser2 RI  on PA bit (-1 = not used)" if
ETRAX_SER2_DTR_RI_DSR_CD_ON_PA || ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT2
-	default "-1" if !ETRAX_SER2_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	default "5" if ETRAX_SER2_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	help
-	  Specify the pin of the PA port to carry the RI signal for serial
-	  port 2.
-
-config ETRAX_SER2_DSR_ON_PA_BIT
-	int "Ser2 DSR on PA bit (-1 = not used)" if
ETRAX_SER2_DTR_RI_DSR_CD_ON_PA || ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT2
-	default "-1" if !ETRAX_SER2_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	default "6" if ETRAX_SER2_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	help
-	  Specify the pin of the PA port to carry the DTR signal for serial
-	  port 2.
-
-config ETRAX_SER2_CD_ON_PA_BIT
-	int "Ser2 CD  on PA bit (-1 = not used)" if
ETRAX_SER2_DTR_RI_DSR_CD_ON_PA || ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT2
-	default "-1" if !ETRAX_SER2_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	default "7" if ETRAX_SER2_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	help
-	  Specify the pin of the PA port to carry the CD signal for serial
-	  port 2.
-
-config ETRAX_SER2_DTR_ON_PB_BIT
-	int "Ser2 DTR on PB bit (-1 = not used)" if
ETRAX_SER2_DTR_RI_DSR_CD_ON_PB || ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT2
-	default "-1" if !ETRAX_SER2_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	default "4" if ETRAX_SER2_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-
-config ETRAX_SER2_RI_ON_PB_BIT
-	int "Ser2 RI  on PB bit (-1 = not used)" if
ETRAX_SER2_DTR_RI_DSR_CD_ON_PB || ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT2
-	default "-1" if !ETRAX_SER2_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	default "5" if ETRAX_SER2_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-
-config ETRAX_SER2_DSR_ON_PB_BIT
-	int "Ser2 DSR on PB bit (-1 = not used)" if
ETRAX_SER2_DTR_RI_DSR_CD_ON_PB || ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT2
-	default "-1" if !ETRAX_SER2_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	default "6" if ETRAX_SER2_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-
-config ETRAX_SER2_CD_ON_PB_BIT
-	int "Ser2 CD  on PB bit (-1 = not used)" if
ETRAX_SER2_DTR_RI_DSR_CD_ON_PB || ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT2
-	default "-1" if !ETRAX_SER2_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-	default "7" if ETRAX_SER2_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER2_DTR_RI_DSR_CD_MIXED
-
-config ETRAX_SERIAL_PORT3
-	bool "Serial port 3 enabled"
-	depends on ETRAX_SERIAL
-	help
-	  Enables the ETRAX 100 serial driver for ser3 (ttyS3).
-
-choice
-	prompt "Ser3 DMA out assignment"
-	depends on ETRAX_SERIAL_PORT3
-	default ETRAX_SERIAL_PORT3_DMA4_OUT
-
-config CONFIG_ETRAX_SERIAL_PORT3_NO_DMA_OUT
-       bool "No DMA out"
-
-config CONFIG_ETRAX_SERIAL_PORT3_DMA4_OUT
-       bool "DMA 4"
-
-endchoice
-
-choice
-	prompt "Ser3 DMA in assignment"
-	depends on ETRAX_SERIAL_PORT3
-	default ETRAX_SERIAL_PORT3_DMA5_IN
-
-config CONFIG_ETRAX_SERIAL_PORT3_NO_DMA_IN
-       bool "No DMA in"
-
-config CONFIG_ETRAX_SERIAL_PORT3_DMA5_IN
-       bool "DMA 5"
-
-endchoice
-
-choice
-	prompt "Ser3 DTR, RI, DSR and CD assignment"
-	depends on ETRAX_SERIAL_PORT3
-	default ETRAX_SER3_DTR_RI_DSR_CD_ON_NONE
-
-config ETRAX_SER3_DTR_RI_DSR_CD_ON_NONE
-	bool "No_DTR_RI_DSR_CD"
-
-config ETRAX_SER3_DTR_RI_DSR_CD_ON_PA
-	bool "DTR_RI_DSR_CD_on_PA"
-
-config ETRAX_SER3_DTR_RI_DSR_CD_ON_PB
-	bool "DTR_RI_DSR_CD_on_PB"
-
-config ETRAX_SER3_DTR_RI_DSR_CD_MIXED
-	bool "DTR_RI_DSR_CD_mixed_on_PA_and_PB"
-
-endchoice
-
-config ETRAX_SER3_DTR_ON_PA_BIT
-	int "Ser3 DTR on PA bit (-1 = not used)" if
ETRAX_SER3_DTR_RI_DSR_CD_ON_PA || ETRAX_SER3_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT3
-	default "-1"
-
-config ETRAX_SER3_RI_ON_PA_BIT
-	int "Ser3 RI  on PA bit (-1 = not used)" if
ETRAX_SER3_DTR_RI_DSR_CD_ON_PA || ETRAX_SER3_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT3
-	default "-1"
-
-config ETRAX_SER3_DSR_ON_PA_BIT
-	int "Ser3 DSR on PA bit (-1 = not used)" if
ETRAX_SER3_DTR_RI_DSR_CD_ON_PA || ETRAX_SER3_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT3
-	default "-1"
-
-config ETRAX_SER3_CD_ON_PA_BIT
-	int "Ser3 CD  on PA bit (-1 = not used)" if
ETRAX_SER3_DTR_RI_DSR_CD_ON_PA || ETRAX_SER3_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT3
-	default "-1"
-
-config ETRAX_SER3_DTR_ON_PB_BIT
-	int "Ser3 DTR on PB bit (-1 = not used)" if
ETRAX_SER3_DTR_RI_DSR_CD_ON_PB || ETRAX_SER3_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT3
-	default "-1"
-
-config ETRAX_SER3_RI_ON_PB_BIT
-	int "Ser3 RI  on PB bit (-1 = not used)" if
ETRAX_SER3_DTR_RI_DSR_CD_ON_PB || ETRAX_SER3_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT3
-	default "-1"
-
-config ETRAX_SER3_DSR_ON_PB_BIT
-	int "Ser3 DSR on PB bit (-1 = not used)" if
ETRAX_SER3_DTR_RI_DSR_CD_ON_PB || ETRAX_SER3_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT3
-	default "-1"
-
-config ETRAX_SER3_CD_ON_PB_BIT
-	int "Ser3 CD  on PB bit (-1 = not used)" if
ETRAX_SER3_DTR_RI_DSR_CD_ON_PB || ETRAX_SER3_DTR_RI_DSR_CD_MIXED
-	depends on ETRAX_SERIAL_PORT3
-	default "-1"
-
-config ETRAX_RS485
-	bool "RS-485 support"
-	depends on ETRAX_SERIAL
-	help
-	  Enables support for RS-485 serial communication.  For a primer on
-	  RS-485, see <http://www.hw.cz/english/docs/rs485/rs485.html>.
-
-config ETRAX_RS485_ON_PA
-	bool "RS-485 mode on PA"
-	depends on ETRAX_RS485
-	help
-	  Control Driver Output Enable on RS485 transceiver using a pin on
PA
-	  port:
-	  Axis 2400/2401 uses PA 3.
-
-config ETRAX_RS485_ON_PA_BIT
-	int "RS-485 mode on PA bit"
-	depends on ETRAX_RS485_ON_PA
-	default "3"
-	help
-	  Control Driver Output Enable on RS485 transceiver using a this bit
-	  on PA port.
-
-config ETRAX_RS485_DISABLE_RECEIVER
-	bool "Disable serial receiver"
-	depends on ETRAX_RS485
-	help
-	  It's necessary to disable the serial receiver to avoid serial
-	  loopback.  Not all products are able to do this in software only.
-	  Axis 2400/2401 must disable receiver.
-
-config ETRAX_IDE
-	bool "ATA/IDE support"
-	help 
-	  Enable this to get support for ATA/IDE.
-	  You can't use parallell ports or SCSI ports
-	  at the same time.
-
-# here we should add the CONFIG_'s necessary to enable the basic
-# general ide drivers so the common case does not need to go
-# into that config submenu. enable disk and CD support. others
-# need to go fiddle in the submenu..
-config IDE
-	tristate
-	depends on ETRAX_IDE
-	default y
-
-config BLK_DEV_IDE
-	tristate
-	depends on ETRAX_IDE
-	default y
-
-config BLK_DEV_IDEDISK
-	tristate
-	depends on ETRAX_IDE
-	default y
-
-config BLK_DEV_IDECD
-	tristate
-	depends on ETRAX_IDE
-	default y
-
-config BLK_DEV_IDEDMA
-	bool
-	depends on ETRAX_IDE
-	default y
-
-config DMA_NONPCI
-	bool
-	depends on ETRAX_IDE
-	default y
-
-config ETRAX_IDE_DELAY
-	int "Delay for drives to regain consciousness"
-	depends on ETRAX_IDE
-	default 15
-	help
-	  Number of seconds to wait for IDE drives to spin up after an IDE
-	  reset.
-choice
-	prompt "IDE reset pin"
-	depends on ETRAX_IDE
-	default ETRAX_IDE_PB7_RESET
-
-config ETRAX_IDE_PB7_RESET
-	bool "Port_PB_Bit_7"
-	help
-	  IDE reset on pin 7 on port B
-	
-config ETRAX_IDE_G27_RESET
-        bool "Port_G_Bit_27"
-	help
-	  IDE reset on pin 27 on port G
-
-endchoice
-	  
-
 config ETRAX_USB_HOST
 	bool "USB host"
 	help
diff -Nur ../orig/arch/cris/arch-v10/drivers/Makefile
./arch/cris/arch-v10/drivers/Makefile
--- ../orig/arch/cris/arch-v10/drivers/Makefile	Thu Jan 22 09:24:12 2004
+++ ./arch/cris/arch-v10/drivers/Makefile	Wed Aug 25 09:50:41 2004
@@ -2,15 +2,12 @@
 # Makefile for Etrax-specific drivers
 #
 
-obj-$(CONFIG_ETRAX_ETHERNET)            += ethernet.o
-obj-$(CONFIG_ETRAX_SERIAL)              += serial.o
 obj-$(CONFIG_ETRAX_AXISFLASHMAP)        += axisflashmap.o
 obj-$(CONFIG_ETRAX_I2C) 	        += i2c.o
 obj-$(CONFIG_ETRAX_I2C_EEPROM)          += eeprom.o
 obj-$(CONFIG_ETRAX_GPIO) 	        += gpio.o
 obj-$(CONFIG_ETRAX_DS1302)              += ds1302.o
 obj-$(CONFIG_ETRAX_PCF8563)		+= pcf8563.o
-obj-$(CONFIG_ETRAX_IDE)                 += ide.o
 obj-$(CONFIG_ETRAX_USB_HOST)            += usb-host.o
 
 
diff -Nur ../orig/drivers/ide/Kconfig ./drivers/ide/Kconfig
--- ../orig/drivers/ide/Kconfig	Mon Aug 16 10:14:37 2004
+++ ./drivers/ide/Kconfig	Wed Aug 25 09:51:46 2004
@@ -1037,6 +1037,8 @@
 
 endif
 
+source "drivers/ide/cris/Kconfig"
+
 config BLK_DEV_IDEDMA
 	def_bool BLK_DEV_IDEDMA_PCI || BLK_DEV_IDEDMA_PMAC ||
BLK_DEV_IDEDMA_ICS
 
diff -Nur ../orig/drivers/ide/Makefile ./drivers/ide/Makefile
--- ../orig/drivers/ide/Makefile	Mon Aug 16 14:38:33 2004
+++ ./drivers/ide/Makefile	Wed Aug 25 09:51:38 2004
@@ -52,3 +52,5 @@
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= legacy/ arm/
 obj-$(CONFIG_BLK_DEV_HD)		+= legacy/
+
+obj-$(CONFIG_CRIS)			+= cris/
diff -Nur ../orig/drivers/ide/cris/Kconfig ./drivers/ide/cris/Kconfig
--- ../orig/drivers/ide/cris/Kconfig	Thu Jan  1 01:00:00 1970
+++ ./drivers/ide/cris/Kconfig	Wed Aug 25 09:51:53 2004
@@ -0,0 +1,64 @@
+config ETRAX_IDE
+	bool "CRIS support"
+	help 
+	  Enable this to get support for ATA/IDE.
+	  You can't use parallell ports or SCSI ports
+	  at the same time.
+
+# here we should add the CONFIG_'s necessary to enable the basic
+# general ide drivers so the common case does not need to go
+# into that config submenu. enable disk and CD support. others
+# need to go fiddle in the submenu..
+config IDE
+	tristate
+	depends on ETRAX_IDE
+	default y
+
+config BLK_DEV_IDE
+	tristate
+	depends on ETRAX_IDE
+	default y
+
+config BLK_DEV_IDEDISK
+	tristate
+	depends on ETRAX_IDE
+	default y
+
+config BLK_DEV_IDECD
+	tristate
+	depends on ETRAX_IDE
+	default y
+
+config BLK_DEV_IDEDMA
+	bool
+	depends on ETRAX_IDE
+	default y
+
+config DMA_NONPCI
+	bool
+	depends on ETRAX_IDE
+	default y
+
+config ETRAX_IDE_DELAY
+	int "Delay for drives to regain consciousness"
+	depends on ETRAX_IDE
+	default 15
+	help
+	  Number of seconds to wait for IDE drives to spin up after an IDE
+	  reset.
+choice
+	prompt "IDE reset pin"
+	depends on ETRAX_IDE
+	default ETRAX_IDE_PB7_RESET
+
+config ETRAX_IDE_PB7_RESET
+	bool "Port_PB_Bit_7"
+	help
+	  IDE reset on pin 7 on port B
+	
+config ETRAX_IDE_G27_RESET
+        bool "Port_G_Bit_27"
+	help
+	  IDE reset on pin 27 on port G
+
+endchoice
diff -Nur ../orig/drivers/ide/cris/Makefile ./drivers/ide/cris/Makefile
--- ../orig/drivers/ide/cris/Makefile	Thu Jan  1 01:00:00 1970
+++ ./drivers/ide/cris/Makefile	Wed Aug 25 09:51:53 2004
@@ -0,0 +1,8 @@
+#
+# Makefile for the CRIS IDE controllers
+#
+
+obj-$(CONFIG_ETRAX_IDE) += ide.o
+
+ide-objs := v10/ide.o
+
diff -Nur ../orig/drivers/net/Kconfig ./drivers/net/Kconfig
--- ../orig/drivers/net/Kconfig	Mon Aug 16 10:14:31 2004
+++ ./drivers/net/Kconfig	Wed Aug 25 09:53:47 2004
@@ -1878,6 +1878,8 @@
 
 source "drivers/net/fec_8xx/Kconfig"
 
+source "drivers/net/cris/Kconfig"
+
 endmenu
 
 #
diff -Nur ../orig/drivers/net/Makefile ./drivers/net/Makefile
--- ../orig/drivers/net/Makefile	Mon Aug 16 14:38:57 2004
+++ ./drivers/net/Makefile	Wed Aug 25 09:52:58 2004
@@ -179,6 +179,7 @@
 obj-$(CONFIG_FEC_8XX) += fec_8xx/
 
 obj-$(CONFIG_ARM) += arm/
+obj-$(CONFIG_CRIS) += cris/
 obj-$(CONFIG_NET_FC) += fc/
 obj-$(CONFIG_DEV_APPLETALK) += appletalk/
 obj-$(CONFIG_TR) += tokenring/
diff -Nur ../orig/drivers/net/cris/Kconfig ./drivers/net/cris/Kconfig
--- ../orig/drivers/net/cris/Kconfig	Thu Jan  1 01:00:00 1970
+++ ./drivers/net/cris/Kconfig	Wed Aug 25 09:54:07 2004
@@ -0,0 +1,43 @@
+config ETRAX_ETHERNET
+	bool "CRIS Ethernet support"
+	help
+	  This option enables the ETRAX 100LX built-in 10/100Mbit Ethernet
+	  controller.
+
+# this is just so that the user does not have to go into the
+# normal ethernet driver section just to enable ethernetworking
+config NET_ETHERNET
+	bool
+	depends on ETRAX_ETHERNET
+	default y
+
+choice
+	prompt "Network LED behavior"
+	depends on ETRAX_ETHERNET
+	default ETRAX_NETWORK_LED_ON_WHEN_ACTIVITY
+
+config ETRAX_NETWORK_LED_ON_WHEN_LINK
+	bool "LED_on_when_link"
+	help
+	  Selecting LED_on_when_link will light the LED when there is a 
+	  connection and will flash off when there is activity. 
+
+	  Selecting LED_on_when_activity will light the LED only when 
+	  there is activity.
+
+	  This setting will also affect the behaviour of other activity LEDs

+	  e.g. Bluetooth. 
+
+config ETRAX_NETWORK_LED_ON_WHEN_ACTIVITY
+	bool "LED_on_when_activity"
+	help
+	  Selecting LED_on_when_link will light the LED when there is a 
+	  connection and will flash off when there is activity. 
+
+	  Selecting LED_on_when_activity will light the LED only when 
+	  there is activity.
+
+	  This setting will also affect the behaviour of other activity LEDs

+	  e.g. Bluetooth. 
+
+endchoice
diff -Nur ../orig/drivers/net/cris/Makefile ./drivers/net/cris/Makefile
--- ../orig/drivers/net/cris/Makefile	Thu Jan  1 01:00:00 1970
+++ ./drivers/net/cris/Makefile	Wed Aug 25 09:54:07 2004
@@ -0,0 +1,6 @@
+#
+# Makefile for the CRIS Ethernet controllers
+#
+
+obj-$(CONFIG_ETRAX_ETHERNET) += eth.o
+eth-objs = v10/ethernet.o
diff -Nur ../orig/drivers/serial/Kconfig ./drivers/serial/Kconfig
--- ../orig/drivers/serial/Kconfig	Mon Aug 16 10:14:33 2004
+++ ./drivers/serial/Kconfig	Wed Aug 25 09:52:26 2004
@@ -714,4 +714,6 @@
 	  This value is only used if the bootloader doesn't pass in the
 	  console baudrate
 
+source "drivers/serial/cris/Kconfig"
+
 endmenu
diff -Nur ../orig/drivers/serial/Makefile ./drivers/serial/Makefile
--- ../orig/drivers/serial/Makefile	Mon Aug 16 10:14:33 2004
+++ ./drivers/serial/Makefile	Wed Aug 25 09:52:13 2004
@@ -41,3 +41,4 @@
 obj-$(CONFIG_SERIAL_SGI_L1_CONSOLE) += sn_console.o
 obj-$(CONFIG_SERIAL_CPM) += cpm_uart/
 obj-$(CONFIG_SERIAL_MPC52xx) += mpc52xx_uart.o
+obj-$(CONFIG_CRIS) += cris/
diff -Nur ../orig/drivers/serial/cris/Kconfig ./drivers/serial/cris/Kconfig
--- ../orig/drivers/serial/cris/Kconfig	Thu Jan  1 01:00:00 1970
+++ ./drivers/serial/cris/Kconfig	Wed Aug 25 09:52:37 2004
@@ -0,0 +1,504 @@
+config ETRAX_SERIAL
+	bool "CRIS Serial-port support"
+	help
+	  Enables the ETRAX 100 serial driver for ser0 (ttyS0)
+	  You probably want this enabled.
+
+config ETRAX_SERIAL_FAST_TIMER
+	bool "Use fast timers for serial DMA flush (experimental)"
+	depends on ETRAX_SERIAL
+	help
+	  Select this to have the serial DMAs flushed at a higher rate than
+	  normally, possible by using the fast timer API, the timeout is
+	  approx. 4 character times.
+	  If unsure, say N.
+
+config ETRAX_SERIAL_FLUSH_DMA_FAST
+	bool "Fast serial port DMA flush"
+	depends on ETRAX_SERIAL && !ETRAX_SERIAL_FAST_TIMER
+	help
+	  Select this to have the serial DMAs flushed at a higher rate than
+	  normally possible through a fast timer interrupt (currently at
+	  15360 Hz).
+	  If unsure, say N.
+
+config ETRAX_SERIAL_RX_TIMEOUT_TICKS
+	int "Receive flush timeout (ticks) "
+	depends on ETRAX_SERIAL && !ETRAX_SERIAL_FAST_TIMER &&
!ETRAX_SERIAL_FLUSH_DMA_FAST
+	default "5"
+	help
+	  Number of timer ticks between flush of receive fifo (1 tick =
10ms).
+	  Try 0-3 for low latency applications.  Approx 5 for high load
+	  applications (e.g. PPP).  Maybe this should be more adaptive some
+	  day...
+
+config ETRAX_SERIAL_PORT0
+	bool "Serial port 0 enabled"
+	depends on ETRAX_SERIAL
+	help
+	  Enables the ETRAX 100 serial driver for ser0 (ttyS0)
+	  Normally you want this on, unless you use external DMA 1 that uses
+	  the same DMA channels.
+
+choice
+	prompt "Ser0 DMA out assignment"
+	depends on ETRAX_SERIAL_PORT0
+	default ETRAX_SERIAL_PORT0_DMA6_OUT
+
+config CONFIG_ETRAX_SERIAL_PORT0_NO_DMA_OUT
+       bool "No DMA out"
+
+config CONFIG_ETRAX_SERIAL_PORT0_DMA6_OUT
+       bool "DMA 6"
+
+endchoice
+
+choice
+	prompt "Ser0 DMA in assignment"
+	depends on ETRAX_SERIAL_PORT0
+	default ETRAX_SERIAL_PORT0_DMA7_IN
+
+config CONFIG_ETRAX_SERIAL_PORT0_NO_DMA_IN
+       bool "No DMA in"
+
+config CONFIG_ETRAX_SERIAL_PORT0_DMA7_IN
+       bool "DMA 7"
+
+endchoice
+
+choice
+	prompt "Ser0 DTR, RI, DSR and CD assignment"
+	depends on ETRAX_SERIAL_PORT0
+	default ETRAX_SER0_DTR_RI_DSR_CD_ON_NONE
+
+config ETRAX_SER0_DTR_RI_DSR_CD_ON_NONE
+	bool "No_DTR_RI_DSR_CD"
+
+config ETRAX_SER0_DTR_RI_DSR_CD_ON_PA
+	bool "DTR_RI_DSR_CD_on_PA"
+
+config ETRAX_SER0_DTR_RI_DSR_CD_ON_PB
+	bool "DTR_RI_DSR_CD_on_PB"
+	help
+	  Enables the status and control signals DTR, RI, DSR and CD on PB
for
+	  ser0.
+
+config ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	bool "DTR_RI_DSR_CD_mixed_on_PA_and_PB"
+
+endchoice
+
+config ETRAX_SER0_DTR_ON_PA_BIT
+	int "Ser0 DTR on PA bit (-1 = not used)" if
ETRAX_SER0_DTR_RI_DSR_CD_ON_PA || ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT0
+	default "-1" if !ETRAX_SER0_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	default "4" if ETRAX_SER0_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+
+config ETRAX_SER0_RI_ON_PA_BIT
+	int "Ser0 RI  on PA bit (-1 = not used)" if
ETRAX_SER0_DTR_RI_DSR_CD_ON_PA || ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT0
+	default "-1" if !ETRAX_SER0_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	default "5" if ETRAX_SER0_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+
+config ETRAX_SER0_DSR_ON_PA_BIT
+	int "Ser0 DSR on PA bit (-1 = not used)" if
ETRAX_SER0_DTR_RI_DSR_CD_ON_PA || ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT0
+	default "-1" if !ETRAX_SER0_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	default "6" if ETRAX_SER0_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+
+config ETRAX_SER0_CD_ON_PA_BIT
+	int "Ser0 CD  on PA bit (-1 = not used)" if
ETRAX_SER0_DTR_RI_DSR_CD_ON_PA || ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT0
+	default "-1" if !ETRAX_SER0_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	default "7" if ETRAX_SER0_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+
+config ETRAX_SER0_DTR_ON_PB_BIT
+	int "Ser0 DTR on PB bit (-1 = not used)" if
ETRAX_SER0_DTR_RI_DSR_CD_ON_PB || ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT0
+	default "-1" if !ETRAX_SER0_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	default "4" if ETRAX_SER0_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	help
+	  Specify the pin of the PB port to carry the DTR signal for serial
+	  port 0.
+
+config ETRAX_SER0_RI_ON_PB_BIT
+	int "Ser0 RI  on PB bit (-1 = not used)" if
ETRAX_SER0_DTR_RI_DSR_CD_ON_PB || ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT0
+	default "-1" if !ETRAX_SER0_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	default "5" if ETRAX_SER0_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	help
+	  Specify the pin of the PB port to carry the RI signal for serial
+	  port 0.
+
+config ETRAX_SER0_DSR_ON_PB_BIT
+	int "Ser0 DSR on PB bit (-1 = not used)" if
ETRAX_SER0_DTR_RI_DSR_CD_ON_PB || ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT0
+	default "-1" if !ETRAX_SER0_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	default "6" if ETRAX_SER0_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	help
+	  Specify the pin of the PB port to carry the DSR signal for serial
+	  port 0.
+
+config ETRAX_SER0_CD_ON_PB_BIT
+	int "Ser0 CD  on PB bit (-1 = not used)" if
ETRAX_SER0_DTR_RI_DSR_CD_ON_PB || ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT0
+	default "-1" if !ETRAX_SER0_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	default "7" if ETRAX_SER0_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER0_DTR_RI_DSR_CD_MIXED
+	help
+	  Specify the pin of the PB port to carry the CD signal for serial
+	  port 0.
+
+config ETRAX_SERIAL_PORT1
+	bool "Serial port 1 enabled"
+	depends on ETRAX_SERIAL
+	help
+	  Enables the ETRAX 100 serial driver for ser1 (ttyS1).
+
+choice
+	prompt "Ser1 DMA out assignment"
+	depends on ETRAX_SERIAL_PORT1
+	default ETRAX_SERIAL_PORT1_DMA8_OUT
+
+config CONFIG_ETRAX_SERIAL_PORT1_NO_DMA_OUT
+       bool "No DMA out"
+
+config CONFIG_ETRAX_SERIAL_PORT1_DMA8_OUT
+       bool "DMA 8"
+
+endchoice
+
+choice
+	prompt "Ser1 DMA in assignment"
+	depends on ETRAX_SERIAL_PORT1
+	default ETRAX_SERIAL_PORT1_DMA9_IN
+
+config CONFIG_ETRAX_SERIAL_PORT1_NO_DMA_IN
+       bool "No DMA in"
+
+config CONFIG_ETRAX_SERIAL_PORT1_DMA9_IN
+       bool "DMA 9"
+
+endchoice
+
+choice
+	prompt "Ser1 DTR, RI, DSR and CD assignment"
+	depends on ETRAX_SERIAL_PORT1
+	default ETRAX_SER1_DTR_RI_DSR_CD_ON_NONE
+
+config ETRAX_SER1_DTR_RI_DSR_CD_ON_NONE
+	bool "No_DTR_RI_DSR_CD"
+
+config ETRAX_SER1_DTR_RI_DSR_CD_ON_PA
+	bool "DTR_RI_DSR_CD_on_PA"
+
+config ETRAX_SER1_DTR_RI_DSR_CD_ON_PB
+	bool "DTR_RI_DSR_CD_on_PB"
+	help
+	  Enables the status and control signals DTR, RI, DSR and CD on PB
for
+	  ser1.
+
+config ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	bool "DTR_RI_DSR_CD_mixed_on_PA_and_PB"
+
+endchoice
+
+config ETRAX_SER1_DTR_ON_PA_BIT
+	int "Ser1 DTR on PA bit (-1 = not used)" if
ETRAX_SER1_DTR_RI_DSR_CD_ON_PA || ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT1
+	default "-1" if !ETRAX_SER1_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	default "4" if ETRAX_SER1_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+
+config ETRAX_SER1_RI_ON_PA_BIT
+	int "Ser1 RI  on PA bit (-1 = not used)" if
ETRAX_SER1_DTR_RI_DSR_CD_ON_PA || ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT1
+	default "-1" if !ETRAX_SER1_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	default "5" if ETRAX_SER1_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+
+config ETRAX_SER1_DSR_ON_PA_BIT
+	int "Ser1 DSR on PA bit (-1 = not used)" if
ETRAX_SER1_DTR_RI_DSR_CD_ON_PA || ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT1
+	default "-1" if !ETRAX_SER1_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	default "6" if ETRAX_SER1_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+
+config ETRAX_SER1_CD_ON_PA_BIT
+	int "Ser1 CD  on PA bit (-1 = not used)" if
ETRAX_SER1_DTR_RI_DSR_CD_ON_PA || ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT1
+	default "-1" if !ETRAX_SER1_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	default "7" if ETRAX_SER1_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+
+config ETRAX_SER1_DTR_ON_PB_BIT
+	int "Ser1 DTR on PB bit (-1 = not used)" if
ETRAX_SER1_DTR_RI_DSR_CD_ON_PB || ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT1
+	default "-1" if !ETRAX_SER1_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	default "4" if ETRAX_SER1_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	help
+	  Specify the pin of the PB port to carry the DTR signal for serial
+	  port 1.
+
+config ETRAX_SER1_RI_ON_PB_BIT
+	int "Ser1 RI  on PB bit (-1 = not used)" if
ETRAX_SER1_DTR_RI_DSR_CD_ON_PB || ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT1
+	default "-1" if !ETRAX_SER1_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	default "5" if ETRAX_SER1_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	help
+	  Specify the pin of the PB port to carry the RI signal for serial
+	  port 1.
+
+config ETRAX_SER1_DSR_ON_PB_BIT
+	int "Ser1 DSR on PB bit (-1 = not used)" if
ETRAX_SER1_DTR_RI_DSR_CD_ON_PB || ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT1
+	default "-1" if !ETRAX_SER1_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	default "6" if ETRAX_SER1_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	help
+	  Specify the pin of the PB port to carry the DSR signal for serial
+	  port 1.
+
+config ETRAX_SER1_CD_ON_PB_BIT
+	int "Ser1 CD  on PB bit (-1 = not used)" if
ETRAX_SER1_DTR_RI_DSR_CD_ON_PB || ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT1
+	default "-1" if !ETRAX_SER1_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	default "7" if ETRAX_SER1_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER1_DTR_RI_DSR_CD_MIXED
+	help
+	  Specify the pin of the PB port to carry the CD signal for serial
+	  port 1.
+
+comment "Make sure you dont have the same PB bits more than once!"
+	depends on ETRAX_SERIAL && ETRAX_SER0_DTR_RI_DSR_CD_ON_PB &&
ETRAX_SER1_DTR_RI_DSR_CD_ON_PB
+
+config ETRAX_SERIAL_PORT2
+	bool "Serial port 2 enabled"
+	depends on ETRAX_SERIAL
+	help
+	  Enables the ETRAX 100 serial driver for ser2 (ttyS2).
+
+choice
+	prompt "Ser2 DMA out assignment"
+	depends on ETRAX_SERIAL_PORT2
+	default ETRAX_SERIAL_PORT2_DMA2_OUT
+
+config CONFIG_ETRAX_SERIAL_PORT2_NO_DMA_OUT
+       bool "No DMA out"
+
+config CONFIG_ETRAX_SERIAL_PORT2_DMA2_OUT
+       bool "DMA 2"
+
+endchoice
+
+choice
+	prompt "Ser2 DMA in assignment"
+	depends on ETRAX_SERIAL_PORT2
+	default ETRAX_SERIAL_PORT2_DMA3_IN
+
+config CONFIG_ETRAX_SERIAL_PORT2_NO_DMA_IN
+       bool "No DMA in"
+
+config CONFIG_ETRAX_SERIAL_PORT2_DMA3_IN
+       bool "DMA 3"
+
+endchoice
+
+choice
+	prompt "Ser2 DTR, RI, DSR and CD assignment"
+	depends on ETRAX_SERIAL_PORT2
+	default ETRAX_SER2_DTR_RI_DSR_CD_ON_NONE
+
+config ETRAX_SER2_DTR_RI_DSR_CD_ON_NONE
+	bool "No_DTR_RI_DSR_CD"
+
+config ETRAX_SER2_DTR_RI_DSR_CD_ON_PA
+	bool "DTR_RI_DSR_CD_on_PA"
+	help
+	  Enables the status and control signals DTR, RI, DSR and CD on PA
for
+	  ser2.
+
+config ETRAX_SER2_DTR_RI_DSR_CD_ON_PB
+	bool "DTR_RI_DSR_CD_on_PB"
+
+config ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	bool "DTR_RI_DSR_CD_mixed_on_PA_and_PB"
+
+endchoice
+
+config ETRAX_SER2_DTR_ON_PA_BIT
+	int "Ser2 DTR on PA bit (-1 = not used)" if
ETRAX_SER2_DTR_RI_DSR_CD_ON_PA || ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT2
+	default "-1" if !ETRAX_SER2_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	default "4" if ETRAX_SER2_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	help
+	  Specify the pin of the PA port to carry the DTR signal for serial
+	  port 2.
+
+config ETRAX_SER2_RI_ON_PA_BIT
+	int "Ser2 RI  on PA bit (-1 = not used)" if
ETRAX_SER2_DTR_RI_DSR_CD_ON_PA || ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT2
+	default "-1" if !ETRAX_SER2_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	default "5" if ETRAX_SER2_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	help
+	  Specify the pin of the PA port to carry the RI signal for serial
+	  port 2.
+
+config ETRAX_SER2_DSR_ON_PA_BIT
+	int "Ser2 DSR on PA bit (-1 = not used)" if
ETRAX_SER2_DTR_RI_DSR_CD_ON_PA || ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT2
+	default "-1" if !ETRAX_SER2_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	default "6" if ETRAX_SER2_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	help
+	  Specify the pin of the PA port to carry the DTR signal for serial
+	  port 2.
+
+config ETRAX_SER2_CD_ON_PA_BIT
+	int "Ser2 CD  on PA bit (-1 = not used)" if
ETRAX_SER2_DTR_RI_DSR_CD_ON_PA || ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT2
+	default "-1" if !ETRAX_SER2_DTR_RI_DSR_CD_ON_PA &&
!ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	default "7" if ETRAX_SER2_DTR_RI_DSR_CD_ON_PA ||
ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	help
+	  Specify the pin of the PA port to carry the CD signal for serial
+	  port 2.
+
+config ETRAX_SER2_DTR_ON_PB_BIT
+	int "Ser2 DTR on PB bit (-1 = not used)" if
ETRAX_SER2_DTR_RI_DSR_CD_ON_PB || ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT2
+	default "-1" if !ETRAX_SER2_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	default "4" if ETRAX_SER2_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+
+config ETRAX_SER2_RI_ON_PB_BIT
+	int "Ser2 RI  on PB bit (-1 = not used)" if
ETRAX_SER2_DTR_RI_DSR_CD_ON_PB || ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT2
+	default "-1" if !ETRAX_SER2_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	default "5" if ETRAX_SER2_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+
+config ETRAX_SER2_DSR_ON_PB_BIT
+	int "Ser2 DSR on PB bit (-1 = not used)" if
ETRAX_SER2_DTR_RI_DSR_CD_ON_PB || ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT2
+	default "-1" if !ETRAX_SER2_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	default "6" if ETRAX_SER2_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+
+config ETRAX_SER2_CD_ON_PB_BIT
+	int "Ser2 CD  on PB bit (-1 = not used)" if
ETRAX_SER2_DTR_RI_DSR_CD_ON_PB || ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT2
+	default "-1" if !ETRAX_SER2_DTR_RI_DSR_CD_ON_PB &&
!ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+	default "7" if ETRAX_SER2_DTR_RI_DSR_CD_ON_PB ||
ETRAX_SER2_DTR_RI_DSR_CD_MIXED
+
+config ETRAX_SERIAL_PORT3
+	bool "Serial port 3 enabled"
+	depends on ETRAX_SERIAL
+	help
+	  Enables the ETRAX 100 serial driver for ser3 (ttyS3).
+
+choice
+	prompt "Ser3 DMA out assignment"
+	depends on ETRAX_SERIAL_PORT3
+	default ETRAX_SERIAL_PORT3_DMA4_OUT
+
+config CONFIG_ETRAX_SERIAL_PORT3_NO_DMA_OUT
+       bool "No DMA out"
+
+config CONFIG_ETRAX_SERIAL_PORT3_DMA4_OUT
+       bool "DMA 4"
+
+endchoice
+
+choice
+	prompt "Ser3 DMA in assignment"
+	depends on ETRAX_SERIAL_PORT3
+	default ETRAX_SERIAL_PORT3_DMA5_IN
+
+config CONFIG_ETRAX_SERIAL_PORT3_NO_DMA_IN
+       bool "No DMA in"
+
+config CONFIG_ETRAX_SERIAL_PORT3_DMA5_IN
+       bool "DMA 5"
+
+endchoice
+
+choice
+	prompt "Ser3 DTR, RI, DSR and CD assignment"
+	depends on ETRAX_SERIAL_PORT3
+	default ETRAX_SER3_DTR_RI_DSR_CD_ON_NONE
+
+config ETRAX_SER3_DTR_RI_DSR_CD_ON_NONE
+	bool "No_DTR_RI_DSR_CD"
+
+config ETRAX_SER3_DTR_RI_DSR_CD_ON_PA
+	bool "DTR_RI_DSR_CD_on_PA"
+
+config ETRAX_SER3_DTR_RI_DSR_CD_ON_PB
+	bool "DTR_RI_DSR_CD_on_PB"
+
+config ETRAX_SER3_DTR_RI_DSR_CD_MIXED
+	bool "DTR_RI_DSR_CD_mixed_on_PA_and_PB"
+
+endchoice
+
+config ETRAX_SER3_DTR_ON_PA_BIT
+	int "Ser3 DTR on PA bit (-1 = not used)" if
ETRAX_SER3_DTR_RI_DSR_CD_ON_PA || ETRAX_SER3_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT3
+	default "-1"
+
+config ETRAX_SER3_RI_ON_PA_BIT
+	int "Ser3 RI  on PA bit (-1 = not used)" if
ETRAX_SER3_DTR_RI_DSR_CD_ON_PA || ETRAX_SER3_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT3
+	default "-1"
+
+config ETRAX_SER3_DSR_ON_PA_BIT
+	int "Ser3 DSR on PA bit (-1 = not used)" if
ETRAX_SER3_DTR_RI_DSR_CD_ON_PA || ETRAX_SER3_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT3
+	default "-1"
+
+config ETRAX_SER3_CD_ON_PA_BIT
+	int "Ser3 CD  on PA bit (-1 = not used)" if
ETRAX_SER3_DTR_RI_DSR_CD_ON_PA || ETRAX_SER3_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT3
+	default "-1"
+
+config ETRAX_SER3_DTR_ON_PB_BIT
+	int "Ser3 DTR on PB bit (-1 = not used)" if
ETRAX_SER3_DTR_RI_DSR_CD_ON_PB || ETRAX_SER3_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT3
+	default "-1"
+
+config ETRAX_SER3_RI_ON_PB_BIT
+	int "Ser3 RI  on PB bit (-1 = not used)" if
ETRAX_SER3_DTR_RI_DSR_CD_ON_PB || ETRAX_SER3_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT3
+	default "-1"
+
+config ETRAX_SER3_DSR_ON_PB_BIT
+	int "Ser3 DSR on PB bit (-1 = not used)" if
ETRAX_SER3_DTR_RI_DSR_CD_ON_PB || ETRAX_SER3_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT3
+	default "-1"
+
+config ETRAX_SER3_CD_ON_PB_BIT
+	int "Ser3 CD  on PB bit (-1 = not used)" if
ETRAX_SER3_DTR_RI_DSR_CD_ON_PB || ETRAX_SER3_DTR_RI_DSR_CD_MIXED
+	depends on ETRAX_SERIAL_PORT3
+	default "-1"
+
+config ETRAX_RS485
+	bool "RS-485 support"
+	depends on ETRAX_SERIAL
+	help
+	  Enables support for RS-485 serial communication.  For a primer on
+	  RS-485, see <http://www.hw.cz/english/docs/rs485/rs485.html>.
+
+config ETRAX_RS485_ON_PA
+	bool "RS-485 mode on PA"
+	depends on ETRAX_RS485
+	help
+	  Control Driver Output Enable on RS485 transceiver using a pin on
PA
+	  port:
+	  Axis 2400/2401 uses PA 3.
+
+config ETRAX_RS485_ON_PA_BIT
+	int "RS-485 mode on PA bit"
+	depends on ETRAX_RS485_ON_PA
+	default "3"
+	help
+	  Control Driver Output Enable on RS485 transceiver using a this bit
+	  on PA port.
+
+config ETRAX_RS485_DISABLE_RECEIVER
+	bool "Disable serial receiver"
+	depends on ETRAX_RS485
+	help
+	  It's necessary to disable the serial receiver to avoid serial
+	  loopback.  Not all products are able to do this in software only.
+	  Axis 2400/2401 must disable receiver.
+	  
+
diff -Nur ../orig/drivers/serial/cris/Makefile
./drivers/serial/cris/Makefile
--- ../orig/drivers/serial/cris/Makefile	Thu Jan  1 01:00:00 1970
+++ ./drivers/serial/cris/Makefile	Wed Aug 25 09:52:37 2004
@@ -0,0 +1,7 @@
+#
+# Makefile for the CRIS UARTs
+#
+
+obj-$(CONFIG_ETRAX_SERIAL) += ser.o
+
+ser-objs = v10/serial.o


