Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbULNJ76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbULNJ76 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 04:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbULNJ76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 04:59:58 -0500
Received: from webapps.arcom.com ([194.200.159.168]:5125 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S261473AbULNJ7z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 04:59:55 -0500
Subject: Re: [tpmdd-devel] Re: [PATCH 1/1] driver: Tpm hardware enablement
From: Ian Campbell <icampbell@arcom.com>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, sailer@watson.ibm.com,
       leendert@watson.ibm.com, Emily Ratliff <emilyr@us.ibm.com>,
       Tom Lendacky <toml@us.ibm.com>, tpmdd-devel@lists.sourceforge.net
In-Reply-To: <1102703942.20230.13.camel@jo.austin.ibm.com>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com>
	 <1102676169.31305.85.camel@icampbell-debian>
	 <1102692480.20230.3.camel@jo.austin.ibm.com>
	 <1102693298.31305.98.camel@icampbell-debian>
	 <1102703942.20230.13.camel@jo.austin.ibm.com>
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Tue, 14 Dec 2004 09:59:53 +0000
Message-Id: <1103018393.31305.150.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Dec 2004 10:02:16.0796 (UTC) FILETIME=[FDE879C0:01C4E1C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-10 at 12:39 -0600, Kylene Hall wrote:
> On Fri, 2004-12-10 at 09:41, Ian Campbell wrote:
> > On Fri, 2004-12-10 at 09:28 -0600, Kylene Hall wrote:
> > > Good point.  Splitting this out (esp. because there will be more in the
> > > future) is a good idea.  What is the usual way to do this?  For example,
> > > what function in the chip specific file would call
> > > register_tpm_hardware, how do I make sure that gets called etc.
> > 
> > I guess you could have multiple modules, one providing the generic code
> > and the dev interface etc (tpm.ko) and then one per hardware chip
> > (tmp-nsc.ko, tpm-atmel.ko, tpm-atmel-i2c.ko). 
> > 
> > The hardware modules can then call tpm_register_hardware() in their
> > module_init function. 
> > 
> I have begun to implement it this but the problem I have now is that
> this setup makes tpm_atmel and tpm_nsc dependent on tpm.  Since tpm
> calls pci_register_driver in its init (which has to happen before
> tpm_<specific> init) probe is called before the "interfaces" are
> registered and thus the tpm_probe fails to find the device.  Do I move
> the pci_register?  If so what is the proper place to register it? When
> one interface registers?  If so then I think devices for the second and
> subsequent interfaces would never be discovered for the same reason as I
> am currently experiencing.  Do I need to move the current tpm probe
> logic to the hw specific drivers?

I'm not too sure about the relationship between the different types of
TPM chip you seem to be coping with and the PCI id's associated with
them. I think the normal way would be to have a separate self-contained
driver encapsulating the complete hardware specific bits for each
possible type of pci hardware device, or indeed i2c device rather than
mixing support for multiple different chips in a single driver.

I think often you would have tpm_atmel's module_init contain a call to
pci_register_driver to register the device id's associated with the
Atmel parts. Then the probe call does tpm_<specific>_init and registers
the tpm h/w device with the hardware independent bit using
tpm_register_hardware().

I would then be able to support the i2c variant of the atmel part by
registering an i2c part instead of a PCI one and calling
tpm_register_hardware from the equivalent i2c probe function.

Ian.

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200

