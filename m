Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268592AbUH3RVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268592AbUH3RVw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268582AbUH3RVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:21:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62648 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268592AbUH3RUP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:20:15 -0400
Message-ID: <413361BF.8020805@pobox.com>
Date: Mon, 30 Aug 2004 13:19:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [patch] libata: add ioctls to support SMART
References: <200408301531.i7UFVBg29089@ra.tuxdriver.com>
In-Reply-To: <200408301531.i7UFVBg29089@ra.tuxdriver.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> Support for HDIO_DRIVE_CMD and HDIO_DRIVE_TASK in libata.  Useful for
> supporting SMART w/ unmodified smartctl and smartd userland binaries.

First let me say that it's a damn fine first attempt, and people should 
be able to use this for SMART until support is merged officially.


> Not happy w/ loop after failed ata_qc_new_init(), but needed because smartctl
> and smartd did not retry after failure.  Likely need an option to wait for
> available qc?  Also not sure all the error return codes are correct...

I'd like to implement it a bit differently, and I think this different 
method will solve some of the open questions you have.

Take a look at http://www.t10.org/ftp/t10/document.04/04-260r2.pdf

I would like to implement HDIO_DRIVE_CMD and HDIO_DRIVE_TASK completely 
inside libata-scsi.c.  These ioctls should translate the ioctl arguments 
into an ATA-passthru SCSI command, and use the standard "issue a scsi 
command" kernel API to submit the command and wait for a result.

That implies, then, that you would add code to libata-scsi.c that 
translates the ATA-passthru SCSI command into an ATA command using the 
ata_scsi_translate() infrastructure.

Note that you'll need to make up a SCSI opcode, inside the SCSI 
vendor-specific opcode space, since the ATA-passthru hasn't yet been 
assigned an official SCSI opcode.  SPC-3 
(http://www.t10.org/ftp/t10/drafts/spc3/spc3r20a.pdf) lists the 
available opcodes in section C.3, denoted with a 'V' across all columns.

Once libata-scsi.c can handle the ATA-passthru SCSI command, 
implementing HDIO_DRIVE_{TASK,CMD} should be quite trivial.

And SMART support will be complete :)

	Jeff


