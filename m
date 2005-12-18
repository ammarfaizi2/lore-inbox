Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932578AbVLRWfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbVLRWfv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 17:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965289AbVLRWfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 17:35:51 -0500
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:48310 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932578AbVLRWfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 17:35:50 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 No Idle HZ aka dynticks 051217
Date: Mon, 19 Dec 2005 09:34:47 +1100
User-Agent: KMail/1.9
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Pavel Machek <pavel@ucw.cz>, Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
References: <200512190219.40631.kernel@kolivas.org> <200512190222.40399.kernel@kolivas.org>
In-Reply-To: <200512190222.40399.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart113498526.IqPq9zWcjC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512190934.51210.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart113498526.IqPq9zWcjC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 19 December 2005 02:22, Con Kolivas wrote:
> On Monday 19 December 2005 02:19, Con Kolivas wrote:
> > Here is yet another updated version of the dynticks code.
> >
> > Changes:
> >
> > Numerous cleanups, microoptimisations and locking improvements.
> >
> > One bugfix for the next tick accounting used in early_dyn_reprogram
> >
> > I've yet to find the cause for grossly high cpu accounting on SMP. I'd
> > appreciate any help in this area as it's the last showstopper for this
> > code.
> >
> > Obvious power savings are evident on uniprocessor now in on/off
> > comparisons using pmstats.
>
> That would be dynticks-051218 I mean, sorry.

Oops, wrong locking order may cause a livelock so this patch will be needed.

Uploaded a 051218-1 patch to website with this bug fix.

http://ck.kolivas.org/patches/dyn-ticks/

Cheers,
Con

=2D--
 arch/i386/kernel/dyn-tick.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

Index: linux-2.6.15-rc5-dt/arch/i386/kernel/dyn-tick.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/arch/i386/kernel/dyn-tick.c
+++ linux-2.6.15-rc5-dt/arch/i386/kernel/dyn-tick.c
@@ -126,16 +126,14 @@ static void do_dyn_tick_interrupt(struct
 {
 	int cpu =3D smp_processor_id();
=20
+	write_seqlock(&xtime_lock);
 	spin_lock(&dyn_tick->lock);
 	if (cpus_equal(nohz_cpu_mask, cpu_online_map)) {
 		/* All were sleeping, recover jiffies */
 		int lost =3D cur_timer->mark_offset();
=20
=2D		if (lost && in_irq()) {
=2D			write_seqlock(&xtime_lock);
+		if (lost && in_irq())
 			do_timer(regs);
=2D			write_sequnlock(&xtime_lock);
=2D		}
 		if (dyntick_using_lapic()) {
 			enable_pit_timer();
 			if (unlikely(lost > DYN_TICK_MAX_SKIP + 1))
@@ -145,6 +143,7 @@ static void do_dyn_tick_interrupt(struct
 	}
 	clear_nohz_cpu(cpu);
 	spin_unlock(&dyn_tick->lock);
+	write_sequnlock(&xtime_lock);
=20
 	/* Make sure we don't miss the next timer tick */
 	dyn_early_reprogram(1);

--nextPart113498526.IqPq9zWcjC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDpeQLZUg7+tp6mRURAokMAJ9dlT52u9RDXhgdwwecFiqeQ0oAKQCfW8Y1
Sqn1sqfk5x6tCn1/pCORKwQ=
=9sDW
-----END PGP SIGNATURE-----

--nextPart113498526.IqPq9zWcjC--
