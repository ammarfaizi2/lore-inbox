Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbUDBSBv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 13:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbUDBSBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 13:01:51 -0500
Received: from gprs212-169.eurotel.cz ([160.218.212.169]:8064 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264137AbUDBSBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 13:01:48 -0500
Date: Fri, 2 Apr 2004 20:01:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz
Cc: "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040402180128.GA363@elf.ucw.cz>
References: <20040320083411.GA25934@wohnheim.fh-wedel.de> <s5gznab4lhm.fsf@patl=users.sf.net> <20040320152328.GA8089@wohnheim.fh-wedel.de> <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402165440.GB24861@wohnheim.fh-wedel.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Also it should be possible to have file with 2 hardlinks cowlinked
> > somewhere, and possibly make more hardlinks of that one... Having
> > pointer to another inode in place where direct block pointers normally
> > are should be enough (thinking ext2 here).
> 
> All right, you are proposing hell.  I've tried to think through all
> possibilities and was too scared to continue.  So limitation is that
> cowlinks and hardlinks are mutually exclusive, which eliminated all
> problems.

I do not think I'm proposing hell.

> If you really want cowlinks and hardlinks to be intermixed freely, I'd
> happily agree with you as soon as you can define the behaviour for all
> possible cases in a simple document and none of them make me scared
> again.  Show me that it is possible and makes sense.

Okay:

            User/kernel API modifications for cowlinks

open(..., O_RDWR) may return ENOSPACE

new syscall is introduced, copyfile(int fd_from, int fd_to). fd_to
must be empty, or it returns -EINVAL. copyfile() copies content of
file from one file to another. It may return success even through
there's not enough space on filesystem to actually do the copy. It is
also pretty fast.

another syscall is introduced for diff and friends, long long
get_data_id(int fd). It may only be used on non-zero-length regular
files. if get_data_id(fd1) == get_data_id(fd2), it means that files
fd1 and fd2 contain same data and you do not need to read them to
check it.

df might be overly optimistic

Implications

In my proposlal, diff will not automagically sense files contain same
stuff using (dev, ino); if you want speedups, you'll have to teach
diff to call get_data_id.

Users do not really know cowlinks exist. Disk space behaves funny, and
copyfile is somehow fast, but otherwise its normal UNIX system.

Trivial implementation does copyfile by real copying (=>slow, takes
lots of space), and returns error on get_data_id. (Or it might return
inode#, but returning error is probably better).
	
[And yes, I believe this can actually be implemented in usefull
way. Are you scared or should I continue?]

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
