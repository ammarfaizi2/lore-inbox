Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265628AbSLQTsP>; Tue, 17 Dec 2002 14:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265636AbSLQTsP>; Tue, 17 Dec 2002 14:48:15 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:39860 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S265628AbSLQTsL>; Tue, 17 Dec 2002 14:48:11 -0500
Date: Tue, 17 Dec 2002 14:58:08 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: "White, Charles" <Charles.White@hp.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.21pre1 cpqfc 
In-Reply-To: <A2C35BB97A9A384CA2816D24522A53BB039917AD@cceexc18.americas.cpqcorp.net>
Message-ID: <Pine.LNX.4.50L.0212171457560.26120-100000@freak.distro.conectiva>
References: <A2C35BB97A9A384CA2816D24522A53BB039917AD@cceexc18.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could you make a short list of the fixed bugs?

On Tue, 17 Dec 2002, White, Charles wrote:

> This patch fixes two minor bugs in cpqfc and makes it version 2.1.2.
>
> diff -urN linux-2.4.21-pre1.orig/drivers/scsi/cpqfc.Readme
> linux-2.4.21-pre1.cpqfc212/drivers/scsi/cpqfc.Readme
> --- linux-2.4.21-pre1.orig/drivers/scsi/cpqfc.Readme	Thu Oct 25
> 16:53:50 2001
> +++ linux-2.4.21-pre1.cpqfc212/drivers/scsi/cpqfc.Readme	Tue Dec
> 17 09:33:18 2002
> @@ -22,6 +22,9 @@
>     * Makefile changes to bring cpqfc into line w/ rest of SCSI drivers
>       (thanks to Keith Owens)
>
> +Ver 2.1.2  Jul 22, 2002
> +   * initialize DumCmnd.lun (used as LUN index in fcFindLoggedInPort())
> +
>  Ver 2.0.5  Aug 06, 2001
>     * Reject non-existent luns in the driver rather than letting the
>       hardware do it.  (some HW behaves differently than others in this
> area.)
> diff -urN linux-2.4.21-pre1.orig/drivers/scsi/cpqfcTSinit.c
> linux-2.4.21-pre1.cpqfc212/drivers/scsi/cpqfcTSinit.c
> --- linux-2.4.21-pre1.orig/drivers/scsi/cpqfcTSinit.c	Tue Dec 17
> 09:25:01 2002
> +++ linux-2.4.21-pre1.cpqfc212/drivers/scsi/cpqfcTSinit.c	Tue Dec
> 17 13:18:20 2002
> @@ -64,7 +64,7 @@
>
>  /* Embedded module documentation macros - see module.h */
>  MODULE_AUTHOR("Compaq Computer Corporation");
> -MODULE_DESCRIPTION("Driver for Compaq 64-bit/66Mhz PCI Fibre Channel
> HBA v. 2.1.1");
> +MODULE_DESCRIPTION("Driver for Compaq 64-bit/66Mhz PCI Fibre Channel
> HBA v. 2.1.2");
>  MODULE_LICENSE("GPL");
>
>  int cpqfcTS_TargetDeviceReset(Scsi_Device * ScsiDev, unsigned int
> reset_flags);
> @@ -411,6 +411,7 @@
>  	// can we find an FC device mapping to this SCSI target?
>  	DumCmnd.channel = ScsiDev->channel;	// For searching
>  	DumCmnd.target = ScsiDev->id;
> +	DumCmnd.lun     = ScsiDev->lun;
>  	pLoggedInPort = fcFindLoggedInPort(fcChip, &DumCmnd,	//
> search Scsi Nexus
>  					   0,	// DON'T search linked
> list for FC port id
>  					   NULL,	// DON'T search
> linked list for FC WWN
> diff -urN linux-2.4.21-pre1.orig/drivers/scsi/cpqfcTSstructs.h
> linux-2.4.21-pre1.cpqfc212/drivers/scsi/cpqfcTSstructs.h
> --- linux-2.4.21-pre1.orig/drivers/scsi/cpqfcTSstructs.h	Tue Dec
> 17 09:25:01 2002
> +++ linux-2.4.21-pre1.cpqfc212/drivers/scsi/cpqfcTSstructs.h	Tue Dec
> 17 09:33:18 2002
> @@ -35,7 +35,7 @@
>  /* don't forget to also change MODULE_DESCRIPTION in cpqfcTSinit.c */
>  #define VER_MAJOR 2
>  #define VER_MINOR 1
> -#define VER_SUBMINOR 1
> +#define VER_SUBMINOR 2
>
>  /*
>   *	Macros for kernel (esp. SMP) tracing using a PCI analyzer
> diff -urN linux-2.4.21-pre1.orig/drivers/scsi/cpqfcTSworker.c
> linux-2.4.21-pre1.cpqfc212/drivers/scsi/cpqfcTSworker.c
> --- linux-2.4.21-pre1.orig/drivers/scsi/cpqfcTSworker.c	Tue Dec 17
> 09:25:01 2002
> +++ linux-2.4.21-pre1.cpqfc212/drivers/scsi/cpqfcTSworker.c	Tue Dec
> 17 09:41:11 2002
> @@ -2706,6 +2706,10 @@
>  					// Report Luns command
>  					if
> (pLoggedInPort->ScsiNexus.LunMasking == 1) {
>  						// we KNOW all the valid
> LUNs... 0xFF is invalid!
> +						if (Cmnd->lun >
> sizeof(pLoggedInPort->ScsiNexus.lun)){
> +							// printk("
> cpqfcTS FATAL: Invalid LUN index !!!!\n ");
> +							return NULL;
> +						}
>  						Cmnd->SCp.have_data_in =
> pLoggedInPort->ScsiNexus.lun[Cmnd->lun];
>  						if
> (pLoggedInPort->ScsiNexus.lun[Cmnd->lun] == 0xFF)
>  							return NULL;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
