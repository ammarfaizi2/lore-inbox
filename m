Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267776AbUHWUjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267776AbUHWUjB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267509AbUHWUYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:24:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:6589 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267483AbUHWTmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 15:42:02 -0400
Date: Mon, 23 Aug 2004 12:40:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: zdzichu@irc.pl, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm4
Message-Id: <20040823124013.19ceb34f.akpm@osdl.org>
In-Reply-To: <1093285874.29822.19.camel@localhost.localdomain>
References: <20040822013402.5917b991.akpm@osdl.org>
	<20040823182113.GA30882@irc.pl>
	<1093285874.29822.19.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Llu, 2004-08-23 at 19:21, Tomasz Torcz wrote:
> > >- This kernel has an x86 patch which alters the copy_*_user() functions so
> > >  they will return -EFAULT on a fault rather than the number of bytes which
> > >  remain to be copied.  This is a bit of an experiment, because this seems to
> > >  be the preferred API for those functions.   It's a see-what-breaks thing.
> > >
> > 
> >  Things appear to broke. Sometimes kernel starts to spit page allocation
> > failures into log for few minutes, despite memory beeing available:
> 
> The kernel relies on copy_from_user returning the number of bytes copied
> so no suprise there.

Noooo.  copy_*_user() returns zero on success and "number of bytes
remaining to be copied" on fault.  The number of places in the kernel which
actually care about the precision of the "number remaining to be copied"
thing is very small.  Most places just test for non-zeroness.

The problem is that the current semantics are hard to implement on several
architectures.  To get it right, sparc64 has to go back and copy one byte
at a time just to work out the address at which the fault really occurred.

