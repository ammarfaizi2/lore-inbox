Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751911AbWCAVDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbWCAVDe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 16:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWCAVDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 16:03:34 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:46504 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1751199AbWCAVDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 16:03:33 -0500
Date: Wed, 1 Mar 2006 23:06:19 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Douglas Gilbert <dougg@torque.net>
cc: Linus Torvalds <torvalds@osdl.org>,
       Matthias Andree <matthias.andree@gmx.de>, Mark Rustad <mrustad@mac.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sg regression in 2.6.16-rc5
In-Reply-To: <4405F6F1.9040106@torque.net>
Message-ID: <Pine.LNX.4.63.0603012239440.5789@kai.makisara.local>
References: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com> <4404AA2A.5010703@torque.net>
 <20060301083824.GA9871@merlin.emma.line.org> <Pine.LNX.4.64.0603011027400.22647@g5.osdl.org>
 <4405F6F1.9040106@torque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2006, Douglas Gilbert wrote:

> Linus Torvalds wrote:
> > 
> > On Wed, 1 Mar 2006, Matthias Andree wrote:
> > 
> >>On Tue, 28 Feb 2006, Douglas Gilbert wrote:
> >>
> >>
> >>>You can stop right there with the 1 MB reads. Welcome
> >>>to the new, blander sg driver which now shares many
> >>>size shortcomings with the block subsystem.
> >>
> >>What is the reason to break user-space applications like this?
> > 
> > 
> > Did you read the whole thread? It was a low-level SCSI driver issue, where 
> > nothing broke user space, but the command was just fed to the drive 
> > differently, which then hit a limit in the driver.
> 
> Linus,
> That is an optimistic take. The maximum data carrying
> capacity of a single SCSI command via the SG_IO ioctl
> depends on the maximum data carrying capacity of a
> scatter gather list. Assuming all scatter gather list
> elements carry the same amount of data then the
> maximum capacity is:
> 'max_bytes_per_element * max_num_elements'
> 
> Only the latter figure is a "low-level SCSI driver issue"
> whose maximum seems to be SG_ALL (255). It is the former
> figure that has changed. The sg driver in lk 2.6.15 used
> __get_free_pages() with the order set to get 32 KB where
> as the generic routine used now get a single page (usually
> 4 KB). Kai Makisara proposed changes in the SCSI LLD
> template that made things better in my experiments with
> scsi_debug.
> 
> However today James Bottomley confirmed that relying on
> coalescing pages that may be adjacent is not deterministic:
> http://marc.theaimsgroup.com/?l=linux-scsi&m=114122991606658&w=2
> 
If this is James's final opininion, then the changes to st for 2.6.16 
to use scsi_execute_async _must be reverted_ before final 2.6.16. They 
cause user-visible regression.

I don't think relying on coalescing in this case is non-deterministic: we 
know that enough pages are adjacent to coalesce. This is because the pages 
have been split into bios from larger kernel space buffers. (Conceptually 
I don't like this splitting and re-merging but it works provided the HBA 
parameters are good.)

I am a little frustrated with this whole thing. Several people have talked 
about switching st to use the block layer. Mike Christie finally did the 
work and the details were discussed on linux-scsi. I thought that 
everybody agreed on the details and I tested that the code works for st. 
Now it seems that there was no agreement!

> That leaves a worst case scatter gather list data capacity
> of (4 * 255) KB if the SCSI LLD (or SATA) uses SG_ALL. That
> is still just under the 1 MB bar that started this thread.
> 
This is not acceptable.

> So I guess we might find out how many people do big,
> single SCSI command data, transfers when lk 2.6.16 comes
> out.
> 
Learn the hard way ;-( I know that there are applications that read and 
write large tape blocks but I think they will hit the problems much later. 
These are production systems that are probably not updated frequently. 
When they find out this, they probably have to move away from Linux.

I have talked about st but I think the same arguments apply mostly to sg. 

-- 
Kai
