Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbRGDOed>; Wed, 4 Jul 2001 10:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265328AbRGDOeX>; Wed, 4 Jul 2001 10:34:23 -0400
Received: from zeus.kernel.org ([209.10.41.242]:14294 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S264724AbRGDOeK>;
	Wed, 4 Jul 2001 10:34:10 -0400
Date: Wed, 4 Jul 2001 16:33:13 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: andrew.grover@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: What are rules for acpi_ex_enter_interpreter?
Message-ID: <20010704163313.A10794@ppc.vc.cvut.cz>
In-Reply-To: <20010704033807.A1469@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010704033807.A1469@ppc.vc.cvut.cz>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2001 at 03:38:07AM +0200, Petr Vandrovec wrote:
> 
>   I did NOT verified other callers of acpi_walk_namespace... And there
> is still some problem left, as although now S5 is listed as available,
> poweroff still does nothing instead of poweroff.

Replying to myself, after following change in additon to acpi_ex_...
poweroff on my machine works. It should probably map type 0 => 0, 3 => 1
and 7 => 2, but it is hard to decide without VIA datasheet, so change
below is minimal change needed to get poweroff through ACPI to work on my 
ASUS A7V.
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz
 
diff -urdN linux/drivers/acpi/hardware/hwsleep.c linux/drivers/acpi/hardware/hwsleep.c
--- linux/drivers/acpi/hardware/hwsleep.c	Tue Jul  3 15:58:35 2001
+++ linux/drivers/acpi/hardware/hwsleep.c	Wed Jul  4 16:07:47 2001
@@ -146,6 +146,13 @@
 		return status;
 	}
 
+	/* Broken ACPI table on ASUS A7V... it reports type 7, but poweroff is type 2... 
+	   sleep is type 1 while ACPI reports type 3, but as I was not able to get 
+	   machine to wake from this state without unplugging power cord... */
+	if (type_a == 7 && type_b == 7 && sleep_state == ACPI_STATE_S5 && !memcmp(acpi_gbl_DSDT->oem_id, "ASUS\0\0", 6)
+			&& !memcmp(acpi_gbl_DSDT->oem_table_id, "A7V     ", 8)) {
+		type_a = type_b = 2;
+	}
 	/* run the _PTS and _GTS methods */
 
 	MEMSET(&arg_list, 0, sizeof(arg_list));

> diff -urdN linux/drivers/acpi/namespace/nsinit.c linux/drivers/acpi/namespace/nsinit.c
> --- linux/drivers/acpi/namespace/nsinit.c	Tue Jul  3 15:58:35 2001
> +++ linux/drivers/acpi/namespace/nsinit.c	Wed Jul  4 02:20:49 2001
> @@ -27,6 +27,7 @@
>  #include "acpi.h"
>  #include "acnamesp.h"
>  #include "acdispat.h"
> +#include "acinterp.h"
>  
>  #define _COMPONENT          ACPI_NAMESPACE
>  	 MODULE_NAME         ("nsinit")
> @@ -62,10 +63,17 @@
>  
>  	/* Walk entire namespace from the supplied root */
>  
> +	status = acpi_ex_enter_interpreter();
> +	if (ACPI_FAILURE(status)) {
> +		return status;
> +	}
> +	
>  	status = acpi_walk_namespace (ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
>  			  ACPI_UINT32_MAX, acpi_ns_init_one_object,
>  			  &info, NULL);
>  
> +	acpi_ex_exit_interpreter();
> +	
>  	return (AE_OK);
>  }
>  
