Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUEHNps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUEHNps (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 09:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264006AbUEHNps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 09:45:48 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:43272 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263971AbUEHNpo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 09:45:44 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Date: Sat, 8 May 2004 16:45:06 +0300
User-Agent: KMail/1.5.4
Cc: Jamie Lokier <jamie@shareable.org>, Pavel Machek <pavel@ucw.cz>,
       "Eric W. Biederman" <ebiederm@xmission.com>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de>
In-Reply-To: <20040506131731.GA7930@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200405081645.06969.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 May 2004 16:17, Jörn Engel wrote:
> Couldn't sleep last night and finished a first complete version of
> cowlinks, code-named MAD COW.  It is still based on the stupid old
> design with a flag to distinguish between regular hard links and
> cowlinks.  Please don't comment on that design, it's just a proof of
> concept.
>
> Patches are against 2.6.5 but most things should apply to other 2.6
> kernel without too much trouble.
>
> 1 generic_sendpage	- allow sendfile with ext[23] files as target
> 2 sendfile		- introduce vfs_sendfile for in-kernel use
> 3 copyfile		- new copyfile() system call
> 4 lock_flags		- old cruft, just ignore it
> 5 madcow		- the MAD COW itself
>
> Patches 1-3 will stay, 4 will be remove and 5 replaced by a better
> design over time.  I've also set up a webpage for it:
> http://wohnheim.fh-wedel.de/~joern/cowlink/
>
> Maybe that should be converted into a wiki so someone with better
> taste than myself can improve it.

Hi,

Glad to see this happening. My filesystems are mostly reiser
these days, but if I have some time/occasion, I will try your patch.

Regarding semantics etc. I have read http://lwn.net/Articles/77972/.
I think most difficulties arose from inode numbers as a concept.

Usage of inode number is a historic UNIX misfeature.
AFAIK it is almost exclusively used for determining whether
two files are really the same: same (dev,ino) => same file.
Usage:
* diff wants this to avoid diffing file against itself.
* du wants this in order to not count file twice.
* cp/tar wants this in order to preserve hardlinks.
For cowlinks it is a bit different:
* diff still dont need to compare cowlinked file.
* cp/tar aren't required to detect cowlinks, may do this
  as an optimization.
* du: I am not sure... analogous to sparse files?

In essense, diff wants to ask kernel "are these files have
identical contents?" while tar/cp ask "are these files
hardlinked together?". du asks "are these share storage"?

Original UNIX folks had to make inode number only an advisory
indicator, meaning "if ino1 != ino2, files are _definitely_ not
linked", and a syscall is_hardlinked(fd1,fd2), intended
for use when inodes are equal.

That is probably unfixable now, but you can avoid making similar
error. Provide is_cowlinked(fd1,fd2) syscall. Pity you will
have to use different inode numbers for cowlinks (due to tar/cp),
and this won't fly:

diff.c:
...
if(ino1==ino2 && is_cowlinked(fd1,fd2))
	skip_diff();
...

diff will have to use if(is_cowlinked(fd1,fd2)), i.e. one
extra syscall, always. Anyway, for diff that's not tragic,
savings from not doing diff are still very substantial.
For du, that would hurt.

Per-block cow filesystems will open another can of worms
for diff and du. ;)

P.S. If is_hardlinked() is introduced too, tar/cp can be
updated to use that, and we can slowly drift into right
direction (of not assuming "equal inos => hardlinked file").
I think too much people will disagree with me, and this
won't happen.
--
vda

