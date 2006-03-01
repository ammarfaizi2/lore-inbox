Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751824AbWCATe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbWCATe2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 14:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWCATe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 14:34:28 -0500
Received: from canuck.infradead.org ([205.233.218.70]:27056 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1750790AbWCATe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 14:34:27 -0500
Message-ID: <4405F6F1.9040106@torque.net>
Date: Wed, 01 Mar 2006 14:33:05 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Matthias Andree <matthias.andree@gmx.de>, Mark Rustad <mrustad@mac.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sg regression in 2.6.16-rc5
References: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com> <4404AA2A.5010703@torque.net> <20060301083824.GA9871@merlin.emma.line.org> <Pine.LNX.4.64.0603011027400.22647@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603011027400.22647@g5.osdl.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 1 Mar 2006, Matthias Andree wrote:
> 
>>On Tue, 28 Feb 2006, Douglas Gilbert wrote:
>>
>>
>>>You can stop right there with the 1 MB reads. Welcome
>>>to the new, blander sg driver which now shares many
>>>size shortcomings with the block subsystem.
>>
>>What is the reason to break user-space applications like this?
> 
> 
> Did you read the whole thread? It was a low-level SCSI driver issue, where 
> nothing broke user space, but the command was just fed to the drive 
> differently, which then hit a limit in the driver.

Linus,
That is an optimistic take. The maximum data carrying
capacity of a single SCSI command via the SG_IO ioctl
depends on the maximum data carrying capacity of a
scatter gather list. Assuming all scatter gather list
elements carry the same amount of data then the
maximum capacity is:
'max_bytes_per_element * max_num_elements'

Only the latter figure is a "low-level SCSI driver issue"
whose maximum seems to be SG_ALL (255). It is the former
figure that has changed. The sg driver in lk 2.6.15 used
__get_free_pages() with the order set to get 32 KB where
as the generic routine used now get a single page (usually
4 KB). Kai Makisara proposed changes in the SCSI LLD
template that made things better in my experiments with
scsi_debug.

However today James Bottomley confirmed that relying on
coalescing pages that may be adjacent is not deterministic:
http://marc.theaimsgroup.com/?l=linux-scsi&m=114122991606658&w=2

That leaves a worst case scatter gather list data capacity
of (4 * 255) KB if the SCSI LLD (or SATA) uses SG_ALL. That
is still just under the 1 MB bar that started this thread.

So I guess we might find out how many people do big,
single SCSI command data, transfers when lk 2.6.16 comes
out.

Doug Gilbert
