Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264342AbTKZW3O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 17:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264351AbTKZW3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 17:29:14 -0500
Received: from ns.suse.de ([195.135.220.2]:55753 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264342AbTKZW3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 17:29:11 -0500
Date: Wed, 26 Nov 2003 23:29:09 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
Message-Id: <20031126232909.7e8a028f.ak@suse.de>
In-Reply-To: <20031126120316.3ee1d251.davem@redhat.com>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>
	<20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>
	<p73fzgbzca6.fsf@verdi.suse.de>
	<20031126113040.3b774360.davem@redhat.com>
	<3FC505F4.2010006@google.com>
	<20031126120316.3ee1d251.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003 12:03:16 -0800
"David S. Miller" <davem@redhat.com> wrote:

> On Wed, 26 Nov 2003 11:58:44 -0800
> Paul Menage <menage@google.com> wrote:
> 
> > How about tracking the number of current sockets that have had timestamp 
> > requests for them? If this number is zero, don't bother with the 
> > timestamps. The first time you get a SIOCGSTAMP ioctl on a given socket, 
> > bump the count and set a flag; decrement the count when the socket is 
> > destroyed if the flag is set.
> 
> Reread what I said please, the user can ask for timestamps using CMSG
> objects via the recvmsg() system call, there are no ioctls or socket
> controls done on the socket.  It is completely dynamic and
> unpredictable.

The user sets the SO_TIMESTAMP setsockopt to 1 and then you get the cmsg.
That's per socket state. The other way is to use the SIOCGTSTAMP ioctl.
That is a bit more ugly because it has no state, but you can do 
a heuristic and assume that an process that does SIOCGTSTAMP once
will do it in future too and set a flag in this case. 

The first SIOCGTSTAMP would be inaccurate, but the following (after 
all untimestamped packets have been flushed) would be ok.

Doing for IP would be relatively easy, the only major user of the
timestamp seems to be DECnet and the bridge, but I supose those could be 
converted to use jiffies too.

-Andi
