Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268406AbUH3UVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268406AbUH3UVs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 16:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268465AbUH3UVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 16:21:48 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:65441 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268448AbUH3UVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 16:21:39 -0400
Message-ID: <41323AD8.7040103@namesys.com>
Date: Sun, 29 Aug 2004 13:21:44 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040514
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: reiser@namesys.com, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, reiserfs-list@namesys.com
Subject: Re: silent semantic changes in reiser4 (brief attempt to document
 the idea of what reiser4 wants to do with metafiles and why
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Idea

You should be able to access metadata about a file the same way you
access the file's data, but with a name based on the filename followed
by a name to select the metadata of interest.

Examples:

cat song_of_silence/metas/owner
cat song_of_silence/metas/permissions
cat 10 > song_of_silence/metas/mixer_defaults/volume
cat song_of_silence/metas/license


But wait!  This idea has flaws.  Let us list them and address them:

Problem: Often we want to access more than one metafile at a time, and
a separate system call for each of them is less efficient than stat or
xattrs.

Solution: Create a system call that can access more than one file at a
time, whether it is a metafile or a data file should be irrelevant.

Problem: Many kinds of metadata need to be updated atomically.

Solution: Atomic filesystem, which allows all files, including data
files, to be updated atomically.

Problem: Many kinds of metadata need to be constrained in their
allowed values.

Solution: Allow general purpose constraints to constrain all files,
including data files also.

Problem: Many kinds of metadata should not be visible to the user
unless he wants to see them.

Solution: Allow all files to be hidden from the user unless he wants
to see them.

Example: metas subdirectory is invisible to readdir

Problem: this approach can pollute the namespace

Answer: choose obscure names

Problem (all credit to Mr. Demidov for identifying this problem, I
argued the other viewpoint, and I can only claim the wisdom to know
that I lost the argument): names like "..metas" are ugly to new users,
who don't really care for languages that use punctuation in their
keywords.

Answer

don't make them too obscure, experienced namespace developers know
that the problem of polluting the namespace is not really as big a
deal as beginners think it is, and Clearcase and the WAFL filesystem
manage to get by just fine, whereas the problem of putting punctuation
marks into names and syntax is a big deal for newbies to the system.
Name it "metas" not "..metas", and users will never experience it as a
real problem, and newbies will never be annoyed by a-rhythmic
punctuation.  Note: if Linus disagrees, it is not the most important
thing in this design, "..metas" isn't the end of the world.

Problem: Many kinds of metadata, such as acls, need to be inherited.
Solution: Allow all files, metafiles and data files both, to be
inherited from other files.

The Idea 2:

When implementing a file plugin, very often there are methods supplied
by that plugin that are unique to that plugin.  These methods are
often well interfaced with as files that can be written to or read
from.  Allow file plugins to define pseudo files that perform these
methods.

Examples:

cat complex_document/pseudos/glued gives an archive of the directory
"complex_document" and everything below it, suitable for emailing.

cat filename/pseudos/backup gives a set of commands that a backup
command can use to create the file "filename" with all of its state
preserved, without the backup program having to understand the
plugin's internals.  (If there is going to be a proliferation of file
plugins, then backup plugin methods are a necessity.

cat password_directory/pseudos/cat gives a concatenation of all the
files in the directory "password_directory".


Why Is This Design Important?

It is all about namespace fragmentation.  If you can access everything
in the OS from the same namespace, the OS is much more powerful.

The expressive power of an OS is not proportional to how many objects
are in the OS, but rather to how many different ways you can combine
them.  Separate namespaces for different types of objects is like
having different railroad track gauges for the different peoples of the
world.

If there are different namespaces for 2 sets of objects, then the
number of possible combinations of the objects is (N/2)^2, which is
less than the number of combinations of the objects if they are in one
namespace, which is N^2.


Why Openat Sucks:

because you can't go cat filenameA/metas/permissions > filenameB/permissions

If cat doesn't work, then we are suffering exactly the problem with
namespace fragmentation that this whole scheme was invented to avoid.

The Origins Of This Idea

I disliked stat() way back in 1984.  This is just one small piece of
my efforts to build tools to allow OS architects to unify namespaces
throughout the OS.  DARPA funded this under the CHATS program, and it
was one of the main components of my proposal.

Schedule:

One piece at a time, I would like to let this mature as a reiser4 only
prototype throughout the 2.7 kernel series, and then have it reviewed
for use by other filesystems after that.  Let us not rush it, please.
I have been studying namespace design since 1984, let someone who is
deeply familiar with namespace design principles have a try at a
coherent design with all the pieces in place first before committee
redesign is attempted.  Please consider that there are advantages to
letting the guy who had the idea and did the work to make it happen be
the maintainer.

My approach is to first produce a working prototype, and only then to
try to make a standard.  It is not an unusual approach in our
community.  Let me take that path, it works better for persons like
me.  I have a half working prototype.  A little more time please.
After 30 years of Unix file system semantics stagnation, there is not
a great rush for this little piece of mild innovation I think.

Conclusion:

Namespace fragmentation is the most important single determinant of OS
expressive power, just as trade fragmentation is the most important
single determinant of national wealth (see Adam Smith's The Wealth of
Nations).  Making objects combine easily is what it is all about.


