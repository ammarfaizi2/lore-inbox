Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUDCTsf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 14:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUDCTsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 14:48:35 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42155 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261904AbUDCTsa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 14:48:30 -0500
To: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Pavel Machek <pavel@ucw.cz>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
References: <20040320083411.GA25934@wohnheim.fh-wedel.de>
	<s5gznab4lhm.fsf@patl=users.sf.net>
	<20040320152328.GA8089@wohnheim.fh-wedel.de>
	<20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net>
	<20040329231635.GA374@elf.ucw.cz>
	<20040402165440.GB24861@wohnheim.fh-wedel.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Apr 2004 12:47:58 -0700
In-Reply-To: <20040402165440.GB24861@wohnheim.fh-wedel.de>
Message-ID: <m1isggonbl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> writes:

> On Tue, 30 March 2004 01:16:35 +0200, Pavel Machek wrote:
> > 
> > I think they *should* have separate permissions.
> 
> That makes the count 2:2.  I'll continue to follow the simple solution
> for some time, but wouldn't like to have it included for now (or ever?)
> 
> > Also it should be possible to have file with 2 hardlinks cowlinked
> > somewhere, and possibly make more hardlinks of that one... Having
> > pointer to another inode in place where direct block pointers normally
> > are should be enough (thinking ext2 here).
> 
> All right, you are proposing hell.  I've tried to think through all
> possibilities and was too scared to continue.  So limitation is that
> cowlinks and hardlinks are mutually exclusive, which eliminated all
> problems.

Sounds like a simple place to start.

> If you really want cowlinks and hardlinks to be intermixed freely, I'd
> happily agree with you as soon as you can define the behaviour for all
> possible cases in a simple document and none of them make me scared
> again.  Show me that it is possible and makes sense.

Concise summary:
- (indirection inodes) solve the hard link problem.
- Don't share the page cache between cow copies.

For intermixing hard links and cow copy operations a single extra layer
of indirection solves the problem.  The cow files point to an (indirection)
inode that holds the hard link count, the real inode number and possibly 
a few extra things like permissions.  Except for never being pointed
at by a directory entry the real inode works like normal.  The link
count of the real inode is the number of indirection inodes pointing
at it.

Caching issues are more subtle.  The pathological case is a read only
mapping of the cow file, that expects to see the mapping changed by
some other process writing to the file.  Not sharing page cache
entries between cow copies solves this problem.

Once page cache entries are distinct it is possible to move the
trigger down from an open with intent to write, to the first
actual write operation.  In aops->prepare_write from sys_write,
and aops->writepage from the mmap version.

And a few scenarios to hopefully make things clear.

So your fs starts out as:

/file1 -> ino1 (link count 2) -> data block #1
/file2 -> ino1 (link count 2) -> data block #1

file1 is only 4K long, so I only need to describe one data block.

Actions:

cowcopy(file2, file3):

/file1 -> ino1 (link count 2) -> ino2 (link count 2) -> data block #1
/file2 -> ino1 (link count 2) -> ino2 (link count 2) -> data block #1
/file3 -> ino3 (link count 1) -> ino2 (link count 2) -> data block #1


copyfile(file3, file4):

/file1 -> ino1 (link count 2) -> ino2 (link count 3) -> data block #1
/file2 -> ino1 (link count 2) -> ino2 (link count 3) -> data block #1
/file3 -> ino3 (link count 1) -> ino2 (link count 3) -> data block #1
/file4 -> ino4 (link count 1) -> ino2 (link count 3) -> data block #1

unlink(file2):

/file1 -> ino1 (link count 1) -> ino2 (link count 3) -> data block #1
/file3 -> ino3 (link count 1) -> ino2 (link count 3) -> data block #1
/file4 -> ino4 (link count 1) -> ino2 (link count 3) -> data block #1

link(file4, file5):

/file1 -> ino1 (link count 1) -> ino2 (link count 3) -> data block #1
/file3 -> ino3 (link count 1) -> ino2 (link count 3) -> data block #1
/file4 -> ino4 (link count 2) -> ino2 (link count 3) -> data block #1
/file5 -> ino4 (link count 2) -> ino2 (link count 3) -> data block #1

write(file3):

/file1 -> ino1 (link count 1) -> ino2 (link count 2) -> data block #1
/file3 -> ino3 (link count 1) -> data block #2
/file4 -> ino4 (link count 2) -> ino2 (link count 2) -> data block #1
/file5 -> ino4 (link count 2) -> ino2 (link count 2) -> data block #1

write(file5):

/file1 -> ino1 (link count 1) -> ino2 (link count 1) -> data block #1
/file3 -> ino3 (link count 1) -> data block #2
/file4 -> ino4 (link count 2) -> data block #3
/file5 -> ino4 (link count 2) -> data block #3

write(file1):

/file1 -> ino1 (link count 1) -> data block #1 (with modified contents)
/file3 -> ino3 (link count 1) -> data block #2
/file4 -> ino4 (link count 2) -> data block #3
/file5 -> ino4 (link count 2) -> data block #3


Does this make things clear?

Eric
