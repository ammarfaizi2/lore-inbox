Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281307AbRKTUM0>; Tue, 20 Nov 2001 15:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281318AbRKTUMQ>; Tue, 20 Nov 2001 15:12:16 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:58076 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S281307AbRKTUMH> convert rfc822-to-8bit; Tue, 20 Nov 2001 15:12:07 -0500
Date: Tue, 20 Nov 2001 18:26:26 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Anton Blanchard <anton@samba.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] small sym-2 fix
In-Reply-To: <20011120170219.A10454@krispykreme>
Message-ID: <20011120181131.F1961-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

On Tue, 20 Nov 2001, Anton Blanchard wrote:

> Hi,
>
> > Could you revert your change and give my patch below a try. Btw, you will
> > be in sync with my current sources. Booting with sym53c8xx=debug:1 will
> > let the driver print all memory allocations to the syslog. You may send me
> > the drivers messages related to these allocations for information.
>
> Thanks, it boots OK now. Do you still want a debug log?

I can guess the result.

> BTW on ppc64 we can have io port addresses > 32 bits so this change is
> required.

Linux/ppc64 looks strange invention to me. As you know IO base addresses
are limited to 32 bit in PCI. And, btw, 32 bits seems to work just fine
here as PPC is defined from the driver as using normal IO. But, IIRC, the
strange Linux/PPC invention only supports MMIO. :-)

If you want to play with _explicit_ MMIO, you just have to remove a couple
of line from sym53c8xx.h. Here they are:

  /*
   *  Use normal IO if configured. Forced for alpha and powerpc.
   *  Powerpc fails copying to on-chip RAM using memcpy_toio().
   *  Forced to MMIO for sparc.
   */
  #if defined(__alpha__)
  #define	SYM_CONF_IOMAPPED
  #elif defined(__powerpc__)
- #define	SYM_CONF_IOMAPPED
- #define SYM_OPT_NO_BUS_MEMORY_MAPPING
  #elif defined(__sparc__)
  #undef SYM_CONF_IOMAPPED
  #elif defined(CONFIG_SCSI_SYM53C8XX_IOMAPPED)
  #define	SYM_CONF_IOMAPPED
  #endif

Btw, I cannot guess the result here. You may want to really let me know
this time. :)

I cannot apply your patch as it is, since I want the driver to distinguish
between kernel fake cookies associated with base addresses and actual
values of those registers. This is needed, since some of these values must
be known from SCSI SCRIPTS and thus must fit the _reality_ and not any
kernel developpers' dream, could be the greatest ones:).

Thanks, anyway, for reporting this problem.

Regards,
  Gérard.

> diff -urN linuxppc_2_4_devel/drivers/scsi/sym53c8xx_2/sym_glue.h linuxppc_2_4_devel_work/drivers/scsi/sym53c8xx_2/sym_glue.h
> --- linuxppc_2_4_devel/drivers/scsi/sym53c8xx_2/sym_glue.h	Mon Nov 12 11:46:42 2001
> +++ linuxppc_2_4_devel_work/drivers/scsi/sym53c8xx_2/sym_glue.h	Tue Nov 20 16:35:14 2001
> @@ -463,7 +462,7 @@
>
>  	vm_offset_t	mmio_va;	/* MMIO kernel virtual address	*/
>  	vm_offset_t	ram_va;		/* RAM  kernel virtual address	*/
> -	u32		io_port;	/* IO port address		*/
> +	u_long		io_port;	/* IO port address		*/
>  	u_short		io_ws;		/* IO window size		*/
>  	int		irq;		/* IRQ number			*/

