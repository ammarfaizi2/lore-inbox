Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266205AbUGOCVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266205AbUGOCVA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 22:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbUGOCVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 22:21:00 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:25449 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266205AbUGOCUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 22:20:54 -0400
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: ak@muc.de, akpm@osdl.org, greg@kroah.com, jgazik@pobox.com,
       linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com,
       zwane@linuxpower.ca
Subject: Re: [PATCH]2.6.7 MSI-X Update
X-Message-Flag: Warning: May contain useful information
References: <200407132202.i6DM2hRa007928@snoqualmie.dp.intel.com>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 14 Jul 2004 19:14:22 -0700
In-Reply-To: <200407132202.i6DM2hRa007928@snoqualmie.dp.intel.com> (long's
 message of "Tue, 13 Jul 2004 15:02:43 -0700")
Message-ID: <528ydmqao1.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Jul 2004 02:14:22.0144 (UTC) FILETIME=[71528C00:01C46A11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Long, welcome back.  I will review your patch as soon as I have a
little free time.

    Roland> 2) removing this overloaded function from free_irq() will
    Roland> also make driver code clearer and easier to maintain.

    long> I need this overloaded function to keep track of the state
    long> of each MSI/MSI-X vector. This allows me to generate a
    long> BUG_ON() if driver calls
    long> pci_disable_msi()/pci_disable_msix() without calling
    long> free_irq() for all MSI/MSI-X vector(s).

I think it's OK to keep track of which MSI/MSI-X vectors have ISRs
attached and which don't.  However I don't think free_irq() should
return a vector to the free pool (that might be used by other
devices).  In other words it should be OK for a correct driver to do

	pci_enable_msix(pdev...);
	request_irq(msix_vector1);
	free_irq(msix_vector1);
	request_irq(msix_vector1);
	free_irq(msix_vector1);
	pci_disable_msix(pdev...);

(obviously with some code in between operations).

I think we agree on this and I will read your code to find out what
you actually do but I just wanted to make my proposed interface clear.

Thanks,
  Roland
