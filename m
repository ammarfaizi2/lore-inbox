Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271394AbTG2Lnk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 07:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271395AbTG2Lnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 07:43:40 -0400
Received: from tolkor.sgi.com ([198.149.18.6]:34985 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S271394AbTG2Lni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 07:43:38 -0400
Subject: Re: bug in 2.6.0test2
From: Steve Lord <lord@sgi.com>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: scholz@wdt.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030728222641.GE10741@schottelius.org>
References: <20030728115902.GA18993@schottelius.org>
	<1059425249.6601.10.camel@jen.americas.sgi.com> 
	<20030728222641.GE10741@schottelius.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 29 Jul 2003 06:43:17 -0500
Message-Id: <1059478999.1749.18.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-28 at 17:26, Nico Schottelius wrote:
> Steve Lord [Mon, Jul 28, 2003 at 03:47:30PM -0500]:
> > 
> > Something else went wrong before you crashed:
> > 
> > bio too big device loop0 (2 > 0)
> > 
> > This means you cannot use any bio larger than zero to this device,
> 
> assume i didn't understand very much you told me..what is a bio?
> how do I use it? and why is it too big here?

It looks like the loop device may not be correctly initialized yet,
no I/O is possible to it yet.

> 
> > which is probably why ext2 said this, since it caught the error when
> > building the bio.
> 
> ext2? I am wondering..afai understood that, the root wasn't even
> decrypted, how can the kernel try to ext2-mount it?
> 
> > EXT2-fs: unable to read superblock
> > 
> > XFS didn't catch the error building the bio and submitted it, at
> > which point the I/O tripped the BUG. I can fix this part, but
> > the original problem is something I know nothing about.
> 
> ..or better why does it start mounting/before decrypt?
> 

I have never used a crypto loop device, so I cannot what is really
going on. Some initialization step may be missing in the loop device
which means it is not usable, the mount it happening because the
kernel was told to mount it. If you are not specifying a filesystem
type, then possibly what is happening is it is attempting to open
the device as different filesystems, these all fail, until xfs
which does not detect the underlying error on the loop device,
and issues the IO which causes the BUG.

So, we caused the crash, but you were on your way to one anyway,
eventually it would have failed to find a root device and given
up that way.

Steve


