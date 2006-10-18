Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161146AbWJRPJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbWJRPJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161138AbWJRPJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:09:12 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:35688 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1161146AbWJRPJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:09:10 -0400
Date: Wed, 18 Oct 2006 11:09:01 -0400
From: Chris Mason <chris.mason@oracle.com>
To: Brice Figureau <brice+lklm@daysofwonder.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sluggish system while copying large files.
Message-ID: <20061018150901.GC16570@think.oraclecorp.com>
References: <1160747774.7929.53.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160747774.7929.53.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 03:56:14PM +0200, Brice Figureau wrote:
> Hi,
> 
> I have a brand new Dell 2850 biXeon x86_64 with a Perc4e/Di (megaraid)
> RAID card with two hardware RAID1 volumes (sda and sdb, ext3 on top of
> LVM2, io scheduler deadline).
> 
> This machine runs 2.6.18 and is used as a mysql server.
> 
> Whenever I cp large files (for instance during backup) from one volume
> to the other, the system becomes really sluggish. 
> Typing a simple ls on an ssh connection to this host takes almost two to
> three secs to print something. 
> Even sometimes top stops displaying stats for a few secs.
> Mysql isn't able to serve request during this time, and request are
> piling until the copy is finished.
> 
> Unfortunately the server is live and I don't have the possibility to
> test old or new kernels easily, so I don't have a baseline to compare
> with.
> 
> swappiness is at 20, kernel compiled without preemption, but with
> SMP/SMT enabled.
> 
> Mysql data is on sdb. The copy takes place from sdb to sda.

The first thing I would suggest would be to use data=writeback for the
mysql partitions.  The easiest way to figure out what is causing the
latencies is to get the output from sysrq-t during one of the stalls.

(see Documentation/sysrq.txt for details on enabling sysrq).

Since mysql is probably triggering tons of fsyncs or O_SYNC writes,
you may want to increase the size of the ext3 log.

If mysql is constantly appending to the files holding your tables, the
synchronous writes are more expensive and log intensive.  Check your
setup to see if you can manually extend any of those files to avoid
constantly growing table files.

-chris
