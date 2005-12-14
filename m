Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbVLNTPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbVLNTPB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbVLNTPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:15:01 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:48532 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964797AbVLNTPA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:15:00 -0500
Subject: Problems in the SiS IDE driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Dec 2005 19:15:05 +0000
Message-Id: <1134587705.25663.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been writing/porting over SIS support to the libata code and in
doing so I've hit a couple of corner cases that appear broken in the SiS
code in ide/pci. 

If you have a prehistoric device that only does PIO0 and you plug it
into the SiS IDE ports then the earlier SiS (pre ATA133) drivers don't
have cases for PIO0. Fortunately PIO0 only devices are kind of rare
nowdays.

The early SiS loads 0 into both timing registers. I'm not sure if that
is a bug or correct behaviour that isn't commented. The ATA100
generation however stuff an unset 16bit variable into the timing
registers which seems to be very wrong indeed.

viz:

test1 is unset on entry

            switch(timing) { /*             active  recovery
                                                  v     v */
                        case 4:         test1 = 0x30|0x01; break;
                        case 3:         test1 = 0x30|0x03; break;
                        case 2:         test1 = 0x40|0x04; break;
                        case 1:         test1 = 0x60|0x07; break;
                        default:        break;
                }
                pci_write_config_byte(dev, drive_pci, test1);


And timing can be zero....

Would be useful to know if this is a bug, and also what the correct
behaviour is at this point as I don't have all the SiS data sheets.

