Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVEYGaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVEYGaH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 02:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbVEYGaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 02:30:07 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:12714 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262294AbVEYG3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 02:29:34 -0400
Date: Wed, 25 May 2005 16:29:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
       Linus <torvalds@osdl.org>
Subject: [PATCH] ppc64 iSeries: fix boot time setting
Message-Id: <20050525162926.7691bb34.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__25_May_2005_16_29_26_+1000_rne/IGnyExwuEf06"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__25_May_2005_16_29_26_+1000_rne/IGnyExwuEf06
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

For quite a while, there has existed a hypervisor bug on legacy iSeries
which means that we do not get the boot time set in the kernel.  This
patch works around that bug.  This was most noticable when the root
partition needed to be checked at every boot as the kernel thought it was
some time in 1905 until user mode reset the time correctly.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/ppc64/kernel/mf.c         |   85 +++++++++++++++++++++++++++++++-----=
-----
 arch/ppc64/kernel/rtc.c        |   39 ------------------
 include/asm-ppc64/iSeries/mf.h |    1
 3 files changed, 67 insertions(+), 58 deletions(-)

Please apply and send to Linus.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus-clock.1/arch/ppc64/kernel/mf.c linus-clock.2/arch/ppc64/ke=
rnel/mf.c
--- linus-clock.1/arch/ppc64/kernel/mf.c	2005-05-17 09:23:07.000000000 +1000
+++ linus-clock.2/arch/ppc64/kernel/mf.c	2005-05-25 14:44:14.000000000 +1000
@@ -1,7 +1,7 @@
 /*
   * mf.c
   * Copyright (C) 2001 Troy D. Armstrong  IBM Corporation
-  * Copyright (C) 2004 Stephen Rothwell  IBM Corporation
+  * Copyright (C) 2004-2005 Stephen Rothwell  IBM Corporation
   *
   * This modules exists as an interface between a Linux secondary partition
   * running on an iSeries and the primary partition's Virtual Service
@@ -36,10 +36,12 @@
=20
 #include <asm/time.h>
 #include <asm/uaccess.h>
+#include <asm/paca.h>
 #include <asm/iSeries/vio.h>
 #include <asm/iSeries/mf.h>
 #include <asm/iSeries/HvLpConfig.h>
 #include <asm/iSeries/ItSpCommArea.h>
+#include <asm/iSeries/ItLpQueue.h>
=20
 /*
  * This is the structure layout for the Machine Facilites LPAR event
@@ -696,36 +698,23 @@ static void get_rtc_time_complete(void *
 	complete(&rtc->com);
 }
=20
-int mf_get_rtc(struct rtc_time *tm)
+static int rtc_set_tm(int rc, u8 *ce_msg, struct rtc_time *tm)
 {
-	struct ce_msg_comp_data ce_complete;
-	struct rtc_time_data rtc_data;
-	int rc;
-
-	memset(&ce_complete, 0, sizeof(ce_complete));
-	memset(&rtc_data, 0, sizeof(rtc_data));
-	init_completion(&rtc_data.com);
-	ce_complete.handler =3D &get_rtc_time_complete;
-	ce_complete.token =3D &rtc_data;
-	rc =3D signal_ce_msg_simple(0x40, &ce_complete);
-	if (rc)
-		return rc;
-	wait_for_completion(&rtc_data.com);
 	tm->tm_wday =3D 0;
 	tm->tm_yday =3D 0;
 	tm->tm_isdst =3D 0;
-	if (rtc_data.rc) {
+	if (rc) {
 		tm->tm_sec =3D 0;
 		tm->tm_min =3D 0;
 		tm->tm_hour =3D 0;
 		tm->tm_mday =3D 15;
 		tm->tm_mon =3D 5;
 		tm->tm_year =3D 52;
-		return rtc_data.rc;
+		return rc;
 	}
=20
-	if ((rtc_data.ce_msg.ce_msg[2] =3D=3D 0xa9) ||
-	    (rtc_data.ce_msg.ce_msg[2] =3D=3D 0xaf)) {
+	if ((ce_msg[2] =3D=3D 0xa9) ||
+	    (ce_msg[2] =3D=3D 0xaf)) {
 		/* TOD clock is not set */
 		tm->tm_sec =3D 1;
 		tm->tm_min =3D 1;
@@ -736,7 +725,6 @@ int mf_get_rtc(struct rtc_time *tm)
 		mf_set_rtc(tm);
 	}
 	{
-		u8 *ce_msg =3D rtc_data.ce_msg.ce_msg;
 		u8 year =3D ce_msg[5];
 		u8 sec =3D ce_msg[6];
 		u8 min =3D ce_msg[7];
@@ -765,6 +753,63 @@ int mf_get_rtc(struct rtc_time *tm)
 	return 0;
 }
=20
+int mf_get_rtc(struct rtc_time *tm)
+{
+	struct ce_msg_comp_data ce_complete;
+	struct rtc_time_data rtc_data;
+	int rc;
+
+	memset(&ce_complete, 0, sizeof(ce_complete));
+	memset(&rtc_data, 0, sizeof(rtc_data));
+	init_completion(&rtc_data.com);
+	ce_complete.handler =3D &get_rtc_time_complete;
+	ce_complete.token =3D &rtc_data;
+	rc =3D signal_ce_msg_simple(0x40, &ce_complete);
+	if (rc)
+		return rc;
+	wait_for_completion(&rtc_data.com);
+	return rtc_set_tm(rtc_data.rc, rtc_data.ce_msg.ce_msg, tm);
+}
+
+struct boot_rtc_time_data {
+	int busy;
+	struct ce_msg_data ce_msg;
+	int rc;
+};
+
+static void get_boot_rtc_time_complete(void *token, struct ce_msg_data *ce=
_msg)
+{
+	struct boot_rtc_time_data *rtc =3D token;
+
+	memcpy(&rtc->ce_msg, ce_msg, sizeof(rtc->ce_msg));
+	rtc->rc =3D 0;
+	rtc->busy =3D 0;
+}
+
+int mf_get_boot_rtc(struct rtc_time *tm)
+{
+	struct ce_msg_comp_data ce_complete;
+	struct boot_rtc_time_data rtc_data;
+	int rc;
+
+	memset(&ce_complete, 0, sizeof(ce_complete));
+	memset(&rtc_data, 0, sizeof(rtc_data));
+	rtc_data.busy =3D 1;
+	ce_complete.handler =3D &get_boot_rtc_time_complete;
+	ce_complete.token =3D &rtc_data;
+	rc =3D signal_ce_msg_simple(0x40, &ce_complete);
+	if (rc)
+		return rc;
+	/* We need to poll here as we are not yet taking interrupts */
+	while (rtc_data.busy) {
+		extern unsigned long lpevent_count;
+		struct ItLpQueue *lpq =3D get_paca()->lpqueue_ptr;
+		if (lpq && ItLpQueue_isLpIntPending(lpq))
+			lpevent_count +=3D ItLpQueue_process(lpq, NULL);
+	}
+	return rtc_set_tm(rtc_data.rc, rtc_data.ce_msg.ce_msg, tm);
+}
+
 int mf_set_rtc(struct rtc_time *tm)
 {
 	char ce_time[12];
diff -ruNp linus-clock.1/arch/ppc64/kernel/rtc.c linus-clock.2/arch/ppc64/k=
ernel/rtc.c
--- linus-clock.1/arch/ppc64/kernel/rtc.c	2005-05-17 09:23:08.000000000 +10=
00
+++ linus-clock.2/arch/ppc64/kernel/rtc.c	2005-05-25 13:59:16.000000000 +10=
00
@@ -292,47 +292,10 @@ int iSeries_set_rtc_time(struct rtc_time
=20
 void iSeries_get_boot_time(struct rtc_time *tm)
 {
-	unsigned long time;
-	static unsigned long lastsec =3D 1;
-
-	u32 dataWord1 =3D *((u32 *)(&xSpCommArea.xBcdTimeAtIplStart));
-	u32 dataWord2 =3D *(((u32 *)&(xSpCommArea.xBcdTimeAtIplStart)) + 1);
-	int year =3D 1970;
-	int year1 =3D ( dataWord1 >> 24 ) & 0x000000FF;
-	int year2 =3D ( dataWord1 >> 16 ) & 0x000000FF;
-	int sec =3D ( dataWord1 >> 8 ) & 0x000000FF;
-	int min =3D dataWord1 & 0x000000FF;
-	int hour =3D ( dataWord2 >> 24 ) & 0x000000FF;
-	int day =3D ( dataWord2 >> 8 ) & 0x000000FF;
-	int mon =3D dataWord2 & 0x000000FF;
-
 	if ( piranha_simulator )
 		return;
=20
-	BCD_TO_BIN(sec);
-	BCD_TO_BIN(min);
-	BCD_TO_BIN(hour);
-	BCD_TO_BIN(day);
-	BCD_TO_BIN(mon);
-	BCD_TO_BIN(year1);
-	BCD_TO_BIN(year2);
-	year =3D year1 * 100 + year2;
-
-	time =3D mktime(year, mon, day, hour, min, sec);
-	time +=3D ( jiffies / HZ );
-
-	/* Now THIS is a nasty hack!
-	* It ensures that the first two calls get different answers. =20
-	* That way the loop in init_time (time.c) will not think
-	* the clock is stuck.
-	*/
-	if ( lastsec ) {
-		time -=3D lastsec;
-		--lastsec;
-	}
-
-	to_tm(time, tm);=20
-	tm->tm_year -=3D 1900;
+	mf_get_boot_rtc(tm);
 	tm->tm_mon  -=3D 1;
 }
 #endif
diff -ruNp linus-clock.1/include/asm-ppc64/iSeries/mf.h linus-clock.2/inclu=
de/asm-ppc64/iSeries/mf.h
--- linus-clock.1/include/asm-ppc64/iSeries/mf.h	2005-05-17 09:25:49.000000=
000 +1000
+++ linus-clock.2/include/asm-ppc64/iSeries/mf.h	2005-05-25 14:12:40.000000=
000 +1000
@@ -52,6 +52,7 @@ extern void mf_clear_src(void);
 extern void mf_init(void);
=20
 extern int mf_get_rtc(struct rtc_time *tm);
+extern int mf_get_boot_rtc(struct rtc_time *tm);
 extern int mf_set_rtc(struct rtc_time *tm);
=20
 #endif /* _ASM_PPC64_ISERIES_MF_H */

--Signature=_Wed__25_May_2005_16_29_26_+1000_rne/IGnyExwuEf06
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFClBtG4CJfqux9a+8RArI1AJ9Ju/IzuDeL37zLlB15IcDek3TZTQCdFK/V
+FgduJsY2yitOv2rOpD/aLk=
=leYw
-----END PGP SIGNATURE-----

--Signature=_Wed__25_May_2005_16_29_26_+1000_rne/IGnyExwuEf06--
