Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267256AbSKVBHR>; Thu, 21 Nov 2002 20:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267258AbSKVBHR>; Thu, 21 Nov 2002 20:07:17 -0500
Received: from mail.michigannet.com ([208.49.116.30]:36104 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S267256AbSKVBHP>; Thu, 21 Nov 2002 20:07:15 -0500
Date: Thu, 21 Nov 2002 20:14:14 -0500
From: Paul <set@pobox.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.20-rc2 screwy ac97_codec.c:codec_id()
Message-ID: <20021122011413.GA1463@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0211151309400.11268-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0211151309400.11268-100000@freak.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi;

	Im pretty sure this is broken, but I dont know exactly
what it is trying to do.
	The first snprintf is overwritten regardless-- missing
else block? And its format string should probably be "%4X:%4X",
because whats there wont fit in the buffer.
	Then the first 3 chars in the string are filled in
with raw numbers (For my card, non-ascii) and then a single
decimal digit?? (This string is printed out during boot time--
which is how I noticed it because of the 'garbage' chars.)
	I dont know what a PnP string is supposed to look like...

Paul
set@pobox.com

--- linux-2.4.19/drivers/sound/ac97_codec.c     2002-08-03 00:39:44.000000000 +0 000
+++ linux-2.4.20/drivers/sound/ac97_codec.c     2002-11-15 14:56:52.000000000 +0 000
@@ -654,6 +654,27 @@
 }
  
/**
+ *     codec_id        -  Turn id1/id2 into a PnP string
+ *     @id1: Vendor ID1
+ *     @id2: Vendor ID2
+ *     @buf: 10 byte buffer
+ *
+ *     Fills buf with a zero terminated PnP ident string for the id1/id2
+ *     pair. For convenience the return is the passed in buffer pointer.
+ */
+ 
+static char *codec_id(u16 id1, u16 id2, char *buf)
+{
+       if(id1&0x8080)
+               snprintf(buf, 10, "%0x4X:%0x4X", id1, id2);
+       buf[0] = (id1 >> 8);
+       buf[1] = (id1 & 0xFF);
+       buf[2] = (id2 >> 8);
+       snprintf(buf+3, 7, "%d", id2&0xFF);
+       return buf;
+}


