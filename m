Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVGOQDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVGOQDu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 12:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbVGOQDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 12:03:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38346 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261521AbVGOQCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 12:02:39 -0400
Date: Fri, 15 Jul 2005 09:01:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Jan Blunck <j.blunck@tu-harburg.de>, linux-kernel@vger.kernel.org,
       joern@wohnheim.fh-wedel.de
Subject: Re: [PATCH] generic_file_sendpage
In-Reply-To: <20050715040611.05907f4a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0507150848500.19183@g5.osdl.org>
References: <42D79468.3050808@tu-harburg.de> <20050715040611.05907f4a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Jul 2005, Andrew Morton wrote:
> 
> I don't know if we want to add this feature, really.  It's such a
> specialised thing.

It is, in this format, and I agree - I don't want to add it.

What I'd really like to see is somebody taking a look at my old "pipe as a
zero-copy buffer" patches, which as an interface allowed arbitrary data to
be copied between _any_ file descriptors, and allowed you to do things
like mix input sources quite naturally (ie you could write a header first
from a user-space buffer, then the contents of a file, and then push the
result out to a socket, all with zero-copy).

"sendfile()" in general I think has been a mistake. It's too specialized,
and the interface has always sucked. As Andrew pointed out, it actually
needs to limit the number of buffers in flight partly because otherwise 
you have uninterruptible kernel work etc etc.

But more importantly, sendfile() was always broken as a interface for
receiving data from anything but a page-cache based filesystem. That means 
that it's totally useless for a lot of things. The pipe-buffer thing ends 
up being a totally generic "in-kernel buffer" interface, and is a _lot_ 
more flexible. 

For anybody interested in zero-copy work, here's a LWN write-up of some of 
the original discussion:

	http://lwn.net/Articles/118750/

and my (very ugly) example patch can be found for example here:

	http://groups-beta.google.com/group/linux.kernel/msg/782bd9e5cb647207?hl=en&

(it's not a a complete implementation, but it shows how to go from a file 
_to_ a pipe buffer, but not back to a file again).

I really want to get _rid_ of sendfile, not make any more of it.

			Linus
