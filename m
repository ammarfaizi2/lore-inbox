Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272765AbTHPLV1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 07:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272774AbTHPLV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 07:21:27 -0400
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:19271 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S272765AbTHPLVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 07:21:24 -0400
Date: Sat, 16 Aug 2003 14:21:22 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Manfred Spraul <manfred@colorfullife.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] slab debug vs. L1 alignement
In-Reply-To: <1061030600.582.121.camel@gaston>
Message-ID: <Pine.LNX.4.56.0308161359460.1703@kai.makisara.local>
References: <3F3D558D.5050803@colorfullife.com>  <1060990883.581.87.camel@gaston>
  <3F3D8D3B.3020708@colorfullife.com>  <1061026667.881.100.camel@gaston> 
 <3F3E02EE.8080909@colorfullife.com> <1061030600.582.121.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Aug 2003, Benjamin Herrenschmidt wrote:

>
> > >
> > Hmm. That means slab debugging did it's job: The driver contains the
> > wrong assumption that all pointers are cache line aligned. Without slab
> > debugging, this would result in rare data corruptions in O_DIRECT apps.
> > With slab debugging on, it's exposed immediately.
>
> As we discussed on IRC, I think SCSI host drivers (at least) can assume
> beeing passed aligned buffers, if somebody don't agree, please speak
> up ;) Christoph said that O_DIRECT has strict alignement rules too.
>
A character device (like st) doing direct i/o from user buffer to/from a
SCSI device does not currently have any alignment restrictions. I think
restricted alignment can't be required from a user of an ordinary
character device. This must then be handled by the driver. The solution is
to use bounce buffers in the driver if the alignment does not meet the
lower level requirements. This leads to surprises with performance if the
user buffer alignment does not satisfy the requirements (e.g., malloc()
may or may not return properly aligned blocks). These surprises should be
avoided as far as the hardware allows.

If an architecture has restrictions, they must, of course, be taken into
account. However, this should not punish architectures that don't have the
restrictions. Specifying that DMA buffers must be cache-line aligned would
be too strict. A separate alignment constraint for DMA in general and for
a device in specific would be a better alternative (a device may have
tighter restrictions than an architecture). The same applies to buffer
sizes. This would mean adding two more masks for each device (like the
current DMA address mask for a device).

-- 
Kai
