Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbTLCEvo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 23:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbTLCEvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 23:51:44 -0500
Received: from dhcp024-209-033-037.neo.rr.com ([24.209.33.37]:64899 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S264498AbTLCEvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 23:51:41 -0500
Date: Tue, 2 Dec 2003 23:44:32 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, trelane@digitasaru.net
Subject: Re: vanilla 2.6.0-test11 and CS4236 card
Message-ID: <20031202234432.GA14730@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
	trelane@digitasaru.net
References: <20031202170637.GD5475@digitasaru.net> <s5hsmk3ceia.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hsmk3ceia.wl@alsa2.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 06:31:57PM +0100, Takashi Iwai wrote:
> At Tue, 2 Dec 2003 11:06:39 -0600,
> Joseph Pingenot wrote:
> > 
> > Howdy.
> > 
> > I'm having problems getting the CS4236+ driver to recognize my 
> >   CS4236B card.  pnp finds it on boot:
> > isapnp: Scanning for PnP cards...
> > isapnp: Card 'CS4236B'
> > isapnp: 1 Plug & Play card detected total
> > 
> > but the ALSA driver doesn't pick it up.
> > isapnp detection failed and probing for CS4236+ is not supported
> > CS4236+ soundcard not found or device busy
> > 
> > Furthermore, after fudging with manually setting it up via modprobe
> >   options, it's still not loading:
> > CS4236+ soundcard not found or device busy
> > 
> > This used to work in the 2.4 series kernel without any modprobe.conf
> >   settings; the OSS driver would pick it up.
> > 
> > Any assistance would be greatly appreciated; this is the only thing holding
> >   me back from 2.6 goodness.  ;)
> 
> does the attached patch work?  (it's untested at all...)


> --- linux-2.6.0-test11/drivers/pnp/card.c-dist	2003-12-02 18:14:21.000000000 +0100
> +++ linux-2.6.0-test11/drivers/pnp/card.c	2003-12-02 18:29:20.000000000 +0100
> @@ -26,8 +26,25 @@
>  {
>  	const struct pnp_card_device_id * drv_id = drv->id_table;
>  	while (*drv_id->id){
> -		if (compare_pnp_id(card->id,drv_id->id))
> -			return drv_id;
> +		if (compare_pnp_id(card->id,drv_id->id)) {
> +			int i = 0;
> +			for (;;) {
> +				int found;
> +				struct pnp_dev *dev;
> +				if (i == PNP_MAX_DEVICES || ! *drv_id->devs[i].id)
> +					return drv_id;
> +				found = 0;
> +				card_for_each_dev(card, dev) {
> +					if (compare_pnp_id(dev->id, drv_id->devs[i].id)) {
> +						found = 1;
> +						break;
> +					}
> +				}
> +				if (! found)
> +					break;
> +				i++;
> +			}
> +		}
>  		drv_id++;
>  	}
>  	return NULL;
>


Here's a slight cleanup of the above patch -- tested with the cs4232 driver.
Any additional testing would be appreciated.

--- a/drivers/pnp/card.c	2003-11-26 20:45:38.000000000 +0000
+++ b/drivers/pnp/card.c	2003-12-02 23:06:55.000000000 +0000
@@ -26,8 +26,18 @@
 {
 	const struct pnp_card_device_id * drv_id = drv->id_table;
 	while (*drv_id->id){
-		if (compare_pnp_id(card->id,drv_id->id))
-			return drv_id;
+		if (compare_pnp_id(card->id,drv_id->id)) {
+			int i = 0;
+			for (;;i++) {
+				struct pnp_dev *dev;
+				if (i == PNP_MAX_DEVICES || ! *drv_id->devs[i].id)
+					return drv_id;
+				card_for_each_dev(card, dev) {
+					if (!compare_pnp_id(dev->id, drv_id->devs[i].id))
+						break;
+				}
+			}
+		}
 		drv_id++;
 	}
 	return NULL;

In this case we could also just continue if the MPU device isn't present.  It
would probably be a good convention to do so because if, for whatever reason
(3rd party driver, resource conflicts, etc), the MPU device is busy in any
matched card id set, the entire probe would fail.

How about something like this? (untested)

--- a/sound/isa/cs423x/cs4236.c	2003-11-26 20:43:05.000000000 +0000
+++ b/sound/isa/cs423x/cs4236.c	2003-12-02 23:36:59.000000000 +0000
@@ -294,13 +294,8 @@
 		kfree(cfg);
 		return -EBUSY;
 	}
-	if (id->devs[2].id[0]) {
+	if (id->devs[2].id[0])
 		acard->mpu = pnp_request_card_device(card, id->devs[2].id, NULL);
-		if (acard->mpu == NULL) {
-			kfree(cfg);
-			return -EBUSY;
-		}
-	}

 	/* WSS initialization */
 	pdev = acard->wss;



Thanks,
Adam
