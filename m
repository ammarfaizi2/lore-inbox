Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbUKFVkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbUKFVkY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 16:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbUKFVkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 16:40:24 -0500
Received: from danga.com ([66.150.15.140]:65204 "EHLO danga.com")
	by vger.kernel.org with ESMTP id S261480AbUKFVkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 16:40:10 -0500
Date: Sat, 6 Nov 2004 13:40:09 -0800 (PST)
From: Brad Fitzpatrick <brad@danga.com>
X-X-Sender: bradfitz@danga.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: "dm-dirtytrack" target to assist w/ remote block device snapshots
Message-ID: <Pine.LNX.4.58.0411061306300.25479@danga.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Working with highly available databases, I frequently have the need to
snapshot multiple block devices on one machine onto identically sized
block devices on another machine, and ideally without much/any downtime on
the source machine.

What I want to do is make a device mapper target that accepts netlink
connections from userspace and for each connection, lets those connections
"subscribe" to dirty notifications on 0 or more block devices, but
otherwise just passes down read/reada/write requests down to the next
layer.  On each write request, the kernel would maintain a list of dirty
sectos/extends for each subscribed connection.

Then a daemon in userspace can keep track of what the remote machine's
already copied, and what's dirty.

I imagine it working like:

Machine S:  source machine, with live database
Machine D:  destination machine, needing the data

   -- run userspace daemon on S

   -- machine D connects to daemon on S

   -- daemon on S subscribes w/ netlink socket to dm-dirtytrack
      each block device it's copying to D.

   -- pass 1:  D copies the entire block devices, rate-limited
      by the daemon on S based on plugins to the daemon
      which monitor the load of the database.  (meanwhile the
      daemon is reading from the netlink socket all the dirty
      sectors/extents)

   -- once D has a dirty snapshot, it then starts pass 2
      and the daemon on S freezes the database, and sends
      all the dirty regions to D, and unfreezes the database.
      (presumably this step would be much faster, else
       multiple dirty-gather passes could be done)

I could just use dm-snapshot locally, and then sync from that (which is
what we do now), but honestly I'm kinda just looking for a project, and
there are a couple of minor advantages to my idea over a local snapshot:

   -- don't need to reserve snapshot space on the source

   -- our database (MySQL-InnoDB) has no way to freeze for a snapshot
      short of stopping it, which takes time, boots clients, and kills
      caches, and there's no way with dm-snapshot (I believe?) to do an
      atomic snapshot over two block devices (our data block device and
      the DB recovery logs on another)  so with the scheme above, we could
      "freeze" the database by just putting it into read-only mode from
      the application and while the data block device will continue to be
      updated by whatever black magic InnoDB does every few seconds, it's
      at a very low rate, and the syncer would be able to catch up.  then
      we start up InnoDB on the slave and the database recovery does the
      rest, once we have a consistent image between the data
      blockdevice and logfile filesystem.

Any comments on my sanity, whether this has been done already, and most
importantly:  thoughts on what a proper design/interface would be?

Thanks!

- Brad
