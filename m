Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWCGUWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWCGUWj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 15:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWCGUWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 15:22:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49823 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932284AbWCGUWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 15:22:37 -0500
Date: Tue, 7 Mar 2006 12:21:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: David Howells <dhowells@redhat.com>, akpm@osdl.org, ak@suse.de,
       mingo@redhat.com, jblunck@suse.de, bcrl@linux.intel.com, matthew@wil.cx,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: Memory barriers and spin_unlock safety
In-Reply-To: <1141757706.31814.80.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0603071218170.3573@g5.osdl.org>
References: <5041.1141417027@warthog.cambridge.redhat.com> 
 <Pine.LNX.4.64.0603030856260.22647@g5.osdl.org>  <32518.1141401780@warthog.cambridge.redhat.com>
  <1146.1141404346@warthog.cambridge.redhat.com>  <31420.1141753019@warthog.cambridge.redhat.com>
  <1141755496.31814.56.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0603071024550.3573@g5.osdl.org> <1141757706.31814.80.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Mar 2006, Alan Cox wrote:
> 
> In the PCI case the I/O write appears to be acked by the bridges used on
> x86 when the write completes on the PCI bus and then back to the CPU.
> MMIO is thankfully posted. At least thats how the timings on some
> devices look.

Oh, absolutely. I'm sayign that you shouldn't wait for even that, since 
it's totally pointless (it's not synchronized _anyway_) and adds 
absolutely zero gain. To really synchronize, you need to read from the 
device anyway.

So the "wait for bus activity" is just making PIO slower for no good 
reason, and keeps the core waiting when it could do something more useful.

On an x86, there are legacy reasons to do it (people expect certain 
timings). But that was what I was saying - on non-x86 architectures, 
there's no reason for the ioread/iowrite interfaces to be as serializing 
as the old-fashioned PIO ones are. Might as well do the MMIO rules for a 
non-cacheable region: no re-ordering, but no waiting for the bus either.

		Linus
