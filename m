Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131878AbRA2I0n>; Mon, 29 Jan 2001 03:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132014AbRA2I0e>; Mon, 29 Jan 2001 03:26:34 -0500
Received: from smtp4.mail.yahoo.com ([128.11.69.101]:13574 "HELO
	smtp4.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131878AbRA2I0X>; Mon, 29 Jan 2001 03:26:23 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A74D703.59578FA8@yahoo.com>
Date: Sun, 28 Jan 2001 21:35:47 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.1-pre8 i486)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@transmeta.com>
CC: root@chaos.analogic.com, Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <Pine.LNX.3.95.1010126085110.265A-100000@chaos.analogic.com> <3A71A3AE.DE587EEE@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, what you need to do is change it and then try it on something
> like 300 different systems.  Since noone has direct access to that kind
> of system, you have to get people to help you out trying it.
> 
> A better idea might be to find out what port, if any, Windows uses.  If
> Windows does it, it is usually safe.

In the FWIW category, the collection of DOS packet drivers from Russ Nelson
(and the many commercial ones based on them) use a read of the NMI status
port to create a similar delay.  This code got used on lots of hardware
(although probably not much on current hw - mostly 386/486 type vintage
stuff I'd guess...)

I'm not advocating we move off 0x80 either - but people wanting to use
POST cards have at least a couple of options.  And if they have a POST
card, it is probably a safe bet that they can manage to apply one of
the patches and rebuild the kernel.

Paul.

[Booted old 486-66 with 8390 based card (uses inb_p/outb_p) & works fine]


--- include/asm-i386/io.h~	Thu May 11 15:19:27 2000
+++ include/asm-i386/io.h	Sun Jan 28 21:10:22 2001
@@ -23,6 +23,11 @@
  * I feel a bit unsafe about using 0x80 (should be safe, though)
  *
  *		Linus
+ *
+ * Some people get upset since they can't use their POST cards
+ * for diagnostics once linux boots and hammers 0x80 with garbage.
+ * DOS packet drivers do a dummy read of the NMI status port to
+ * obtain a similar delay.			Paul G.
  */
 
  /*
@@ -32,7 +37,11 @@
 #ifdef SLOW_IO_BY_JUMPING
 #define __SLOW_DOWN_IO "\njmp 1f\n1:\tjmp 1f\n1:"
 #else
+#ifdef HAVE_POST_CARD
+#define __SLOW_DOWN_IO "\n\tpushl %%eax\n\tinb $0x61,%%al\n\tpopl %%eax"
+#else
 #define __SLOW_DOWN_IO "\noutb %%al,$0x80"
+#endif
 #endif
 
 #ifdef REALLY_SLOW_IO




_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
