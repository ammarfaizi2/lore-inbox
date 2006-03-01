Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWCAUq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWCAUq3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWCAUq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:46:29 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:57325 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1751177AbWCAUqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:46:15 -0500
Subject: Re: sg regression in 2.6.16-rc5
From: Mike Christie <michaelc@cs.wisc.edu>
To: dougg@torque.net
Cc: Linus Torvalds <torvalds@osdl.org>,
       Matthias Andree <matthias.andree@gmx.de>, Mark Rustad <mrustad@mac.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4405F6F1.9040106@torque.net>
References: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com>
	 <4404AA2A.5010703@torque.net> <20060301083824.GA9871@merlin.emma.line.org>
	 <Pine.LNX.4.64.0603011027400.22647@g5.osdl.org>
	 <4405F6F1.9040106@torque.net>
Content-Type: text/plain
Date: Wed, 01 Mar 2006 14:42:49 -0600
Message-Id: <1141245769.9586.6.camel@max>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-01 at 14:33 -0500, Douglas Gilbert wrote:
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
> 4 KB). 

The current sg driver should use alloc_pages() with an order that should
get 32 KB. If the order being passed to alloc_pages() in sg.c is only
getting one page by default that is bug.

The generic routines now being used can turn that 32KB segment into
multiple 4KB ones if the LLD does not support clustering.


> Kai Makisara proposed changes in the SCSI LLD
> template that made things better in my experiments with
> scsi_debug.
> 
> However today James Bottomley confirmed that relying on
> coalescing pages that may be adjacent is not deterministic:
> http://marc.theaimsgroup.com/?l=linux-scsi&m=114122991606658&w=2
> 
> That leaves a worst case scatter gather list data capacity
> of (4 * 255) KB if the SCSI LLD (or SATA) uses SG_ALL. That
> is still just under the 1 MB bar that started this thread.

Actually, we will hit the SCSI_MAX_PHYS_SEGMENTS first. It is 128 by
default so (4 * 128) KB. Here is a patch, only compile tested, to
increase SCSI_MAX_PHYS_SEGMENTS to 256.

--- linux-2.6.16-rc4/include/scsi/scsi.h.orig	2006-03-01 14:32:18.000000000 -0600
+++ linux-2.6.16-rc4/include/scsi/scsi.h	2006-03-01 14:33:32.000000000 -0600
@@ -14,7 +14,7 @@
  *	The maximum sg list length SCSI can cope with
  *	(currently must be a power of 2 between 32 and 256)
  */
-#define SCSI_MAX_PHYS_SEGMENTS	MAX_PHYS_SEGMENTS
+#define SCSI_MAX_PHYS_SEGMENTS	256
 
 
 /*


