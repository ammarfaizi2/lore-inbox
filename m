Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266419AbUGJUdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266419AbUGJUdF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 16:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266423AbUGJUdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 16:33:04 -0400
Received: from ppps0328.hakata02.bbiq.jp ([202.226.241.201]:13710 "EHLO
	uriuri.com") by vger.kernel.org with ESMTP id S266419AbUGJUcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 16:32:39 -0400
Date: Sun, 11 Jul 2004 05:27:27 +0900 (JST)
Message-Id: <20040711.052727.607952779.shibata@luky.org>
To: stern@rowland.harvard.edu
Cc: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-usb-users] Genesys Logic and Kernel 2.4
From: Hisaaki Shibata <shibata@luky.org>
References: <20040709054435.GA31159@torres.ka0.zugschlus.de>
X-Face: (p:N+d=)]R.hGpO.WD'FWD}r"'N]'G~TQL>ZMHN6Ev":krdN|{+={]m/yqX7|9Qzu[eX[+}
 ^=d9Vr7#OCKV?ZAYq=#iG2v&fyuJZWeVwGrmTRvpcWiSTzga-$8/W\XR"r]63S56VQ@[8w}/;iq)sm
 1=B_r2J$Uf~aN5@8f2Fk$Oa[wZ
X-Mailer: Mew version 2.2 on XEmacs 21.4.8 (Honest Recruiter)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I have just subscribed Linux-usb-users tonight.

I found your message
> Re: [Linux-usb-users] Genesys Logic and Kernel 2.4
on the web.

> > I have a USB-IDE-Enclosure using the buggy Genesys chipset. My system
> > has a 2.4 kernel and I cannot update soon for various reasons.

I maybe have almost the same enclosure using Genesys chip.

> I backported the 2.6 patch to 2.4.27, but I haven't tried compiling it so 
> there might be an error or two lurking.  Please try it out and tell us 
> if it works.

I tried following patch with a little change.

> --- 2.4.27/drivers/usb/storage/transport.c	Fri Jul  9 10:56:27 2004
> +++ 2.4.27-gl/drivers/usb/storage/transport.c	Fri Jul  9 11:51:14 2004
> @@ -1170,6 +1170,12 @@
>  
>  	/* if the command transfered well, then we go to the data stage */
>  	if (result == 0) {
> +
> +		/* Genesys Logic interface chips need a 100us delay between
> +		 * the command phase and the data phase */
> +		if (us->pusb_dev->descriptor.idVendor == USB_VENDOR_ID_GENESYS)
> +			udelay(100);
> +
>  		/* send/receive data payload, if there is any */
>  		if (bcb->DataTransferLength) {
>  			usb_stor_transfer(srb, us);
> --- 2.4.27/drivers/usb/storage/usb.c	Fri Jul  9 11:44:53 2004
> +++ 2.4.27-gl/drivers/usb/storage/usb.c	Fri Jul  9 11:49:44 2004
> @@ -996,6 +996,15 @@
>  		 */
>  		(struct us_data *)ss->htmplt.proc_dir = ss; 
>  
> +		/* According to the technical support people at Genesys Logic,
> +		 * devices using their chips have problems transferring more
> +		 * than 32 KB at a time.  In practice people have found that
> +		 * 64 KB works okay and that's what Windows does.  But we'll
> +		 * be conservative.
> +		 */
> +		if (ss->pusb_dev->descriptor.idVendor == USB_VENDOR_ID_GENESYS)
> +			ss->htmplt->max_sectors = 64;

+			ss->htmplt.max_sectors = 64;

> +
>  		/* Just before we start our control thread, initialize
>  		 * the device if it needs initialization */
>  		if (unusual_dev && unusual_dev->initFunction)
> --- 2.4.27/drivers/usb/storage/usb.h	Fri Jul  9 10:56:03 2004
> +++ 2.4.27-gl/drivers/usb/storage/usb.h	Fri Jul  9 11:45:49 2004
> @@ -193,4 +193,7 @@
>  /* Function to fill an inquiry response. See usb.c for details */
>  extern void fill_inquiry_response(struct us_data *us,
>  	unsigned char *data, unsigned int data_len);
> +
> +/* Vendor ID list for devices that require special handling */
> +#define USB_VENDOR_ID_GENESYS		0x05e3	/* Genesys Logic */
>  #endif

Before I patched the kernel, I met many errors and hangups
with big files writing into the enclosure.

After with your patch, It works fine for me.

My kernel is linux-2.4.27-rc3 with video4linux2 patch.
HDD in the enclosure is HGST Deskstar 7K250.

Just a report.

Best Regards,
Hisaaki Shibata

-- 
 WWWWW  shibata@luky.org
 |O-O|  SHIBATA,Hisaaki @ Fukuoka-shi, JAPAN
0( ^ )0 http://his.luky.org/
   ~    http://hoop.euqset.org/        IRC: #luky
