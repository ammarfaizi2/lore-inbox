Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265661AbUHQMMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbUHQMMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 08:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268203AbUHQMLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 08:11:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36261 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268184AbUHQMHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 08:07:14 -0400
Date: Tue, 17 Aug 2004 08:06:22 -0400
From: Alan Cox <alan@redhat.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: switch ide-proc to use the ide_key functionality
Message-ID: <20040817120622.GF3204@devserv.devel.redhat.com>
References: <20040815150414.GA12181@devserv.devel.redhat.com> <200408170231.25725.bzolnier@elka.pw.edu.pl> <20040817010533.GB32628@devserv.devel.redhat.com> <200408171248.12235.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408171248.12235.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 12:48:12PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Which means my cunning plan from the previous mail doesn't actually work
> > unless we take ide_cfg_sem at the top of the proc code before setting_sem.
> > Also looking over it I need to send you the bits to take the sems in each
> > proc routine for that case.
> 
> Yes, on the other hand we may try to do real refcounting.

refcounting doesn't solve the need for keys however due to the way procfs works
I've fixed the keys in my tree by taking the cfg/settings sem for all those
proc functions. I've also done it for the hwif level proc functions.

I'll have a look at what occurs if we make the ->key functions ref count
and add "put" functions. I think that can be made to work cleanly without
changing the rest of the code to refcounts at the same time. It'll still need
some locking because of the memset.  We would still have keys but we'd
refcount usage off them as a starting point.

> more about it - i.e. what protects us from removing hwif while it is being 
> configured by host driver?

A hwif is only removed by the owner. Thus for the PCI devices it is 
protected by higher level serializing. 

> I also can't see how sysfs can help with synchronizing writes to ISA/PCI 
> config space with ongoing I/O?

The question is do we need it ?

Alan

