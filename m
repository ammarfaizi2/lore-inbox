Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWINWlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWINWlA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 18:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWINWlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 18:41:00 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:26333 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932079AbWINWk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 18:40:59 -0400
Message-ID: <4509DA77.7000508@us.ibm.com>
Date: Thu, 14 Sep 2006 15:40:55 -0700
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>
CC: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>
Subject: Re: [PATCH v3] libsas: move ATA bits into a separate module
References: <4508A0A2.2080605@us.ibm.com> <450971D3.2040405@garzik.org>
In-Reply-To: <450971D3.2040405@garzik.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> I disagree completely with this approach.
> 
> You don't need a table of hooks for the case where libata is disabled in
> .config.  Thus, it's only useful for the case where libsas is loaded as
> a module, but libata is not.

Indeed, I misunderstood what James Bottomley wanted, so I reworked the
patch.  It has the same functionality as before, but this module uses
the module loader/symbol resolver for all the functions in libata, and
allows libsas to (optionally) call into sas_ata with weak references by
pushing a table of the necessary function pointers into libsas at
sas_ata load time.  Thus, libsas doesn't need to load libata/sas_ata
unless it actually finds a SATA device.

> The libsas code should directly call libata functions.  If ATA support
> in libsas is disabled in .config, then those functions will never be
> called, thus never loaded the libata module.

I certainly can (and now do) call libata functions from sas_ata.
However, there are a few cases where libsas needs to call libata (ex.
sas_ioctl); for those cases, I think the function pointers are still
necessary because I don't want to make libsas require libata.  In any
case, if ATA support is disabled in .config, sata_is_dev always returns
0, so the dead-code eliminator should zap that out of libsas entirely.

As usual, thank you for any feedback that you have.

Link to version 3:
http://sweaglesw.net/~djwong/docs/sas-ata_3.patch

--D

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
