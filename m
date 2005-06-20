Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVFUALr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVFUALr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVFUALJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:11:09 -0400
Received: from cog1.w2cog.org ([206.251.188.12]:63388 "EHLO mail1.w2cog.org")
	by vger.kernel.org with ESMTP id S261858AbVFTXyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:54:45 -0400
Date: Mon, 20 Jun 2005 18:54:23 -0500 (CDT)
From: Roy Keene <rkeene@psislidell.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Erik Slagter <erik@slagter.name>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.6 kernel and lots of I/O
In-Reply-To: <6DCC9CC1-2B5C-430F-96AC-F36477AC8290@mac.com>
Message-ID: <Pine.LNX.4.62.0506201848500.2736@hammer.psislidell.com>
References: <Pine.LNX.4.62.0505311042470.7546@hammer.psislidell.com>
 <20050601195922.GA589@openzaurus.ucw.cz> <1117966262.5027.9.camel@localhost.localdomain>
 <AF6BB031-9221-4BA3-AFC9-7D167EBE866C@mac.com>
 <Pine.LNX.4.62.0506201711090.3592@hammer.psislidell.com>
 <6DCC9CC1-2B5C-430F-96AC-F36477AC8290@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But the problem doesn't occur with the "local" end, it's with the 
"recieving" end (which may be the same thing, but mostly it's not, since I 
tend to reboot the secondary node more).

The problem occurs on the node running `nbd-server' in userspace and not 
nessicarily having "nbd" support.

"nbd1" is a remote nbd device to the secondary server, which then becomes 
highly unusable.  I'm not sure what you're attempting to convey to me, as 
the server that is running raid1_resync (reading from nbd0, which 
cooresponds with a local nbd-client binding) is perfectly usable in the 
example I gave, but the remote node is not...


 	Roy Keene
 	Planning Systems Inc.

On Mon, 20 Jun 2005, Kyle Moffett wrote:

> On Jun 20, 2005, at 18:19:19, Roy Keene wrote:
>> On Mon, 6 Jun 2005, Kyle Moffett wrote:
>>>> IIRC, because of the way the loopback delivers packets from the
>>>> same context as they are sent, it is possible (and quite easy)
>>>> to either deadlock or peg the CPU and make everything hang and
>>>> be unuseable.  DRBD likewise used to have problems with testing
>>>> over the loopback until they added a special configuration
>>>> option to be extra careful and yield CPU.
>> 
>> Actually, the problem I have isn't specific to the using it over
>> the local device.  Quite often I have the problem where the
>> secondary node goes down and comes back up after some time and
>> needs to be resyncd.  This is done on the master (raid1_resync) by
>> hot-removing /dev/nbd1 and then hot-adding it back.
>
> No, see, when you hot-add /dev/nbd1, the kernel md resync thread
> begins processing the resync.  The resync operation on two nbds
> involves:
>  1) Send data request packet from nbd0
>  2) Wait for response
>  3) Send data packet to nbd1
>  4) Wait for response
>  5) Repeat until done
>
> On a normal net device, the "Send data request packet" causes the
> system to drop the packet on the wire and go away to do other stuff
> for a while, whereas on the loopback, it can schedule immediately
> to the process receiving the packet, which is the kernel itself.
> The kernel then processes the packet and returns the result, over
> the loopback.  It then sends the response to the other server over
> a real net connection.  During most of this time, the kernel is
> taking big locks and turning interrupts off and on and such, causing
> massive hangs until resync finishes.  Since you mentioned bad write
> performance with your RAID controller, I suspect its driver may also
> turn off interrupts, take excessive locks, or do other madness,
> further worsening system responsiveness.
>
> Cheers,
> Kyle Moffett
>
> --
> There are two ways of constructing a software design. One way is to make it 
> so simple that there are obviously no deficiencies. And the other way is to 
> make it so complicated that there are no obvious deficiencies.
> -- C.A.R. Hoare
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
