Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVCOGk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVCOGk2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 01:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVCOGk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 01:40:28 -0500
Received: from relay.rost.ru ([80.254.111.11]:35210 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S262283AbVCOGkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 01:40:13 -0500
Date: Tue, 15 Mar 2005 09:40:09 +0300
From: Andrey Panin <pazke@donpac.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, natalie.protasevich@unisys.com,
       jason.davis@unisys.com
Subject: Re: [PATCH] ES7000 Legacy Mappings Update
Message-ID: <20050315064009.GD2904@pazke>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, natalie.protasevich@unisys.com,
	jason.davis@unisys.com
References: <20050314183533.GA28889@righTThere.net> <20050314180554.10455185.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <20050314180554.10455185.akpm@osdl.org>
X-Uname: Linux 2.6.11-pazke i686
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 073, 03 14, 2005 at 06:05:54PM -0800, Andrew Morton wrote:
> 
> You triggered my trivia twitch.
> 
> Jason Davis <jason@rightthere.net> wrote:
> >
> >  -	 * ES7000 has no legacy identity mappings
> >  +	 * Older generations of ES7000 have no legacy identity mappings
> >   	 */
> >  -	if (es7000_plat)
> >  +	if (es7000_plat && es7000_plat < 2) 
> >   		return;
> 
> Why not
> 
> 	if (es7000_plat == 1)
> 
> ?
> 
> >   	/* 
> >  diff -Naurp linux-2.6.11.3/arch/i386/mach-es7000/es7000plat.c linux-2.6.11.3-legacy/arch/i386/mach-es7000/es7000plat.c
> >  --- linux-2.6.11.3/arch/i386/mach-es7000/es7000plat.c	2005-03-13 01:44:41.000000000 -0500
> >  +++ linux-2.6.11.3-legacy/arch/i386/mach-es7000/es7000plat.c	2005-03-14 11:52:44.000000000 -0500
> >  @@ -138,7 +138,14 @@ parse_unisys_oem (char *oemptr, int oem_
> >   		es7000_plat = 0;
> >   	} else {
> >   		printk("\nEnabling ES7000 specific features...\n");
> >  -		es7000_plat = 1;
> >  +		/*
> >  +		 * Check to see if this is a x86_64 ES7000 machine.
> >  +		 */
> >  +		if (!(boot_cpu_data.x86 <= 15 && boot_cpu_data.x86_model <= 2))
> >  +			es7000_plat = 2;
> >  +		else
> >  +			es7000_plat = 1;
> >  +
> 
> Perhaps some nice enumerated identifiers here, rather than magic numbers?

While you are looking at this code can you take a look at the attached
trivial patch ?

-- 
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-dmi-2-es7000


This patch moves es7000_plat global variable out of DMI code.

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 arch/i386/kernel/dmi_scan.c |    2 --
 arch/i386/kernel/mpparse.c  |    1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff -urdpNX /usr/share/dontdiff linux-2.6.11.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.11/arch/i386/kernel/dmi_scan.c
--- linux-2.6.11.vanilla/arch/i386/kernel/dmi_scan.c	2005-03-08 18:02:00.000000000 +0300
+++ linux-2.6.11/arch/i386/kernel/dmi_scan.c	2005-03-08 18:04:38.000000000 +0300
@@ -12,8 +12,6 @@
 #include <linux/bootmem.h>
 
 
-int es7000_plat = 0;
-
 struct dmi_header
 {
 	u8	type;
diff -urdpNX /usr/share/dontdiff linux-2.6.11.vanilla/arch/i386/kernel/mpparse.c linux-2.6.11/arch/i386/kernel/mpparse.c
--- linux-2.6.11.vanilla/arch/i386/kernel/mpparse.c	2005-03-02 10:37:53.000000000 +0300
+++ linux-2.6.11/arch/i386/kernel/mpparse.c	2005-03-08 18:05:28.000000000 +0300
@@ -982,6 +982,7 @@ void __init mp_override_legacy_irq (
 	return;
 }
 
+int es7000_plat;
 
 void __init mp_config_acpi_legacy_irqs (void)
 {

--W/nzBZO5zC0uMSeA--
