Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266809AbUF3Ssp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266809AbUF3Ssp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 14:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUF3SrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 14:47:14 -0400
Received: from disk.smurf.noris.de ([192.109.102.53]:33952 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S266807AbUF3Sq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 14:46:26 -0400
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Wed, 30 Jun 2004 20:45:13 +0200
To: Ben Collins <bcollins@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm4: regression: ieee1394: sbp2: null pointer dereference
Message-ID: <20040630184509.GD5389@kiste>
References: <20040629181347.GA5259@kiste> <pan.2004.06.30.04.01.10.828506@smurf.noris.de> <20040630154623.GB18174@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630154623.GB18174@phunnypharm.org>
User-Agent: Mutt/1.5.6+20040523i
X-Smurf-Spam-Score: -4.0 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ben Collins:
> This oops traces back into the scsi stack, right?

Umm ... not that I know of. It basically says

                      sbp2_logout_device+0x13/0x140 [sbp2]
kernel:  [<fb2c49f1>] sbp2_update+0x21/0x80 [sbp2]

No SCSI anywhere (that I can see).

sbp2_update+0x21 points to the instruction after a call to
sbp2_logout_device(), so that matches up. GDB says the error is here:

sbp2.c:1323:	scsi_id->logout_orb->reserved1 = 0x0;

which probably means that either scsi_id or logout_orb is NULL.

>         I guess USB doesn't have too many problems since it does a
> scsi-host per device, but that's not as easy with sbp2 and 1394, since a
> single sbp2 device can have multiple LUN's, and it's just easier to
> treat that as one scsi host.
> 
So can USB; I have a card reader here which registers a different LUN
per card interface.

> I can't reproduce it, but I'll try to get into the logic of sbp2 device
> removal again to see if I can find out where and why this is occuring.

FWIW, here's the device info (from gscanbus):

SelfID Info
-----------
Physical ID: 2
Link active: Yes
Gap Count: 10
PHY Speed: S400
PHY Delay: <=144ns
IRM Capable: No
Power Class: None
Port 0: Connected to parent node
Port 1: Connected to child node
Init. reset: No

CSR ROM Info
------------
GUID: 0x00A0B80A0000144F
Node Capabilities: 0x000083C0
Vendor ID: 0x0000A0B8
Unit Spec ID: 0x0000609E
Unit SW Version: 0x00010483
Model ID: 0x00000000
Nr. Textual Leafes: 2

Vendor:  SYMBIOS LOGIC INC.
Textual Leafes: 
LSI Logic
LSI 501 rev B3

AV/C Subunits
-------------
N/A



-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
