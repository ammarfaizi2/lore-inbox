Return-Path: <linux-kernel-owner+w=401wt.eu-S965142AbWLMUHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbWLMUHM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbWLMUHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:07:11 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:50106 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965136AbWLMUHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:07:07 -0500
Message-ID: <45805D54.3070809@us.ibm.com>
Date: Wed, 13 Dec 2006 12:06:44 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Patrick Mansfield <patmans@us.ibm.com>
CC: Jeff Garzik <jeff@garzik.org>, linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] libata: Simulate REPORT LUNS for ATAPI devices
References: <4574A90E.5010801@us.ibm.com> <4574AB78.40102@garzik.org>	<4574B004.6030606@us.ibm.com> <20061213185627.GA21535@us.ibm.com>
In-Reply-To: <20061213185627.GA21535@us.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield wrote:
> On Mon, Dec 04, 2006 at 03:32:20PM -0800, Darrick J. Wong wrote:
>> The Quantum GoVault SATAPI removable disk device returns ATA_ERR in
>> response to a REPORT LUNS packet.  If this happens to an ATAPI device
>> that is attached to a SAS controller (this is the case with sas_ata),
>> the device does not load because SCSI won't touch a "SCSI device"
>> that won't report its LUNs.  Since most ATAPI devices don't support
>> multiple LUNs anyway, we might as well fake a response like we do for
>> ATA devices.
> 
> If the REPORT LUNS fails, we should fall back to a sequential scan.
> 
> Is (or why isn't) the error propagated back to scsi?

I believe the error is reported back to SCSI, which attempts to follow
up with TEST UNIT READY.  Unfortunately, for some reason the device then
gets dropped.  libata normally calls __scsi_add_device with lun=0, but
SAS calls scsi_scan_target with lun=SCAN_WILD_CARD, which is why SCSI
sends REPORT LUNs in the first place.

As an alternative I suppose we could detect ATA devices in sas_rphy_add
and change that SCAN_WILD_CARD to "0".

--D
