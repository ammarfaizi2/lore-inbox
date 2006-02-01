Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWBAHd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWBAHd0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 02:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWBAHd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 02:33:26 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:52128 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751400AbWBAHdZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 02:33:25 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Chris Mason <mason@suse.com>
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
Date: Wed, 1 Feb 2006 09:32:50 +0200
User-Agent: KMail/1.8.2
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
References: <200601281613.16199.vda@ilport.com.ua> <43DDAE2D.6080300@namesys.com> <200601300822.47821.mason@suse.com>
In-Reply-To: <200601300822.47821.mason@suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602010932.50972.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 January 2006 15:22, Chris Mason wrote:
> On Monday 30 January 2006 01:11, Hans Reiser wrote:
> > Chris, would Denis Vlasenko wrote:
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

Will try this and report the result.

Please consider printing a big fat warning at mount time if total RAM
on the system is close to sum of RAM space required for all currently
mounted reiserfs partitions...
--
vda
