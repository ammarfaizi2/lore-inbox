Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbVLMPDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbVLMPDl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbVLMPDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:03:41 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:26040 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964950AbVLMPDk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:03:40 -0500
Subject: Re: tp_smapi conflict with IDE, hdaps
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Shem Multinymous <multinymous@gmail.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Rovert Love <rlove@rlove.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <41840b750512130635p45591633ya1df731f24a87658@mail.gmail.com>
References: <41840b750512130635p45591633ya1df731f24a87658@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 13 Dec 2005 15:03:22 +0000
Message-Id: <1134486203.11732.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-13 at 16:35 +0200, Shem Multinymous wrote:
> Evidently, the SMAPI BIOS sends some ATA command to the drive. If the
> kernel is accessing the drive at the same time (e.g., an ongoing "cat
> /dev/scd0"), the machine hangs. The ideal solution would be to figure
> out the relevant ATA commands and add them to libata/ata_piix/ide, but
> it's not clear how to do that. So tp_smapi needs to obtain some lock
> guaranteeing there is no access (or ongoing transaction) to that ATA
> device.

You will need to find out the command. Trying to arbitrate libata access
with unknown bios behaviour isn't going to have a sane resolution. There
are standard commands for this so they ought to work. If not we need to
know why, who makes the drive used etc

> with the recently added HDAPS accelerometer driver. Both drivers read
> their data from the same ports (0x1604-0x161F), which implement a
> query-reponse transaction interface, so both drivers talking to the
> hardware simultaneously will wreak havoc. Some synchronization is
> needed, and a way to address the request_region conflict.
> 
> What is standard procedure for resolving such conflicts?

You probably want a low level driver that just arbitrates the interface
and implements the basic query/response transaction interface and
locking and then is called by both HDAPS and your driver (and no doubt
other future drivers talking to that controller). It can thene export
the interface to both drivers.

