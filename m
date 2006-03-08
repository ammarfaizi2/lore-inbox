Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWCHTkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWCHTkj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 14:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWCHTkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 14:40:39 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:31365 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932159AbWCHTki
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 14:40:38 -0500
Date: Wed, 8 Mar 2006 12:40:37 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Alan Cox <alan@redhat.com>,
       akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Message-ID: <20060308194037.GO7301@parisc-linux.org>
References: <20060308184500.GA17716@devserv.devel.redhat.com> <20060308173605.GB13063@devserv.devel.redhat.com> <20060308145506.GA5095@devserv.devel.redhat.com> <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com> <9834.1141837491@warthog.cambridge.redhat.com> <11922.1141842907@warthog.cambridge.redhat.com> <14275.1141844922@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 11:26:41AM -0800, Linus Torvalds wrote:
> > I presume there only needs to be an mmiowb() here if you've got the
> > appropriate CPU's I/O memory window set up to be weakly ordered.
> 
> Actually, since the different NUMA things may have different paths to the 
> PCI thing, I don't think even the mmiowb() will really help. It has 
> nothing to serialize _with_.
> 
> It only orders mmio from within _one_ CPU and "path" to the destination. 
> The IO might be posted somewhere on a PCI bridge, and and depending on the 
> posting rules, the mmiowb() just isn't relevant for IO coming through 
> another path.

Looking at the SGI implementation, it's smarter than you think.  Looks
like there's a register in the local I/O hub that lets you determine
when this write has been queued in the appropriate host->pci bridge.
So by the time __sn_mmiowb() returns, you're guaranteed no other CPU
can bypass the write because the write's got far enough.

