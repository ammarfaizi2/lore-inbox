Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276832AbRJPW6O>; Tue, 16 Oct 2001 18:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276840AbRJPW6E>; Tue, 16 Oct 2001 18:58:04 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:2311 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S276832AbRJPW5z>;
	Tue, 16 Oct 2001 18:57:55 -0400
Date: Wed, 17 Oct 2001 00:58:22 +0200
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Cc: mdharm-usb@one-eyed-alien.net
Subject: [PATCH] Oops in usb-storage.c
Message-ID: <20011017005822.A2161@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

usb-storage.c oopses in fill_inquiry_response if I send an INQUIRY
to device which is currently disconnected from the USB bus.

This happens because fill_inquiry_response is called outside a
check for us->pusb_dev. Moving the special case into the if() 
block, the oops is fixed.

(For reference, the oops is below the patch)

Jan

--- linux-2.4.12-ac3/drivers/usb/storage/usb.c.orig	Mon Oct  1 12:15:29 2001
+++ linux-2.4.12-ac3/drivers/usb/storage/usb.c	Wed Oct 17 00:33:22 2001
@@ -389,24 +389,6 @@
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
 
@@ -423,15 +405,30 @@
 					       sizeof(usb_stor_sense_notready));
 					us->srb->result = GOOD << 1;
 				} else {
+					memset(us->srb->request_buffer, 0, us->srb->request_bufflen);
 					memcpy(us->srb->sense_buffer, 
 					       usb_stor_sense_notready, 
 					       sizeof(usb_stor_sense_notready));
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




Oct 16 21:07:28 sirith kernel: Oops: 0000
Oct 16 21:07:28 sirith kernel: CPU:    0
Oct 16 21:07:28 sirith kernel: EIP:    0010:[<e4951766>]    Tainted: P 
Oct 16 21:07:28 sirith kernel: EFLAGS: 00010246
Oct 16 21:07:28 sirith kernel: eax: 00000000   ebx: dc636600   ecx: 00000000   edx: 00000010
Oct 16 21:07:28 sirith kernel: esi: e495d460   edi: d9f09fcc   ebp: e495d450   esp: d9f09f7c
Oct 16 21:07:28 sirith kernel: ds: 0018   es: 0018   ss: 0018
Oct 16 21:07:28 sirith kernel: Process usb-storage-0 (pid: 766, stackpage=d9f09000)
Oct 16 21:07:28 sirith kernel: Stack: d9f08000 e495da91 d9f09ff0 dc636600 c0116373 c02955a7 00000005 c01162c4 
Oct 16 21:07:28 sirith kernel:        d9f08000 e4951b44 dc636600 d9f09fcc 00000024 e495daa0 00000100 da003dcc 
Oct 16 21:07:28 sirith kernel:        dc636600 dc636600 dc636604 00000001 02028000 0000001f 69736143 0000006f 
Oct 16 21:07:28 sirith kernel: Call Trace: [<e495da91>] [release_console_sem+115/128] [printk+260/272] [<e4951b44>] [<e495daa0>] 
Oct 16 21:07:28 sirith kernel: Code: 0f b7 80 cc 00 00 00 66 c1 e8 0c 0c 30 88 47 20 8b 43 18 8a 

>>EIP; e4951766 <[usb-storage]fill_inquiry_response+116/2f0>   <=====
Trace; e495da90 <[usb-storage]__module_usb_device_size+670/81be>
Code;  e4951766 <[usb-storage]fill_inquiry_response+116/2f0>
00000000 <_EIP>:
Code;  e4951766 <[usb-storage]fill_inquiry_response+116/2f0>   <=====
   0:   0f b7 80 cc 00 00 00      movzwl 0xcc(%eax),%eax   <=====
Code;  e495176c <[usb-storage]fill_inquiry_response+11c/2f0>
   7:   66 c1 e8 0c               shr    $0xc,%ax
Code;  e4951770 <[usb-storage]fill_inquiry_response+120/2f0>
   b:   0c 30                     or     $0x30,%al
Code;  e4951772 <[usb-storage]fill_inquiry_response+122/2f0>
   d:   88 47 20                  mov    %al,0x20(%edi)
Code;  e4951776 <[usb-storage]fill_inquiry_response+126/2f0>
  10:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  e4951778 <[usb-storage]fill_inquiry_response+128/2f0>
  13:   8a 00                     mov    (%eax),%al

