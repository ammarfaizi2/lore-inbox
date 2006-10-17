Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWJQWmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWJQWmY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 18:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWJQWmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 18:42:23 -0400
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:3948 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750969AbWJQWmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 18:42:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=jZIqUdPmMecdGmRyk4nTUy+kmnH3/aNQwon5KIisoc9qSfUbJLtgcMHixWGYqsTcaIPz0ORkWmuJXNKesmNsli4ph7WAM0kjCVJiEHVfki4tLVRE4UaDd+WQ2gJwI4fMI7PnyRZyVFei2S0IriV4Q1S8VUdY/OjzQtDYk6XrBSI=  ;
Message-ID: <20061017224221.89332.qmail@web31804.mail.mud.yahoo.com>
Date: Tue, 17 Oct 2006 15:42:21 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: [PATCH] libsas: support NCQ for SATA disks
To: James Bottomley <James.Bottomley@SteelEye.com>,
       Jeff Garzik <jeff@garzik.org>
Cc: brking@us.ibm.com, "Darrick J. Wong" <djwong@us.ibm.com>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>
In-Reply-To: <1161102937.3720.11.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- James Bottomley <James.Bottomley@SteelEye.com> wrote:
> On Tue, 2006-10-17 at 07:15 -0400, Jeff Garzik wrote:
> > Brian King wrote:
> > > This doesn't look like the right fix for the oops you were seeing. The
> > > SAS usage of libata has ap->scsi_host as NULL, which indicates that
> > > libata does not own the associated scsi_host. I'm concerned you may
> > > have broken some other code path by making this change. I think the correct
> > > fix may require removing the dependence of ap->scsi_host from
> > > ata_dev_config_ncq. 
> > 
> > Yep.  I had already mentioned this on IRC.
> 
> I understand, but right at the moment, my priority is sorting out the
> aic94xx driver so that it works with SATA devices.  It has become
> apparent that there's some need for a bit of code sorting out in libata
> to drive intelligent sas controllers, so we can take a look at bugs in
> ata_dev_config_ncq() when someone's time frees up to look into the
> libata issues.

Just to give people some freedom of choice:

I feel the need to mention that my code as I support it, the
SAS Stack, does include fully T10-complient SATL, which does SAT on
per device basis, leaving the transport be whatever it need be.
I.e. no messing around with "ata ports" or "hosts" or what not.

A provider (SAS Stack, software ATA emulation, whatever) simply
_registers_ with SATL, declaring in a structure of method stubs
what it can do, and then SATL drives the device.  This is similar to
how my SAS Stack works with SAS LLDD (the bottomleyised version of my
code uses a libsas "on the side" instead of being a fully fledged
layer as intended and originally written).

The SATL also does SATA feature configuration as per the declared
capabilities of the LLDD (aic94xx, or whatever) _and_ as per the
device declared capabilities.  I.e. if one or the other doesn't
support it, then it is turned off, if both support it it is on.

The SATL also supports NCQ, S-ATAPI, full error recovery (NCQ, etc).

It also supports MODE SENSE, MODE SELECT, ATA Pass-through (all protocols),
S-ATAPI, etc, etc, as per SAT.*

Bottomley has simply made a decision for you, what kind of code
you should be using, what it supports and how it supports it.

Good luck everyone!
     Luben

* For example, I exclusively cut CDs/DVDs using a S-ATAPI DVD-RW device
attached to an expander using the SAS Stack and SATL.

