Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbTIWGpy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 02:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263314AbTIWGpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 02:45:54 -0400
Received: from miranda.org ([209.58.150.153]:57096 "HELO miranda.org")
	by vger.kernel.org with SMTP id S263270AbTIWGpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 02:45:53 -0400
Date: Tue, 23 Sep 2003 12:15:45 +0530
From: Abhijit Menon-Sen <ams@wiw.org>
To: linux-kernel@vger.kernel.org
Subject: how is recv(..., MSG_PEEK) racy?
Message-ID: <20030923121545.D700@lustre.dyn.wiw.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm reposting to linux-kernel because I got no response on netdev.)

I'm trying to understand a fetchmail problem that causes large downloads
from IMAP servers to fail randomly. For some reason, fetchmail uses the
following bizarre code inside a loop to read data from the server:

    if ((n = recv(sock, bp, len, MSG_PEEK)) <= 0)
        return (-1);

    if ((newline = memchr(bp, '\n', n)) != NULL)
        n = newline - bp + 1;

    if ((n = read(sock, bp, n)) == -1)
        return (-1);

The problem occurs (at an unpredictable time, but very often, and with a
greater probability with a larger attachment) when the recv() returns 0,
although tcpdump doesn't show the server closing the connection, or any
other unusual behaviour.

Are there any circumstances other than the connection being closed where
recv(..., MSG_PEEK) can return 0? (Stevens/SUSv3 don't mention any.)

I found the following (paraphrased) comment in net/ipv4/tcp.c:

    if ((flags & MSG_PEEK) && peek_seq != tp->copied_seq) {
        printk(KERN_DEBUG "TCP(%s:%d): Application bug, race in MSG_PEEK.\n",
               current->comm, current->pid);

While fetchmail doesn't seem to be triggering that printk(), I'm curious
about what the race condition is. Google found a post by DaveM saying it
has something to do with URG data, but without any further details. I'd
appreciate any explanation of the problem(s).

Thank you.

-- ams
