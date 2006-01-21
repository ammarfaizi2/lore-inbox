Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWBBPEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWBBPEx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWBBPEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:04:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16655 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751121AbWBBPEx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:04:53 -0500
Date: Sat, 21 Jan 2006 23:20:08 +0000
From: Pavel Machek <pavel@suse.cz>
To: Chris Mason <mason@suse.com>
Cc: Hans Reiser <reiser@namesys.com>, Denis Vlasenko <vda@ilport.com.ua>,
       linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
Message-ID: <20060121232008.GA2697@ucw.cz>
References: <200601281613.16199.vda@ilport.com.ua> <200601281811.35690.vda@ilport.com.ua> <43DDAE2D.6080300@namesys.com> <200601300822.47821.mason@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601300822.47821.mason@suse.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > >[CCing namesys]
> > >
> > >Narrowed it down to 100% reproducible case:
> > >
> > >	chown -Rc 0:<n> .
> > >
> > >in a top directory of tree containing ~21938 files
> > >on reiser3 partition:
> > >
> > >	/dev/sdc3 on /.3 type reiserfs (rw,noatime)
> > >
> > >causes oom kill storm. "ls -lR", "find ." etc work fine.
> > >
> > >I suspected that it is a leak in winbindd libnss module,
> > >but chown does not seem to grow larger in top, and also
> > >running it under softlimit -m 400000 still causes oom kills
> > >while chown's RSS stays below 4MB.
> 
> In order for the journaled filesystems to make sure the FS is consistent after 
> a crash, we need to keep some blocks in memory until other blocks have been 
> written.  These blocks are pinned, and can't be freed until a certain amount 
> of io is done.
> 
> In the case of reiserfs, it might pin as much as the size of the journal at 
> any time.  The default journal is 32MB, which is much too large for a system 
> with only 32MB of ram.
> 
> You can shrink the log of an existing filesystem.  The minimum size is 513 
> blocks, you might try 1024 as a good starting poing.
> 
> reiserfstune -s 1024 /dev/xxxx
> 
> The filesystem must be unmounted first.

Could we refuse to mount filesystem unless journal_size <
physmem_size/2 or something like that?

I was not aware of this trap, and it seems unlikely that users know
about it...
								Pavel
-- 
Thanks, Sharp!
