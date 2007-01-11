Return-Path: <linux-kernel-owner+w=401wt.eu-S965334AbXAKIIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965334AbXAKIIG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 03:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965330AbXAKIIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 03:08:05 -0500
Received: from hera.kernel.org ([140.211.167.34]:48723 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965323AbXAKIIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 03:08:04 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [2.6.20-rc4 regression] ibm-acpi: bay support disabled
Date: Thu, 11 Jan 2007 02:59:11 -0500
User-Agent: KMail/1.9.5
Cc: Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org,
       ibm-acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20070109172845.GA3528@khazad-dum.debian.net> <20070109174534.GN25007@stusta.de> <20070109185422.GB3528@khazad-dum.debian.net>
In-Reply-To: <20070109185422.GB3528@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701110259.12094.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reverted.

thanks,
-Len

On Tuesday 09 January 2007 13:54, Henrique de Moraes Holschuh wrote:
> On Tue, 09 Jan 2007, Adrian Bunk wrote:
> > > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > > index 1639998..34cc8d5 100644
> > > --- a/drivers/acpi/Kconfig
> > > +++ b/drivers/acpi/Kconfig
> > > @@ -215,26 +215,29 @@ config ACPI_IBM
> > >  config ACPI_IBM_DOCK
> > >  	bool "Legacy Docking Station Support"
> > >  	depends on ACPI_IBM
> > > -	depends on ACPI_DOCK=n
> > > -	default n
> > > +	depends on ! ACPI_DOCK
> > > +	default y
> > >...
> > 
> > !ACPI_DOCK is wrong if the intention was ACPI_DOCK=n (since ACPI_DOCK is 
> > a tristate).
> 
> Actually, the intention is to give a sensible default AND to avoid
> ACPI_DOCK=y && ACPI_IBM_DOCK=y.  The same goes for ACPI_BAY.  An user is
> certainly entitled to have both as modules (e.g. to see if ACPI_DOCK or
> ACPI_BAY works in his ThinkPad).
> 
> Even better would be to detect it at runtime, and disable the specific
> support in ibm-acpi if the generic support is loaded.  But that's something
> to try in -mm and target 2.6.21 or 2.6.22.
> 
> > I'd say the right fix is to remove the negative dependencies on unmerged 
> > options and reintroduce them once these options themselves got merged.
> 
> Well, as long as the regression is fixed, I am happy.  Here is an
> alternative patch, that reverts the problematic commit,
> 2df910b4c3edcce9a0c12394db6f5f4a6e69c712.
> 
> -- 
>   "One disk to rule them all, One disk to find them. One disk to bring
>   them all and in the darkness grind them. In the Land of Redmond
>   where the shadows lie." -- The Silicon Valley Tarot
>   Henrique Holschuh
> 
> From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> 
> ACPI: ibm-acpi: allow bay support to work in mainline
> 
> This patch reverts commit 2df910b4c3edcce9a0c12394db6f5f4a6e69c712.
> 
> ACPI_BAY has not been merged into mainline yet, so the changes to ibm-acpi
> related Kconfig entries that depend on ACPI_BAY were permanently disabling
> ibm-acpi bay support.  This is a serious regression for ThinkPad users.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> ---
>  drivers/acpi/Kconfig    |   11 -----------
>  drivers/acpi/ibm_acpi.c |   13 +------------
>  2 files changed, 1 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1639998..f4f000a 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -225,17 +225,6 @@ config ACPI_IBM_DOCK
>  
>  	  If you are not sure, say N here.
>  
> -config ACPI_IBM_BAY
> -	bool "Legacy Removable Bay Support"
> -	depends on ACPI_IBM
> -	depends on ACPI_BAY=n
> -	default n
> -	---help---
> -	  Allows the ibm_acpi driver to handle removable bays.
> -	  This support is obsoleted by CONFIG_ACPI_BAY.
> -
> -	  If you are not sure, say N here.
> -
>  config ACPI_TOSHIBA
>  	tristate "Toshiba Laptop Extras"
>  	depends on X86
> diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
> index b72d13d..c6144ca 100644
> --- a/drivers/acpi/ibm_acpi.c
> +++ b/drivers/acpi/ibm_acpi.c
> @@ -157,7 +157,6 @@ IBM_HANDLE(dock, root, "\\_SB.GDCK",	/* X30, X31, X40 */
>  	   "\\_SB.PCI.ISA.SLCE",	/* 570 */
>      );				/* A21e,G4x,R30,R31,R32,R40,R40e,R50e */
>  #endif
> -#ifdef CONFIG_ACPI_IBM_BAY
>  IBM_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",	/* 570 */
>  	   "\\_SB.PCI0.IDE0.IDES.IDSM",	/* 600e/x, 770e, 770x */
>  	   "\\_SB.PCI0.SATA.SCND.MSTR",	/* T60, X60, Z60 */ 
> @@ -175,7 +174,6 @@ IBM_HANDLE(bay2, root, "\\_SB.PCI0.IDE0.PRIM.SLAV",	/* A3x, R32 */
>  IBM_HANDLE(bay2_ej, bay2, "_EJ3",	/* 600e/x, 770e, A3x */
>  	   "_EJ0",		/* 770x */
>      );				/* all others */
> -#endif
>  
>  /* don't list other alternatives as we install a notify handler on the 570 */
>  IBM_HANDLE(pci, root, "\\_SB.PCI");	/* 570 */
> @@ -1042,7 +1040,6 @@ static int light_write(char *buf)
>  	return 0;
>  }
>  
> -#if defined(CONFIG_ACPI_IBM_DOCK) || defined(CONFIG_ACPI_IBM_BAY)
>  static int _sta(acpi_handle handle)
>  {
>  	int status;
> @@ -1052,7 +1049,7 @@ static int _sta(acpi_handle handle)
>  
>  	return status;
>  }
> -#endif
> +
>  #ifdef CONFIG_ACPI_IBM_DOCK
>  #define dock_docked() (_sta(dock_handle) & 1)
>  
> @@ -1118,7 +1115,6 @@ static void dock_notify(struct ibm_struct *ibm, u32 event)
>  }
>  #endif
>  
> -#ifdef CONFIG_ACPI_IBM_BAY
>  static int bay_status_supported;
>  static int bay_status2_supported;
>  static int bay_eject_supported;
> @@ -1194,7 +1190,6 @@ static void bay_notify(struct ibm_struct *ibm, u32 event)
>  {
>  	acpi_bus_generate_event(ibm->device, event, 0);
>  }
> -#endif
>  
>  static int cmos_read(char *p)
>  {
> @@ -2354,7 +2349,6 @@ static struct ibm_struct ibms[] = {
>  	 .type = ACPI_SYSTEM_NOTIFY,
>  	 },
>  #endif
> -#ifdef CONFIG_ACPI_IBM_BAY
>  	{
>  	 .name = "bay",
>  	 .init = bay_init,
> @@ -2364,7 +2358,6 @@ static struct ibm_struct ibms[] = {
>  	 .handle = &bay_handle,
>  	 .type = ACPI_SYSTEM_NOTIFY,
>  	 },
> -#endif
>  	{
>  	 .name = "cmos",
>  	 .read = cmos_read,
> @@ -2650,9 +2643,7 @@ IBM_PARAM(light);
>  #ifdef CONFIG_ACPI_IBM_DOCK
>  IBM_PARAM(dock);
>  #endif
> -#ifdef CONFIG_ACPI_IBM_BAY
>  IBM_PARAM(bay);
> -#endif
>  IBM_PARAM(cmos);
>  IBM_PARAM(led);
>  IBM_PARAM(beep);
> @@ -2735,14 +2726,12 @@ static int __init acpi_ibm_init(void)
>  	IBM_HANDLE_INIT(dock);
>  #endif
>  	IBM_HANDLE_INIT(pci);
> -#ifdef CONFIG_ACPI_IBM_BAY
>  	IBM_HANDLE_INIT(bay);
>  	if (bay_handle)
>  		IBM_HANDLE_INIT(bay_ej);
>  	IBM_HANDLE_INIT(bay2);
>  	if (bay2_handle)
>  		IBM_HANDLE_INIT(bay2_ej);
> -#endif
>  	IBM_HANDLE_INIT(beep);
>  	IBM_HANDLE_INIT(ecrd);
>  	IBM_HANDLE_INIT(ecwr);
