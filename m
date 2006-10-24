Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbWJXOKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWJXOKG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 10:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbWJXOKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 10:10:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:25164 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030335AbWJXOKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 10:10:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=l4MMa3uZJLT1fVmn0rILcUgMRWStn04NlCf/+pHHJg8vT/RME6Z/NV3Rw81GKZr6EGGI6kpZA6jRknxwC7cZem8t/1tu8fr0+rbnXcTWC6/6BSLhNAw8jPVaMmMrNVsFQCDcaVLq5nKfsQK5ayVWDPYZtowt+k3fWAsyvXTVCqc=
Message-ID: <f46018bb0610240709y203d8cdbw95cdf66db23aa1ce@mail.gmail.com>
Date: Tue, 24 Oct 2006 10:09:59 -0400
From: "Holden Karau" <holden@pigscanfly.ca>
To: "Daniel Drake" <dsd@gentoo.org>
Subject: Re: [PATCH] wireless-2.6 zd1211rw check against regulatory domain rather than hardcoded value of 11
Cc: zd1211-devs@lists.sourceforge.net, linville@tuxdriver.com,
       netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
       holdenk@xandros.com, "Ulrich Kunitz" <kune@deine-taler.de>
In-Reply-To: <453D48E5.8040100@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f46018bb0610231121s4fb48f88l28a6e7d4f31d40bb@mail.gmail.com>
	 <453D48E5.8040100@gentoo.org>
X-Google-Sender-Auth: d5f4e4ea1dafd3e1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've changed the patch based on your suggestions :-)
Hopefully my mailer doesn't eat the tabs this time, if it does I've
put the patch up at
http://www.holdenkarau.com/~holden/projects/zd1211rw/zd1211rw-use-geo-for-channels-r2.patch

On 10/23/06, Daniel Drake <dsd@gentoo.org> wrote:
> Holden Karau wrote:
> > From: Holden Karau <holden@pigscanfly.ca> http://www.holdenkarau.com
> >
> > I have made a small patch for the zd1211rw driver which uses the
> > boundry channels of the regulatory domain, rather than the hard coded
> > values of 1 & 11.
> > Signed-off-by: Holden Karau <holden@pigscanfly.ca>
> > http://www.holdenkarau.com
>
> Thanks for the patch! Please always look up the MAINTAINERS entry for
> the code you are modifying and CC the developers on patches.
>
I looked at the mainteners file, but the zd1211rw website (
http://zd1211.ath.cx/wiki/DriverRewrite ) says not to e-mail you guys
directly, rather use the mailing list.
> Comments below, all minor points.
>
> > I'm not entirely sure how useful this patch is, but it seems like a
> > good idea. If its totally misguided, let me know :-) In case the patch
> > gets mangled I've put it up at
> > http://www.holdenkarau.com/~holden/projects/zd1211rw/zd1211rw-use-geo-for-channels.patch
>
> Your mailer ate tabs and wrapped long lines. You're going to need to fix
> that.
>
whoops. Sorry about that.
> > --- a/drivers/net/wireless/zd1211rw/zd_chip.c    2006-10-23
> > 10:07:39.000000000 -0400
> > +++ b/drivers/net/wireless/zd1211rw/zd_chip.c    2006-10-23
> > 10:41:51.000000000 -0400
> > @@ -38,6 +38,8 @@ void zd_chip_init(struct zd_chip *chip,
> >     mutex_init(&chip->mutex);
> >     zd_usb_init(&chip->usb, netdev, intf);
> >     zd_rf_init(&chip->rf);
> > +    /* The chip needs to know which geo it is in */
> > +    chip->geo =
> > ieee80211_get_geo(zd_mac_to_ieee80211(zd_netdev_mac(netdev)));
>
> There is no need to store a geo reference here. You can use
> zd_chip_to_mac() to go from chip to mac, then mac-to-ieee80211 is easy.
>
That is much cleaner. Thanks :-)
> > }
> >
> > void zd_chip_clear(struct zd_chip *chip)
> > @@ -606,14 +608,17 @@ static int patch_6m_band_edge(struct zd_
> >         { CR128, 0x14 }, { CR129, 0x12 }, { CR130, 0x10 },
> >         { CR47,  0x1e },
> >     };
> > +    struct ieee80211_geo *geo = chip->geo;
> >
> >     if (!chip->patch_6m_band_edge || !chip->rf.patch_6m_band_edge)
> >         return 0;
> >
> > -    /* FIXME: Channel 11 is not the edge for all regulatory domains. */
> > -    if (channel == 1 || channel == 11)
> > +    /* Checks the channel boundry of the region */
> > +    dev_dbg_f("checking boundry == %d || %d\n" , 1 , geo->bg_channels);
> > +    if (channel == 1 || channel == geo->bg_channels)
>
> Typo, you mean boundary. Also, I think the debug message can go once
> you're confident it's working correctly.
>
> >         ioreqs[0].value = 0x12;
> >
> > +
>
> This added line could go as well.
>
> >     dev_dbg_f(zd_chip_dev(chip), "patching for channel %d\n", channel);
> >     return zd_iowrite16a_locked(chip, ioreqs, ARRAY_SIZE(ioreqs));
> > }
>
> I think that after the above changes, your modifications to zd_chip.h
> can be removed.
Yup. Much cleaner :-)
>
> > --- a/drivers/net/wireless/zd1211rw/zd_chip.h    2006-10-23
> > 10:07:39.000000000 -0400
> > +++ b/drivers/net/wireless/zd1211rw/zd_chip.h    2006-10-23
> > 10:39:08.000000000 -0400
> > @@ -21,6 +21,8 @@
> > #include "zd_types.h"
> > #include "zd_rf.h"
> > #include "zd_usb.h"
> > +#include "zd_ieee80211.h"
> > +#include <linux/wireless.h>
> >
> > /* Header for the Media Access Controller (MAC) and the Baseband Processor
> >  * (BBP). It appears that the ZD1211 wraps the old ZD1205 with USB glue and
> > @@ -669,6 +671,7 @@ struct zd_chip {
> >     /* SetPointOFDM in the vendor driver */
> >     u8 ofdm_cal_values[3][E2P_CHANNEL_COUNT];
> >     u16 link_led;
> > +      struct ieee80211_geo* geo;
> >     unsigned int pa_type:4,
> >         patch_cck_gain:1, patch_cr157:1, patch_6m_band_edge:1,
> >         new_phy_layout:1,
> > -
> > To unsubscribe from this list: send the line "unsubscribe netdev" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
The new patch :
--- a/wireless-2.6/drivers/net/wireless/zd1211rw/zd_chip.c	2006-10-23
10:07:39.000000000 -0400
+++ b/wireless-2.6/drivers/net/wireless/zd1211rw/zd_chip.c	2006-10-24
09:39:10.000000000 -0400
@@ -606,12 +606,13 @@ static int patch_6m_band_edge(struct zd_
 		{ CR128, 0x14 }, { CR129, 0x12 }, { CR130, 0x10 },
 		{ CR47,  0x1e },
 	};
+	struct ieee80211_geo *geo =
ieee80211_get_geo(zd_mac_to_ieee80211(zd_chip_to_mac(chip)));

 	if (!chip->patch_6m_band_edge || !chip->rf.patch_6m_band_edge)
 		return 0;

-	/* FIXME: Channel 11 is not the edge for all regulatory domains. */
-	if (channel == 1 || channel == 11)
+	/* Checks the channel boundary of the region */
+	 if (channel == 1 || channel == geo->bg_channels)
 		ioreqs[0].value = 0x12;

 	dev_dbg_f(zd_chip_dev(chip), "patching for channel %d\n", channel);
