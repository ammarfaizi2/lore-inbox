Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWFGIY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWFGIY7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 04:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWFGIY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 04:24:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35970 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751125AbWFGIY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 04:24:58 -0400
Date: Wed, 7 Jun 2006 09:24:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org,
       Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 4/4] Make Emulex lpfc driver legacy I/O port free
Message-ID: <20060607082448.GA31004@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Greg KH <greg@kroah.com>, akpm@osdl.org,
	Rajesh Shah <rajesh.shah@intel.com>,
	Grant Grundler <grundler@parisc-linux.org>,
	"bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@atrey.karlin.mff.cuni.cz
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com> <447FA920.9060509@jp.fujitsu.com> <4484263C.1030508@jp.fujitsu.com> <20060606075812.GB19619@kroah.com> <448643B9.2080805@jp.fujitsu.com> <448644D6.9030907@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448644D6.9030907@jp.fujitsu.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 12:15:34PM +0900, Kenji Kaneshige wrote:
> This patch makes Emulex lpfc driver legacy I/O port free.

Your interface for this is really horrible ;-)

> +	int bars = pci_select_bars(pdev, IORESOURCE_MEM);
>  
> -	if (pci_enable_device(pdev))
> +	if (pci_enable_device_bars(pdev, bars))
>  		goto out;
> -	if (pci_request_regions(pdev, LPFC_DRIVER_NAME))
> +	if (pci_request_selected_regions(pdev, bars, LPFC_DRIVER_NAME))
>  		goto out_disable_device;

Please make this something like:

	if (pci_enable_device_noioport(pdev))
		goto out;
	if (pci_request_regions(pdev, LPFC_DRIVER_NAME))
		goto out_disable_device;

as in:

 - get rid of this awkward pci_select_bars function, the pci_enable* function
   should do all the work and add a flag to struct pci_dev so that all other
   functions do the right thing.

