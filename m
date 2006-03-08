Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWCHSpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWCHSpK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 13:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWCHSpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 13:45:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24269 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932355AbWCHSpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 13:45:08 -0500
Date: Wed, 8 Mar 2006 13:45:00 -0500
From: Alan Cox <alan@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Alan Cox <alan@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Message-ID: <20060308184500.GA17716@devserv.devel.redhat.com>
References: <20060308173605.GB13063@devserv.devel.redhat.com> <20060308145506.GA5095@devserv.devel.redhat.com> <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com> <9834.1141837491@warthog.cambridge.redhat.com> <11922.1141842907@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11922.1141842907@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 06:35:07PM +0000, David Howells wrote:
> Alan Cox <alan@redhat.com> wrote:
> 
> > spin_unlock ensures that local CPU writes before the lock are visible
> > to all processors before the lock is dropped but it has no effect on 
> > I/O ordering. Just a need for clarity.
> 
> So I can't use spinlocks in my driver to make sure two different CPUs don't
> interfere with each other when trying to communicate with a device because the
> spinlocks don't guarantee that I/O operations will stay in effect within the
> locking section?

If you have 

CPU #0

	spin_lock(&foo->lock)
	writel(0, &foo->regnum)
	writel(1, &foo->data);
	spin_unlock(&foo->lock);

					CPU #1
						spin_lock(&foo->lock);
						writel(4, &foo->regnum);
						writel(5, &foo->data);
						spin_unlock(&foo->lock);

then on some NUMA infrastructures the order may not be as you expect. The
CPU will execute writel 0, writel 1 and the second CPU later will execute
writel 4 writel 5, but the order they hit the PCI bridge may not be the
same order. Usually such things don't matter but in a register windowed
case getting 0/4/1/5 might be rather unfortunate.

See Documentation/DocBook/deviceiobook.tmpl (or its output)

The following case is safe

	spin_lock(&foo->lock);
	writel(0, &foo->regnum);
	reg = readl(&foo->data);
	spin_unlock(&foo->lock);

as the real must complete and it forces the write to complete. The pure write
case used above should be implemented as

	spin_lock(&foo->lock);
	writel(0, &foo->regnum);
	writel(1, &foo->data);
	mmiowb();
	spin_unlock(&foo->lock);

The mmiowb ensures that the writels will occur before the writel from another
CPU then taking the lock and issuing a writel.

Welcome to the wonderful world of NUMA

Alan

