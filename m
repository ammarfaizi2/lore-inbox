Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbULFAeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbULFAeZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 19:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbULFAeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 19:34:24 -0500
Received: from mout2.freenet.de ([194.97.50.155]:55969 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S261436AbULFAd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 19:33:56 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: paulmck@us.ibm.com
Subject: Re: [RFC] Strange code in cpu_idle()
Date: Mon, 6 Dec 2004 01:32:35 +0100
User-Agent: KMail/1.7.1
References: <20041204231149.GA1591@us.ibm.com>
In-Reply-To: <20041204231149.GA1591@us.ibm.com>
Cc: dipankar@in.ibm.com, rusty@au1.ibm.com, ak@suse.de, gareth@valinux.com,
       davidm@hpl.hp.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2243999.IoNvx1kSFo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412060132.40912.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2243999.IoNvx1kSFo
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Paul,

Well, your mail is _very_ interresting for me.

I get this oops for weeks with several kernel versions now:

Unable to handle kernel paging request at virtual address 00099108
 printing eip:
b01010c0
*pde =3D 00000000
Oops: 0000 [#1]
SMP=20
Modules linked in: nfs lockd sunrpc nvidia ipv6 ohci_hcd tuner tvaudio msp3=
400 bttv video_buf firmware_class btcx_risc ehci_hcd uhci_hcd usbcore intel=
_agp agpgart evdev
CPU:    0
EIP:    0060:[<b01010c0>]    Tainted: P      VLI
EFLAGS: 00010286   (2.6.10-rc2-ck2-nozeroram-findvmastat)=20
EIP is at cpu_idle+0x31/0x3f
eax: 00000001   ebx: 00099100   ecx: 00000000   edx: 0000001d
esi: 00000000   edi: b03dff9c   ebp: b03dffe4   esp: b03dffe0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=3Db03de000 task=3Db034db40)
Stack: 00020800 b03dfff8 b03e0898 000000bd b03e0340 b040cb80 0044f007 b0100=
211=20
Call Trace:
 [<b0103c00>] show_stack+0x7a/0x90
 [<b0103d81>] show_registers+0x152/0x1ca
 [<b0103f86>] die+0xf4/0x178
 [<b0114556>] do_page_fault+0x42a/0x645
 [<b01038a7>] error_code+0x2b/0x30
 [<b03e0898>] start_kernel+0x13a/0x151
 [<b0100211>] 0xb0100211
Code: e0 ff ff 21 e3 eb 24 8b 0d 84 c6 40 b0 b8 26 10 10 b0 8b 15 c0 eb 34 =
b0 85 c9 0f 44 c8 8b 43 10 c1 e0 07 89 90 84 52 41 b0 ff d1 <8b> 43 08 a8 0=
8 74 d5 e8 d8 7f 1f 00 eb f2 55 89 e5 56 53 fb ba=20
 <0>Kernel panic - not syncing: Attempted to kill the idle task!


I changed cpu_idle to look like this:

void cpu_idle (void)
{
 while (1) {
  while (!need_resched()) {
   irq_stat[smp_processor_id()].idle_timestamp =3D jiffies;
   default_idle();
  }
  schedule();
 }
}

I did not have an oops with the changed cpu_idle() until today.
But maybe that is just luck. The oops is not reproducible.
There were days when I got 3 oopses, but there were also weeks
when the machine was rock-stable.


The above oops shows a crash when we try to access the
thread_info->flags field. This is done by need_resched()
to check the TIF_NEED_RESCHED flag.
I don't know how to interpret the oops correctly to find
the source of the crash.

b010108f <cpu_idle>:
b010108f: 55                    push   %ebp
b0101090: 89 e5                 mov    %esp,%ebp
b0101092: 53                    push   %ebx
b0101093: bb 00 e0 ff ff        mov    $0xffffe000,%ebx
b0101098: 21 e3                 and    %esp,%ebx
b010109a: eb 24                 jmp    b01010c0 <cpu_idle+0x31>
b010109c: 8b 0d 84 c6 40 b0     mov    0xb040c684,%ecx
b01010a2: b8 26 10 10 b0        mov    $0xb0101026,%eax
b01010a7: 8b 15 c0 eb 34 b0     mov    0xb034ebc0,%edx
b01010ad: 85 c9                 test   %ecx,%ecx
b01010af: 0f 44 c8              cmove  %eax,%ecx
b01010b2: 8b 43 10              mov    0x10(%ebx),%eax
b01010b5: c1 e0 07              shl    $0x7,%eax
b01010b8: 89 90 84 52 41 b0     mov    %edx,0xb0415284(%eax)
b01010be: ff d1                 call   *%ecx
b01010c0: 8b 43 08              mov    0x8(%ebx),%eax
^^^^^^^^^^^^^^^^^^^^^ OOPS here. This is clearly the need_resched() check.
b01010c3: a8 08                 test   $0x8,%al
b01010c5: 74 d5                 je     b010109c <cpu_idle+0xd>
b01010c7: e8 d8 7f 1f 00        call   b02f90a4 <schedule>
b01010cc: eb f2                 jmp    b01010c0 <cpu_idle+0x31>


Quoting "Paul E. McKenney" <paulmck@us.ibm.com>:
> Hello!
>=20
> Strange code in i386, ia64, and x86-64 cpu_idle():
>=20
>  void cpu_idle (void)
>  {
>   /* endless idle loop with no priority at all */
>   while (1) {
>    while (!need_resched()) {
>     void (*idle)(void);
>     /*
>      * Mark this as an RCU critical section so that
>      * synchronize_kernel() in the unload path waits
>      * for our completion.
>      */
>     rcu_read_lock();
>     idle =3D pm_idle;
>     if (!idle)
>      idle =3D default_idle;
>     idle();
>     rcu_read_unlock();
>    }
>    schedule();
>   }
>  }
>=20
> Unless idle_cpu() is busted, it seems like the above is, given the code in
> rcu_check_callbacks():
>=20
>  void rcu_check_callbacks(int cpu, int user)
>  {
>   if (user ||=20
>       (idle_cpu(cpu) && !in_softirq() &&=20
>      hardirq_count() <=3D (1 << HARDIRQ_SHIFT))) {
>    rcu_qsctr_inc(cpu);
>    rcu_bh_qsctr_inc(cpu);
>   } else if (!in_softirq())
>    rcu_bh_qsctr_inc(cpu);
>   tasklet_schedule(&per_cpu(rcu_tasklet, cpu));
>  }
>=20
> And idle_cpu() is pretty straightforward:
>=20
> 	int idle_cpu(int cpu)
> 	{
> 		return cpu_curr(cpu) =3D=3D cpu_rq(cpu)->idle;
> 	}
>=20
> So I would say that the rcu_read_lock() in cpu_idle() is having no
> effect, because any timer interrupt from cpu_idle() will mark a
> quiescent state notwithstanding.  What am I missing here?
>=20
> If I am not missing anything, then the attached patch would be in
> order here, though there might be some additional work required.
> (Though I thought that the try_stop_module() stuff took care of
> all of this these days...)
>=20
> Note that we really, really do want the idle loop to be an extended
> quiescent state, otherwise one gets indefinite grace periods and
> runs out of memory...
>=20
> 						Thanx, Paul
>=20
> diff -urpN -X ../dontdiff linux-2.5/arch/i386/kernel/process.c linux-2.5-=
idle_rcu/arch/i386/kernel/process.c
> --- linux-2.5/arch/i386/kernel/process.c	Mon Nov 29 10:47:14 2004
> +++ linux-2.5-idle_rcu/arch/i386/kernel/process.c	Sat Dec  4 14:53:37 2004
> @@ -144,14 +144,12 @@ void cpu_idle (void)
>  {
>  	/* endless idle loop with no priority at all */
>  	while (1) {
> +		/*
> +		 * Note that it is illegal to use RCU read-side
> +		 * critical sections within the idle loop.
> +		 */
>  		while (!need_resched()) {
>  			void (*idle)(void);
> -			/*
> -			 * Mark this as an RCU critical section so that
> -			 * synchronize_kernel() in the unload path waits
> -			 * for our completion.
> -			 */
> -			rcu_read_lock();
>  			idle =3D pm_idle;
> =20
>  			if (!idle)
> @@ -159,7 +157,6 @@ void cpu_idle (void)
> =20
>  			irq_stat[smp_processor_id()].idle_timestamp =3D jiffies;
>  			idle();
> -			rcu_read_unlock();
>  		}
>  		schedule();
>  	}
> diff -urpN -X ../dontdiff linux-2.5/arch/ia64/kernel/process.c linux-2.5-=
idle_rcu/arch/ia64/kernel/process.c
> --- linux-2.5/arch/ia64/kernel/process.c	Mon Nov 29 10:47:18 2004
> +++ linux-2.5-idle_rcu/arch/ia64/kernel/process.c	Sat Dec  4 14:54:30 2004
> @@ -230,6 +230,10 @@ cpu_idle (void *unused)
> =20
>  	/* endless idle loop with no priority at all */
>  	while (1) {
> +		/*
> +		 * Note that it is illegal to use RCU read-side
> +		 * critical sections within the idle loop.
> +		 */
>  #ifdef CONFIG_SMP
>  		if (!need_resched())
>  			min_xtp();
> @@ -239,17 +243,10 @@ cpu_idle (void *unused)
> =20
>  			if (mark_idle)
>  				(*mark_idle)(1);
> -			/*
> -			 * Mark this as an RCU critical section so that
> -			 * synchronize_kernel() in the unload path waits
> -			 * for our completion.
> -			 */
> -			rcu_read_lock();
>  			idle =3D pm_idle;
>  			if (!idle)
>  				idle =3D default_idle;
>  			(*idle)();
> -			rcu_read_unlock();
>  		}
> =20
>  		if (mark_idle)
> diff -urpN -X ../dontdiff linux-2.5/arch/x86_64/kernel/process.c linux-2.=
5-idle_rcu/arch/x86_64/kernel/process.c
> --- linux-2.5/arch/x86_64/kernel/process.c	Mon Nov 29 10:48:05 2004
> +++ linux-2.5-idle_rcu/arch/x86_64/kernel/process.c	Sat Dec  4 14:55:13 2=
004
> @@ -133,19 +133,16 @@ void cpu_idle (void)
>  {
>  	/* endless idle loop with no priority at all */
>  	while (1) {
> +		/*
> +		 * Note that it is illegal to use RCU read-side
> +		 * critical sections within the idle loop.
> +		 */
>  		while (!need_resched()) {
>  			void (*idle)(void);
> -			/*
> -			 * Mark this as an RCU critical section so that
> -			 * synchronize_kernel() in the unload path waits
> -			 * for our completion.
> -			 */
> -			rcu_read_lock();
>  			idle =3D pm_idle;
>  			if (!idle)
>  				idle =3D default_idle;
>  			idle();
> -			rcu_read_unlock();
>  		}
>  		schedule();
>  	}
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20
>=20

=2D-=20
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]



--nextPart2243999.IoNvx1kSFo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBs6ioFGK1OIvVOP4RAuYXAKDXweJq/8/FQFrF3kHtsBHns/9LMgCfffVb
Cekus3zkqVdQ46Pyf1OtHCk=
=iH61
-----END PGP SIGNATURE-----

--nextPart2243999.IoNvx1kSFo--
