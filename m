Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423343AbWBBHZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423343AbWBBHZr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 02:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423345AbWBBHZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 02:25:46 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:14988 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1423343AbWBBHZq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 02:25:46 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Chris Mason <mason@suse.com>
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
Date: Thu, 2 Feb 2006 09:25:00 +0200
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
Message-Id: <200602020925.00863.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 January 2006 15:22, Chris Mason wrote:
> > >	chown -Rc 0:<n> .
> > >
> > >in a top directory of tree containing ~21938 files
> > >on reiser3 partition:
> > >
> > >	/dev/sdc3 on /.3 type reiserfs (rw,noatime)
> > >
> > >causes oom kill storm. "ls -lR", "find ." etc work fine.
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

I had reiserfsprogs 3.6.11 and reiserfstune (above command) made my /dev/sdc3
unmountable without -t reiserfs. I upgraded reiserfsprogs to 3.6.19 and now
reiserfsck /dev/sdc3 reports no problems, but mount problem persists:

# mount -t reiserfs /dev/sdc3 /.3
# umount /.3
# mount /dev/sdc3 /.3
mount: you must specify the filesystem type
# dmesg | tail -3
br: port 1(ifi) entering forwarding state
FAT: bogus number of reserved sectors
VFS: Can't find a valid FAT filesystem on dev sdc3.

"chown -Rc <n>:<m> ." now does not OOM kill the box, so this issue
is resolved, thanks!

Can I restore sdc3 somehow that I won't need -t reiserfs in mount command?
You can find result of

dd if=/dev/sdc3 of=1m bs=1M count=1

at http://195.66.192.167/linux/1m
--
vda
