Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264874AbVBDQq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbVBDQq5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 11:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVBDQq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 11:46:57 -0500
Received: from zeus.kernel.org ([204.152.189.113]:56721 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264874AbVBDQqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 11:46:42 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
Subject: Re: [PATCH] PCI: fix pci_remove_legacy_files() crash
Date: Fri, 4 Feb 2005 08:45:44 -0800
User-Agent: KMail/1.7.2
Cc: Greg KH <greg@kroah.com>, John Rose <johnrose@austin.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
References: <87zmyl2ecb.wl%muneda.takahiro@jp.fujitsu.com>
In-Reply-To: <87zmyl2ecb.wl%muneda.takahiro@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502040845.44954.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 3, 2005 7:28 pm, MUNEDA Takahiro wrote:
> Hi,
>
> The legacy_io which is the member of pci_bus struct might be
> NULL. It should be checked.
>
> This patch checks 'b->legacy_io', NULL or not.
>
> Signed-off-by: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
>
> ---
>
>  probe.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
>
> diff -Npur a/drivers/pci/probe.c b/drivers/pci/probe.c
> --- a/drivers/pci/probe.c 2005-01-31 13:31:27.000000000 +0900
> +++ b/drivers/pci/probe.c 2005-02-03 11:21:51.000000000 +0900
> @@ -64,9 +64,11 @@ static void pci_create_legacy_files(stru
>
>  void pci_remove_legacy_files(struct pci_bus *b)
>  {
> - class_device_remove_bin_file(&b->class_dev, b->legacy_io);
> - class_device_remove_bin_file(&b->class_dev, b->legacy_mem);
> - kfree(b->legacy_io); /* both are allocated here */
> + if (b->legacy_io) {
> +  class_device_remove_bin_file(&b->class_dev, b->legacy_io);
> +  class_device_remove_bin_file(&b->class_dev, b->legacy_mem);
> +  kfree(b->legacy_io); /* both are allocated here */
> + }
>  }
>  #else /* !HAVE_PCI_LEGACY */
>  static inline void pci_create_legacy_files(struct pci_bus *bus) { return;
> }

Thanks, though the case where b->legacy_io is NULL should be very rare (it'll 
only happen if the initialization can't get memory for b->legacy_io), it's 
still a possibility so this fix is needed.

Acked-by: Jesse Barnes <jbarnes@sgi.com>
