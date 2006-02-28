Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWB1RuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWB1RuL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbWB1RuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:50:11 -0500
Received: from mx.pathscale.com ([64.160.42.68]:42963 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751318AbWB1RuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:50:10 -0500
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060225174134.GA18291@kvack.org>
References: <1140841250.2587.33.camel@localhost.localdomain>
	 <20060225142814.GB17844@kvack.org>
	 <1140887517.9852.4.camel@localhost.localdomain>
	 <20060225174134.GA18291@kvack.org>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 09:50:08 -0800
Message-Id: <1141149009.24103.8.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-25 at 12:41 -0500, Benjamin LaHaise wrote:

> That is not the same as saying the write buffers are flushed and wholly 
> visible to their destination, it just means that subsequent reads or 
> writes will not be reordered prior to the sfence instruction.

Right.  I don't need the writes to be visible at the destination device,
in this particular case; a write followed by a barrier just has to show
up at the device before the next write.

Here's what a write to our chip looks like, for sending a packet:

      * write a 64-bit control register that includes the length of the
        segment being written
      * do a barrier to make sure it gets to the device before any other
        writes
      * perform a pile of writes using __iowrite_copy32, not caring
        about the order in which they reach the chip
      * do another barrier
      * perform one final 32-bit write using __raw_writel
      * do one final barrier

The last 32-bit write triggers the chip to put the packet on the wire.
We make sure it happens after the earlier bulk write using a barrier.

	<b

