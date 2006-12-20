Return-Path: <linux-kernel-owner+w=401wt.eu-S965054AbWLTNkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbWLTNkl (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 08:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbWLTNkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 08:40:41 -0500
Received: from kagl.donpac.ru ([80.254.111.32]:38368 "EHLO donpac.ru"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965054AbWLTNkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 08:40:40 -0500
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 08:40:39 EST
Date: Wed, 20 Dec 2006 16:33:10 +0300
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add support for Korenix 16C950-based PCI cards
Message-ID: <20061220133310.GA28555@pazke.donpac.ru>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20061213144546.GA23951@dyn-67.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20061213144546.GA23951@dyn-67.arm.linux.org.uk>
X-Uname: Linux 2.6.18-1-amd64 x86_64
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 347, 12 13, 2006 at 02:45:46PM +0000, Russell King wrote:
> Linus, Andrew,
> 
> This patch adds initial support to 8250-pci for the Korenix Jetcard PCI
> serial cards.  The JC12xx cards are standard RS232-based serial cards
> utilising the Oxford 16C950 device.
> 
> The JC14xx are RS422/RS485-based cards, but in order for these to be
> supported natively, we will need additional tweaks to the 8250 layers
> so we can specify some values for the 950's registers.  Hence, these
> two entries are commented out.

IIRC 16c950 just need two bits in ACR set properly. Will attached patch 
do the trick ?

> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
>  drivers/serial/8250_pci.c |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
> index 4d0ff8f..89c3f2c 100644
> --- a/drivers/serial/8250_pci.c
> +++ b/drivers/serial/8250_pci.c
> @@ -2239,6 +2239,30 @@ static struct pci_device_id serial_pci_t
>  		pbn_b0_bt_1_460800 },
>  
>  	/*
> +	 * Korenix Jetcard F0/F1 cards (JC1204, JC1208, JC1404, JC1408).
> +	 * Cards are identified by their subsystem vendor IDs, which
> +	 * (in hex) match the model number.
> +	 *
> +	 * Note that JC140x are RS422/485 cards which require ox950
> +	 * ACR = 0x10, and as such are not currently fully supported.
> +	 */
> +	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
> +		0x1204, 0x0004, 0, 0,
> +		pbn_b0_4_921600 },
> +	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
> +		0x1208, 0x0004, 0, 0,
> +		pbn_b0_4_921600 },
> +/*	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
> +		0x1402, 0x0002, 0, 0,
> +		pbn_b0_2_921600 }, */
> +/*	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF0,
> +		0x1404, 0x0004, 0, 0,
> +		pbn_b0_4_921600 }, */
> +	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF1,
> +		0x1208, 0x0004, 0, 0,
> +		pbn_b0_4_921600 },
> +
> +	/*
>  	 * Dell Remote Access Card 4 - Tim_T_Murphy@Dell.com
>  	 */
>  	{	PCI_VENDOR_ID_DELL, PCI_DEVICE_ID_DELL_RAC4,

-- 
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ACR

diff -urdpNX /usr/share/dontdiff -x Makefile linux-2.6.19.vanilla/drivers/serial/8250.c linux-2.6.19/drivers/serial/8250.c
--- linux-2.6.19.vanilla/drivers/serial/8250.c	2006-12-19 20:18:26.000000000 +0300
+++ linux-2.6.19/drivers/serial/8250.c	2006-12-19 19:53:04.000000000 +0300
@@ -1548,7 +1548,7 @@ static int serial8250_startup(struct uar
 
 	if (up->port.type == PORT_16C950) {
 		/* Wake up and initialize UART */
-		up->acr = 0;
+		up->acr = port->initial_acr;
 		serial_outp(up, UART_LCR, 0xBF);
 		serial_outp(up, UART_EFR, UART_EFR_ECB);
 		serial_outp(up, UART_IER, 0);
@@ -2599,6 +2599,7 @@ int serial8250_register_port(struct uart
 		uart->port.iotype   = port->iotype;
 		uart->port.flags    = port->flags | UPF_BOOT_AUTOCONF;
 		uart->port.mapbase  = port->mapbase;
+		uart->port.initial_acr = port->initial_acr;
 		if (port->dev)
 			uart->port.dev = port->dev;
 
diff -urdpNX /usr/share/dontdiff -x Makefile linux-2.6.19.vanilla/drivers/serial/8250.h linux-2.6.19/drivers/serial/8250.h
--- linux-2.6.19.vanilla/drivers/serial/8250.h	2006-12-19 20:44:12.000000000 +0300
+++ linux-2.6.19/drivers/serial/8250.h	2006-12-19 20:28:29.000000000 +0300
@@ -29,6 +29,8 @@ struct old_serial_port {
 	unsigned short iomem_reg_shift;
 };
 
+#define initial_acr unused[0]
+
 /*
  * This replaces serial_uart_config in include/linux/serial.h
  */

--mP3DRpeJDSE+ciuQ--
