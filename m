Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318288AbSGWVXj>; Tue, 23 Jul 2002 17:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318289AbSGWVXi>; Tue, 23 Jul 2002 17:23:38 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46602 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318288AbSGWVXi>; Tue, 23 Jul 2002 17:23:38 -0400
Date: Tue, 23 Jul 2002 17:20:57 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Dominik Brodowski <devel@brodo.de>
cc: davej@suse.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] resolve ACPI oops on boot
In-Reply-To: <20020718231509.A539@brodo.de>
Message-ID: <Pine.LNX.3.96.1020723165428.2194A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Dominik Brodowski wrote:

> An u8 was casted into an u32, then all 32 bits were set to zero, this
> causing another variable - in my case, processor flags - to be corrupted. 
> 
> Dominik

But that's not what's happening here, the pointer is being cast, if the
object of the pointer is not u32, then casting the pointer doesn't fix the
real problem. If the "data" pointer points to a u8, then no casting will
make it work right when you save 32 bits into an 8 bit space. If this
changes the problem it's because of alignment, perhaps.

You give neither the kernel version nor the architecture, so I can't be
sure what's happening or what the compiler might do. I don't find that
code in the kernel I have on this machine (2.4.19-pre7-jam6) but that
diesn't mean much. The routine in hardware/hwregs.c on my kernel would
seem to pass the width correctly, but clearly this is a very different
version.

I think the cast is just to avoid the compiler whining about types, the
version I have is actually type "(acpi_generic_address*)" not (u32*), I
would think the compiler would still complain, but maybe only with
-pedantic or whatever.

In any case only the number of bits requested should be written, the
problem may have been avoided rather than fixed.

 
> --- linux/drivers/acpi-original/ec.c	Fri Jul 12 22:43:11 2002
> +++ linux/drivers/acpi/ec.c	Fri Jul 12 23:28:14 2002
> @@ -134,7 +134,7 @@
>  acpi_ec_read (
>  	struct acpi_ec		*ec,
>  	u8			address,
> -	u8			*data)
> +	u32			*data)
>  {
>  	acpi_status		status = AE_OK;
>  	int			result = 0;
> @@ -167,7 +167,7 @@
>  		goto end;
>  
>  
> -	acpi_hw_low_level_read(8, (u32*) data, &ec->data_addr, 0);
> +	acpi_hw_low_level_read(8, data, &ec->data_addr, 0);
>  
>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Read [%02x] from address [%02x]\n",
>  		*data, address));


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

