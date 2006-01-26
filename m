Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWAZQNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWAZQNA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 11:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWAZQNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 11:13:00 -0500
Received: from main.gmane.org ([80.91.229.2]:14774 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964785AbWAZQM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 11:12:59 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [RFT] sky2: pci express error fix
Date: Fri, 27 Jan 2006 01:11:20 +0900
Message-ID: <drasb9$5jj$1@sea.gmane.org>
References: <200601190930.k0J9US4P009504@typhaon.pacific.net.au> <20060124220533.5fade501@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060115)
In-Reply-To: <20060124220533.5fade501@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> For all those people suffering with pci express errors
> on the sky2 driver.  The problem is the PCI subsystem sometimes
> won't let the sky2 driver write to PCI express registers. It depends
> on the phase of the moon (actually ACPI) and number of devices.
> 
> Anyway, this should fix it. Please tell me if it solves it for you.

Can you describe the bug a bit more? What happens?

I had a few times something like this:

[   24.145040] sky2 eth0: phy interrupt status 0x1c40 0xbc0c

[ 3647.341757] sky2 eth0: phy interrupt status 0x1c40 0xbc4c

after which all network was dead. (and it wasn't a module so had to
restart). As you can see from the above two logs, sometimes it failed on
boot, sometimes after an hour. Sourry, I didn't remember the phase of the
moon, but I can check :-)

I have two Asus P5GDC-V Deluxe boards, with these chips. One of them is
happily working with sk98lin (the binary one), the other is dying miserably,
so now I use r8169 card to be able to isolate the problem (separate mail).

Kalin.

> 
> 
> --- sky2-2.6.orig/drivers/net/sky2.c
> +++ sky2-2.6/drivers/net/sky2.c
> @@ -2003,19 +2003,16 @@ static void sky2_hw_intr(struct sky2_hw 
>  
>  	if (status & Y2_IS_PCI_EXP) {
>  		/* PCI-Express uncorrectable Error occurred */
> -		u32 pex_err;
> -
> -		pci_read_config_dword(hw->pdev, PEX_UNC_ERR_STAT, &pex_err);
> +		u32 pex_err = sky2_read32(hw, PCI_C(PEX_UNC_ERR_STAT));
>  
>  		if (net_ratelimit())
>  			printk(KERN_ERR PFX "%s: pci express error (0x%x)\n",
>  			       pci_name(hw->pdev), pex_err);
>  
>  		/* clear the interrupt */
> -		sky2_write32(hw, B2_TST_CTRL1, TST_CFG_WRITE_ON);
> -		pci_write_config_dword(hw->pdev, PEX_UNC_ERR_STAT,
> -				       0xffffffffUL);
> -		sky2_write32(hw, B2_TST_CTRL1, TST_CFG_WRITE_OFF);
> +		sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_ON);
> +		sky2_write32(hw, PCI_CI(PEX_UNC_ERR_STAT), 0xffffffffUL);
> +		sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_OFF);
>  
>  		if (pex_err & PEX_FATAL_ERRORS) {
>  			u32 hwmsk = sky2_read32(hw, B0_HWE_IMSK);
> @@ -2181,12 +2178,8 @@ static int sky2_reset(struct sky2_hw *hw
>  	sky2_write8(hw, B0_CTST, CS_MRST_CLR);
>  
>  	/* clear any PEX errors */
> -	if (is_pciex(hw)) {
> -		u16 lstat;
> -		pci_write_config_dword(hw->pdev, PEX_UNC_ERR_STAT,
> -				       0xffffffffUL);
> -		pci_read_config_word(hw->pdev, PEX_LNK_STAT, &lstat);
> -	}
> +	if (pci_find_capability(hw->pdev, PCI_CAP_ID_EXP))
> +		sky2_write32(hw, PCI_C(PEX_UNC_ERR_STAT), 0xffffffffUL);
>  
>  	pmd_type = sky2_read8(hw, B2_PMD_TYP);
>  	hw->copper = !(pmd_type == 'L' || pmd_type == 'S');
> --- sky2-2.6.orig/drivers/net/sky2.h
> +++ sky2-2.6/drivers/net/sky2.h
> @@ -183,6 +183,12 @@ enum csr_regs {
>  	Y2_CFG_SPC	= 0x1c00,
>  };
>  
> +/* Workaround for ACPI limitations in pci support.
> + * Sometimes it is impossible to access registers > 256 with
> + * pci_{read/write}_config_dword
> + */
> +#define PCI_C(reg)	(Y2_CFG_SPC + reg)
> +
>  /*	B0_CTST			16 bit	Control/Status register */
>  enum {
>  	Y2_VMAIN_AVAIL	= 1<<17,/* VMAIN available (YUKON-2 only) */


-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

