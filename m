Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266715AbUFYW1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266715AbUFYW1R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 18:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUFYW0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 18:26:37 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:23024 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266715AbUFYW0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 18:26:10 -0400
Message-ID: <40DCA67E.7050909@comcast.net>
Date: Fri, 25 Jun 2004 18:26:06 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Collapse ext2 and 3 please
References: <40DB605D.6000409@comcast.net> <40DBED77.6090704@hist.no>
In-Reply-To: <40DBED77.6090704@hist.no>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Helge Hafting wrote:
| John Richard Moser wrote:
|
|> -----BEGIN PGP SIGNED MESSAGE-----
|> Hash: SHA1
|>
|> I know this has been mentioned before, or at least I *hope* it has.
|>
| Take a look at history.  Linus said that creating a journalled fs was
| fine, but they had to make it a new fs so as to not make ext2 unstable
| while working on it.  Therefore - ext3.  Now ext3 was based on ext2
| so it basically started out as a copy.
|

Yep.  What's your point?  It started out that way; nobody grabbed it and
said "Let's make two copies."

|> ext2 and ext3 are essentially the same, aren't they?  I'm looking at a
|> diff, and other than ext2->ext3, I'm seeing things like:
*snip*
|
|
| No, because:
| 1. Code withg lots of #ifdefs isn't popular here.  So don't suggest it,
|    because no argument will win this one.

So don't then; maybe we should consider dropping the journal's togglability.

| 2. Did it ever occur to you that some people want to support both
|    ext2 and ext3 with the same kernel.  Impossible with your scheme,
|    and don't say "nobody needs that".

I'd thought about this.

kernel /boot/bzImage-2.6.7 root=/dev/hda5 ext3_root_journal=none

That'd be specific enough syntax to make the root mount at boot time
mount just as ext2 would, without makign all ext* partitions
nonjournaled (with appropriate code).

As for mounting, data=nojournal or data=direct or whatever flavor you
like could be used to force no journal, just like mounting an ext3 as an
ext2.

If no journal is found, it can load as nonjournaled/ext2 automatically.

| 3. ext3 may evolve differently from ext2 with time.  Common code
|    makes people do things in suboptimal ways in order to keep
|    commonality.  There is _no_ commonality pressure when the
|    sources are separate.  ext3 developers are free to change their
|    code in ways that could break operation of the non-journalling ext2.
|    And vice-versa- ext2 is free do use ordering optimizations incompatible
|    with journalling.

if (!journaled)
	extfs_do_ordering()

Some things look like hell with the diffs; there's blocks where blocks
of 3-4 lines are different, then one similar.  Either code has to be
reordered to make it cleaner; or some lines will have to be duplicated,
which I'd rather not do because it makes for maintenance nightmares.

| 4. "Appropriate" doesn't matter.  Readability and maintainability does.

I have no argument; however, the current code organization may be
altered to conform to this assertion if necessary.

| 5. Linus demanded two fs'es in this case, so there is no discussion.

You said above, "so as to not make ext2 unstable while working on it."
I do not know what Linus said exactly; but I interpret this the way you
stated as, "I don't want you hacking new sh*t into our primary
filesystem and having it blow up in our faces while you get your sketchy
design refined out to something workable."  It's already workable now,
so if I'm interpreting this right, it should be fine.

I will say this:  that is a brilliant suggestion.  Somebody should copy
fs/ext3 to fs/extfs, merge in the missing parts of ext2, make
{ext,EXT}{2,3}* {extfs,EXTFS}*, and try to stabalize it first.  This
will inflame the issue at hand first, by adding another redundant
filesystem to the tree; but if people use it over ext2+ext3, perhaps the
others will be depricated eventually, and fall off the tree.  If not,
maybe they'll junk it; that's always a risk.

|> I see entire functions that
|> are dropped and added; the dropped can stay, the added can be added,
|> they can be used conditionally.  I also see mostly code that just was
|> copied verbatim, or was s/EXT2/EXT3/ or s/ext2/ext3/ .  That's just not
|> appropriate.
|
|
| This is not much of a problem - a few kB wasted on keeping some
| identical copies of code.  You might be able to establish a
| ext23_common.c, _if_ you can prove that the stuff therein really
| won't ever be different in ext2 and ext3.
|

Don't forget that I have to compile the same shit twice; make sure the
appropriate module is in my kernel; and switch between them to use on
different filesystems.  This even leaves no room for `mount -o
remount,data=nojournal` if someone was so inclined to lock the fs, flush
the journal, switch journaling off, and unlock.

|
|>
|> The ext2 driver can even load up ext3 partitions without using the
|> journal, if it still behaves like it did in 2.4.20.  I say collapse them
|> in on eachother.
|
|
| This was very useful during initial development, when ext3 couldn't
| really be trusted.  It is still useful because it allows easy conversion
| of existing filesystems, and a single fsck. Compatibility might break
| someday though.

I see ext3 as ext2 with an added journal, and to my understanding this
is exactly what it is.  ext2 was supposed to have transparent
compression or something at some point; when (if) it gets it, it will
have to be merged into ext3 as well.

Also, from Documentation/filesystems/ext3.txt:

ext3 is ext2 filesystem enhanced with journalling capabilities.

As well as:

Specification
=============
ext3 shares all disk implementation with ext2 filesystem, and add
transactions capabilities to ext2.  Journaling is done by the
Journaling block device layer.

| The fs code may take very different approaches with time anyway,
| even if the disk layout remains compatible.

Optimization functions and such could be split out, and from what I've
seen some code will have to be reordered to be more blocky to avoid a
hell of if() blocks; but you can always conditionally call the different
functions.

| Helge Hafting


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA3KZ7hDd4aOud5P8RAonLAJ984zGlJtZ83rS5/zKPxS83UEA+qgCdEx9Q
WDnj+bFbc6hP8OHGL/1imN8=
=M3kf
-----END PGP SIGNATURE-----
