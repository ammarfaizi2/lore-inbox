Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277910AbRJRTFv>; Thu, 18 Oct 2001 15:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277975AbRJRTFn>; Thu, 18 Oct 2001 15:05:43 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:50696 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S277910AbRJRTFb>;
	Thu, 18 Oct 2001 15:05:31 -0400
Date: Thu, 18 Oct 2001 21:06:03 +0200
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Oops in usb-storage.c
Message-ID: <20011018210603.A6372@gondor.com>
In-Reply-To: <20011017005822.A2161@gondor.com> <20011016175640.A18541@one-eyed-alien.net> <20011017031113.A3072@gondor.com> <20011016183243.B18541@one-eyed-alien.net> <20011017034410.A3722@gondor.com> <20011016232452.A22978@one-eyed-alien.net> <20011017124249.A1505@gondor.com> <20011017121540.A32020@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011017121540.A32020@one-eyed-alien.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2001 at 12:15:40PM -0700, Matthew Dharm wrote:
> This looks better... but you have a dangerous memset() in an else clause --
> the request buffer pointer could be pointing to a scatter-gather list, so
> you can't just memset on it.

Ok here is an updated patch.

--- linux-2.4.12-ac3/drivers/usb/storage/usb.c.orig	Thu Oct 18 20:47:58 2001
+++ linux-2.4.12-ac3/drivers/usb/storage/usb.c	Thu Oct 18 01:06:32 2001
@@ -262,16 +262,28 @@
 	if (data_len<36) // You lose.
 		return;
 
-	memcpy(data+8, us->unusual_dev->vendorName, 
-		strlen(us->unusual_dev->vendorName) > 8 ? 8 :
-		strlen(us->unusual_dev->vendorName));
-	memcpy(data+16, us->unusual_dev->productName, 
-		strlen(us->unusual_dev->productName) > 16 ? 16 :
-		strlen(us->unusual_dev->productName));
-	data[32] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>12) & 0x0F);
-	data[33] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>8) & 0x0F);
-	data[34] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>4) & 0x0F);
-	data[35] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice) & 0x0F);
+	if(data[0]&0x20) { /* USB device currently not connected. Return
+			      peripheral qualifier 001b ("...however, the
+			      physical device is not currently connected
+			      to this logical unit") and leave vendor and
+			      product identification empty. ("If the target
+			      does store some of the INQUIRY data on the
+			      device, it may return zeros or ASCII spaces 
+			      (20h) in those fields until the data is
+			      available from the device."). */
+		memset(data+8,0,28);
+	} else {
+		memcpy(data+8, us->unusual_dev->vendorName, 
+			strlen(us->unusual_dev->vendorName) > 8 ? 8 :
+			strlen(us->unusual_dev->vendorName));
+		memcpy(data+16, us->unusual_dev->productName, 
+			strlen(us->unusual_dev->productName) > 16 ? 16 :
+			strlen(us->unusual_dev->productName));
+		data[32] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>12) & 0x0F);
+		data[33] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>8) & 0x0F);
+		data[34] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice>>4) & 0x0F);
+		data[35] = 0x30 + ((us->pusb_dev->descriptor.bcdDevice) & 0x0F);
+	}
 
 	if (us->srb->use_sg) {
 		sg = (struct scatterlist *)us->srb->request_buffer;
@@ -389,24 +401,6 @@
 				break;
 			}
 
-			/* Handle those devices which need us to fake their
-			 * inquiry data */
-			if ((us->srb->cmnd[0] == INQUIRY) &&
-			    (us->flags & US_FL_FIX_INQUIRY)) {
-			    	unsigned char data_ptr[36] = {
-				    0x00, 0x80, 0x02, 0x02,
-				    0x1F, 0x00, 0x00, 0x00};
-
-			    	US_DEBUGP("Faking INQUIRY command\n");
-				fill_inquiry_response(us, data_ptr, 36);
-				us->srb->result = GOOD << 1;
-
-				set_current_state(TASK_INTERRUPTIBLE);
-				us->srb->scsi_done(us->srb);
-				us->srb = NULL;
-				break;
-			}
-
 			/* lock the device pointers */
 			down(&(us->dev_semaphore));
 
@@ -422,6 +416,13 @@
 					       usb_stor_sense_notready, 
 					       sizeof(usb_stor_sense_notready));
 					us->srb->result = GOOD << 1;
+				} else if(us->srb->cmnd[0] == INQUIRY) {
+					unsigned char data_ptr[36] = {
+					    0x20, 0x80, 0x02, 0x02,
+					    0x1F, 0x00, 0x00, 0x00};
+					US_DEBUGP("Faking INQUIRY command for disconnected device\n");
+					fill_inquiry_response(us, data_ptr, 36);
+					us->srb->result = GOOD << 1;
 				} else {
 					memcpy(us->srb->sense_buffer, 
 					       usb_stor_sense_notready, 
@@ -429,9 +430,23 @@
 					us->srb->result = CHECK_CONDITION << 1;
 				}
 			} else { /* !us->pusb_dev */
-				/* we've got a command, let's do it! */
-				US_DEBUG(usb_stor_show_command(us->srb));
-				us->proto_handler(us->srb, us);
+
+				/* Handle those devices which need us to fake 
+				 * their inquiry data */
+				if ((us->srb->cmnd[0] == INQUIRY) &&
+				    (us->flags & US_FL_FIX_INQUIRY)) {
+					unsigned char data_ptr[36] = {
+					    0x00, 0x80, 0x02, 0x02,
+					    0x1F, 0x00, 0x00, 0x00};
+
+					US_DEBUGP("Faking INQUIRY command\n");
+					fill_inquiry_response(us, data_ptr, 36);
+					us->srb->result = GOOD << 1;
+				} else {
+					/* we've got a command, let's do it! */
+					US_DEBUG(usb_stor_show_command(us->srb));
+					us->proto_handler(us->srb, us);
+				}
 			}
 
 			/* unlock the device pointers */
