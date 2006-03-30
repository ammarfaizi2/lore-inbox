Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWC3AFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWC3AFE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWC3AFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:05:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3304 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751033AbWC3AFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:05:02 -0500
Date: Wed, 29 Mar 2006 16:06:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: adrian@smop.co.uk
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       Andi Kleen <ak@muc.de>
Subject: Re: 2.6.16-mm1 leaks in dvb playback
Message-Id: <20060329160648.59395d67.akpm@osdl.org>
In-Reply-To: <20060329233712.GA21810@smop.co.uk>
References: <20060326211514.GA19287@wyvern.smop.co.uk>
	<20060327172356.7d4923d2.akpm@osdl.org>
	<20060328070220.GA29429@smop.co.uk>
	<20060327231630.76e97b83.akpm@osdl.org>
	<20060329233712.GA21810@smop.co.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adrian <adrian@smop.co.uk> wrote:
>
> On Mon, Mar 27, 2006 at 23:16:30 -0800 (-0800), Andrew Morton wrote:
> > It's unlikely that the sock_inode_cache leak is related to the dcache leak,
> > but we won't know until we know...
> 
> Looks like this might be the same issus as "dcache leak in 2.6.16-git8
> (II)"...
> 
> I think I've found the patch which causes the leak - it was the
> "use fget_light() in net/socket.c" patch.   I can't see anything
> obviously wrong, although the patch changes the code so that in
> sys_sendto and sys_recvfrom it now does a sockfd_put(sock) if the
> sock_from_file call fails which didn't use to happen.   That seems to
> agree more with other bits of code, but I've no idea what is the right
> thing todo.

OK, thanks, that helps heaps.

The code does look OK, so it that's the source of the leak then something
subtle might be happening.

If it _is_ a fget/fput thing then I'd expect files_cache to be leaking too.

> One item I spotted whilst perusing the code is that in net/core/sock.c
> in compat_sock_common_getsockopt, it checks if
> sk->sk_prot->compat_setsockopt is NULL before calling
> sk->sk_prot->compat_getsockopt (set vs get).

Ah.  I guess nobody ever implements compat_getsockopt without also
implementing compat_setsockopt but yes, it'd be tidier to actually check
the thing we're about to call ;)

> I'll try and confirm tomorrow with a nice fresh build.   The command
> I'm using to test is "dvbstream -f 650166.670 -v 570 -a 571 -o >
> /dev/null" 

Thanks again.
