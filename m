Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbTJORlQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbTJORlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:41:16 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:38280 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263782AbTJORlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:41:09 -0400
Date: Wed, 15 Oct 2003 13:40:47 -0400
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Bradley Chapman <kakadu_croc@yahoo.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: 2.6.0-test7-mm1
Message-ID: <20031015174047.GE971@phunnypharm.org>
References: <20031015032215.58d832c1.akpm@osdl.org> <20031015123444.46223.qmail@web40904.mail.yahoo.com> <20031015102810.4017950f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015102810.4017950f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 10:28:10AM -0700, Andrew Morton wrote:
> Bradley Chapman <kakadu_croc@yahoo.com> wrote:
> >
> > You're welcome. Unfortunately I got this non-fatal Oops when I first booted:
> > 
> >  ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
> >  ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[e8207000-e82077ff]  Max
> >  Packet=[2048]
> >  Debug: sleeping function called from invalid context at mm/slab.c:1869
> >  in_atomic():1, irqs_disabled():0
> >  Call Trace:
> >   [<c0123fc6>] __might_sleep+0xa0/0xc2
> >   [<c0156bc4>] __kmalloc+0x204/0x216
> >   [<e08a9ed4>] hpsb_create_hostinfo+0x6b/0xe8 [ieee1394]
> >   [<e08af0e6>] nodemgr_add_host+0x23/0x1d2 [ieee1394]
> >   [<c0216bd4>] sprintf+0x1f/0x23
> >   [<e08aa789>] highlevel_add_host+0x6b/0x6f [ieee1394]
> >   [<e08a9cce>] hpsb_add_host+0x6d/0x95 [ieee1394]
> 
> highlevel_add_host() does read_lock() and then proceeds to do things like
> starting kernel threads under that lock.  The locking is pretty broken
> in there :(

No, highlevel_add_host() itself doesn't start any threads. But it does
pass around data that needs to be locked from changes, and one of the
handlers happens to start a thread, and other things allocate memory
(such as this case).

It's ugly, and I've been trying to clean it up. This case can be fixed
quickly with a simple check in hpsb_create_hostinfo() to pass GFP_ATOMIC
to kmalloc.

My problem right now, is I don't use any architectures that support
preempt, so I don't see a lot of these problems, like I catch with
CONFIG_SMP.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
