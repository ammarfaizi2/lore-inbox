Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130167AbRAVWjC>; Mon, 22 Jan 2001 17:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131339AbRAVWir>; Mon, 22 Jan 2001 17:38:47 -0500
Received: from mail.valinux.com ([198.186.202.175]:49420 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S130167AbRAVWil>;
	Mon, 22 Jan 2001 17:38:41 -0500
Date: Mon, 22 Jan 2001 14:37:40 -0800
From: "H . J . Lu" <hjl@valinux.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: [NFS] [CFT] Improved RPC congestion handling for 2.4.0 (and 2.2.18)
Message-ID: <20010122143740.A31589@valinux.com>
In-Reply-To: <14904.54852.334762.889784@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14904.54852.334762.889784@charged.uio.no>; from trond.myklebust@fys.uio.no on Thu, Dec 14, 2000 at 03:16:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 03:16:36PM +0100, Trond Myklebust wrote:
> 
> Hi,
> 
>    One of the things we've been lacking in the Linux implementation of
> RPC is the 'ping' routine. The latter is used on most *NIX
> implementations in order to test whether or not the RPC server is
> alive. To do so, it simply calls procedure-0 (the NULL procedure),
> which is always set up to return the value 0 and therefore acts more
> or less like the icmp 'ping'.
> 
>   The appended patch implements such a routine, and uses it to improve
> our congestion control, by allowing the entire set of pending requests
> to inquire whether or not the server is alive, and then to sleep for 5
> seconds before retrying. This is done if and only if we get a major
> RPC timeout and we see that the client Van Jacobson congestion control
> can no longer throttle back the number of pending requests.
> 
>   This is more accurate than the current system of just retrying each
> request, and waiting for 5 seconds if icmp fails, because the ping
> directly tests whether the server is up and responding to
> requests. Furthermore, unlike the retried requests, the packet length
> of a ping request is always short, so we don't fall prone to issues of
> udp fragmentation messing up the test. Finally, because all pending
> requests are made to wait on a single ping rather than bombarding the
> server with retries, it avoids further congestion to the network.

I got a report which indicates it may not be a good idea, especially
for UDP. Suppose you have a lousy LAN or NFS UDP server for whatever
reason, some NFS/UDP packets may get lost very easily while a ping
request may get through. In that case, the rpc ping may slow down
the NFS client over UDP significantly.


H.J.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
