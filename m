Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422721AbWCXFcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422721AbWCXFcH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 00:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423144AbWCXFcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 00:32:06 -0500
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:26045 "EHLO
	smtpq2.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1423142AbWCXFcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 00:32:00 -0500
Message-ID: <44238482.50401@keyaccess.nl>
Date: Fri, 24 Mar 2006 06:32:50 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: ALSA devel <alsa-devel@alsa-project.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ALSA] ISA drivers bailing on first !enable[i]
Content-Type: multipart/mixed;
 boundary="------------010904020002050806060005"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010904020002050806060005
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

After the change to the platform_driver stuff in 2.6.16, all ISA card
module_inits loop over the cards using:

	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {

This means that the driver bails completely on the first !enable[i].
This did not use to be the case and does not seem right. I believe it
should rather be:

	for (i = 0; i < SNDRV_CARDS; i++) {
		if (!enable[i])
			continue;

This would restore the previous behaviour for the enable parameter; ie,
only ignore the one.

Assuming this was indeed the idea, I've attached a patch against 2.6.16.
If it's correct, but you need it against ALSA CVS instead, please say so

     sound/isa/ad1848/ad1848.c       |    4 +++-
     sound/isa/cmi8330.c             |    4 ++--
     sound/isa/cs423x/cs4231.c       |    4 +++-
     sound/isa/cs423x/cs4236.c       |    4 ++--
     sound/isa/es1688/es1688.c       |    4 +++-
     sound/isa/gus/gusclassic.c      |    4 +++-
     sound/isa/gus/gusextreme.c      |    4 +++-
     sound/isa/gus/gusmax.c          |    4 +++-
     sound/isa/gus/interwave.c       |    4 +++-
     sound/isa/opl3sa2.c             |    4 +++-
     sound/isa/sb/sb16.c             |    4 ++--
     sound/isa/sb/sb8.c              |    4 +++-
     sound/isa/sgalaxy.c             |    4 +++-
     sound/isa/wavefront/wavefront.c |    4 +++-
     14 files changed, 39 insertions(+), 17 deletions(-)

Rene.





--------------010904020002050806060005
Content-Type: text/plain;
 name="alsa_platform_enable.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_platform_enable.diff"

Index: local/sound/isa/ad1848/ad1848.c
===================================================================
--- local.orig/sound/isa/ad1848/ad1848.c	2006-02-27 19:22:35.000000000 +0100
+++ local/sound/isa/ad1848/ad1848.c	2006-03-24 02:39:20.000000000 +0100
@@ -187,8 +187,10 @@ static int __init alsa_card_ad1848_init(
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(SND_AD1848_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/isa/cmi8330.c
===================================================================
--- local.orig/sound/isa/cmi8330.c	2006-02-27 19:22:35.000000000 +0100
+++ local/sound/isa/cmi8330.c	2006-03-24 02:34:03.000000000 +0100
@@ -690,9 +690,9 @@ static int __init alsa_card_cmi8330_init
 	if ((err = platform_driver_register(&snd_cmi8330_driver)) < 0)
 		return err;
 
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
-		if (is_isapnp_selected(i))
+		if (!enable[i] || is_isapnp_selected(i))
 			continue;
 		device = platform_device_register_simple(CMI8330_DRIVER,
 							 i, NULL, 0);
Index: local/sound/isa/cs423x/cs4231.c
===================================================================
--- local.orig/sound/isa/cs423x/cs4231.c	2006-02-27 19:22:35.000000000 +0100
+++ local/sound/isa/cs423x/cs4231.c	2006-03-24 02:38:21.000000000 +0100
@@ -203,8 +203,10 @@ static int __init alsa_card_cs4231_init(
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(SND_CS4231_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/isa/cs423x/cs4236.c
===================================================================
--- local.orig/sound/isa/cs423x/cs4236.c	2006-03-23 04:11:11.000000000 +0100
+++ local/sound/isa/cs423x/cs4236.c	2006-03-24 02:37:58.000000000 +0100
@@ -771,9 +771,9 @@ static int __init alsa_card_cs423x_init(
 	if ((err = platform_driver_register(&cs423x_nonpnp_driver)) < 0)
 		return err;
 
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
-		if (is_isapnp_selected(i))
+		if (!enable[i] || is_isapnp_selected(i))
 			continue;
 		device = platform_device_register_simple(CS423X_DRIVER,
 							 i, NULL, 0);
Index: local/sound/isa/es1688/es1688.c
===================================================================
--- local.orig/sound/isa/es1688/es1688.c	2006-02-27 19:22:35.000000000 +0100
+++ local/sound/isa/es1688/es1688.c	2006-03-24 02:42:14.000000000 +0100
@@ -207,8 +207,10 @@ static int __init alsa_card_es1688_init(
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(ES1688_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/isa/gus/gusclassic.c
===================================================================
--- local.orig/sound/isa/gus/gusclassic.c	2006-02-27 19:22:35.000000000 +0100
+++ local/sound/isa/gus/gusclassic.c	2006-03-24 02:43:12.000000000 +0100
@@ -247,8 +247,10 @@ static int __init alsa_card_gusclassic_i
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(GUSCLASSIC_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/isa/gus/gusextreme.c
===================================================================
--- local.orig/sound/isa/gus/gusextreme.c	2006-02-27 19:22:35.000000000 +0100
+++ local/sound/isa/gus/gusextreme.c	2006-03-24 02:44:56.000000000 +0100
@@ -357,8 +357,10 @@ static int __init alsa_card_gusextreme_i
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(GUSEXTREME_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/isa/gus/gusmax.c
===================================================================
--- local.orig/sound/isa/gus/gusmax.c	2006-02-27 19:22:35.000000000 +0100
+++ local/sound/isa/gus/gusmax.c	2006-03-24 02:44:03.000000000 +0100
@@ -384,8 +384,10 @@ static int __init alsa_card_gusmax_init(
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(GUSMAX_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/isa/gus/interwave.c
===================================================================
--- local.orig/sound/isa/gus/interwave.c	2006-02-27 19:22:35.000000000 +0100
+++ local/sound/isa/gus/interwave.c	2006-03-24 02:45:43.000000000 +0100
@@ -935,8 +935,10 @@ static int __init alsa_card_interwave_in
 	if ((err = platform_driver_register(&snd_interwave_driver)) < 0)
 		return err;
 
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 #ifdef CONFIG_PNP
 		if (isapnp[i])
 			continue;
Index: local/sound/isa/opl3sa2.c
===================================================================
--- local.orig/sound/isa/opl3sa2.c	2006-02-27 19:22:35.000000000 +0100
+++ local/sound/isa/opl3sa2.c	2006-03-24 02:47:22.000000000 +0100
@@ -949,8 +949,10 @@ static int __init alsa_card_opl3sa2_init
 	if ((err = platform_driver_register(&snd_opl3sa2_nonpnp_driver)) < 0)
 		return err;
 
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 #ifdef CONFIG_PNP
 		if (isapnp[i])
 			continue;
Index: local/sound/isa/sb/sb16.c
===================================================================
--- local.orig/sound/isa/sb/sb16.c	2006-02-27 19:22:35.000000000 +0100
+++ local/sound/isa/sb/sb16.c	2006-03-24 02:49:24.000000000 +0100
@@ -712,9 +712,9 @@ static int __init alsa_card_sb16_init(vo
 	if ((err = platform_driver_register(&snd_sb16_nonpnp_driver)) < 0)
 		return err;
 
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
-		if (is_isapnp_selected(i))
+		if (!enable[i] || is_isapnp_selected(i))
 			continue;
 		device = platform_device_register_simple(SND_SB16_DRIVER,
 							 i, NULL, 0);
Index: local/sound/isa/sb/sb8.c
===================================================================
--- local.orig/sound/isa/sb/sb8.c	2006-02-27 19:22:35.000000000 +0100
+++ local/sound/isa/sb/sb8.c	2006-03-24 02:50:20.000000000 +0100
@@ -258,8 +258,10 @@ static int __init alsa_card_sb8_init(voi
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(SND_SB8_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/isa/sgalaxy.c
===================================================================
--- local.orig/sound/isa/sgalaxy.c	2006-02-27 19:22:35.000000000 +0100
+++ local/sound/isa/sgalaxy.c	2006-03-24 02:51:11.000000000 +0100
@@ -360,8 +360,10 @@ static int __init alsa_card_sgalaxy_init
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(SND_SGALAXY_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/isa/wavefront/wavefront.c
===================================================================
--- local.orig/sound/isa/wavefront/wavefront.c	2006-02-27 19:22:35.000000000 +0100
+++ local/sound/isa/wavefront/wavefront.c	2006-03-24 02:53:05.000000000 +0100
@@ -710,8 +710,10 @@ static int __init alsa_card_wavefront_in
 	if ((err = platform_driver_register(&snd_wavefront_driver)) < 0)
 		return err;
 
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 #ifdef CONFIG_PNP
 		if (isapnp[i])
 			continue;





--------------010904020002050806060005--
