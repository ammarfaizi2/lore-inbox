Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266358AbTGJOuG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 10:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269290AbTGJOuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 10:50:06 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:64402 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S266358AbTGJOuC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 10:50:02 -0400
Date: Thu, 10 Jul 2003 16:04:41 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client errors with 2.5.74?
Message-ID: <20030710150441.GC29113@mail.jlokier.co.uk>
References: <20030710053944.GA27038@mail.jlokier.co.uk> <16141.15245.367725.364913@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16141.15245.367725.364913@charged.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>      >       kernel: nfs: server 192.168.1.1 not responding, timed out

Trond Myklebust wrote:
> I can never guarantee you perfect service with soft mounts (a 5 second
> network patition/server congestion is all it takes)

There is _no_ congestion to speak of: I type "ls directory" and it
returns EIO apparently immediately, from an otherwise idle network and
unloaded server.

The "server 192.168.1.1 not responding, timed out" message also
appears immediately in this case - there is no 5 second delay.

There is no 0.7 second delay either (the default value of "timeo"
according to nfs(5)).  So the retransmission logic is buggered.

> Sigh... I hate soft mounts...  Have I said that before? 8-)

If I switch to a hard mount ("hard,intr") the EIO errors go away.

However, the protocol problem remains: multiple READDIRPLUS calls with
the same xid in a fraction of a second.  Note: there is no 0.7 second
delay between these packets.  According to Ethereal, it is between
0.01 and 0.1 seconds between duplicate requests.

There seems to be a transition from a state where calls with duplicate
xids are rare (but they do occur), to one where they occur on nearly
every request.

I have 768MB of RAM on the client, so I checked whether RAM being
filled makes a difference.  Not really.

After mounting, if I do "ls -lR" then I see that duplicate xids are
rare for a while, then they become common.  In this state, I still
have 400MB free (i.e. not even filled clean pagecache pages), so it is
not an absolute shortage of RAM which triggers this, but something else.

I suspect the request timeout logic is buggered, and sending retries
too quickly - 0.01 to 0.1 seconds rather than 0.7 upwards.  It would
also explain why "soft" is failing quickly: if the timeout logic
thinks it has already sent the maximum number of retries in a very
short time, it will count it as a timeout even though the server is
quite fast in responding.

It's interesting that this state can be reached even when the network,
client and server are idle and I try "ls directory" for some uncached
directory.  This shows it's not purely a question of congestion, but
that even a fast response is not good enough.

-- Jamie
