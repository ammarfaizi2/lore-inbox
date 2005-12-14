Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVLPQCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVLPQCs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 11:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVLPQCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 11:02:47 -0500
Received: from styx.suse.cz ([82.119.242.94]:40627 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932345AbVLPQCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 11:02:46 -0500
Date: Wed, 14 Dec 2005 22:12:16 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Problems in the SiS IDE driver
Message-ID: <20051214211216.GA6045@corona.suse.de>
References: <1134587705.25663.67.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134587705.25663.67.camel@localhost.localdomain>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 07:15:05PM +0000, Alan Cox wrote:
> I've been writing/porting over SIS support to the libata code and in
> doing so I've hit a couple of corner cases that appear broken in the SiS
> code in ide/pci. 
> 
> If you have a prehistoric device that only does PIO0 and you plug it
> into the SiS IDE ports then the earlier SiS (pre ATA133) drivers don't
> have cases for PIO0. Fortunately PIO0 only devices are kind of rare
> nowdays.
> 
> The early SiS loads 0 into both timing registers. I'm not sure if that
> is a bug or correct behaviour that isn't commented.

This is correct. 0's on SiS mean PIO0 timing.

> The ATA100
> generation however stuff an unset 16bit variable into the timing
> registers which seems to be very wrong indeed.
> 
> viz:
> 
> test1 is unset on entry
> 
>             switch(timing) { /*             active  recovery
>                                                   v     v */
>                         case 4:         test1 = 0x30|0x01; break;
>                         case 3:         test1 = 0x30|0x03; break;
>                         case 2:         test1 = 0x40|0x04; break;
>                         case 1:         test1 = 0x60|0x07; break;
>                         default:        break;
>                 }
>                 pci_write_config_byte(dev, drive_pci, test1);
> 
> 
> And timing can be zero....
> 
> Would be useful to know if this is a bug, and also what the correct
> behaviour is at this point as I don't have all the SiS data sheets.

This is a bug - test1 should be initialized to 0.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
