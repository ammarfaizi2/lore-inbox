Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272747AbTHEMrI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 08:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272748AbTHEMrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 08:47:08 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:45842 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S272747AbTHEMoo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 08:44:44 -0400
Message-ID: <3F2FA862.2070401@aitel.hist.no>
Date: Tue, 05 Aug 2003 14:51:46 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
References: <20030804141548.5060b9db.skraw@ithnet.com>	<03080409334500.03650@tabby>	<20030804170506.11426617.skraw@ithnet.com>	<03080416092800.04444@tabby> <20030805003210.2c7f75f6.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
> On Mon, 4 Aug 2003 16:09:28 -0500
> Jesse Pollard <jesse@cats-chateau.net> wrote:
> 
> 
>>>tar --dereference loops on symlinks _today_, to name an example.
>>>All you have to do is to provide a way to find out if a directory is a
>>>hardlink, nothing more. And that should be easy.
>>
>>Yup - because a symlink is NOT a hard link. it is a file.
>>
>>If you use hard links then there is no way to determine which is the "proper"
>>link.
> 
> 
> Where does it say that an fs is not allowed to give you this information in
> some way?

Because there is no such thing as the "proper" link.

Every filename and directoryname is a "hard link" to
some inode.  The "ln" command lets you make more
links to the same inode, there is _no_ difference
at all between the "first" and the "second" (or third) hard link.
There is no information recorded anywhere about which one
where "first".  You can remove the "first" and still
use the file through the second link.


> 
>>>>It was also done in one of the "popular" code management systems under
>>>>unix. (it allowed a "mount" of the system root to be under the CVS
>>>>repository to detect unauthorized modifications...). Unfortunately,
>>>>the system could not be backed up anymore. 1. A dump of the CVS
>>>>filesystem turned into a dump of the entire system... 2. You could not
>>>>restore the backups... The dumps failed (bru at the time) because the
>>>>pathnames got too long, the restore failed since it ran out of disk space
>>>>due to the multiple copies of the tree being created.
>>>
>>>And they never heard of "--exclude" in tar, did they?
>>
>>Doesn't work. Remember - you have to --exclude EVERY possible loop. And 
>>unless you know ahead of time, you can't exclude it. The only way we found
>>to reliably do the backup was to dismount the CVS.
> 
> 
> And if you completely run out of ideas in your wild-mounts-throughout-the-tree
> problem you should simply use "tar -l".
> 
> And in just the same way fs could provide a mode bit saying "hi, I am a
> hardlink", and tar can then easily provide option number 1345 saying "stay away
> from hardlinks".
> 
Then you stay away from each and every file on the system, because
every file is a hard link.  This is useless.

Making up a new bit in the directory saying "this directory entry
was created with 'ln' as opposed to 'open'" is indeed possible,
but wouldn't solve your problems.  Consider this:

A file is created in the normal way by a user.  (link count=1)
Someone else finds it useful creates a link to it. (link count=2)
The first user don't need the file anymore and deletes it. (link count=1)
The file still exist, because disk blocks are only released when
the link count goes to zero.
The second user can still use the file through his link, and think
it is safe.  But the file is no longer backed up because your
tar avoids the directory entry created with 'ln', and there is no
longer any directory entry created the normal way.  Similiar
problems arise for all other utilities you might want to modify
to use this sort of linking flags.

The problem don't aries with symlinks because
the file really disappear when deleted, leaving invalid
symlinks.  (Everybody knows that and don't think they
can keep a file by making a symlink, as you can with a hardlink)

The number of hard links to some inode is a reference count,
the number of symlinks is not.

Another post of yours:
 > tar --dereference loops on symlinks _today_, to name an example.
 > All you have to do is to provide a way to find out if a directory is a
 > hardlink, nothing more. And that should be easy.

There is currently no way to find out, as explained above.  And a
"flag" solution is useless, as you then will get files (and directories)
that exist only as links when the "original" link is deleted.

Another post:

 >> Things would break badly if the hierarchy became an arbitrary graph.
 > Care to name one? What exactly is the rule you see broken? Sure you 
can build
 > loops,

Loops are funny in more than one way.  Tools can be made that detect
them via inode numbers, and handle them properly. This can be costly in time
and memory, but backing up or otherwise traversing a generic graph is 
possible.

Even more fun is when you have a directory loop like this:

mkdir A
cd A
mkdir B
cd B
make hard link C back to A

cd ../..
rmdir A

You now removed A from your home directory, but the
directory itself did not disappear because it had
another hard link from C in B.

Expected behaviour, but there is no longer a path
from _anywhere_ to the B and C directories.  That
means they occupy disk space but cannot be deleted,
accessed or used in any way short of garbage collecting
the entire directory structure. That can be a big job.
The space usage can be big too, for the inaccessible B or C
directories might hold some large files.

This isn't easily avoidable by "not doing stupid things"
either, interactions between several users who don't
know what the others do can easily form loops by
linking and moving some directories around.

Helge Hafting

