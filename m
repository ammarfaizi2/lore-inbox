Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263752AbUESBBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbUESBBI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 21:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263756AbUESBBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 21:01:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:7894 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263752AbUESBBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 21:01:04 -0400
Date: Tue, 18 May 2004 18:00:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: invalidate_inode_pages2
Message-Id: <20040518180028.2f3f5744.akpm@osdl.org>
In-Reply-To: <20040519005106.GP3044@dualathlon.random>
References: <20040519001520.GO3044@dualathlon.random>
	<20040518172718.773d32c1.akpm@osdl.org>
	<20040519005106.GP3044@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Tue, May 18, 2004 at 05:27:18PM -0700, Andrew Morton wrote:
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > >
> > > Something broke in invalidate_inode_pages2 between 2.4 and 2.6, this
> > > causes malfunctions with mapped pages in 2.6.
> > 
> > What is the malfunction?
> 
> >From Olaf Kirch
> 
>  -      single application on NFS client opens file and maps it.
>         No-one else has this file open. File contains "zappa\n",
>         and the test app stats it once a second and reports size and
>         contents.
>         len=6, data=7a 61 70 70 61 0a
>  -      on the NFS server, I do "echo frobnorz > file"
>  -      after a while, the test app on the client reports
>         len=10, data=7a 61 70 70 61 0a
>  -      I ctrl-C the app and restart it. We agree that this amounts to
>         a munmap+mmap of the file, right?
>         The test app now reports
>         len=10, data=7a 61 70 70 61 0a 00 00 00 00

OK.  Can we do a full pte invalidation and force a major fault?

> > It's currently the case that pages which are mapped into process pagetables
> > are always up to date, which sounds like a good invariant to have.  This
> 
> I already intentionally broke that invariant in 2.4 just to make exactly
> this thing work safely, this is needed for correct O_DIRECT semantics
> too.
> 
> All it matters is that the pages are re-read after munmap+mmap.
> 
> > changes that rule.  I dunno if it'll break anything though.
> 
> It didn't break anything in 2.4 AFIK.

It might have caused some of the debug checks in fs/buffer.c to get angry
when it's used by direct-IO.  But they're gone now anyway...


