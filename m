Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264498AbUEDQQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbUEDQQw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 12:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUEDQQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 12:16:52 -0400
Received: from panda.sul.com.br ([200.219.150.4]:52750 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S264498AbUEDQQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 12:16:40 -0400
Date: Tue, 4 May 2004 13:14:42 -0300
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cyclades cleanups
Message-ID: <20040504161441.GA30055@cathedrallabs.org>
References: <20040503191704.GB6434@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <20040503191704.GB6434@logos.cnet>
From: aris@cathedrallabs.org (Aristeu Sergio Rozanski Filho)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,
> diff -Nur linux-2.6.5.orig/drivers/char/cyclades.c linux-2.6.5/drivers/ch=
ar/cyclades.c
> --- linux-2.6.5.orig/drivers/char/cyclades.c	2004-05-03 15:38:58.97765912=
0 -0300
> +++ linux-2.6.5/drivers/char/cyclades.c	2004-05-03 15:48:27.348253656 -03=
00
> @@ -681,16 +681,6 @@
>  static void cy_throttle (struct tty_struct *tty);
>  static void cy_send_xchar (struct tty_struct *tty, char ch);
> =20
> -static unsigned long=20
> -cy_get_user(unsigned long *addr)
> -{
> -	unsigned long result =3D 0;
> -	int error =3D get_user (result, addr);
> -	if (error)
> -		printk ("cyclades: cy_get_user: error =3D=3D %d\n", error);
> -	return result;
> -}
> -
>  #ifndef MIN
>  #define MIN(a,b)        ((a) < (b) ? (a) : (b))
>  #endif
janitorial alarm! patch attached :)

--=20
Aristeu Sergio Rozanski Filho


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cyclades-use_kernel_h_min_macro.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.5/drivers/char/cyclades.c.old	2004-05-04 08:23:08.000000000 -=
0300
+++ linux-2.6.5/drivers/char/cyclades.c	2004-05-04 13:01:09.000000000 -0300
@@ -681,10 +681,6 @@ static char rcsid[] =3D
 static void cy_throttle (struct tty_struct *tty);
 static void cy_send_xchar (struct tty_struct *tty, char ch);
=20
-#ifndef MIN
-#define MIN(a,b)        ((a) < (b) ? (a) : (b))
-#endif
-
 #define IS_CYC_Z(card) ((card).num_chips =3D=3D -1)
=20
 #define Z_FPGA_CHECK(card) \
@@ -698,7 +694,7 @@ static void cy_send_xchar (struct tty_st
 			((card).base_addr+ID_ADDRESS))->signature)))
=20
 #ifndef SERIAL_XMIT_SIZE
-#define	SERIAL_XMIT_SIZE	(MIN(PAGE_SIZE, 4096))
+#define	SERIAL_XMIT_SIZE	(min(PAGE_SIZE, 4096))
 #endif
 #define WAKEUP_CHARS		256
=20
@@ -2670,7 +2666,7 @@ cy_wait_until_sent(struct tty_struct *tt
   unsigned char *base_addr;
   int card,chip,channel,index;
   unsigned long orig_jiffies;
-  signed long char_time;
+  int char_time;
 =09
     if (serial_paranoia_check(info, tty->name, "cy_wait_until_sent"))
 	return;
@@ -2695,7 +2691,7 @@ cy_wait_until_sent(struct tty_struct *tt
     if (timeout < 0)
 	timeout =3D 0;
     if (timeout)
-	char_time =3D MIN(char_time, timeout);
+	char_time =3D min(char_time, timeout);
     /*
      * If the transmitter hasn't cleared in twice the approximate
      * amount of time to send the entire FIFO, it probably won't
@@ -2922,8 +2918,8 @@ cy_write(struct tty_struct * tty, int fr
 	while (1) {
 	    int c1;
 	   =20
-	    c =3D MIN(count, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
-				SERIAL_XMIT_SIZE - info->xmit_head));
+	    c =3D min(count, min((int)(SERIAL_XMIT_SIZE - info->xmit_cnt - 1),
+				(int)(SERIAL_XMIT_SIZE - info->xmit_head)));
 	    if (c <=3D 0)
 		break;
=20
@@ -2935,8 +2931,8 @@ cy_write(struct tty_struct * tty, int fr
 		break;
 	    }
 	    CY_LOCK(info, flags);
-	    c1 =3D MIN(c, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
-			SERIAL_XMIT_SIZE - info->xmit_head));
+	    c1 =3D min(c, min((int)(SERIAL_XMIT_SIZE - info->xmit_cnt - 1),
+			(int)(SERIAL_XMIT_SIZE - info->xmit_head)));
 		=09
 	    if (c1 < c)
 	    	c =3D c1;
@@ -2952,8 +2948,8 @@ cy_write(struct tty_struct * tty, int fr
     } else {
 	CY_LOCK(info, flags);
 	while (1) {
-	    c =3D MIN(count, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,=20
-			SERIAL_XMIT_SIZE - info->xmit_head));
+	    c =3D min(count, min((int)(SERIAL_XMIT_SIZE - info->xmit_cnt - 1),
+			(int)(SERIAL_XMIT_SIZE - info->xmit_head)));
 	       =20
 	    if (c <=3D 0)
 		break;

--98e8jtXdkpgskNou--
