Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWELXhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWELXhP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWELXhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:37:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:12450 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932148AbWELXhN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:37:13 -0400
Date: Sat, 13 May 2006 00:37:12 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Erik Mouw <erik@harddisk-recovery.com>, Or Gerlitz <or.gerlitz@gmail.com>,
       linux-scsi@vger.kernel.org, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
Message-ID: <20060512233711.GW27946@ftp.linux.org.uk>
References: <20060512203416.GA17120@flint.arm.linux.org.uk> <20060512214354.GP27946@ftp.linux.org.uk> <20060512215520.GH17120@flint.arm.linux.org.uk> <20060512220807.GR27946@ftp.linux.org.uk> <Pine.LNX.4.64.0605121519420.3866@g5.osdl.org> <20060512222816.GS27946@ftp.linux.org.uk> <20060512224804.GT27946@ftp.linux.org.uk> <20060512225101.GU27946@ftp.linux.org.uk> <Pine.LNX.4.64.0605121559490.3866@g5.osdl.org> <20060512232131.GV27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060512232131.GV27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2006 at 12:21:31AM +0100, Al Viro wrote:
> The problem is with disk->driverfs_dev, not disk itself.  Block layer
> has no fscking business touching it after del_gendisk() - if nothing else,
> we might have _no_ underlying object at all from the very beginning.
> 
> So anything that wants events related to partitions, let alone mounting,
> can't expect to see PHYSDEV... crap.  Moreover, it can bloody well
> get to PHYSDEV... itself *if* it wants to and if it's there.  There's
> a reason why we have that symlink in sys/block/<device> and userland can
> bloody well access it on its own.

BTW, the best option is to kill bdev_uevent() again.  Short of that,
skip PHYSDEV mess if disk doesn't have GENHD_FL_UP.
