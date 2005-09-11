Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbVIKXwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbVIKXwU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 19:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVIKXwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 19:52:19 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:39110 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S1751060AbVIKXwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 19:52:19 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Date: Mon, 12 Sep 2005 09:52:09 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17188.49961.268818.355923@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: read-from-all-disks support for RAID1?
In-Reply-To: message from Lennert Buytenhek on Saturday September 10
References: <20050910123902.GA9461@xi.wantstofly.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday September 10, buytenh@wantstofly.org wrote:
> (please CC on replies)
> 
> Hi!
> 
> I recently had a case where one disk in a two-disk RAID1 array went
> subtly bad, effectively refusing to write to certain sectors without
> reporting an error.  Basically, parts of the disk went undetectably
> read-only, causing file system corruption that wouldn't go away after
> fsck, and all kinds of other fun.

That really isn't something that a drive should do.  If a write fails,
you need to be told that it failed.  If anything else happens, maybe
you should consider boycotting that manufacturer, or at least buying
more expensive drives (do I guess right that there were fairly
cheap??).


> 
> Would it be hard/wise to add an option for RAID1 mode to read from all
> devices on a read, and report an error to syslog or simply return an
> I/O error if there is a mismatch?  (Or use majority voting and tell
> people to use 3-disk RAID1 arrays from now on ;-)
> 

No, I don't think so.  The overhead would be substantial, so people
would be very unlikely to use it.
Checking of the correctness of the data is really best done in
hardware - in the drive itself.  That's what CRC fields (or whatever
they use today) in the physical sectors are for...

Sun's new ZFS file system (don't know if it's released yet) has a
fairly cute idea.  Instead of just storing the address of each data
block in a files index information, they also store a checksum and
potentially multiple physical addresses.   When loading the data, they
(maybe optionally) check the checksum (it would be nice if that could
be hardware accelerated!).  If the check fails, either flag an error,
or try to read from another location.
I think doing this in the filesystem is a much better idea than trying
to do it in the raid layer.

The only raid-layer option that I can think of that makes much sense
is to have a regular background scan that reads all blocks and makes
sure all mirrors are consistent.  If an error is found, you generate a
warning and possibly fix it.  This wouldn't report errors immediately,
but at least you would find out proactively instead of through weird
data corruption.

I'm working towards this functionality, but it is still a little way
off.

NeilBrown
