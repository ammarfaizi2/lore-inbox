Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752060AbWCBTwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbWCBTwR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbWCBTwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:52:16 -0500
Received: from canuck.infradead.org ([205.233.218.70]:8341 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1752058AbWCBTwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:52:15 -0500
Message-ID: <44074CA1.3000007@torque.net>
Date: Thu, 02 Mar 2006 14:50:57 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
CC: Linus Torvalds <torvalds@osdl.org>,
       Matthias Andree <matthias.andree@gmx.de>, Mark Rustad <mrustad@mac.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sg regression in 2.6.16-rc5
References: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com> <4404AA2A.5010703@torque.net> <20060301083824.GA9871@merlin.emma.line.org> <Pine.LNX.4.64.0603011027400.22647@g5.osdl.org> <4405F6F1.9040106@torque.net> <Pine.LNX.4.63.0603012239440.5789@kai.makisara.local>
In-Reply-To: <Pine.LNX.4.63.0603012239440.5789@kai.makisara.local>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Makisara wrote:
> On Wed, 1 Mar 2006, Douglas Gilbert wrote:
> 
> 
>>Linus Torvalds wrote:
>>
>>>On Wed, 1 Mar 2006, Matthias Andree wrote:
>>>
>>>
>>>>On Tue, 28 Feb 2006, Douglas Gilbert wrote:
>>>>
>>>>
>>>>
>>>>>You can stop right there with the 1 MB reads. Welcome
>>>>>to the new, blander sg driver which now shares many
>>>>>size shortcomings with the block subsystem.
>>>>
>>>>What is the reason to break user-space applications like this?
>>>
>>>
>>>Did you read the whole thread? It was a low-level SCSI driver issue, where 
>>>nothing broke user space, but the command was just fed to the drive 
>>>differently, which then hit a limit in the driver.
>>
>>Linus,
>>That is an optimistic take. The maximum data carrying
>>capacity of a single SCSI command via the SG_IO ioctl
>>depends on the maximum data carrying capacity of a
>>scatter gather list. Assuming all scatter gather list
>>elements carry the same amount of data then the
>>maximum capacity is:
>>'max_bytes_per_element * max_num_elements'
>>
>>Only the latter figure is a "low-level SCSI driver issue"
>>whose maximum seems to be SG_ALL (255). It is the former
>>figure that has changed. The sg driver in lk 2.6.15 used
>>__get_free_pages() with the order set to get 32 KB where
>>as the generic routine used now get a single page (usually
>>4 KB). Kai Makisara proposed changes in the SCSI LLD
>>template that made things better in my experiments with
>>scsi_debug.
>>
>>However today James Bottomley confirmed that relying on
>>coalescing pages that may be adjacent is not deterministic:
>>http://marc.theaimsgroup.com/?l=linux-scsi&m=114122991606658&w=2
>>
> 
> If this is James's final opininion, then the changes to st for 2.6.16 
> to use scsi_execute_async _must be reverted_ before final 2.6.16. They 
> cause user-visible regression.
> 
> I don't think relying on coalescing in this case is non-deterministic: we 
> know that enough pages are adjacent to coalesce. This is because the pages 
> have been split into bios from larger kernel space buffers. (Conceptually 
> I don't like this splitting and re-merging but it works provided the HBA 
> parameters are good.)

As more information has come to light, the worst case
"big transfer" of a single SCSI command through sg (and
st I suspect) is 512 KB **. With full coalescing that figure
goes up to 4 MB **. I am also aware that some users
increase SG_SCATTER_SZ in the sg driver to get larger
"big transfer"s than sg's current limit of (8MB - 32KB) **.
That facility has now gone (i.e. upping SG_SCATTER_SZ will
have no effect) with no replacement mechanism.

So I'll add my vote to "revert this change before lk 2.6.16"
with a view to applying it after some solution to the "big
transfer" problem is found.

In 8 years of maintaining the sg driver I cannot remember
anybody contacting me regarding the way the sg driver ignored
the DISABLE_CLUSTERING flag; that was until Mike Christie raised
it yesterday with regard to iscsi_tcp ***. Gerard's post from
2000 implied clustering was not a problem with U160 (SPI-3)
so perhaps it was for SPI-2 (1998) or SPI (1995) or SCSI-2 (1993).
If so those are pretty old symbios controllers. Why would any
storage manufacturer make a DMA element that was restricted
to Intel's i386 page size per transfer?

I suspect there are a small number of high power users
that need "big transfers" and they will get a surprise
in lk 2.6.16 if things stay as they are.

> I am a little frustrated with this whole thing. Several people have talked 
> about switching st to use the block layer. Mike Christie finally did the 
> work and the details were discussed on linux-scsi. I thought that 
> everybody agreed on the details and I tested that the code works for st. 
> Now it seems that there was no agreement!
> 
> 
>>That leaves a worst case scatter gather list data capacity
>>of (4 * 255) KB if the SCSI LLD (or SATA) uses SG_ALL. That
>>is still just under the 1 MB bar that started this thread.
>>
> 
> This is not acceptable.
> 
> 
>>So I guess we might find out how many people do big,
>>single SCSI command data, transfers when lk 2.6.16 comes
>>out.
>>
> 
> Learn the hard way ;-( I know that there are applications that read and 
> write large tape blocks but I think they will hit the problems much later. 
> These are production systems that are probably not updated frequently. 
> When they find out this, they probably have to move away from Linux.
> 
> I have talked about st but I think the same arguments apply mostly to sg. 

I believe the sg and st drivers share these problems as would
osst and ch if they tried to send a lot of data in one command.
Firmware loading comes to mind.


** these figures assume ".sg_tablesize" in the corresponding low level
driver is at least 128. If not, scale those figures down proportionally.

*** I believe the iscsi_tcp driver is emulating DMA and Mike
Christie said yesterday that code could be added to that driver
to support "clustering" (i.e. scatter gather element sizes larger
than page size).

Doug Gilbert
