Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVBVDyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVBVDyB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 22:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVBVDyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 22:54:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17884 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262198AbVBVDx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 22:53:58 -0500
Date: Tue, 22 Feb 2005 03:53:38 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Jon Smirl <jonsmirl@gmail.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       adaplas@pol.net, dri-devel@lists.sourceforge.net,
       xorg@lists.freedesktop.org, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Resource management.
In-Reply-To: <9e473391050221170111610521@mail.gmail.com>
Message-ID: <Pine.LNX.4.56.0502220319330.20949@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0502211908520.14500@pentafluge.infradead.org> 
 <200502220653.01286.adaplas@hotpop.com>  <Pine.LNX.4.56.0502212313160.18148@pentafluge.infradead.org>
 <9e473391050221170111610521@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Do you see any other solution to this then?
> 
> You could build this inside of the DRM framework which already
> supports DMA and memory management. DRM doesn't really know anything
> about 3D, it just knows how to send commands to the graphics hardware.
> It's the mesa layer in user space that knows about 3D.
> 
> There is a lot of code inside DRM to stop a DRM user from using the
> DMA hardware to play with kernel memory and gain root priv. fbdev will
> need the same protection if it starts using DMA.

I have CC the dri list to discuss the issues. I have looked at the DRI 
code. I know merging dri and fbdev infrastructres has been discussed
before. There are a few issues that have always prevented this. Now
I'm going to go over the issues.

1. Lots of work that would take lots of time. To my knowledge all fbdev 
   developers work in there spare free time. No one does this for a 
   living.

2. Sharing of headers. The dri headers are isolated in the drm directory.
   I totally understand why :-) It makes merging easier for them. The
   disadvantage is no one in the fbdev can use them easily :-(

3. DRM has way to much functionality for most embedded devices. I have 
   talked to embedded guys before and they want a simple api to work with.
   By default DRM builds in everything. A simple api mean alot to those 
   guys. Plus the extra built in code bloat takes up to much space which 
   is precious on embedded devices. If a devices doesn't support dma then 
   the dma code doesn't need to be built in.

4. Which comes to the next point. The code is not modular enough. Take 
   drm_bufs.c. Everything is a ioctl function. This has a few disadvantages.
   One is the fbdev layer couldn't just link into it so fbcon could use 
   it. The second is it's not easy to take advantage of things like sysfs.
   If you could untangle the code somewhat it would make life so much 
   easier. That would include making life easier for OS ports.

5. The license issue. The DRI code is GPL and additional rights. What is that? 

For the fbdev layer we would need a layer on top of the drm data 
structures because we need to know things in the kernel to draw images
for font characters i.e how much byte padding is need for images.
