Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287254AbSALSTV>; Sat, 12 Jan 2002 13:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287255AbSALSTM>; Sat, 12 Jan 2002 13:19:12 -0500
Received: from mk-smarthost-3.mail.uk.tiscali.com ([212.74.112.73]:16147 "EHLO
	mk-smarthost-3.mail.uk.tiscali.com") by vger.kernel.org with ESMTP
	id <S287254AbSALSSz>; Sat, 12 Jan 2002 13:18:55 -0500
Date: Sat, 12 Jan 2002 18:18:07 +0000
From: Jonathan Hudson <jonathan@daria.co.uk>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br, torvalds@transmeta.com, vshebordaev@mail.ru
Subject: [PATCH] Gemtek FM Radio PCI driver enhancement.
Message-ID: <20020112181807.GA3630@trespassersw.daria.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Organisation: The Dead Letter Drop
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This small patch enables the Gemtek FM Radio PCI driver to report the
audio mode (mono or stereo) of the card. Applies to
2.4.17/2.5.2-pre11.

--- linux/drivers/media/radio/radio-gemtek-pci.c.orig	Sat Jan 12 17:16:03 2002
+++ linux/drivers/media/radio/radio-gemtek-pci.c	Sat Jan 12 17:19:51 2002
@@ -221,6 +221,7 @@
 		case VIDIOCGTUNER:
 		{
 			struct video_tuner t;
+                        int signal;
 
 			if ( copy_from_user( &t, arg, sizeof( struct video_tuner ) ) )
 				return -EFAULT;
@@ -228,11 +229,12 @@
 			if ( t.tuner ) 
 				return -EINVAL;
 
+                        signal = gemtek_pci_getsignal( card );
 			t.rangelow = GEMTEK_PCI_RANGE_LOW;
 			t.rangehigh = GEMTEK_PCI_RANGE_HIGH;
-			t.flags = VIDEO_TUNER_LOW;
+			t.flags = VIDEO_TUNER_LOW | (7 << signal) ;
 			t.mode = VIDEO_MODE_AUTO;
-			t.signal = 0xFFFF * gemtek_pci_getsignal( card );
+			t.signal = 0xFFFF * signal;
 			strcpy( t.name, "FM" );
 
 			if ( copy_to_user( arg, &t, sizeof( struct video_tuner ) ) )
@@ -282,6 +284,7 @@
 			a.flags |= VIDEO_AUDIO_MUTABLE;
 			a.volume = 1;
 			a.step = 65535;
+                        a.mode = (1 << gemtek_pci_getsignal( card ));
 			strcpy( a.name, "Radio" );
 
 			if ( copy_to_user( arg, &a, sizeof( struct video_audio ) ) )
