Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288859AbSAXSkv>; Thu, 24 Jan 2002 13:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288862AbSAXSkb>; Thu, 24 Jan 2002 13:40:31 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:54660 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S288859AbSAXSkY>;
	Thu, 24 Jan 2002 13:40:24 -0500
Date: Thu, 24 Jan 2002 19:40:11 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Wayne Whitney <whitney@math.berkeley.edu>
Cc: Rasmus B?g Hansen <moffe@amagerkollegiet.dk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: ACPI trouble (Was: Re: [patch] amd athlon cooling on kt266/266a chipset)
Message-ID: <20020124184011.GA23785@vana.vc.cvut.cz>
In-Reply-To: <20020124155853Z287177-13996+11274@vger.kernel.org> <Pine.LNX.4.44.0201241803540.1345-100000@grignard.amagerkollegiet.dk> <200201241749.g0OHnbG02468@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201241749.g0OHnbG02468@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2002 at 09:49:37AM -0800, Wayne Whitney wrote:
> In mailing-lists.linux-kernel, Rasmus B?g Hansen wrote:
> 
> > When running /sbin/poweroff from runlevel 3 or 5, 'halt -i -d -p' is
> > again the last command run, follwing this from the kernel: 
> >   Power down.  
> >   hwsleep-0178 [02] Acpi_enable_sleep_state: Entering S5 
> > And again my system hangs.
> 
> I have an ASUS A7V motherboard, similar to your ASUS A7V133.  I find
> that stock kernel (2.4.18-pre7) APM powers off the machine, but stock
> kernel ACPI does not.  However, the Intel ACPI patch, available from
> http://developer.intel.com/technology/IAPC/acpi/downloads.htm against
> kernel 2.4.16, does power down my machine.  I was able to forward port
> this to 2.4.18-pre7 without too much trouble by starting with 2.4.16,
> applying the Intel ACPI patch first, and then applying kernel
> patch-2.4.17 and kernel patch-2.4.18-pre7.

I still have this in my tree. I have no idea who is wrong, whether parser
or BIOS.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz

diff -urdN linux/drivers/acpi/hardware/hwsleep.c linux/drivers/acpi/hardware/hwsleep.c
--- linux/drivers/acpi/hardware/hwsleep.c	Wed Oct 24 21:06:22 2001
+++ linux/drivers/acpi/hardware/hwsleep.c	Tue Jan 22 16:17:46 2002
@@ -152,6 +152,13 @@
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
