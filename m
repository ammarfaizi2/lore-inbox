Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbSLQPn6>; Tue, 17 Dec 2002 10:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263991AbSLQPn5>; Tue, 17 Dec 2002 10:43:57 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20962
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261724AbSLQPn4>; Tue, 17 Dec 2002 10:43:56 -0500
Subject: Re: Via 8233 flooding of errors [2.4-ac]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nathaniel Russell <reddog83@chartermi.net>
Cc: alan@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0212171035450.1629-100000@reddog.example.net>
References: <Pine.LNX.4.44.0212171035450.1629-100000@reddog.example.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Dec 2002 16:31:40 +0000
Message-Id: <1040142700.19998.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-17 at 15:49, Nathaniel Russell wrote:
> Alan,
> What would you like to me to send you all i play are mp3's and i watch DVD's???
> And about the ignoring drained playback i can just ignore that paranoia, that
> is fine with me. Oh and yes i hit ^C to stop the mp3 player :).

Ok lets see if I understand what is actually going on. Can you try

--- drivers/sound/via82cxxx_audio.c~	2002-12-17 15:47:21.000000000 +0000
+++ drivers/sound/via82cxxx_audio.c	2002-12-17 15:48:51.000000000 +0000
@@ -15,7 +15,7 @@
  */
 

-#define VIA_VERSION	"1.9.1-ac"
+#define VIA_VERSION	"1.9.1-ac2"
 

 #include <linux/config.h>
@@ -1344,7 +1344,11 @@
 
 static inline void via_chan_maybe_start (struct via_channel *chan)
 {
-	assert (chan->is_active == sg_active(chan->iobase));
+	if(chan->is_active != sg_active(chan->iobase))
+	{
+		chan->is_active = 0;
+		printk(KERN_ERR "via82cxx_audio: DSP stopped unexpectedly.\n");
+	}
 
 	if (!chan->is_active && chan->is_enabled) {
 		chan->is_active = 1;
@@ -3275,7 +3279,7 @@
 
 	if (file->f_mode & FMODE_WRITE) {
 		rc = via_dsp_drain_playback (card, &card->ch_out, nonblock);
-		if (rc && rc != ERESTARTSYS)	/* Nobody needs to know about ^C */
+		if (rc && rc != -ERESTARTSYS)	/* Nobody needs to know about ^C */
 			printk (KERN_DEBUG "via_audio: ignoring drain playback error %d\n", rc);
 
 		via_chan_free (card, &card->ch_out);
