Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266585AbUFWRHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbUFWRHs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 13:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUFWRHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 13:07:48 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:55076 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266585AbUFWRHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 13:07:31 -0400
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: ak@muc.de, akpm@osdl.org, greg@kroah.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com,
       zwane@linuxpower.ca, eli@mellanox.co.il
Subject: Re: [PATCH]2.6.7 MSI-X Update
X-Message-Flag: Warning: May contain useful information
References: <200406222148.i5MLmA4Y001949@snoqualmie.dp.intel.com>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 23 Jun 2004 09:50:21 -0700
In-Reply-To: <200406222148.i5MLmA4Y001949@snoqualmie.dp.intel.com> (long's
 message of "Tue, 22 Jun 2004 14:48:10 -0700")
Message-ID: <523c4mi5gy.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Jun 2004 16:50:21.0345 (UTC) FILETIME=[2BF5A910:01C45942]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, yet another comment on this update :)

Overall I like the idea of separating MSI and MSI-X support and
getting rid of the msi_alloc_vectors()/msi_free_vectors().  However it
seems there is a slight asymmetry in how MSI-X is handled now.

If a driver calls pci_enable_msix() (and the call succeeds), then the
device is immediately put into MSI-X mode -- that is, the enable bit
of its MSI-X capability is set.  However, this bit will not be cleared
until the driver calls free_irq() for the last MSI-X vector.

This means that for a driver to clear the MSI-X enable bit, it must
first do request_irq() on all the vectors it was assigned and then
call free_irq().  It seems quite possible to me that a driver may not
use all the MSI-X vectors it is assigned, so device cleanup becomes a
problem.  Also, there is no way for the driver to free its unused
MSI-X vectors.

It seems we need a pci_disable_msix() call to match the
pci_enable_msix() call.  (And remove the disabling of MSI-X from the
free_irq code path) 

I guess there is actually a similar problem with MSI -- if a driver
calls pci_enable_msi(), MSI will not be disabled until the driver does
request_irq/free_irq.  This is not quite as serious because a driver
is unlikely not to use the since MSI vector it gets, but it is still a
problem for error cleanup paths.  So maybe we need pci_disable_msi()
as well.

What do you think?

Thanks,
  Roland
