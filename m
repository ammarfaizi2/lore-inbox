Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVLASE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVLASE3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 13:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVLASE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 13:04:29 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:16021 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S932383AbVLASE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 13:04:28 -0500
Subject: Re: [PATCH 2.6-git] SPI core refresh
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>,
       dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
In-Reply-To: <20051201191109.40f2d04b.vwool@ru.mvista.com>
References: <20051201191109.40f2d04b.vwool@ru.mvista.com>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Thu, 01 Dec 2005 10:04:17 -0800
Message-Id: <1133460257.4528.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 19:11 +0300, Vitaly Wool wrote:
> Again, some advantages of our core compared to David's I'd like to mention
> 
> - it can be compiled as a module
> - it is priority inversion-free
> - it can gain more performance with multiple controllers
> - it's more adapted for use in real-time environments
> - it's not so lightweight, but it leaves less effort for the bus driver developer.
> 
> (As a response to the last bullet David claims that we limit the flexibility. It's not correct.
> The core method for message retrieval is just a default one and can easily be overridden by the bus driver. It's a common practice, for instance, see MTD/NAND interface.)
> 
> It's also been proven to work on SPI EEPROMs and SPI WiFi module (the latter was a really good survival test! :)).

I have a question about your proposed core.  But first a little
background:

My board has a 3 Cirrus Logic SPI devices (CS8415A, CS8405A and a
CS4341) connected to a PXA255 NSSP port.  I have implemented the PXA2xx
NSSP SPI driver with DMA support using Davids framework and implemented
an working CS8415A driver.

Page 18 of the CS8415A data sheet discusses the SPI IO operation. Three
paragraphs and 1 timing diagram.

http://www.cirrus.com/en/pubs/proDatasheet/CS8415A_F4.pdf

The critical things to get from the datasheet are:

1) The chip has an internal register file pointer MAP which must be
positioned before write and read register operations.

2) The MAP has a auto-increment feature.

3) Register writes can be performed in one chip select cycles while
register reads MAY require a MAP write cycle first and thus require two
chip select cycles. 

Now assume the CS8415A register operations will be generated from two
different sources: "process context" and "interrupt context".  This
assumption forces a "guaranteed message order" requirement onto the IO
Model because of the possibility that an "interrupt context" will move
the MAP in between an "process context" write MAP message and read
register message.  If this is not clear, let me know because it is
important.

I'm using David's SPI IO model to enforce "guaranteed message order" by
building multiple write/read transfers in a single SPI message which is
guaranteed execute in the correct order.

How do I accomplish the same with your core?

-Stephen





