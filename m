Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278556AbRJXPSx>; Wed, 24 Oct 2001 11:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278561AbRJXPSo>; Wed, 24 Oct 2001 11:18:44 -0400
Received: from geos.coastside.net ([207.213.212.4]:37058 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S278556AbRJXPSd>; Wed, 24 Oct 2001 11:18:33 -0400
Mime-Version: 1.0
Message-Id: <p05100321b7fc88a08346@[207.213.214.37]>
In-Reply-To: <E15wKn8-00013C-00@the-village.bc.nu>
In-Reply-To: <E15wKn8-00013C-00@the-village.bc.nu>
Date: Wed, 24 Oct 2001 08:18:04 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        benh@kernel.crashing.org (Benjamin Herrenschmidt)
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
        mochel@osdl.org (Patrick Mochel)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:57 AM +0100 10/24/01, Alan Cox wrote:
>  > the HW or not when getting a new request). In cases where a mid-layer
>>  enters the scene, like SCSI, that wants to do timeouts, then well...
>>  we can let it timeout (just stop processing requests), or we can
>>  have the midlayer go to sleep as well :) That later solution
>>  may cause some interesting ordering issues however...
>
>For scsi you have to complete the pending commands, you don't know what the
>transaction granularity is in some cases and half completing the sequence
>won't help you. In addition the upper layers have to queue additional scsi
>commands to do stuff like cd drawer locking and to ask the drive firmware
>to enter powerdown modes
>
>>  For USB, for example, we can consider that when a device driver
>>  (not a controller driver) suspend has been done, any URB it submits
>>  can just be dropped (returned immediately with an error). We don't
>>  need blocking here neither. Of course, that means we have the
>>  framework to call devices' suspend/resume callbacks when the
>  > controller is about to go to sleep.
>
>That will scramble large numbers of devices. Randomly erroring pending block
>writes is -not- civilised.

In our "extreme prejudice" suspend (this is in the context of masking 
& recovering from a fault in a fault-tolerant machine) we have cases 
in which completion of pending commands isn't possible. Our solution 
is to issue a SCSI bus reset, and terminate all outstanding commands 
with an appropriate (retryable) error. This is especially easy to 
implement in drivers that use SCSI bus reset as a routine (though 
last resort) error recovery mechanism, since the requisite logic is 
already in place. Not pretty, I suppose, but effective.

One model we've considered (but haven't implemented yet) is to make 
parents in the device tree responsible for suspending their children, 
so the suspend propagates down the tree and each node "knows" how to 
suspend its children, assuming any special action is required. So a 
SCSI HBA, for example, would be asked by its bus parent to suspend, 
and in turn would suspend its SCSI device children before suspending 
itself. I'm not quite sure how virtual device layers like md would 
fit into this scheme, since they can cut across device and power 
hierarchies.

At 11:54 AM +0100 10/24/01, Alan Cox wrote:
>So the scsi devices hang off sd, sr etc which in turn hang off scsi and
>the controllers hang off scsi (and or the bus layers)

Our first implementation was under Solaris 2.x (SPARC) in which the 
parent->child relationship is bus->hba->sd. scsi isn't in the tree; 
it's more of an interface layer between hba & sd. fwiw.
-- 
/Jonathan Lundell.
