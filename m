Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbSKVD6r>; Thu, 21 Nov 2002 22:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbSKVD6r>; Thu, 21 Nov 2002 22:58:47 -0500
Received: from mail.michigannet.com ([208.49.116.30]:40970 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S265134AbSKVD6p>; Thu, 21 Nov 2002 22:58:45 -0500
Date: Thu, 21 Nov 2002 23:05:45 -0500
From: Paul <set@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-rc2 screwy ac97_codec.c:codec_id()
Message-ID: <20021122040545.GA1432@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0211151309400.11268-100000@freak.distro.conectiva> <20021122011413.GA1463@squish.home.loc> <1037930226.10314.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <1037930226.10314.3.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Alan Cox <alan@lxorguk.ukuu.org.uk>, on Fri Nov 22, 2002 [01:57:06 AM] said:
> On Fri, 2002-11-22 at 01:14, Paul wrote:
> > 	Im pretty sure this is broken, but I dont know exactly
> > what it is trying to do.
> > 	The first snprintf is overwritten regardless-- missing
> > else block? And its format string should probably be "%4X:%4X",
> > because whats there wont fit in the buffer.
> 
> There is an else missing you are correct
> 
	Hi;
	
	Well, just for the heck of it, here is a patch that
puts the else block in, and fixes the format so that it matches
previous output and fits in the buffer. If the powers that be
wanted "1234:ABCD" instead of "0x1234:0xabcd", then the
format string would be "%04X:%04X" and CODEC_ID_BUFSZ could
go back to 10.
	Tested.

Paul
set@pobox.com

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.20-rc2-ac97_codec.patch"

--- 2.4.20-rc2/drivers/sound/ac97_codec.c.orig	2002-11-21 13:54:36.000000000 -0500
+++ 2.4.20-rc2/drivers/sound/ac97_codec.c	2002-11-21 22:49:18.000000000 -0500
@@ -52,6 +52,8 @@
 #include <linux/ac97_codec.h>
 #include <asm/uaccess.h>
 
+#define CODEC_ID_BUFSZ 14
+
 static int ac97_read_mixer(struct ac97_codec *codec, int oss_channel);
 static void ac97_write_mixer(struct ac97_codec *codec, int oss_channel, 
 			     unsigned int left, unsigned int right);
@@ -657,7 +659,7 @@
  *	codec_id	-  Turn id1/id2 into a PnP string
  *	@id1: Vendor ID1
  *	@id2: Vendor ID2
- *	@buf: 10 byte buffer
+ *	@buf: CODEC_ID_BUFSZ byte buffer
  *
  *	Fills buf with a zero terminated PnP ident string for the id1/id2
  *	pair. For convenience the return is the passed in buffer pointer.
@@ -665,12 +667,14 @@
  
 static char *codec_id(u16 id1, u16 id2, char *buf)
 {
-	if(id1&0x8080)
-		snprintf(buf, 10, "%0x4X:%0x4X", id1, id2);
-	buf[0] = (id1 >> 8);
-	buf[1] = (id1 & 0xFF);
-	buf[2] = (id2 >> 8);
-	snprintf(buf+3, 7, "%d", id2&0xFF);
+	if(id1&0x8080) {
+		snprintf(buf, CODEC_ID_BUFSZ, "0x%04x:0x%04x", id1, id2);
+	} else {
+		buf[0] = (id1 >> 8);
+		buf[1] = (id1 & 0xFF);
+		buf[2] = (id2 >> 8);
+		snprintf(buf+3, CODEC_ID_BUFSZ - 3, "%d", id2&0xFF);
+	}
 	return buf;
 }
  
@@ -702,7 +706,7 @@
 	u16 id1, id2;
 	u16 audio, modem;
 	int i;
-	char cidbuf[10];
+	char cidbuf[CODEC_ID_BUFSZ];
 
 	/* probing AC97 codec, AC97 2.0 says that bit 15 of register 0x00 (reset) should 
 	 * be read zero.
@@ -746,7 +750,7 @@
 	}
 	if (codec->name == NULL)
 		codec->name = "Unknown";
-	printk(KERN_INFO "ac97_codec: AC97 %s codec, id: %s(%s)\n", 
+	printk(KERN_INFO "ac97_codec: AC97 %s codec, id: %s (%s)\n", 
 		modem ? "Modem" : (audio ? "Audio" : ""),
 	       codec_id(id1, id2, cidbuf), codec->name);
 

--TB36FDmn/VVEgNH/--
