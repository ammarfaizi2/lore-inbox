Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293614AbSCFOfK>; Wed, 6 Mar 2002 09:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293597AbSCFOfC>; Wed, 6 Mar 2002 09:35:02 -0500
Received: from host194.steeleye.com ([216.33.1.194]:19462 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S293599AbSCFOet>; Wed, 6 Mar 2002 09:34:49 -0500
Message-Id: <200203061434.g26EYg301641@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Daniel Phillips <phillips@bonn-fries.net>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3) 
In-Reply-To: Message from Daniel Phillips <phillips@bonn-fries.net> 
   of "Wed, 06 Mar 2002 14:59:52 +0100." <E16ibxR-0002zI-00@starship.berlin> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Mar 2002 08:34:41 -0600
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

phillips@bonn-fries.net said:
> How can a drive can accept a command while it is disconnected from the
> bus. Did you mean that after it reconnects it might refuse the ordered
> tag and accept another?  That would be a bug, I'd think. 

Disconnect is SCSI slang for releasing the bus to other uses, it doesn't imply 
electrical disconnection from it.  The architecture of SCSI is like this, the 
usual (and simplified) operation of a single command is:

- Initiator selects device and sends command and tag information.
- device disconnects
....
- device reselects initiator, presents tag and demands to transfer data (in 
the direction dictated by the command).
- device may disconnect and reselect as many times as it wishes during data 
transfer as dictated by its flow control (at least one block of data must 
transfer for each reselection)
- device disconnects to complete operation
...
- device reselects and presents tag and status (command is now complete)

A tag is like a temporary ticket for identifying the command in progress.

During the (...) phases, the bus is free and the initiator is able to send 
down new commands with different tags.  If the device isn't going to be able 
to accept the command, it is allowed to skip the data transfer phase and go 
straight to status and present a QUEUE FULL status return.  However, there is 
still a disconnected period where the initiator doesn't know the command won't 
be accepted and may send down other tagged commands.

> It would mean we would have to wait for completion of the tagged
> command before submitting any more commands.  Not nice, but not
> horribly costly either. 

But if we must await completion of ordered tags just to close this hole, it 
makes the most sense to do it in the bio layer (or the journal layer, where 
the wait is currently being done anyway) since it is generic to every low 
level driver.

James


