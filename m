Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266911AbRGQSu2>; Tue, 17 Jul 2001 14:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266913AbRGQSuI>; Tue, 17 Jul 2001 14:50:08 -0400
Received: from mail.altsoftware.com ([216.191.138.67]:59402 "EHLO
	mail.altsoftware.com") by vger.kernel.org with ESMTP
	id <S266911AbRGQSt4>; Tue, 17 Jul 2001 14:49:56 -0400
Message-ID: <007401c10ef1$3f317e80$7102a8c0@altsoftware.com>
From: "Jason McCarty" <mccartyj@altsoftware.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Linus Torvalds" <torvalds@transmeta.com>
Subject: [PATCH] linux/drivers/char/pc_keyb.c patch please
Date: Tue, 17 Jul 2001 14:49:44 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0071_01C10ECF.B7B38820"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0071_01C10ECF.B7B38820
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I think a change is needed in pc_keyb.c.
5 lines should be removed because they consume valid data.

patch is for linux-2.4.6/drivers/char/pc_keyb.c
kernel version 2.4.6 (also checked older kernels, they all have it)
Why this patch is needed:
because it messes up my hardware :(
Extensive testing was done on my machine and I found with lines removed my
hardware works fine in shell program and in X.

Details:

pc_keyb.c handles ps/2 input
Usually mouse sends 3 byte packets (4 bytes if wheel mouse) to ps/2 port.
1st byte is buttons/movement direction, 2nd byte is x displacement, 3rd byte
is y displacement.  The lines I want removed intercept any byte in this
packet that is 0xAA and eats it.
The reason for this is that according to ps/2 mouse specs the mouse sends
2bytes - 0xAA 0x00 after it is reset.

Why this is bad:  suppose the mouse moves170(0xAA) in the x direction (byte
2 of packet)... guess what happens?  That byte 2 is lost and the mouse is
sent an enable command.  The mouse receives that command, forgets about
whatever it was sending, and starts transmitting the next byte (which is now
the byte for the start of the next packet).  Sounds ok, except... in all
this someone
forgot to tell the driver(that was reading from /dev/psaux) that the byte 1
that it got previously is now garbage.  So the driver now reads another 2
bytes (byte 1 and 2 of next packet) and interpretes it as the bytes 2 and 3
of the previous packet, except that's wrong, and now look... your cursor
just flew half way across the screen!

This code has existed for some time due to the fact that it is extremely
difficult for a normal mouse to generate a move of 170.  But it can happen,
and with the input device i'm using, it happens often.

The simplest solution(and maybe the best) is to just remove the 5 lines of
code and let any software that reads from /dev/psaux handle the 0xAA acks
(this works fine for me, and seems fine in X).

------=_NextPart_000_0071_01C10ECF.B7B38820
Content-Type: application/octet-stream;
	name="my_patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="my_patch"

--- /home/mccartyj/linux-2.4.6/drivers/char/pc_keyb.c	Fri Apr  6 =
13:42:55 2001=0A=
+++ linux-2.4.6/drivers/char/pc_keyb.c	Tue Jul 17 13:29:45 2001=0A=
@@ -403,12 +403,13 @@=0A=
 		}=0A=
 		mouse_reply_expected =3D 0;=0A=
 	}=0A=
+#if 0=0A=
 	else if(scancode =3D=3D AUX_RECONNECT){=0A=
 		queue->head =3D queue->tail =3D 0;  /* Flush input queue */=0A=
 		__aux_write_ack(AUX_ENABLE_DEV);  /* ping the mouse :) */=0A=
 		return;=0A=
 	}=0A=
-=0A=
+#endif=0A=
 	add_mouse_randomness(scancode);=0A=
 	if (aux_count) {=0A=
 		int head =3D queue->head;=0A=

------=_NextPart_000_0071_01C10ECF.B7B38820--

