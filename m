Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273364AbRJQBLI>; Tue, 16 Oct 2001 21:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273565AbRJQBKs>; Tue, 16 Oct 2001 21:10:48 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:22535 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S273364AbRJQBKl>;
	Tue, 16 Oct 2001 21:10:41 -0400
Date: Wed, 17 Oct 2001 03:11:13 +0200
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Oops in usb-storage.c
Message-ID: <20011017031113.A3072@gondor.com>
In-Reply-To: <20011017005822.A2161@gondor.com> <20011016175640.A18541@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011016175640.A18541@one-eyed-alien.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2001 at 05:56:40PM -0700, Matthew Dharm wrote:
> Actually, this is a side-effect of another problem, which is that INQUIRY
> is legal for a device at any time (at least, to SCSI).  What we really need
> to do is fake an INQURIY response for detached devices, separate from also
> those devices which need a faked-inquiry all the time.

Ok, then the fix could look like the following, I think. The INQUIRY
response in the disconnected case is a little bit different, as the
information from pusb_dev is not available, but the INQUIRY works and
the oops is fixed.

Jan


--- linux-2.4.12-ac3/drivers/usb/storage/usb.c.orig	Mon Oct  1 12:15:29 2001
+++ linux-2.4.12-ac3/drivers/usb/storage/usb.c	Wed Oct 17 03:04:32 2001
@@ -268,10 +268,12 @@
 	memcpy(data+16, us->unusual_dev->productName, 
 		strlen(us->unusual_dev->productName) > 16 ? 16 :
 		strlen(us->unusual_dev->productName));
-	data[32] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>12) & 0x0F);
-	data[33] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>8) & 0x0F);
-	data[34] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>4) & 0x0F);
-	data[35] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice) & 0x0F);
+	if(us->pusb_dev) {
+		data[32] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>12) & 0x0F);
+		data[33] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>8) & 0x0F);
+		data[34] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>4) & 0x0F);
+		data[35] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice) & 0x0F);
+	}
 
 	if (us->srb->use_sg) {
 		sg = (struct scatterlist *)us->srb->request_buffer;



