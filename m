Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264158AbUDBTHg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 14:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264162AbUDBTHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 14:07:36 -0500
Received: from gprs214-53.eurotel.cz ([160.218.214.53]:896 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264158AbUDBTHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 14:07:21 -0500
Date: Fri, 2 Apr 2004 20:23:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: mj@ucw.cz, jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040402182357.GB410@elf.ucw.cz>
References: <20040320083411.GA25934@wohnheim.fh-wedel.de> <s5gznab4lhm.fsf@patl=users.sf.net> <20040320152328.GA8089@wohnheim.fh-wedel.de> <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402181707.GA28112@wohnheim.fh-wedel.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > If you really want cowlinks and hardlinks to be intermixed freely, I'd
> > > happily agree with you as soon as you can define the behaviour for all
> > > possible cases in a simple document and none of them make me scared
> > > again.  Show me that it is possible and makes sense.
> > 
> > Okay:
> > 
> >             User/kernel API modifications for cowlinks
> > 
> > open(..., O_RDWR) may return ENOSPACE
> > 
> > new syscall is introduced, copyfile(int fd_from, int fd_to). fd_to
> > must be empty, or it returns -EINVAL. copyfile() copies content of
> > file from one file to another. It may return success even through
> > there's not enough space on filesystem to actually do the copy. It is
> > also pretty fast.
> > 
> > another syscall is introduced for diff and friends, long long
> > get_data_id(int fd). It may only be used on non-zero-length regular
> > files. if get_data_id(fd1) == get_data_id(fd2), it means that files
> > fd1 and fd2 contain same data and you do not need to read them to
> > check it.
> 
> Sounds good, but you missed the hell part.

:-).

> Now you write to either one of the six files.  What happens?
> 
> Give me a clean proposal how this is simple, defined and not too
> dangerous for the unaware.  Then I agree, there is no hell involved.

Okay, now I have to start talking about implementation. Assume ext2 as
a base. Theres new object "cowid" which contains, well, id for
get_data_id() and usage count. Each inode either has pointer to
"cowid" object, or it is plain old regular file.

INODE123 Usage count = 2.

> What happens, if you copyfile() a file that has two links?

copyfile results in:

INODE123 Usage count = 2, pointer to cowid 567
COWID 567: Usage count = 2
INODE124 Usage count = 1, pointer to cowid 567

> Then you link() the result.

No, problem just increase usage count on inode124:

INODE123 Usage count = 2, pointer to cowid 567
COWID 567: Usage count = 2
INODE124 Usage count = 2, pointer to cowid 567

> Then you copyfile() one of those two links.

Creates another inode pointing at same old cowid:

INODE123 Usage count = 2, pointer to cowid 567
COWID 567: Usage count = 3
INODE124 Usage count = 2, pointer to cowid 567
INODE125 Usage count = 1, pointer to cowid 567

> Then you link()...

INODE123 Usage count = 2, pointer to cowid 567
COWID 567: Usage count = 3
INODE124 Usage count = 2, pointer to cowid 567
INODE125 Usage count = 2, pointer to cowid 567

Now, if I write to any inode with has cowid, data have to be copied,
and pointer to cowid deleted from that inode .

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
