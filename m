Return-Path: <linux-kernel-owner+w=401wt.eu-S932446AbWLLVrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWLLVrF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 16:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWLLVrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 16:47:05 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:14794 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932446AbWLLVrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 16:47:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CpzULSLOjhXzFr5qmTcteiX4OK828Rgtlm9VQPegjbXc+VDJM4Sp4s8DhUSGm/bQsKVgz0gCc6aLo1giDRqWa57rCNFeEOijvWyUgqf7teOD7SCGamKI49ZG5XPeJ6MOV+D+HBB/+YBHVV8K+7Ii0DR8dui8AkoN+r98mJdhyGA=
Message-ID: <5a4c581d0612121347r487256bqb884014b761b0df5@mail.gmail.com>
Date: Tue, 12 Dec 2006 22:47:02 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Steve Wise" <swise@opengridcomputing.com>
Subject: Re: 2.6.19-git3 panics on boot - ata_piix/PCI related [still in -git17]
Cc: "Jeff Garzik" <jeff@garzik.org>, Alan <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <1165949381.24482.10.camel@stevo-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a4c581d0612110526j26a07b31q26edc075d4981cd8@mail.gmail.com>
	 <1165873362.20877.22.camel@stevo-desktop>
	 <1165941542.24482.5.camel@stevo-desktop>
	 <20061212173516.1b7dc654@localhost.localdomain>
	 <457EEF1F.8040906@garzik.org>
	 <1165949381.24482.10.camel@stevo-desktop>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/06, Steve Wise <swise@opengridcomputing.com> wrote:
> On Tue, 2006-12-12 at 13:04 -0500, Jeff Garzik wrote:
> > Alan wrote:
> > > On Tue, 12 Dec 2006 10:39:02 -0600
> > > Steve Wise <swise@opengridcomputing.com> wrote:
> > >
> > >> All,
> > >>
> > >> Bisecting reveals that this commit causes the problem:
> > >
> > > Yes we know. There is a libata patch missing. As I said - if it is still
> > > missing by -rc1 I'll sort out a diff.
> >
> > What's the patch?  Message-id?  I don't have anything from you in my
> > patch queue.
> >
> >       Jeff
> >
> >
> >
>
> I dug up the patch below from here:
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116343564202844&q=raw
>
> This patch fixes my problem, and I don't think its in Linus's tree at
> this point.
>
>
> Steve.
>
>
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 10ee22a..40a2bfa 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -1027,13 +1027,13 @@ #if defined(CONFIG_NO_ATA_LEGACY)
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
>                 if (!request_region(ATA_PRIMARY_CMD, 8, "libata")) {
>                         struct resource *conflict, res;
>                         res.start = ATA_PRIMARY_CMD;

This patch on top of 2.6.19-git19 fixes my boot problem. Thanks !

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)
