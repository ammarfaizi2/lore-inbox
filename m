Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267328AbSLEPFE>; Thu, 5 Dec 2002 10:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267330AbSLEPFE>; Thu, 5 Dec 2002 10:05:04 -0500
Received: from host194.steeleye.com ([66.206.164.34]:59919 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267328AbSLEPFC>; Thu, 5 Dec 2002 10:05:02 -0500
Message-Id: <200212051512.gB5FCWg02101@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation 
In-Reply-To: Message from Benjamin Herrenschmidt <benh@kernel.crashing.org> 
   of "05 Dec 2002 12:15:30 +0100." <1039086930.1609.71.camel@zion> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 05 Dec 2002 09:12:32 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

benh@kernel.crashing.org said:
> actually, the device model defines a bus "type" structure rather than a
> "bus instance" structure (well, at least it did last I looked a couple
> of weeks ago). That's a problem I beleive here, as those functions are
> really a property of a given bus instance. One solution would
> eventually be to have the set of functions pointers in the generic
> struct device and by default be copied from parent to child. 

Well, the bus in the generic device model is just a struct device as well.

The parisc implementation I'm working on stores this type of conversion 
information in the platform_data field of the generic device (although the 
function pointers that make use of it are global).

I did do an implementation which added a dma_accessors set of functions to the 
struct device (and also struct bus_type), but I eventually concluded they had 
to be so platform specific that there was no utility to exposing them.

> Consistency of memory (or simply, in some cases, accessibility of
> system memory by a given device) is really a property of the bus.
> Tweaking magic bits in dma_addr_t and testing them later is a hack.
> The proper implementation is to have the consistent_{alloc,free,map,unm
> ap,sync,...) functions be function pointers in the generic bus
> structure. 

actually, in parisc, the implementation is simple.  The type of memory is 
determined globally per architecture (so it's not encoded in the dma_addr_t).  
As Adam said.  The preferred platform implementation for a machine that did 
both (I believe this is the fabled parisc V class, which I've never seen) 
would be to implement a consistent region so you could tell if dma_addr_t fell 
in that region for whether it was consistent or not.

I fully recognise that dma_addr_t actually has to be freely convertable to the 
physical address by simple casting, because that's the way the pci_ functions 
use it.

James


