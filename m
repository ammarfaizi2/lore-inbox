Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbTJ2TdI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 14:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbTJ2TdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 14:33:08 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:65459 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261429AbTJ2TdD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 14:33:03 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Stefan Talpalaru <stefantalpalaru@yahoo.com>
Subject: Re: PATCH: CMD640 IDE chipset
Date: Wed, 29 Oct 2003 20:36:56 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20031029121218.56602.qmail@web20606.mail.yahoo.com>
In-Reply-To: <20031029121218.56602.qmail@web20606.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310292036.56309.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday 29 of October 2003 13:12, Stefan Talpalaru wrote:
> Hi Bartolomiej!

Hi,

> --- Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> > Hi,
> >
> > Can you please drop all code-style changes (such as foo() -> foo ())
>
>  sorry about that, I ran Lindent on it...

Please read Documentation/CodingStyle instead ;-).

>    Please excuse me for sending this patch as an attachment,
> but as my mail account is Yahoo! and I'm too lazy to find a better
> sollution, I cannot get the patch through the web interface without
> breaking the lines.

Okay.

>   This patch integrates the CMD640 chipset support in the 2.4.22
> kernel. I was using it succesfully in the 2.2.x kernel series, but
> got no result in the 2.4.x kernels. After comparing the 2 versions,
> I noticed errors in the new version (outb_p() instead of outl_p())
> and also some useless code (the wrapers: __put_cmd640_reg() and 
> __get_cmd640_reg() - which I removed and placed the locks where needed;

It seems Alexander already covered removal of wrappers...

> the pci_conf1() and pci_conf2() functions).

You can't remove them.

/* Find out what kind of PCI probing is supported otherwise
   we break some Adaptec cards...  */

>   I also removed the CONFIG_BLK_DEV_CMD640_ENHANCED config option, as
> it
> makes little difference for the kernel size.
>   The init_hwif_cmd640() function had to be rewritten because it is
> called once for each ide interface found, so the old way of addressing
> all the drives in one run was no longer working. Therefore, to not
> break all the code, came the need for a function that computes the
> index from the ide_drive_t* : calculate_index().

ide_probe_for_cmd640x() should be still be used instead.
By removing setup_device_ptrs() and moving this driver to generic PCI layer,
you broke support for VLB version of CMD640.

Also there is a comment in a cmd640.c:

/*
 * The CMD640x chip does not support DWORD config write cycles, but some
 * of the BIOSes use them to implement the config services.
 */

which worries me that it might be not safe to move this driver to generic
IDE PCI layer (at least for now).

>   The code that handles PIO settings was rearanged in a new function:
> cmd640_tuneproc().

Is this really necessary, it is even harder to read it now...

Stefan, please rework your patch.  Thanks.

cheers,
--bartlomiej

