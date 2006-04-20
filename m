Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWDTT07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWDTT07 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 15:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWDTT07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 15:26:59 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:953
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750953AbWDTT06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 15:26:58 -0400
Date: Thu, 20 Apr 2006 12:26:47 -0700 (PDT)
Message-Id: <20060420.122647.03915644.davem@davemloft.net>
To: axboe@suse.de
Cc: torvalds@osdl.org, diegocg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060420145041.GE4717@suse.de>
References: <20060419200001.fe2385f4.diegocg@gmail.com>
	<Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>
	<20060420145041.GE4717@suse.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@suse.de>
Date: Thu, 20 Apr 2006 16:50:42 +0200

> On Wed, Apr 19 2006, Linus Torvalds wrote:
> >  - vmsplice() system call to basically do a "write to the buffer", but 
> >    using the reference counting and VM traversal to actually fill the 
> >    buffer. This means that the user needs to be careful not to re-use the 
> >    user-space buffer it spliced into the kernel-space one (contrast this 
> >    to "write()", which copies the actual data, and you can thus re-use the 
> >    buffer immediately after a successful write), but that is often easy to 
> >    do.
> 
> This I already did, it was pretty easy and straight forward. I'll post
> it soonish.

Do we plan to do vmsplice() to sockets?  That's interesting, but
requires some serious cooperation from things like TCP so that
the indication of "buffer can be reused now, thanks" is explicit
and indicated as soon as ACK's come back for those parts of the
data stream.

Even UDP would need to wait until the card is done with transmit,
and we have DCCP and SCTP too.

People would want to be able to get event notifications of this,
or do we plan to just block?  Blocking could be problematic,
performance wise.

Anyways, I'm just stabbing in the dark.  It would be useful, because
there is no real clan way to use sendfile() for zero copy of anonymous
user data, and this vmsplice() thing seems like it could bridge that
gap if we do it right.
