Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWCATUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWCATUR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 14:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWCATUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 14:20:16 -0500
Received: from mx.pathscale.com ([64.160.42.68]:22494 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750740AbWCATUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 14:20:15 -0500
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andi Kleen <ak@suse.de>, Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200602282033.48570.ak@suse.de>
References: <1140841250.2587.33.camel@localhost.localdomain>
	 <20060228190354.GE24306@kvack.org>
	 <1141154424.20227.11.camel@serpentine.pathscale.com>
	 <200602282033.48570.ak@suse.de>
Content-Type: text/plain
Date: Wed, 01 Mar 2006 11:20:23 -0800
Message-Id: <1141240823.2899.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-28 at 20:33 +0100, Andi Kleen wrote:

> Anyways if MFENCE improved performance you're probably relying
> on some very specific artifact of the microarchitecture of your 
> CPU or Northbridge. I don't think it's a architecurally guaranteed
> feature.

I looked this up, and you appear to be wrong here.

Here's the appropriate quote from page 246 of the PDF of "AMD64
Architecture Programmer's Manual Volume 2: System Programming":

        http://www.amd.com/us-en/assets/content_type/DownloadableAssets/dwamd_24593.pdf

Section 7.4.1 specifically describes what happens to write buffers:

        [...] the processor completely empties the write buffer by
        writing the contents to memory as a result of performing any of
        the following operations:
        
        SFENCE Instruction
        Executing a store-fence (SFENCE) instruction forces all memory
        writes before the SFENCE (in program order) to be written into
        memory before memory writes that follow the SFENCE instruction.
        The memory-fence (MFENCE) instruction has a similar effect, but
        it forces the ordering of loads in addition to stores.
        [...]

So in fact SFENCE is the appropriate, architecturally guaranteed, thing
for us to be doing on x86_64.

With respect to Ben's contention that wmb() will suffice instead, that
isn't true, either, even on x86-class hardware.  The writes absolutely
travel over the HT bus in non-ascending order on AMD64 systems unless we
fence them, and we've verified this using a HT bus analyser.

	<b

