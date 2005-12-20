Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbVLTKLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbVLTKLb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 05:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbVLTKLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 05:11:30 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:5078 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750920AbVLTKLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 05:11:30 -0500
Date: Tue, 20 Dec 2005 02:11:29 -0800
From: Deepak Saxena <dsaxena@plexity.net>
To: andrew.grover@intel.com, christopher.leech@intel.com
Cc: john.ronciak@intel.com, linux-kernel@vger.kernel.org
Subject: IOAT comments
Message-ID: <20051220101128.GA28938@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andy & Chris,

Sorry for the very very delayed response on your patch. Some comments below.

- Embedded chipsets have had DMA engines on them for a long time and 
  having a single cross-platform API that can be used to offload standard
  kernel functions (memcpy, user_copy, etc) is a good starting point to make
  use of these. However, in addition to simple memory to memory copying, the
  engines on embedded devices often support memory <-> I/O space copying
  (accelereted memcpy_to_io/from_io). 

  What I would ideally like to see is an API that allows me to allocate a
  DMA channel between system memory and a device struct:

  dma_client_alloc_chan(struct dma_client client*, struct device *dev);

  The core would then search the DMA controller list, calling some function
  [(dma_device->device_supported(dev)?] to determine whether a controller 
  can DMA to/from this device.  Currently we have lots of CPU-specific DMA
  APIs in the embedded architectures and it would be nice to have well
  defined API that all drivers across all architectures could use.

  Passing a NULL dev would signify that we just want to do mem <-> mem DMA.

- Make the various copy functions static inlines since they are just doing
  an extra function pointer dereference. 

- The API currently supports only 1 client per DMA channel. I think a 
  client should be able to ask for exclusive or non-exclusive usage of 
  a DMA channel and the core can mark channels as unvailable when 
  exclusive use is required. This could be useful in systems with just 
  1 DMA channel but multiple applications wanting to use it.

- Add an interface that takes scatter gather lists as both source and
  destination.

- DMA engine buffer alignment requirements? I've seen engines that 
  handle any source/destination alignment and ones that handle 
  only 32-bit or 64-bit aligned buffers. In the case of a transfer
  that is != alignment requirement of DMA engine, does the DMA device
  driver handle this or does the DMA core handle this?

- Can we get rid of the "async" in the various function names? I don't
  know of any HW that implements a synchronous DMA engine! It would sort
  of defeat the purpose. :)

- The user_dma code should be generic, not in net/ but in kernel/ or
  in drivers/dma as other subsystems and applications can probably 
  make use of this funcionality.

~Deepak



-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net
