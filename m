Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVGZUbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVGZUbi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVGZUbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:31:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23948 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261867AbVGZUbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:31:36 -0400
Date: Tue, 26 Jul 2005 05:32:30 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Ju, Seokmann" <sju@lsil.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Kolli, Neela Syam" <knsyam@lsil.com>
Subject: Re: [PATCH 2.4.31 1/1] scsi/megaraid2: add 64-bit application support
Message-ID: <20050726083230.GC5511@dmt.cnet>
References: <0E3FA95632D6D047BA649F95DAB60E5703662A58@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E5703662A58@exa-atlanta>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Seokmann,

On Fri, Jul 15, 2005 at 11:32:08AM -0400, Ju, Seokmann wrote:
> This patch contains accumulated changes over the time.
> 
> Description of the changes.
> ### Version 2.10.10.1
> Thu Jan 27 15:59:59 EDT 2005 - Seokmann Ju <sju@lsil.com>
> 1.	There was a bug in the 'megadev_ioctl()' function that cause random
> 	deletion error and has been fixed.
> 
> ### Version 2.10.10.0
> Fri Jan 21 15:59:59 EDT 2005 - Seokmann Ju <sju@lsil.com>
> 1.	Fixed Tape drive issue : For any Direct CDB command to physical
> device
> 	including tape, timeout value set by driver was 10 minutes. With
> this
> 	value, most of command will return within timeout. However, for
> those
> 	command like ERASE or FORMAT, it takes more than an hour depends on
> 	capacity of the device and the command could be terminated before it
> 	completes.
> 	To address this issue, the 'timeout' field in the DCDB command will
> 	have NO TIMEOUT (i.e., 4) value as its timeout on DCDB command.
> 2.	Added NEC ROMB support : NEC MegaRAID PCI Express ROMB controller


> @@ -83,6 +83,7 @@
>  #define INTEL_SUBSYS_VID		0x8086
>  #define FSC_SUBSYS_VID			0x1734
>  #define ACER_SUBSYS_VID			0x1025
> +#define NEC_SUBSYS_VID			0x1033
>  
>  #define HBA_SIGNATURE	      		0x3344
>  #define HBA_SIGNATURE_471	  	0xCCCC
> @@ -143,7 +144,8 @@
>  	.eh_device_reset_handler =	megaraid_reset,		\
>  	.eh_bus_reset_handler =		megaraid_reset,		\
  	.eh_host_reset_handler =	megaraid_reset,		\
> -	.highmem_io =			1			\
> +	.highmem_io =			1,			\
> +	.vary_io =			1			\

vary_io has never been part of mainline. How come did you add it
here?

> -#if defined(__x86_64__)
> +#if defined(CONFIG_COMPAT) || defined( __x86_64__) ||

There is no CONFIG_COMPAT on v2.4... thanks James and Christoph
for reviewing.

> defined(IA32_EMULATION)
> +#ifndef __ia64__
> +#define LSI_CONFIG_COMPAT
> +#endif
> +#endif
> +
> +
> +#ifdef LSI_CONFIG_COMPAT
>  static int megadev_compat_ioctl(unsigned int, unsigned int, unsigned long,
>  	struct file *);
>  #endif

