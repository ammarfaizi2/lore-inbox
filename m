Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316832AbSEVCig>; Tue, 21 May 2002 22:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316833AbSEVCif>; Tue, 21 May 2002 22:38:35 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:38876 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316832AbSEVCid>;
	Tue, 21 May 2002 22:38:33 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Greg KH <greg@kroah.com>, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 fix for running a SMP kernel on a UP box
Date: Tue, 21 May 2002 19:36:39 -0700
User-Agent: KMail/1.4.1
In-Reply-To: <20020521215217.GA3784@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_39RHFI3JQR4OVX0KF4WW"
Message-Id: <200205211936.39259.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_39RHFI3JQR4OVX0KF4WW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I was looking at this with Jack Vogel and I can't figure out how it goes=20
wrong, either.  However, the code in move() that uses the cpu number is a=
 bit=20
strange.  Entering loops in their middles is generally considered bug-pro=
ne=20
by programming style books.  What about eliminating the goto by using=20
something like the attached patch?

On Tuesday 21 May 2002 02:52 pm, Greg KH wrote:
> I can't seem to run a SMP 2.5.17 kernel on a UP machine, it locks up
> during the boot process.  In talking to Jack Vogel, he suggested I make
> the following patch, which seems to solve the problem for me.  In
> looking at the code, I have no idea of why this seems to work, so there
> probably is a better fix out there.
>=20
> Any suggestions?
>=20
> thanks,
>=20
> greg k-h
>=20
>=20
>=20
> diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
> --- a/arch/i386/kernel/io_apic.c=09Tue May 21 14:47:06 2002
> +++ b/arch/i386/kernel/io_apic.c=09Tue May 21 14:47:06 2002
> @@ -205,7 +205,7 @@
>  } ____cacheline_aligned irq_balance_t;
> =20
>  static irq_balance_t irq_balance[NR_IRQS] __cacheline_aligned
> -=09=09=09=3D { [ 0 ... NR_IRQS-1 ] =3D { 1, 0 } };
> +=09=09=09=3D { [ 0 ... NR_IRQS-1 ] =3D { 0, 0 } };
> =20
>  extern unsigned long irq_affinity [NR_IRQS];
> =20
> -


--=20
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

--------------Boundary-00=_39RHFI3JQR4OVX0KF4WW
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="irq_balance_move.patch2"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="irq_balance_move.patch2"

*** linux/arch/i386/kernel/io_apic.c.df	Mon May 20 22:07:36 2002
--- linux/arch/i386/kernel/io_apic.c	Tue May 21 18:41:54 2002
***************
*** 203,213 ****
  	unsigned int cpu;
  	unsigned long timestamp;
  } ____cacheline_aligned irq_balance_t;
  
  static irq_balance_t irq_balance[NR_IRQS] __cacheline_aligned
! 			= { [ 0 ... NR_IRQS-1 ] = { 1, 0 } };
  
  extern unsigned long irq_affinity [NR_IRQS];
  
  #endif
  
--- 203,213 ----
  	unsigned int cpu;
  	unsigned long timestamp;
  } ____cacheline_aligned irq_balance_t;
  
  static irq_balance_t irq_balance[NR_IRQS] __cacheline_aligned
! 			= { [ 0 ... NR_IRQS-1 ] = { 0, 0 } };
  
  extern unsigned long irq_affinity [NR_IRQS];
  
  #endif
  
***************
*** 220,248 ****
  static unsigned long move(int curr_cpu, unsigned long allowed_mask, unsigned long now, int direction)
  {
  	int search_idle = 1;
  	int cpu = curr_cpu;
  
! 	goto inside;
! 
! 	do {
! 		if (unlikely(cpu == curr_cpu))
! 			search_idle = 0;
! inside:
! 		if (direction == 1) {
! 			cpu++;
! 			if (cpu >= smp_num_cpus)
  				cpu = 0;
  		} else {
! 			cpu--;
! 			if (cpu == -1)
! 				cpu = smp_num_cpus-1;
  		}
! 	} while (!IRQ_ALLOWED(cpu,allowed_mask) ||
! 			(search_idle && !IDLE_ENOUGH(cpu,now)));
! 
! 	return cpu;
  }
  
  static inline void balance_irq(int irq)
  {
  #if CONFIG_SMP
--- 220,242 ----
  static unsigned long move(int curr_cpu, unsigned long allowed_mask, unsigned long now, int direction)
  {
  	int search_idle = 1;
  	int cpu = curr_cpu;
  
! 	for (;;) {
! 		if (direction) {
! 			if (++cpu >= smp_num_cpus)
  				cpu = 0;
  		} else {
! 			if (--cpu < 0)
! 				cpu = smp_num_cpus - 1;
  		}
! 		if (IRQ_ALLOWED(cpu, allowed_mask) && (!search_idle || IDLE_ENOUGH(cpu, now)))
! 			return cpu;
! 		if (unlikely(cpu == curr_cpu))
! 			search_idle = 0;
! 	}
  }
  
  static inline void balance_irq(int irq)
  {
  #if CONFIG_SMP

--------------Boundary-00=_39RHFI3JQR4OVX0KF4WW--

