Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290619AbSAYJtl>; Fri, 25 Jan 2002 04:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290622AbSAYJtY>; Fri, 25 Jan 2002 04:49:24 -0500
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:59152 "HELO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with SMTP
	id <S290619AbSAYJtM>; Fri, 25 Jan 2002 04:49:12 -0500
Date: Fri, 25 Jan 2002 10:48:31 +0100 (CET)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ACPI trouble (Was: Re: [patch] amd athlon cooling on kt266/266a
 chipset)
In-Reply-To: <20020124184011.GA23785@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0201251044210.1519-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Petr Vandrovec wrote:

> On Thu, Jan 24, 2002 at 09:49:37AM -0800, Wayne Whitney wrote:
> > In mailing-lists.linux-kernel, Rasmus B?g Hansen wrote:
> > 
> > > When running /sbin/poweroff from runlevel 3 or 5, 'halt -i -d -p' is
> > > again the last command run, follwing this from the kernel: 
> > >   Power down.  
> > >   hwsleep-0178 [02] Acpi_enable_sleep_state: Entering S5 
> > > And again my system hangs.
> > 
> > I have an ASUS A7V motherboard, similar to your ASUS A7V133.  I find
> > that stock kernel (2.4.18-pre7) APM powers off the machine, but stock
> > kernel ACPI does not.  However, the Intel ACPI patch, available from
> > http://developer.intel.com/technology/IAPC/acpi/downloads.htm against
> > kernel 2.4.16, does power down my machine.  I was able to forward port
> > this to 2.4.18-pre7 without too much trouble by starting with 2.4.16,
> > applying the Intel ACPI patch first, and then applying kernel
> > patch-2.4.17 and kernel patch-2.4.18-pre7.
> 
> I still have this in my tree. I have no idea who is wrong, whether parser
> or BIOS.

Your patch might work on the A7V, but it does not on my A7V133-C. If I 
modify the OEM string in the patch, it works. It may also be modified to 
[...] "A7V-133", 7)[...] but then it probably won't work on a A7V...

As said in another post, the patch from the intel site also solves the 
problem.

Regards
Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
A computer without Windows is like a chocolate cake without mustard.
----------------------------------[ moffe at amagerkollegiet dot dk ] --

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
+			&& !memcmp(acpi_gbl_DSDT->oem_table_id, "A7V", 3)) {
+		type_a = type_b = 2;
+	}
 	/* run the _PTS and _GTS methods */
 
 	MEMSET(&arg_list, 0, sizeof(arg_list));

