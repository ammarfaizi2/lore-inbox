Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288741AbSADT4w>; Fri, 4 Jan 2002 14:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288738AbSADT4r>; Fri, 4 Jan 2002 14:56:47 -0500
Received: from goliath.siemens.de ([194.138.37.131]:2780 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S288735AbSADT4g>; Fri, 4 Jan 2002 14:56:36 -0500
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Thomas Hood <jdthood@mail.com>, rmk@arm.linux.org.uk,
        linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: APM driver patch summary
In-Reply-To: <XFMail.20011222154452.ast@domdv.de>
In-Reply-To: <XFMail.20011222154452.ast@domdv.de>
Content-Type: multipart/mixed; boundary="=-jJdFQ6iOPH30owdnsTxY"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 04 Jan 2002 22:56:18 +0300
Message-Id: <1010174181.2530.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jJdFQ6iOPH30owdnsTxY
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: quoted-printable

Sorry for the delay, I was off before New Year and then could not test
it ...


On =F3=C2=D4, 2001-12-22 at 17:44, Andreas Steinmetz wrote:
> Hi,
> I merged 2., 3. and 4. (attached) with some modifications.
>=20
> 1. There is now a module parameter apm-idle-threshold which allows to =
override
>    the compiled in idle percentage threshold above which BIOS idle =
calls are
>    done.
>=20
> 2. I modified Andrej's mechanism to detect a defunct BIOS (stating =
'does stop
>    CPU' when it actually doesn't) to take into account that there's =
other
>    interrupts than the timer interrupt that could reactivate the cpu.
>    As there's 16 hardware interrupts on x86 (apm is arch specific =
anyway) I do
>    use a leaky bucket counter for a maximum of 16 idle rounds until =
jiffies is
>    increased. When the counter reaches zero it stays at this value =
and the
>    system idle routine is called. If BIOS idle is a noop then the =
counter
>    reaches zero fast, thus effectively halting the cpu.
>=20

I do not think you need it. Either interrupt waked up somebody and set
need_resched and we exit loop or nobody is ready to run and we can =
sleep
again. Why complicate things any more than needed?=20

> Andrej, could you please test the patch if it works for your laptop?
>=20

It does not work and I am very surprised it works for somebody (well,
there are conditios when it will work). By default pm_idle is always
NULL so we *never* actually call kernel function that really stops CPU.
Main idle task is cpu_idle that does

if (pm_idle)
   pm_idle()
or
   default_idle

and CPU is halted in default_idle. So your patch just enters busy loop
calling BIOS APM Idle over and over again just like it was before.

Attached patch makes apm_cpu_idle do the same and call either old
pm_idle (a.k.a. sys_idle) or default_idle. I removed your interrupt
handling - it does not actually affect the problem but it still is not
needed IMHO. t1, t2 are changed from int into long because jiffies is
long - not sure if it is really needed.

cheers and sorry for delay

-andrej




--=-jJdFQ6iOPH30owdnsTxY
Content-Disposition: attachment; filename=apm.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-diff; charset=KOI8-R

--- linux-2.4.16-9mdk/arch/i386/kernel/apm.c.combined	Sun Dec 23 =
22:15:43 2001
+++ linux-2.4.16-9mdk/arch/i386/kernel/apm.c	Fri Jan  4 22:26:09 2002
@@ -761,6 +761,7 @@
 static void (*sys_idle)(void);
 static unsigned int last_jiffies =3D 0;
 static unsigned int last_stime =3D 0;
+extern void default_idle(void);
=20
 /**
  * apm_cpu_idle		-	cpu idling for APM capable Linux
@@ -774,8 +775,8 @@
 {
 	static int use_apm_idle =3D 0;
 	int apm_is_idle =3D 0;
-	unsigned int t1 =3D jiffies - last_jiffies;
-	unsigned int t2;
+	unsigned long t1 =3D jiffies - last_jiffies;
+	unsigned long t2;
=20
 recalc:	if(t1 > IDLE_CALC_LIMIT)
 		goto reset;
@@ -799,15 +800,8 @@
 			t1 =3D jiffies;
 			switch (apm_do_idle()) {
 			case 0:	apm_is_idle =3D 1;
-				if (t1 !=3D jiffies) {
-					if (t2) {
-						t2 =3D IDLE_LEAKY_MAX;
-						continue;
-					}
-				} else if (t2) {
-					t2--;
+				if (t1 !=3D jiffies)
 					continue;
-				}
 				break;
 			case 1:	apm_is_idle =3D 1;
 				break;
@@ -816,6 +810,8 @@
=20
 		if (sys_idle)
 			sys_idle();
+		else
+		    default_idle();
=20
 		t1 =3D jiffies - last_jiffies;
 		if (t1 > HARD_IDLE_TIMEOUT)
--- linux-2.4.16-9mdk/arch/i386/kernel/process.c.org	Thu Dec 13 =
13:12:46 2001
+++ linux-2.4.16-9mdk/arch/i386/kernel/process.c	Fri Jan  4 22:24:47 =
2002
@@ -77,8 +77,10 @@
 /*
  * We use this if we don't have any better
  * idle routine..
+ * It is also called from apm_cpu_idle if BIOS does not stop clock
+ * for us
  */
-static void default_idle(void)
+void default_idle(void)
 {
 	if (current_cpu_data.hlt_works_ok && !hlt_counter) {
 		__cli();

--=-jJdFQ6iOPH30owdnsTxY--
