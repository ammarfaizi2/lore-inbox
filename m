Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135362AbRAQQTk>; Wed, 17 Jan 2001 11:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135340AbRAQQTb>; Wed, 17 Jan 2001 11:19:31 -0500
Received: from [64.109.89.110] ([64.109.89.110]:48216 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S135311AbRAQQTW>; Wed, 17 Jan 2001 11:19:22 -0500
Message-Id: <200101171616.LAA01194@localhost.localdomain>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Mike Porter <mike@UDel.Edu>
cc: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux not adhering to BIOS Drive boot order? 
In-Reply-To: Message from Mike Porter <mike@UDel.Edu> 
   of "Wed, 17 Jan 2001 10:33:06 EST." <Pine.SOL.4.31.0101171029270.12-100000@copland.udel.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Jan 2001 11:16:58 -0500
From: James Bottomley <J.E.J.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, what about a compromise.

The fundamental problem that we all agree on is that SCSI devices are detected 
in the order that the mid-layer hosts.c file calls their detect routines.  
Further, for multiple cards of the same type, the detection order is up to the 
individual driver.  A different problem is that SCSI targets and LUNs are 
mapped sequentially to /dev/sd[a-z][a-d] so if you lose a device from the 
middle the ordering shifts.

I think that devfs does a very good job of addressing the latter problem, 
since you can now use it's naming scheme to find the exact target/lun you were 
looking for.

The former problem is really something that affects all adapter cards in the 
linux system (you have a similar problem for multiple ethernet cards, etc.)

One of the ways this could be solved would be to impose bus ordering on the 
detection sequence.  Since every computer bus (except the ancient ISA) has a 
way of getting its logical slot numbering (which is not necessarily related to 
physical slot numbering), you can easily impose this type of ordering on all 
card detection.  Doing this would necessitate some surgery in the way device 
detection is done, probably major enough to make it a 2.5 feature.

The up side would be that, as long as you maintain your cards in the same 
slot, the SCSI ordering would remain the same (you could even change the card 
and still have the same order).

The compromise over UUID detection is that if you change the slot, all bets 
are off.

If there is sufficient interest in this, I could look at putting together a 
patch to 2.4.x which would implement the scheme.

James Bottomley


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
