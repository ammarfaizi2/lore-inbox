Return-Path: <linux-kernel-owner+w=401wt.eu-S964781AbXABMHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbXABMHz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbXABMHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:07:55 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:12183 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964781AbXABMHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:07:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o+Ygm1BM0Fdlhu/K+gZoYEmhtd0u+Aehp/Pu3M40JS0SLuRaln8WxF1pmTAkrOddqU+5NbCJ9hLodVzIEDxKIsThbLDKc9gIiJoU2iJNLRBPtdwEF3NSYufWqFASLBg00n+8B49kwJ+izEgu433NLntIYbcOja3WrscdEQjwHr0=
Message-ID: <5a4c581d0701020407w7c0c768bk7ce3ab2d2d7f19f5@mail.gmail.com>
Date: Tue, 2 Jan 2007 13:07:53 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: fix combined mode (was Re: Happy New Year (and v2.6.20-rc3 released))
Cc: "Jeff Garzik" <jgarzik@pobox.com>, "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <20070102115834.1e7644b2@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
	 <5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>
	 <Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>
	 <459973F6.2090201@pobox.com>
	 <20070102115834.1e7644b2@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> This is a slight variant on the patch I posted December 16th to fix
> libata combined mode handling. The only real change is that we now
> correctly also reserve BAR1,2,4. That is basically a neatness issue.
>
> Jeff was unhappy about two things
>
> 1. That it didn't work in the case of one channel native one channel
> legacy.
>
> This is a silly complaint because the SFF layer in libata doesn't handle
> this case yet anyway.
>
> 2. The case where combined mode is in use and IDE=n.
>
> In this case the libata quirk code reserves the resources in question
> correctly already.
>
> Once the combined mode stuff is redone properly (2.6.21) then the entire
> mess turns into a single pci_request_regions() for all cases and all the
> ugly resource hackery goes away.
>
> I'm sending this now rather than after running full test suites so that
> it can get the maximal testing in a short time. I'll be running tests on
> this after lunch.
>
> Signed-off-by: Alan Cox <alan@redhat.com>
>
> --- linux.vanilla-2.6.20-rc3/drivers/ata/libata-sff.c   2007-01-01 21:43:27.000000000 +0000
> +++ linux-2.6.20-rc3/drivers/ata/libata-sff.c   2007-01-02 11:15:53.000000000 +0000
> @@ -1027,13 +1027,15 @@
>  #endif
>         }
>
> -       rc = pci_request_regions(pdev, DRV_NAME);
> -       if (rc) {
> -               disable_dev_on_err = 0;
> -               goto err_out;
> -       }
> -
> -       if (legacy_mode) {
> +       if (!legacy_mode) {
> +               rc = pci_request_regions(pdev, DRV_NAME);
> +               if (rc) {
> +                       disable_dev_on_err = 0;
> +                       goto err_out;
> +               }
> +       } else {
> +               /* Deal with combined mode hack. This side of the logic all
> +                  goes away once the combined mode hack is killed in 2.6.21 */
>                 if (!request_region(ATA_PRIMARY_CMD, 8, "libata")) {
>                         struct resource *conflict, res;
>                         res.start = ATA_PRIMARY_CMD;
> @@ -1071,6 +1073,13 @@
>                         }
>                 } else
>                         legacy_mode |= ATA_PORT_SECONDARY;
> +
> +               if (legacy_mode & ATA_PORT_PRIMARY)
> +                       pci_request_region(pdev, 1, DRV_NAME);
> +               if (legacy_mode & ATA_PORT_SECONDARY)
> +                       pci_request_region(pdev, 3, DRV_NAME);
> +               /* If there is a DMA resource, allocate it */
> +               pci_request_region(pdev, 4, DRV_NAME);
>         }
>
>         /* we have legacy mode, but all ports are unavailable */
> @@ -1114,11 +1123,20 @@
>  err_out_ent:
>         kfree(probe_ent);
>  err_out_regions:
> -       if (legacy_mode & ATA_PORT_PRIMARY)
> -               release_region(ATA_PRIMARY_CMD, 8);
> -       if (legacy_mode & ATA_PORT_SECONDARY)
> -               release_region(ATA_SECONDARY_CMD, 8);
> -       pci_release_regions(pdev);
> +       /* All this conditional stuff is needed for the combined mode hack
> +          until 2.6.21 when it can go */
> +       if (legacy_mode) {
> +               pci_release_region(pdev, 4);
> +               if (legacy_mode & ATA_PORT_PRIMARY) {
> +                       release_region(ATA_PRIMARY_CMD, 8);
> +                       pci_release_region(pdev, 1);
> +               }
> +               if (legacy_mode & ATA_PORT_SECONDARY) {
> +                       release_region(ATA_SECONDARY_CMD, 8);
> +                       pci_release_region(pdev, 3);
> +               }
> +       } else
> +               pci_release_regions(pdev);
>  err_out:
>         if (disable_dev_on_err)
>                 pci_disable_device(pdev);
>

Appears to work just fine here (compiles, boots and I'm
 typing this email :).  The build warnings below seem new
 to me - but I guess they're harmless...

  CC      drivers/ata/libata-sff.o
drivers/ata/libata-sff.c: In function 'ata_pci_init_one':
drivers/ata/libata-sff.c:1078: warning: ignoring return value of
'pci_request_region', declared with attribute warn_unused_result
drivers/ata/libata-sff.c:1080: warning: ignoring return value of
'pci_request_region', declared with attribute warn_unused_result
drivers/ata/libata-sff.c:1082: warning: ignoring return value of
'pci_request_region', declared with attribute warn_unused_result

Thanks, ciao,

--alessandro

 "but I thought that I should let you know
  the things that I don't always show
  might not be worth the time it took"

     (Steve Wynn, 'If My Life Was An Open Book')
