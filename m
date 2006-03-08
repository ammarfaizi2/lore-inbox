Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbWCHUDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbWCHUDT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWCHUDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:03:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21907 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932563AbWCHUDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:03:18 -0500
Date: Wed, 8 Mar 2006 15:02:46 -0500
From: Alan Cox <alan@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Alan Cox <alan@redhat.com>,
       akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Message-ID: <20060308200246.GA17886@devserv.devel.redhat.com>
References: <20060308184500.GA17716@devserv.devel.redhat.com> <20060308173605.GB13063@devserv.devel.redhat.com> <20060308145506.GA5095@devserv.devel.redhat.com> <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com> <9834.1141837491@warthog.cambridge.redhat.com> <11922.1141842907@warthog.cambridge.redhat.com> <14275.1141844922@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 11:26:41AM -0800, Linus Torvalds wrote:
> Actually, since the different NUMA things may have different paths to the 
> PCI thing, I don't think even the mmiowb() will really help. It has 
> nothing to serialize _with_.

It serializes to the bridge. On the Altix for example this is done by reading
a local status register with the pending write count in it and waiting until
the chip reports the write has propogated across the fabric. At that point it
has hit the bridge and the usual PCI posting applies, but the PCI ordering
rule will also apply so the write won't be passed by another write issued
after the spinlock is then dropped.

> The IO might be posted somewhere on a PCI bridge, and and depending on the 
> posting rules, the mmiowb() just isn't relevant for IO coming through 
> another path.

Yes. mmiowb only serializes to the bridge. Thats how it is defined in the
documentation. Thats enough to sort out things like the example with locks,
but where a read from the device would be overkill.

> general, or even very commonly. The undeniable fact is that "big NUMA" 
> machines need to validate the drivers they use separately. The fact that 
> it works on a normal PC - and that it's been tested to death there - does 
> not guarantee much anything.

mmiowb comes about from the Altix folks strangley enough.

> The good news, of course, is that you don't use that kind of "big NUMA" 
> system the same way you'd use a regular desktop SMP. You don't plug in 
> random devices into it and just expect them to work. I'd hope ;)

Various core drivers like tg3 use mmiowb()

Alan

