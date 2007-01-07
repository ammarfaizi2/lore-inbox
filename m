Return-Path: <linux-kernel-owner+w=401wt.eu-S964994AbXAGTg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbXAGTg6 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 14:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbXAGTg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:36:57 -0500
Received: from smtp.osdl.org ([65.172.181.24]:43043 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964984AbXAGTg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:36:56 -0500
Date: Sun, 7 Jan 2007 11:35:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Christoph Hellwig <hch@infradead.org>, Willy Tarreau <w@1wt.eu>,
       "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
       nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       webmaster@kernel.org
Subject: Re: How git affects kernel.org performance
In-Reply-To: <9e4733910701071126r7931042eldfb73060792f4f41@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0701071132450.3661@woody.osdl.org>
References: <1166297434.26330.34.camel@localhost.localdomain> 
 <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> 
 <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>  <20070107085526.GR24090@1wt.eu>
 <45A0B63E.2020803@zytor.com>  <20070107090336.GA7741@1wt.eu>
 <20070107102853.GB26849@infradead.org>  <Pine.LNX.4.64.0701070957080.3661@woody.osdl.org>
  <Pine.LNX.4.64.0701071028450.3661@woody.osdl.org>
 <9e4733910701071126r7931042eldfb73060792f4f41@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2007, Jon Smirl wrote:
> > 
> >  - proper read-ahead. Right now, even if the directory is totally
> >    contiguous on disk (just remove the thing that writes data to the
> >    files, so that you'll have empty files instead of 8kB files), I think
> >    we do those reads totally synchronously if the filesystem was mounted
> >    with directory hashing enabled.
> 
> What's the status on the Adaptive Read-ahead patch from Wu Fengguang
> <wfg@mail.ustc.edu.cn> ? That patch really helped with read ahead
> problems I was having with mmap. It was in mm forever and I've lost
> track of it.

Won't help. ext3 does NO readahead at all. It doesn't use the general VFS 
helper routines to read data (because it doesn't use the page cache), it 
just does the raw buffer-head IO directly.

(In the non-indexed case, it does do some read-ahead, and it uses the 
generic routines for it, but because it does everything by physical 
address, even the generic routines will decide that it's just doing random 
reading if the directory isn't physically contiguous - and stop reading 
ahead).

(I may have missed some case where it does do read-ahead in the index 
routines, so don't take my word as being unquestionably true. I'm _fairly_ 
sure, but..)

			Linus
