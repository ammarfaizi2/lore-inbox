Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbVJRAKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbVJRAKR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 20:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbVJRAKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 20:10:17 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:11489 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751422AbVJRAKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 20:10:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IrZDp4cRnkG9aXO785PbGMETfk/ZBIwWi4v8K1nQ8146iC4RXTxubOGTbbXKB2TJzYOdBNapRSnVldyKuebARoSHuJW2M0pHru+e+E2A3TrKarbuARogxxI68d5Ye9kF2v1z0hpdycVVgUTxFwKPm2LRA6gHbyctwFDAdPYCet4=
Message-ID: <43543D4C.3050700@gmail.com>
Date: Tue, 18 Oct 2005 08:09:48 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bob Tracy <rct@gherkin.frus.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: vesafb_blank() vs. Toshiba 730XCDT notebook
References: <20051017174612.4ECE7DBA1@gherkin.frus.com>
In-Reply-To: <20051017174612.4ECE7DBA1@gherkin.frus.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Tracy wrote:
> Apologies for not reporting this problem sooner...  The system with
> the problem doesn't get powered-up as often as it probably should.
> 
> Is there a way to disable or otherwise control the display blanking
> feature that was added after 2.6.13?  I've got a Toshiba notebook
> (730XCDT -- Pentium 150MMX) for which I'm using the Vesa FB driver.
> When the machine has been idle for some time and the driver attempts
> to powerdown the display, rather than the display going blank, it goes
> gray with several strange lines.  When I hit the "shift" key or other-
> wise wake up the display, the old video state is not fully restored:
> the image is badly distorted (looks like video memory corruption --
> moving the mouse pointer around causes the affected areas to refresh
> properly) until I switch from X11 to a virtual console and then back
> to X11.
> 
> Also, when I first go into X11, the display goes into a mode that has
> the appearance of film melting in front of a hot projector lamp :-(.
> In the background I see faint tile outlines.  Finally, the display goes
> into the proper mode and all is well until I leave the machine idle for
> a few minutes as described above.
> 
> None of this behavior was present in 2.6.13: when I invoked "startx",
> the display would simply go blank until the expected background image
> (standard X11 moire) appeared.  The first kernel I tried that has the
> display problems is 2.6.14-rc1.  I'm only seeing these problems on the
> Toshiba: my other systems behave fine.
> 
> Thanks in advance for any help/guidance those in the know can provide.
> 

Can you try this patch first? 

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

diff --git a/drivers/video/vesafb.c b/drivers/video/vesafb.c
--- a/drivers/video/vesafb.c
+++ b/drivers/video/vesafb.c
@@ -96,14 +96,14 @@ static int vesafb_blank(int blank, struc
 		int loop = 10000;
 		u8 seq = 0, crtc17 = 0;
 	    
-		err = 0;
-
-		if (blank) {
+		if (blank == FB_BLANK_POWERDOWN) {
 			seq = 0x20;
 			crtc17 = 0x00;
+			err = 0;
 		} else {
 			seq = 0x00;
 			crtc17 = 0x80;
+			err = (blank == FB_BLANK_UNBLANK) ? 0 : -EINVAL;
 		}
 		
 		vga_wseq(NULL, 0x00, 0x01);

