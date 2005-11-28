Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbVK1XBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVK1XBk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 18:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVK1XBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 18:01:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26082 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932286AbVK1XBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 18:01:39 -0500
Date: Mon, 28 Nov 2005 15:01:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
cc: Marc Koschewski <marc@osknowledge.org>,
       "Calin A. Culianu" <calin@ajvar.org>, akpm@osdl.org, adaplas@pol.net,
       linux-kernel@vger.kernel.org
Subject: Re: nvidia fb flicker
In-Reply-To: <438B82A4.4030107@gmail.com>
Message-ID: <Pine.LNX.4.64.0511281450260.3263@g5.osdl.org>
References: <Pine.LNX.4.64.0511252358390.25302@rtlab.med.cornell.edu>
 <20051128103554.GA7071@stiffy.osknowledge.org> <438AF8A2.6030403@gmail.com>
 <20051128132035.GA7265@stiffy.osknowledge.org> <438B0D89.1080400@gmail.com>
 <20051128212418.GA7185@stiffy.osknowledge.org> <438B82A4.4030107@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Nov 2005, Antonino A. Daplas wrote:
> 
> Nov 28 14:02:32 stiffy kernel: Extrapolated
> Nov 28 14:02:32 stiffy kernel:            H: 75-75KHz V: 60-60Hz DCLK: 162MHz
> 
> Since the min and max value of the sync timings are equal, nvidiafb has
> no room left to verify the timings, and will _always_ reject any timings even
> if they are valid.
> 
> So, try this patch, we make nvidiafb less restrictive by ignoring the
> hsync and vsync ranges if the min and max values are equal. This should
> make your hardware display properly even if CONFIG_FB_NVIDIA_I2c = y.

Tony,

 may I suggestinstead making the verifier allow a small error?

I don't find it at all unlikely that some EDID blocks might say that only 
a 60Hz refresh rate is allowed. A lot of LCD's are literally specced for 
that (just read their manuals), even though they often in practice allow 
other frequencies (often _wildly_ different - most modern LCD's are 
perfectly happy to sync up with almost anything).

And if a monitor says that it wants a vertical frequency of 60Hz, a mode 
that has a frequency of 59 should certainly be accepted.

So it sounds like something has marked a perfectly valid mode as invalid, 
just because it's not _exactly_ at the frequency.

So how about allowing a small error in the frequencies in 
fb_validate_mode()? And make sure to try to round the divisions to 
nearest, not down. Something like the appended (totally untested)..

		Linus

----
diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index fc7965b..15b0e7e 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -1261,10 +1261,15 @@ int fb_validate_mode(const struct fb_var
 	if (var->vmode & FB_VMODE_DOUBLE)
 		vtotal *= 2;
 
-	hfreq = pixclock/htotal;
+	hfreq = (pixclock + htotal/2) / htotal;
 	hfreq = (hfreq + 500) / 1000 * 1000;
 
-	vfreq = hfreq/vtotal;
+	vfreq = (hfreq + vtotal/2) / vtotal;
+
+	/* Allow a 3% error */
+	vfmin -= vfmin >> 5; vfmax += vfmax >> 5;
+	hfmin -= hfmin >> 5; hfmax += hfmax >> 5;
+	
 
 	return (vfreq < vfmin || vfreq > vfmax || 
 		hfreq < hfmin || hfreq > hfmax ||
