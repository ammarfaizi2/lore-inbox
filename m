Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268665AbRGZTv5>; Thu, 26 Jul 2001 15:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268667AbRGZTvs>; Thu, 26 Jul 2001 15:51:48 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:54022 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S268665AbRGZTvf> convert rfc822-to-8bit; Thu, 26 Jul 2001 15:51:35 -0400
Date: Thu, 26 Jul 2001 21:49:04 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: richard offer <offer@sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: unitialized variable in 2.4.7 (sym53c8xx, dmi_scan)
In-Reply-To: <E15PW9s-0002hY-00@the-village.bc.nu>
Message-ID: <20010726213543.W1488-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Wed, 25 Jul 2001, Alan Cox wrote:

> >  static __init int disable_ide_dma(struct dmi_blacklist *d)
> >  {
> >  #ifdef CONFIG_BLK_DEV_IDE
> > @@ -169,6 +170,7 @@
> >  #endif
> >         return 0;
> >  }
> > +#endif
>
> This just makes it harder to finish the merges
>
> > makes that automatic.
> > ===== drivers/scsi/sym53c8xx.c 1.6 vs edited =====
> > --- 1.6/drivers/scsi/sym53c8xx.c        Thu Jul  5 04:28:16 2001
> > +++ edited/drivers/scsi/sym53c8xx.c     Wed Jul 25 13:37:10 2001
> > @@ -6991,7 +6991,7 @@
> >
> >  static void ncr_soft_reset(ncb_p np)
> >  {
> > -       u_char istat;
> > +       u_char istat=0;
> >         int i;
> >
> >         if (!(np->features & FE_ISTAT1) || !(INB (nc_istat1) & SRUN))
>
> And this means when we get a real bug with istat not being assigned it
> wont be seen.

This will not happen (istat will never be used unitialised).
The compiler has enough information to know about this at compile time as
the full code below demonstrates clearly:

--

static void ncr_soft_reset(ncb_p np)
{
	u_char istat;
	int i;

	if (!(np->features & FE_ISTAT1) || !(INB (nc_istat1) & SRUN))
		goto do_chip_reset;

	OUTB (nc_istat, CABRT);
	for (i = 100000 ; i ; --i) {
		istat = INB (nc_istat);
		if (istat & SIP) {
			INW (nc_sist);
		}
		else if (istat & DIP) {
			if (INB (nc_dstat) & ABRT);
				break;
		}
		UDELAY(5);
	}
	OUTB (nc_istat, 0);
	if (!i)
		printk("%s: unable to abort current chip operation, "
		       "ISTAT=0x%02x.\n", ncr_name(np), istat);
do_chip_reset:
	ncr_chip_reset(np);
}

--

IMO, the problem should be reported to the compiler maintainers. By
assigning some fake definitions to FE_ISTAT1, SRUN, INB(), etc...,
the code above should help them fix the compiler paranoia disease.
Changing the driver code looks like an odd idea.

  Gérard.

