Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263783AbTDGXT0 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263886AbTDGXPU (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:15:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26511 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263788AbTDGXCK (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 19:02:10 -0400
Message-ID: <3E92064C.9080306@pobox.com>
Date: Mon, 07 Apr 2003 19:14:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] xircom_cb release memory on failure
References: <Pine.LNX.4.50.0304061635500.2268-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0304061635500.2268-100000@montezuma.mastecende.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> This patch switches free'ing to pci_free_consistent and fixes a memory 
> leak plus a few small cleanups.
> 
> Index: linux-2.5.66/drivers/net/tulip/xircom_cb.c
> ===================================================================
> RCS file: /build/cvsroot/linux-2.5.66/drivers/net/tulip/xircom_cb.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 xircom_cb.c
> --- linux-2.5.66/drivers/net/tulip/xircom_cb.c	24 Mar 2003 23:39:20 -0000	1.1.1.1
> +++ linux-2.5.66/drivers/net/tulip/xircom_cb.c	6 Apr 2003 20:25:44 -0000
> @@ -73,6 +73,8 @@ MODULE_LICENSE("GPL");
>  /* Offsets of the buffers within the descriptor pages, in bytes */
>  
>  #define NUMDESCRIPTORS 4
> +#define RX_BUF_SIZE	8192
> +#define TX_BUF_SIZE	8192
>  
>  static int bufferoffsets[NUMDESCRIPTORS] = {128,2048,4096,6144};
>  
> @@ -96,7 +98,7 @@ struct xircom_private {
>  	int transmit_used;
>  
>  	/* Spinlock to serialize register operations.
> -	   It must be helt while manipulating the following registers:
> +	   It must be held whilst manipulating the following registers:
>  	   CSR0, CSR6, CSR7, CSR9, CSR10, CSR15
>  	 */
>  	spinlock_t lock;
> @@ -220,12 +222,13 @@ static int __devinit xircom_probe(struct
>  	unsigned char chip_rev;
>  	unsigned long flags;
>  	unsigned short tmp16;
> +	int ret = -EIO;
>  	enter("xircom_probe");
>  	
>  	/* First do the PCI initialisation */
>  
>  	if (pci_enable_device(pdev))
> -		return -ENODEV;
> +		goto out;

regression: no longer calls leave() as intended


>  
>  	/* disable all powermanagement */
>  	pci_write_config_dword(pdev, PCI_POWERMGMT, 0x0000);
> @@ -250,30 +254,27 @@ static int __devinit xircom_probe(struct
>  	   is available. 
>  	 */
>  	private = kmalloc(sizeof(*private),GFP_KERNEL);
> -	memset(private, 0, sizeof(struct xircom_private));
> +	if (private == NULL)
> +		goto out_region;
> +
> +	memset(private, 0, sizeof(*private));

see davej's patches -- not needed.  get alloc_etherdev() to allocate and 
free dev->priv, and eliminate this memset altogether.  That in turn 
simplifies what you are trying to do here.

	Jeff



