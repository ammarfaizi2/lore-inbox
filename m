Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268800AbUIHA2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268800AbUIHA2S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 20:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268802AbUIHA2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 20:28:17 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:5281 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S268800AbUIHA2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 20:28:06 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Hans Reiser <reiser@namesys.com>
Date: Wed, 8 Sep 2004 10:27:51 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16702.20999.806070.540145@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Alexander Zarochentcev <zam@namesys.com>,
       vs <vs@thebsh.namesys.com>, Edward Shishkin <edward@namesys.com>
Subject: Re: [PATCH - EXPERIMENTAL] files with forks in the VFS
In-Reply-To: message from Hans Reiser on Tuesday September 7
References: <16699.44411.361938.856856@cse.unsw.edu.au>
	<413BFCB5.4010608@namesys.com>
	<16700.60673.453455.255327@cse.unsw.edu.au>
	<413E0C88.6020402@namesys.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday September 7, reiser@namesys.com wrote:
> Neil Brown wrote:
> >In the first case, the extra semantic only applies to files, not
> >directories (allowing a directory to have extra streams is nothing
> >new).
> >In the second case, the extra semantic should apply to directories as
> >well (as there may we be different views you might want on a
> >directory). 
> >  
> >
> I don't understand the paragraph above.  Can you say with fewer 
> indirections (e.g. define extra semantic)?

Sorry.  I'll be more verbose (probably too verbose.  Stop reading when
you've had enough:-)

The topic of discussion is "adding namespace below files", and I want
to be sure I know *why* we are doing that - what the purpose is.
Knowing the purpose helps a lot with reasoning.

I claim there are two distinct purposes that have been discussed.
There may be more, but there seem to be two main ones.

The first purpose can be called "attributes" or "forks".  This allows
arbitrary pieces of data to be associated with a pre-existing
filesystem object.  Here the "extra semantic" is "extra information
can be stored as name-value pairs".  This is already the case for
directories.  Directories have files with names.  Adding some other
sorts of name-value pairs is nothing more or less than adding  a wart
to the name space.
Other filesystem objects (files, device-special-files, pipes ...) do
not currently have a way to store extra name-value pairs, so they
could conceivably benefit from the "extra semantic".

My patch showed an example of how to provide this extra semantic, so
that it could be explored in a concrete way.

The second purpose can be called "views".  It allows a pre-existing
filesystem object to be seen in a different way than normal.  Here the
"extra semantic" is "alternate ways to look at what you already have".
Some examples are "untar" and "uncompress".
You wouldn't normally expect a "view" to show information that is not
already in the object, but only to show already-existing information
in a different way. (Note that this isn't an absolute rule. e.g. a
file is a container as well as a content. Some information about the
container is visible in stat(2) [such as st_blocks], but not all
[e.g. depth of btree] so a view could reasonably show other
information).

Views could reasonably apply to directories just as much as to files
or other filesystem objects.

So this is one element of the difference between "attributes" and
"views".  There is no point in giving directories "attributes" because
they already have them.  They are called "files".
There is point in giving directories "views" - just as much as for
files.

One example of a need for views on directories that came up a while
ago, but was not (I think) resolved, was the NFS client (nfsv4
particularly) wanted to present statistics information for each
mountpoint (request counts, errors, retries etc).  This is most
naturally done as a view on the root directory, but Unix has no way
to easily present views.  xattrs were suggested as were magic names in
the directory.  None were universally accepted.

Implementing "attributes" is very like implementing a directory.  I
believe that the one should be leveraged to support the other (if the
support is actually needed/wanted).

Implementing "views" is much more like implementing filesystems.  A
filesystem is in some sense a filter that maps some underlying object
(typically a block device, but sometimes a network connection or even
a file) into some other filesystem object (typically a directory
tree).
I think if views are wanted, they should, as much as possible,
leverage mounts and filesystems.

One could imagine using filenames like:
   /dev/sda1/ext3,rw,data=journal,nodev/some/path

to transparently mount a block device with appropriate options and
provide access to it.  Among the several problems with this (many of
which could be resolved) is the fact that you cannot use it to mount a
directory or a file-with-attributes as accessing names within those
objects already has another meaning.

So here is the problem.  We seem to want name1/name2 to mean two
different things
  1/ an attribute/fork/file named "name2" with the object named "name1"
  2/ a view called "name2" on the object called "name1"
and that just doesn't work in the kernel.

Now it is worth noting that in user-space, we cope quite well with
filenames meaning different things in different contexts.
 '~' at the start of a filename often indicates a user's home
     directory.
  *  is often a wildcard
  {,} allows one filename to become several

These are all dealt with quite effectively in user-space using
convention and quotes.
Maybe the right answer to the current problem is to leave it to
user-space.
e.g  x/y always means to the kernel "the attribute/fork/file in 'x' that is called
     'y'"
    but allow userspace  to treat (say) a '~' at the start of a
    non-initial component to mean "mount the view".  So the above
    example simply becomes 
       /dev/sda1/~ext3,rw,data=journal,nodev/some/path

    [As there are already problem with filenames beginning with ~, this
    might not be too much of a further problem]
    Then the shell, or any other program that current handles
    wildcards, can perform the implied mount, and substitute the
    chosen mountpoint ($HOME/.mounts/xxxx) for the initial part of the
    path.

This would provide most of what you want with relatively little
ugliness in the kernel.

Some simple cases of this could be done today:
    cat ~mirror/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2/~unarch/linux-2.6.8/Makefile

could be interpreted by your shell to run some "unarch" program on the
kernel archive, asking for "linux-2.6.8/Makefile".  "unarch" would
notice that it is a tar.bz2, would unbzip and extract just the
Makefile and store it in some temp directory.  It would then run
   cat $TEMPDIR/Makefile

all transparently.

Ok, I'll stop rambling now.

NeilBrown

