Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262621AbTCIU6Q>; Sun, 9 Mar 2003 15:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262623AbTCIU6Q>; Sun, 9 Mar 2003 15:58:16 -0500
Received: from terminus.zytor.com ([63.209.29.3]:17096 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S262621AbTCIU6O>; Sun, 9 Mar 2003 15:58:14 -0500
Message-ID: <3E6BAD57.803@zytor.com>
Date: Sun, 09 Mar 2003 13:08:39 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reserving physical memory at boot time
References: <Pine.LNX.3.95.1021204115837.29419B-100000@chaos.analogic.com> <Pine.LNX.4.33L2.0212040905230.8842-100000@dragon.pdx.osdl.net> <b442s0$pau$1@cesium.transmeta.com> <32981.4.64.238.61.1046844111.squirrel@www.osdl.org> <b453mj$qpi$1@cesium.transmeta.com> <20030306212607.GA173@elf.ucw.cz> <3E67D89B.1010308@zytor.com> <20030307231954.GB164@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Okay; which mem= options you want killed?
> 

Anything that doesn't match the regexp (in Perl syntax):

/^mem=(0[0-7]*|[1-9][0-9]*|0x[0-9a-f]+)[kmg]$/i

> What about this?

Looks good to me.

> 								Pavel
> 
> --- clean/arch/i386/kernel/setup.c	2003-03-06 23:25:14.000000000 +0100
> +++ linux/arch/i386/kernel/setup.c	2003-03-08 00:18:21.000000000 +0100
> @@ -527,6 +527,9 @@
>  		 * to <mem>, overriding the bios size.
>  		 * "mem=XXX[KkmM]@XXX[KkmM]" defines a memory region from
>  		 * <start> to <start>+<mem>, overriding the bios size.
> +		 *
> +		 * HPA tells me bootloaders need to parse mem=, so no new
> +		 * option should be mem=
>  		 */
>  		if (c == ' ' && !memcmp(from, "mem=", 4)) {
>  			if (to != command_line)
> @@ -535,8 +538,24 @@
>  				from += 9+4;
>  				clear_bit(X86_FEATURE_PSE, boot_cpu_data.x86_capability);
>  				disable_pse = 1;
> -			} else if (!memcmp(from+4, "exactmap", 8)) {
> -				from += 8+4;
> +			} else {
> +				/* If the user specifies memory size, we
> +				 * limit the BIOS-provided memory map to
> +				 * that size. exactmap can be used to specify
> +				 * the exact map. mem=number can be used to
> +				 * trim the existing memory map.
> +				 */
> +				unsigned long long start_at, mem_size;
> + 
> +				mem_size = memparse(from+4, &from);
> +			}
> +		}
> +
> +		if (c == ' ' && !memcmp(from, "memmap=", 7)) {
> +			if (to != command_line)
> +				to--;
> +			if (!memcmp(from+7, "exactmap", 8)) {
> +				from += 8+7;
>  				e820.nr_map = 0;
>  				userdef = 1;
>  			} else {
> @@ -548,7 +567,7 @@
>  				 */
>  				unsigned long long start_at, mem_size;
>   
> -				mem_size = memparse(from+4, &from);
> +				mem_size = memparse(from+7, &from);
>  				if (*from == '@') {
>  					start_at = memparse(from+1, &from);
>  					add_memory_region(start_at, mem_size, E820_RAM);
> @@ -565,6 +584,7 @@
>  			}
>  		}
>  
> +
>  		/* "acpi=off" disables both ACPI table parsing and interpreter init */
>  		if (c == ' ' && !memcmp(from, "acpi=off", 8))
>  			acpi_disabled = 1;
> 
> 

