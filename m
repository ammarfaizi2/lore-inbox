Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbUC0Ouz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 09:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUC0Ouy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 09:50:54 -0500
Received: from mail.shareable.org ([81.29.64.88]:23954 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261757AbUC0Ouw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 09:50:52 -0500
Date: Sat, 27 Mar 2004 14:49:45 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Pavel Machek <pavel@suse.cz>,
       Suspend development list <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]]
Message-ID: <20040327144945.GG21884@mail.shareable.org>
References: <20040323233228.GK364@elf.ucw.cz> <opr5d7ad0b4evsfm@smtp.pacific.net.th> <20040325014107.GB6094@elf.ucw.cz> <200403250857.08920.matthias.wieser@hiasl.net> <1080247142.6679.3.camel@calvin.wpcb.org.au> <20040325222745.GE2179@elf.ucw.cz> <1080250718.6674.35.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080250718.6674.35.camel@calvin.wpcb.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> > Kernel could automagically select the right one..
>
> How?

Run two parallel tasks: 1. write pages to disk by queuing the I/Os;
2. compress unqueued pages.

The first task won't use much CPU because it's always waiting for disk
DMAs to complete.  While it sleeps, the second task runs.
Alternatively this can be implemented using polling for I/O
completions in the second task, if that's easier.

The first task should keep the I/O queue full enough to sustain
writing, but not much fuller than that.  Either a fixed queue length
will be fine, or it is easy to adjust the queue length dynamically by
enlarging it if any I/O completions occur when the queue is empty.

The second task consumes uncompressed pages and makes available
compressed pages.

When the first task wants to queue more pages for I/O, it first checks
the compressed-page list.  If there are any, they are queued,
otherwise it consumes uncompressed pages.

This will automatically converge on an optimal balance between
compressed and uncompressed page writing, provided the disk is using
DMA, which they do on all modern system.

This is actually better than fully enabling or disabling compression.
Even on a slow CPU, the fastest strategy is to compress x% of the
pages.  E.g. if the CPU can compress 1 page in the time it takes to
write 3 pages, you will suspend fastest by compressing about 30% of
all pages.

-- Jamie
