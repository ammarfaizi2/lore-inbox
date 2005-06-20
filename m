Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVFTWtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVFTWtr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 18:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVFTWso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:48:44 -0400
Received: from cog1.w2cog.org ([206.251.188.12]:50076 "EHLO mail1.w2cog.org")
	by vger.kernel.org with ESMTP id S262318AbVFTWTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:19:44 -0400
Date: Mon, 20 Jun 2005 17:19:19 -0500 (CDT)
From: Roy Keene <rkeene@psislidell.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Erik Slagter <erik@slagter.name>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.6 kernel and lots of I/O
In-Reply-To: <AF6BB031-9221-4BA3-AFC9-7D167EBE866C@mac.com>
Message-ID: <Pine.LNX.4.62.0506201711090.3592@hammer.psislidell.com>
References: <Pine.LNX.4.62.0505311042470.7546@hammer.psislidell.com>
 <20050601195922.GA589@openzaurus.ucw.cz> <1117966262.5027.9.camel@localhost.localdomain>
 <AF6BB031-9221-4BA3-AFC9-7D167EBE866C@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

 	Actually, the problem I have isn't specific to the using it over 
the local device.  Quite often I have the problem where the secondary node 
goes down and comes back up after some time and needs to be resyncd.  This 
is done on the master (raid1_resync) by hot-removing /dev/nbd1 and then 
hot-adding it back.

The result ?  The slave node becomes completely unusable despite the fact 
that only nbd-server processes (two, the listener and the accepted socket) 
are running on there and nothing in the kernel context (well, at least 
w.r.t. to nbd, obviously some kernel code is involved ! :-P, but the nbd 
module doesn't even have to be loaded). And by unusable I mean I can no 
longer open files for writing, attempting to do so results in a hang until 
the resync is complete.

This is not-so-bad when the slave is being resync'd as the primary is 
still fully usable, but it really sucks when the primary goes down and 
needs to be resync'd from the secondary upon coming back up.

I'm thinking my system disks' RAID controller may be really horrible, or 
horribly supported.  I have a RAID5 (hardware, uses the megaraid_mbox 
driver) of 3 x 73gb 10K RPM SCSI-320 disks and my write performance is .. 
horrible.

I've looked at "drbd" and it looks very promising, but I haven't had a 
chance to implement it yet, but it promises to resolve my resync time 
issues at least.


 	Roy Keene
 	Planning Systems Inc.

On Mon, 6 Jun 2005, Kyle Moffett wrote:

> On Jun 5, 2005, at 06:11:02, Erik Slagter wrote:
>> On Wed, 2005-06-01 at 21:59 +0200, Pavel Machek wrote:
>> 
>>>>     Start RAID in degraded mode with remote device (nbd1)
>>>>     Hot-add local device (nbd0)
>>> 
>>> Stop right here. You may not use nbd over loopback.
>> 
>> Any specific reason (just curious)?
>
> IIRC, because of the way the loopback delivers packets from the
> same context as they are sent, it is possible (and quite easy)
> to either deadlock or peg the CPU and make everything hang and
> be unuseable.  DRBD likewise used to have problems with testing
> over the loopback until they added a special configuration
> option to be extra careful and yield CPU.
>
> Cheers,
> Kyle Moffet
>
>
