Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266887AbUIEQfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266887AbUIEQfN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 12:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266885AbUIEQfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 12:35:13 -0400
Received: from the-village.bc.nu ([81.2.110.252]:8605 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266880AbUIEQey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 12:34:54 -0400
Subject: Re: New proposed DRM interface design
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Keith Whitwell <keith@tungstengraphics.com>, Dave Jones <davej@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mharris@redhat.com
In-Reply-To: <9e47339104090508052850b649@mail.gmail.com>
References: <20040904102914.B13149@infradead.org>
	 <4139A9F4.4040702@tungstengraphics.com> <20040904115442.GD2785@redhat.com>
	 <4139B03A.6040706@tungstengraphics.com> <20040904122057.GC26419@redhat.com>
	 <4139C8A3.6010603@tungstengraphics.com>
	 <9e47339104090408362a356799@mail.gmail.com>
	 <4139FEB4.3080303@tungstengraphics.com>
	 <9e473391040904110354ba2593@mail.gmail.com>
	 <1094386050.1081.33.camel@localhost.localdomain>
	 <9e47339104090508052850b649@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094398257.1251.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 05 Sep 2004 16:31:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only glue structure you need for most of this is

struct fb_device
{
	struct fb_info *fb;	/* NULL or frame buffer device */
	struct dri_whatever *dri;  /* As yet not nicely extracted DRI
					object */
	atomic_t refcnt;
	void *private
};

Right now the drvdata for most PCI/AGP frame buffers is set to the
fb_info. If that is set to the shared object then you can attach DRI and
or FB first and they can find and call each others methods.

It might also need a single lock just to avoid DRI deciding to go away
while fb is calling dri and the reverse although I think the refcnt is
easier and cheaper.

With that in place if X tells DRI "640x480 starting here" then DRI can
tell fb "640x480 starting here". Similarly fb and dri can find each
other for acceleration and the kernel can become a DRI client for
console acceleration.

Once you have this object you can start attaching memory managers and
mode setup pointers to the shared structure so that they live
independantly.

