Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264801AbUEaViY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264801AbUEaViY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 17:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264804AbUEaViY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 17:38:24 -0400
Received: from S010600a0c9f25a40.vn.shawcable.net ([24.87.160.169]:59598 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id S264801AbUEaViW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 17:38:22 -0400
Date: Mon, 31 May 2004 14:38:21 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: NFS client behavior on close
Message-ID: <20040531213820.GA32572@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'lo,

I have a simple script which downloads pictures from my camera's flash
card and writes them to the current directory, which is often on an NFS
mount to a box with available HD space.

I noticed that with files of about this size (~5 MB), there seems to be a
lot of blocking with "cp" (or "mv"), noted by the LED on the card reader
being idle between each file.  What seems to be happening is that "cp"
will open() the source and destination, read and write a bunch of times,
and then close() the destination and source.  An "strace -r" reveals that
on the close() of the destination, "cp" blocks for quite a while. 
Looking at the network, it appears this is happening:

- cp starts copying, data goes to dirty cache (not yet to NFS server)
- cp closes destination
- cp blocks while NFS client writes dirty cache to NFS server
- cp wakes back up when NFS has written all data
- cp proceeds to the next file

This is quite suboptimal in that while the file is being read from the
(relatively slow) compact flash reader it has not yet started writing
over the network, and then between each file it writes all data.

Is the NFS client required to write all data on close?  If I mount with
"noac", downloads are actually faster because each block is written
immediately and there's nothing to unclog on close().  However, with this
option all other bulk transfers are slower (the network never saturates).

I'm using NFSv3.  Would NFSv4 or another version behave differently here?

2.6.6 server and client, btw.  Server exported "async", though exported
with "sync" appears equivalent to the client.

...
     0.000073 read(3, "\f\0\322\0z\0\200\0\r\0\n\0"..., 4096) = 800
     0.000065 write(4, "\f\0\322\0z\0\200\0\r\0\n\0"..., 800) = 800
     0.000066 read(3, "", 4096)         = 0
     0.000055 close(4)                  = 0
     0.906548 close(3)                  = 0

Thanks,

Simon-
