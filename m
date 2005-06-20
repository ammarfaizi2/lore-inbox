Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVFTXgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVFTXgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVFTXVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:21:03 -0400
Received: from smtpout.mac.com ([17.250.248.46]:50377 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261819AbVFTXSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:18:49 -0400
In-Reply-To: <Pine.LNX.4.62.0506201711090.3592@hammer.psislidell.com>
References: <Pine.LNX.4.62.0505311042470.7546@hammer.psislidell.com> <20050601195922.GA589@openzaurus.ucw.cz> <1117966262.5027.9.camel@localhost.localdomain> <AF6BB031-9221-4BA3-AFC9-7D167EBE866C@mac.com> <Pine.LNX.4.62.0506201711090.3592@hammer.psislidell.com>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6DCC9CC1-2B5C-430F-96AC-F36477AC8290@mac.com>
Cc: Erik Slagter <erik@slagter.name>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Problem with 2.6 kernel and lots of I/O
Date: Mon, 20 Jun 2005 19:18:35 -0400
To: Roy Keene <rkeene@psislidell.com>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 20, 2005, at 18:19:19, Roy Keene wrote:
> On Mon, 6 Jun 2005, Kyle Moffett wrote:
>>> IIRC, because of the way the loopback delivers packets from the
>>> same context as they are sent, it is possible (and quite easy)
>>> to either deadlock or peg the CPU and make everything hang and
>>> be unuseable.  DRBD likewise used to have problems with testing
>>> over the loopback until they added a special configuration
>>> option to be extra careful and yield CPU.
>
> Actually, the problem I have isn't specific to the using it over
> the local device.  Quite often I have the problem where the
> secondary node goes down and comes back up after some time and
> needs to be resyncd.  This is done on the master (raid1_resync) by
> hot-removing /dev/nbd1 and then hot-adding it back.

No, see, when you hot-add /dev/nbd1, the kernel md resync thread
begins processing the resync.  The resync operation on two nbds
involves:
   1) Send data request packet from nbd0
   2) Wait for response
   3) Send data packet to nbd1
   4) Wait for response
   5) Repeat until done

On a normal net device, the "Send data request packet" causes the
system to drop the packet on the wire and go away to do other stuff
for a while, whereas on the loopback, it can schedule immediately
to the process receiving the packet, which is the kernel itself.
The kernel then processes the packet and returns the result, over
the loopback.  It then sends the response to the other server over
a real net connection.  During most of this time, the kernel is
taking big locks and turning interrupts off and on and such, causing
massive hangs until resync finishes.  Since you mentioned bad write
performance with your RAID controller, I suspect its driver may also
turn off interrupts, take excessive locks, or do other madness,
further worsening system responsiveness.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.
  -- C.A.R. Hoare

