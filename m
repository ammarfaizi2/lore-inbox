Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUIINS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUIINS2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 09:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUIINS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 09:18:28 -0400
Received: from dhcp164.rrze.uni-erlangen.de ([192.44.87.164]:1408 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263024AbUIINSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 09:18:25 -0400
Date: Thu, 9 Sep 2004 14:39:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrey Savochkin <saw@saw.sw.com.sg>, linux-kernel@vger.kernel.org
Subject: Re: Q about pagecache data never written to disk
Message-ID: <20040909123957.GB1065@elf.ucw.cz>
References: <20040905120147.A9202@castle.nmd.msu.ru> <20040905035233.6a6b5823.akpm@osdl.org> <20040905154336.B9202@castle.nmd.msu.ru> <20040905140040.58a5fcdc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040905140040.58a5fcdc.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The kernel will make one attampt to write the data to disk.  If that write
> > > hits ENOSPC, the page is not redirtied (ie: the data can be lost).
> > > 
> > > When that write hits ENOSPC an error flag is set in the address_space and
> > > that will be returned from a subsequent msync().  The application will then
> > > need to do something about it.
> > > 
> > > If your application doesn't msync() the memory then it doesn't care about
> > > its data anyway.  If your application _does_ msync the pages then we
> > > reliably report errors.
> > 
> > This question came to my mind when I was thinking about journal_start in
> > ext3_prepare_write and copy_from_user issue...
> > Did you follow that discussion?
> 
> Yup.  Chris and I have been admiring the problem for a few months now.
> 
> > In the considered scenario not only the application is not
> > guaranteed anything till msync(), but all other programs doing regular read()
> > may also be fooled about the file content, and this idea surprised me.
> > On the other hand, after a write() other programs also see the new content
> > without a guarantee that this content corresponds with what is on the disk...
> 
> No, read() will see the modified pagecache data immediately, apart from CPU
> cache coherency effects.

Is not this quite a big security hole?

cat evil_data > /tmp/sign.me   [Okay, evil_data probably have to
				contain lot of zeroes?]
sync, fill disk or wait for someone to fill disk completely

attempt to write good_data to /tmp/sign.me using mmap

"Hey, root, see what /tmp/sign.me contains, can you make it suid?"

root reads /tmp/sign.me, and sees it is good.

root does chown root.root /tmp/sign.me; chmod 4755 /tmp/sign.me

kernel realizes that there's not enough disk space, and discard
changes, therefore /tmp/sign.me reverts to previous, evil, content.

								Pavel
-- 
When do you have heart between your knees?
