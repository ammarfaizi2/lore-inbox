Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbUFWWHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUFWWHl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUFWWFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:05:48 -0400
Received: from fmr06.intel.com ([134.134.136.7]:31711 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261763AbUFWWEj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 18:04:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]2.6.7 MSI-X Update
Date: Wed, 23 Jun 2004 15:03:19 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502405843FF0@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]2.6.7 MSI-X Update
Thread-Index: AcRZRJdc6fCh/4lqSUy89lfQB+Gs9AAJfT5w
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Roland Dreier" <roland@topspin.com>,
       "long" <tlnguyen@snoqualmie.dp.intel.com>
Cc: <ak@muc.de>, <akpm@osdl.org>, <greg@kroah.com>, <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>, <zwane@linuxpower.ca>,
       <eli@mellanox.co.il>
X-OriginalArrivalTime: 23 Jun 2004 22:03:21.0065 (UTC) FILETIME=[E58B8590:01C4596D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, June 23, 2004 Roland Dreier wrote:
> OK, yet another comment on this update :)
>
>Overall I like the idea of separating MSI and MSI-X support and
>getting rid of the msi_alloc_vectors()/msi_free_vectors().  However it
>seems there is a slight asymmetry in how MSI-X is handled now.
>
>If a driver calls pci_enable_msix() (and the call succeeds), then the
>device is immediately put into MSI-X mode -- that is, the enable bit
>of its MSI-X capability is set.  However, this bit will not be cleared
>until the driver calls free_irq() for the last MSI-X vector.
>
>This means that for a driver to clear the MSI-X enable bit, it must
>first do request_irq() on all the vectors it was assigned and then
>call free_irq().  It seems quite possible to me that a driver may not
>use all the MSI-X vectors it is assigned, so device cleanup becomes a
>problem.  Also, there is no way for the driver to free its unused
>MSI-X vectors.
>
>It seems we need a pci_disable_msix() call to match the
>pci_enable_msix() call.  (And remove the disabling of MSI-X from the
>free_irq code path) 
>
>I guess there is actually a similar problem with MSI -- if a driver
>calls pci_enable_msi(), MSI will not be disabled until the driver does
>request_irq/free_irq.  This is not quite as serious because a driver
>is unlikely not to use the since MSI vector it gets, but it is still a
>problem for error cleanup paths.  So maybe we need pci_disable_msi()
>as well.
>
>What do you think?
It was my initial thought. However, below two reasons convince me that 
the patch should enforce the rules to ensure that the software device 
driver behaves properly.

-The software driver is responsible for asking how many vectors 
it actually needs to serivce its hardward needs. Why does it asks for 
more than what it actually uses?
-Assuming I add pci_disable_msix() API, then there are two consequences
for this approach. It would be a problem for the kernel to determine 
whether the MSI vectors are unhooked cleanly from their corresponding 
driver ISR before freeing these MSI vectors for reuse purpose on other 
devices. If there is an error in the driver, it may result an 
unexpected behavior. Second, for example if a driver asks for 10 MSI 
vector for the first time and decides to call pci_disable_msix() to free
up 5. If the driver switches interrupt mode back and forth, the next MSI
request by calling pci_enable_msix() will result 5 given instead of 10.

Please tell me what you think?

Thanks,
Long

