Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWCHPat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWCHPat (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 10:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWCHPat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 10:30:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58326 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750753AbWCHPas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 10:30:48 -0500
Date: Wed, 8 Mar 2006 07:30:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Paul Mackerras <paulus@samba.org>, David Howells <dhowells@redhat.com>,
       akpm@osdl.org, linux-arch@vger.kernel.org, bcrl@linux.intel.com,
       matthew@wil.cx, linux-kernel@vger.kernel.org, mingo@redhat.com,
       linuxppc64-dev@ozlabs.org, jblunck@suse.de
Subject: Re: Memory barriers and spin_unlock safety
In-Reply-To: <1141823577.7605.31.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0603080724180.32577@g5.osdl.org>
References: <32518.1141401780@warthog.cambridge.redhat.com> 
 <Pine.LNX.4.64.0603030823200.22647@g5.osdl.org>  <17417.29375.87604.537434@cargo.ozlabs.ibm.com>
  <Pine.LNX.4.64.0603040914160.22647@g5.osdl.org>  <17422.19865.635112.820824@cargo.ozlabs.ibm.com>
  <Pine.LNX.4.64.0603071930530.32577@g5.osdl.org> <1141823577.7605.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Mar 2006, Alan Cox wrote:
>
> On Maw, 2006-03-07 at 19:54 -0800, Linus Torvalds wrote:
> > Close, yes. HOWEVER, it's only really ordered wrt the "innermost" bus. I 
> > don't think PCI bridges are supposed to post PIO writes, but a x86 CPU 
> > basically won't stall for them forever.
> 
> The bridges I have will stall forever. You can observe this directly if
> an IDE device decides to hang the IORDY line on the IDE cable or you
> crash the GPU on an S3 card.

Ok. The only thing I have tested is the timing of "outb()" on its own, 
which is definitely long enough that it clearly waits for _some_ bus 
activity (ie the CPU doesn't just post the write internally), but I don't 
know exactly what the rules are as far as the core itself is concerned: I 
suspect the core just waits until it has hit the northbridge or something.

In contrast, a MMIO write to a WC region at least will not necessarily 
pause the core at all: it just hits the write queue in the core, and the 
core continues on (and may generate other writes that will be combined in 
the write buffers before the first one even hits the bus).

		Linus
