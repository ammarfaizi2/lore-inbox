Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277393AbRJZD1m>; Thu, 25 Oct 2001 23:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277395AbRJZD1c>; Thu, 25 Oct 2001 23:27:32 -0400
Received: from zero.tech9.net ([209.61.188.187]:18698 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S277393AbRJZD1Z>;
	Thu, 25 Oct 2001 23:27:25 -0400
Subject: Re: SiS/Trident 4DWave sound driver oops
From: Robert Love <rml@tech9.net>
To: David Weinehall <tao@acc.umu.se>
Cc: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
        "Michael F. Robbins" <compumike@compumike.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011026051346.J25701@khan.acc.umu.se>
In-Reply-To: <1004016263.1384.15.camel@tbird.robbins>
	<7ktjw58u.wl@nisaaru.dvs.cs.fujitsu.co.jp>
	<1004060759.11258.12.camel@phantasy>
	<6693w4ds.wl@nisaaru.dvs.cs.fujitsu.co.jp>
	<1004061741.11366.32.camel@phantasy>
	<g087jff1.wl@nisaaru.dvs.cs.fujitsu.co.jp>
	<1004064125.19937.5.camel@phantasy>  <20011026051346.J25701@khan.acc.umu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.25.15.53 (Preview Release)
Date: 25 Oct 2001 23:28:02 -0400
Message-Id: <1004066884.29627.22.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-10-25 at 23:13, David Weinehall wrote:
> I think the way this is coded stinks anyway. the {0,} should be used
> as a loop-terminator, not ARRAY_SIZE(blaha) - 1. Yes, using 0-termination
> wastes space. But it's cleaner and in line with what most other code
> does.

Agreed.  Also, I didn't check if other ac97 code uses the {0,} as a
terminator.  Removing it may break that.

The patch below accomplishes this.

However, now that I am actually looking at the code <g>, I don't see why
this would be a problem either way.  Even though the loop reads the 
"terminal" entry, it just checks whether it equals the specified id.  It
is equal to 0 so I assume it never will...we aren't dereferencing it or
anything.

diff -u linux-2.4.12-ac6/drivers/sound/ac97_codec.c linux/drivers/sound/ac97_codec.c
--- linux-2.4.12-ac6/drivers/sound/ac97_codec.c	Tue Oct 23 17:16:20 2001
+++ linux/drivers/sound/ac97_codec.c	Thu Oct 25 23:21:02 2001
@@ -669,7 +669,7 @@
 {
 	u16 id1, id2;
 	u16 audio, modem;
-	int i;
+	int i = 0;
 
 	/* probing AC97 codec, AC97 2.0 says that bit 15 of register 0x00 (reset) should 
 	 * be read zero.
@@ -700,13 +700,14 @@
 
 	id1 = codec->codec_read(codec, AC97_VENDOR_ID1);
 	id2 = codec->codec_read(codec, AC97_VENDOR_ID2);
-	for (i = 0; i < ARRAY_SIZE(ac97_codec_ids); i++) {
+	while(a97_codec_ids[i].id != 0) {
 		if (ac97_codec_ids[i].id == ((id1 << 16) | id2)) {
 			codec->type = ac97_codec_ids[i].id;
 			codec->name = ac97_codec_ids[i].name;
 			codec->codec_ops = ac97_codec_ids[i].ops;
 			break;
 		}
+		i++;
 	}
 	if (codec->name == NULL)
 		codec->name = "Unknown";


	Robert Love

