Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319312AbSHVJqY>; Thu, 22 Aug 2002 05:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319313AbSHVJqY>; Thu, 22 Aug 2002 05:46:24 -0400
Received: from ALyon-209-1-13-54.abo.wanadoo.fr ([217.128.17.54]:11961 "EHLO
	alph.dyndns.org") by vger.kernel.org with ESMTP id <S319312AbSHVJqX>;
	Thu, 22 Aug 2002 05:46:23 -0400
Subject: [PATCH]: fix 32bits integer overflow in loops_per_jiffy calculation
From: Yoann Vandoorselaere <yoann@prelude-ids.org>
To: cpufreq@lists.arm.linux.org
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org,
       "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Content-Type: multipart/mixed; boundary="=-gG50E+/VVPeXiE/jq6T6"
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Aug 2002 11:50:40 +0200
Message-Id: <1030009840.15429.109.camel@alph>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gG50E+/VVPeXiE/jq6T6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

The "low_part * mult" multiplication of the old function may overflow a
32bits integer...

This patch both fix the overflow issue (tested with frequencies up to
20Ghz), and make the result of the function lose less precision.

Please apply, 

-- 
Yoann Vandoorselaere, http://www.prelude-ids.org

"Programming is a race between programmers, who try and make more and 
 more idiot-proof software, and universe, which produces more and more 
 remarkable idiots. Until now, universe leads the race"  -- R. Cook

--=-gG50E+/VVPeXiE/jq6T6
Content-Disposition: attachment; filename=cpufreq-overflow.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=cpufreq-overflow.diff; charset=ISO-8859-1

--- linux-benh/kernel/cpufreq.c	2002-08-21 17:27:52.000000000 +0200
+++ linux-yoann/kernel/cpufreq.c	2002-08-22 11:27:09.000000000 +0200
@@ -78,14 +78,16 @@ static unsigned int             cpufreq_
  */
 static unsigned long scale(unsigned long old, u_int div, u_int mult)
 {
-	unsigned long low_part, high_part;
-
-	high_part  =3D old / div;
-	low_part   =3D (old % div) / 100;
-	high_part *=3D mult;
-	low_part   =3D low_part * mult / div;
-
-	return high_part + low_part * 100;
+        unsigned long val, carry =3D 0;
+       =20
+        mult /=3D 100;
+        div  /=3D 100;
+        val =3D old / div * mult;
+
+        carry =3D old % div;
+        carry =3D carry * mult / div;
+               =20
+        return val + carry;
 }
=20
=20

--=-gG50E+/VVPeXiE/jq6T6--

