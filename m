Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267613AbTAQTCh>; Fri, 17 Jan 2003 14:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267626AbTAQTCh>; Fri, 17 Jan 2003 14:02:37 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:3718 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267613AbTAQTCf>;
	Fri, 17 Jan 2003 14:02:35 -0500
Date: Fri, 17 Jan 2003 14:13:15 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: "Ruslan U. Zakirov" <cubic@miee.ru>
Cc: Samium Gromoff <deepfire@ibe.miee.ru>, LKML <linux-kernel@vger.kernel.org>,
       Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA and isapnp cards
Message-ID: <20030117141315.GC26108@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	"Ruslan U. Zakirov" <cubic@miee.ru>,
	Samium Gromoff <deepfire@ibe.miee.ru>,
	LKML <linux-kernel@vger.kernel.org>,
	Jaroslav Kysela <perex@perex.cz>
References: <20030117111854.GA22551@neo.rr.com> <Pine.BSF.4.05.10301171931290.71917-100000@wildrose.miee.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.05.10301171931290.71917-100000@wildrose.miee.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 07:56:44PM +0300, Ruslan U. Zakirov wrote:
> Hello Adam and other.
> I've just posted another patch that works for PnP cards to you and Samium.
> During the work on it, i've found some bugs, but I can't solve them.
> At the end of patch there is hack for drivers/pnp/driver.c look at it.
> devs -  member of pnp_card_device_id struct have got more then one id for
> awe32 cards and when we request first device with 
> const char *id=devs[0].id it contains "CTL0031CTL0021" instead "CTL0031"
> and compare_pnp_id fails on it.
> This bug can be solved in other way with allocation tmp buffer in driver,
> copy id from table to buffer, add to the end \0 then request for device,
> but I think that it's bad way. 
> Any suggestions?

Could you please try this patch.  I think the lenght should be 8, not 7. Yep
that should do the trick.  Thanks for finding this bug.

--- a/include/linux/pnp.h	Tue Jan 14 05:59:30 2003
+++ b/include/linux/pnp.h	Fri Jan 17 14:02:33 2003
@@ -23,6 +23,7 @@
 #define DEVICE_COUNT_IO		8
 #define DEVICE_COUNT_MEM	4
 #define MAX_DEVICES		8
+#define PNP_ID_LEN		8
 
 struct pnp_resource;
 struct pnp_protocol;
@@ -148,7 +149,7 @@
 }
 
 struct pnp_fixup {
-	char id[7];
+	char id[PNP_ID_LEN];
 	void (*quirk_function)(struct pnp_dev *dev);	/* fixup function */
 };
 
@@ -180,20 +181,20 @@
  */
 
 struct pnp_id {
-	char id[7];
+	char id[PNP_ID_LEN];
 	struct pnp_id * next;
 };
 
 struct pnp_device_id {
-	char id[7];
+	char id[PNP_ID_LEN];
 	unsigned long driver_data;	/* data private to the driver */
 };
 
 struct pnp_card_device_id {
-	char id[7];
+	char id[PNP_ID_LEN];
 	unsigned long driver_data;	/* data private to the driver */
 	struct {
-		char id[7];
+		char id[PNP_ID_LEN];
 	} devs[MAX_DEVICES];		/* logical devices */
 };
 


> And next:
> if probe function fails for some reasons. PnP layer does not do all clean
> ups as i think. Because just after it I do the same command and ko loads
> with oops. Some points on it:

Could you please give me more details on this, such as what driver you are
using.

>    1) pnpc_driver has been registered, but after drv->probe fail, it's not
> been unregistered.

Hmm, I don't think the driver should be unregistered on a probe failure, it
should be registered on a module unload.  It's the driver's job to clean
things up so it can accept another match if one comes up.

>    2) There is was some patch in 2.5.59 to driver-model that changed
> something and it's may be a reason, I don't know exactly. 

A lot of things have changed, I'll take a look.

Regards,
Adam
