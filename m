Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264901AbTLRCSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 21:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbTLRCSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 21:18:51 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:32520 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S264901AbTLRCSq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 21:18:46 -0500
Date: Wed, 17 Dec 2003 18:18:42 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: raid0 slower than devices it is assembled of?
Message-ID: <20031218021842.GF9137@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <3FDF1C03.2020509@aitel.hist.no> <Pine.LNX.4.58.0312160825570.1599@home.osdl.org> <brqlbu$7vh$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <brqlbu$7vh$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This space available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 10:29:18PM +0000, bill davidsen wrote:
> In article <Pine.LNX.4.58.0312160825570.1599@home.osdl.org>,
> Linus Torvalds  <torvalds@osdl.org> wrote:
> | 
> | 
> | On Tue, 16 Dec 2003, Helge Hafting wrote:
> | >
> | > Raid-0 is ideally N times faster than a single disk, when
> | > you have N disks.
> | 
> | Well, that's a _really_ "ideal" world. Ideal to the point of being
> | unrealistic.
> | 
> | In most real-world situations, latency is at least as important as
> | throughput, and often dominates the story. At which point RAID-0 doesn't
> | improve performance one iota (it might make the seeks shorter, but since
> | seek latency tends to be dominated by things like rotational delay and
> | settle times, that's unlikely to be a really noticeable issue).
> 
> Don't forget time in o/s queues, once an array get loaded that may
> dominate the mechanical latency and transfer times. If you call "access
> time" the sum of all latency between syscall and the first data
> transfer, then reading from multiple drives doesn't reliably help until
> you get the transfer time from an i/o somewhere between 2 and 4x the
> access time. So if the transfer time for a typical i/o is less than 2x
> the typical access time, gains are unlikely. If you set the stripe size
> high enough to make it likely that a typical i/o falls on a single drive
> you usually win. And when the transfer time reaches 4x the access time,
> you almost always win with a split.
> 
> So if you are copying 100MB elements you probably win by spreading the
> i/o, but for more normal things it doesn't much matter.
> 
> THERE'S ONE EXCEPTION: if you have a f/s type which puts the inodes at
> the beginning of the space, and you are creating and deleting a LOT of
> files, with a large stripe you will beat the snot out of one drive and
> the system will bottleneck no end. In that one case you gain by using
> small stripe size and spreading the head motion, even though the file
> i/o itself may really rot. Makes me wish for a f/s which could put the
> inodes in some distributed pattern.

If i recall correctly ext2 like ufs splits the inode table
up and puts parts of it at the beginning of each cylinder or
block group.  Inode assignment being based on an allocation
rule that spreads them across the disks so the file data and
inode will be near each other.  ext[23] also has

       -R raid-options
              Set  raid-related options for the filesystem.  Raid
              options are comma separated, and may take an argu­
              ment  using  the  equals ('=') sign.  The following
              options are supported:

                   stride=stripe-size
                          Configure the  filesystem  for  a RAID
                          array   with   stripe-size filesystem
                          blocks per stripe.

The purpose of the stride option is so that that the inode
table pieces won't all wind up on the same disks as would
happen if stripe size aligns with block group size but be
staggered.

My recollection is that one or both of XFS and JFS store
the inode table in extents which are allocated on demand so
i would hope they also make inode and file data locality a
priority.




-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
