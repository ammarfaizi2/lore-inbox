Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbTKLDu0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 22:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbTKLDu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 22:50:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27846 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261509AbTKLDuU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 22:50:20 -0500
Message-ID: <3FB1ADEC.80600@pobox.com>
Date: Tue, 11 Nov 2003 22:50:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Daniel Craig <dancraig@internode.on.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-bk16 ALi M5229 kernel boot error
References: <Pine.LNX.4.44.0311111901490.1694-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0311111901490.1694-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Wed, 12 Nov 2003, Daniel Craig wrote:
> 
>>Does anyone have any idea what might be going wrong...?
> 
> 
> Yes. The ALI driver has some really strange code to avoid tweaking non-ALI 
> southbridges. 
> 
> But the thing is, it breaks even _with_ ALI southbridges, if we just don't 
> find the ALI bridge we expect.
> 
> Does this patch fix it?
> 
> 		Linus
> 
> ---
> --- 1.15/drivers/ide/pci/alim15x3.c	Sun Aug 24 15:33:30 2003
> +++ edited/drivers/ide/pci/alim15x3.c	Tue Nov 11 19:03:21 2003
> @@ -578,7 +578,6 @@
>  {
>  	unsigned long flags;
>  	u8 tmpbyte;
> -	struct pci_dev *north = pci_find_slot(0, PCI_DEVFN(0,0));
>  
>  	pci_read_config_byte(dev, PCI_REVISION_ID, &m5229_revision);
>  
> @@ -625,11 +624,9 @@
>  
>  	/*
>  	 * We should only tune the 1533 enable if we are using an ALi
> -	 * North bridge. We might have no north found on some zany
> -	 * box without a device at 0:0.0. The ALi bridge will be at
> -	 * 0:0.0 so if we didn't find one we know what is cooking.
> +	 * south bridge.
>  	 */
> -	if (north && north->vendor != PCI_VENDOR_ID_AL) {
> +	if (!isa_dev) {
>  		local_irq_restore(flags);
>  	        return 0;


For a little bit of history, this 'if' test succeeds on Alpha.  We 
return here on Alpha to avoid x86-specific stuff.

Al, any chance you could test Linus's patch?  It hinges on whether the 
Alpha will match the southbridge (isa_dev), rather than the northbridge. 
  This seems like a safe bet, but better to test and be sure...

	Jeff



