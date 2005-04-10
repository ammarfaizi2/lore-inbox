Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVDJLVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVDJLVz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 07:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVDJLVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 07:21:55 -0400
Received: from wingding.demon.nl ([82.161.27.36]:22164 "EHLO wingding.demon.nl")
	by vger.kernel.org with ESMTP id S261460AbVDJLVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 07:21:47 -0400
Date: Sun, 10 Apr 2005 13:21:39 +0200
From: Rutger Nijlunsing <rutger@nospam.com>
To: Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Proposal for shell-patch-format [was: Re: more git updates..]
Message-ID: <20050410112139.GA21496@nospam.com>
Reply-To: linux-kernel@tux.tmfweb.nl
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net>
Organization: M38c
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2005 at 12:51:59AM -0700, Junio C Hamano wrote:
> Listing the file paths and their sigs included in a tree to make
> a snapshot of a tree state sounds fine, and diffing two trees by
> looking at the sigs between two such files sounds fine as well.
> 
> But I am wondering what your plans are to handle renames---or
> does git already represent them?

git doesn't represent transitions (or deltas), but only state. So it's
not (much) more then a .tar file from version-management perspective;
the only difference being that a git-tree has a comment field and a
predecessor-reference, which are currently not used in determining the
'patch' between two trees.

Deltas are derived by comparing different versions and determining
the difference by reverse-engineering the differences which got us
from version A to version B.

Deltas are currently described as patch(1)es. Patches don't have the
concept of 'renaming', so even after determining that file X has been
renamed to Y, we have no container for this fact. A patch(1) only
contains local-file-edits: substitute lines by other lines.

Deltas are not needed to follow a tree; deltas are useful for merging
branches of versions, and for reviewing purposes. This is comparable
to using tar for version-management: it is very common to weekly tar
your current version of your project as a poor-mans-version management
for one-person one-project.

So what is needed is a way to represent deltas which can contain more
than only traditional patches. I would propose a simple format: 
the shell-script in a fixed-format.

Shell-patch format in EBNF:
  <shellpatch> ::= ( <comment>? <command>* )*
  <comment> ::= <commentline>+
    The comments contains the text describing the function of the
    patch following it.
  <commentline> ::= "# " <text>
  <command> ::=
    "mv " <pathname> " " <pathname> "\n" |
    "cp " <filename> " " <filename> "\n" |
    "chmod " <mode> <pathname> "\n" |
    "patch <<__UNIQUE_STRING__\n" <patch> "__UNIQUE_STRING__\n"
      (where UNIQUE_STRING must not be contained in patch)
  <filename> ::= <pathname>
    (but pointing to a file)
  <pathname> ::= a pathname relative to '.';
    escaping special characters the shell-way;
    may not contain '..'.

Example:
  # Rename file b to a1, and change a line.
  mv b a1
  patch <<__END__
  *** a1  Sun Apr 10 11:43:37 2005
  --- a2  Sun Apr 10 11:43:41 2005
  ***************
  *** 1,4 ****
    1
    2
  ! from
    3
  --- 1,4 ----
    1
    2
  ! to
    3
  __END__

Advantages:
  - ASCII!
  - a shell-patch is executable without extra tooling
  - a shell-patch is readable and therefore reviewable
  - a shell-patch is forward-compatible: a shell-patch acts
    like a patch (since patch(1) ignores garbage around patch :),
    but not backwards-compatible.
  - extensible
  - the heavy-lifting is done by 'patch'
Disadvantages:
  - no deltas for binary files

Open issues:
  - <comment> could be made more structured; maybe containing fields
    like Sujbect:, Author:, Signed-By:, certificates, ...
    (BitKeeper seems to be using "# " <field> ":" <value> "\n" lines)
  - patch(1) doesn't know any directories. Should shell-patch
    know directories? This implies commands working on directories to
    (like directory renaming, mode changing, ...). Otherwise directories
    are implicit (a file in a directories implies the existance of that
    directory). Also implies mkdir and rmdir as shell-patch commands.
  - extra commands might be useful to conserve more state(changes):
    ln -s  -- for symbolic links;
    ln     -- for hard links;
    chown  -- for permissions;
    chattr -- for storing extended attributes
    touch  -- for setting timestamps (probably creation time only,
              since mtime is something git relies on)
    ...and for the really adventurous:
    sed 's,<fromstring>,<tostring>,' -- for substitutions
      (this is something darcs supports, but which I think is too
       bothersome to use since it is difficult to reverse engineere
       from two random trees)
Why a fixed format at all?
  - This way, the executable shell-patch can be proven to be
    harmless to the machine: 'rm -rf /' is a valid shell-script,
    but not a valid shell-patch (since 'rm' is not valid command,
    random flags like '-rf' are not supported, and '/' is an absolute
    pathname.
  - A fixed format enables tooling to support such a patch format;
    for example creating the reverse-patch, merging patches (yeah,
    'cat' also merges patches...).

...what has this to do with git?  Not much and everything, depending
on how you look onto it. 'git' is 'tar', and 'shell-patch' is 'patch';
both orthogonal concepts but very usable in combination. We'll look at
getting from two git trees to a shell-patch.

Diffing the trees would not only look at the file and per file at the
hashes, but also the other way around: which hash values are used more
than once. For files with the same hash value, compare the contents
(and rest of attributes); this is needed since the mapping from file
contents to sha1 is one-way. When the contents is the same, the
shell-patch-command to generate is obviously a 'cp'.

For example, we have got two trees in git (pathname -> hash value):
  tree1/file1 -> 1234
  tree1/file2 -> 4567
and
  tree2/file1 -> 3456
  tree2/file3 -> 4567
  tree2/file4 -> 4567

..this could generate shell-patch:

  # Comments-go-here
  mv tree2/file2 tree2/file3
  cp tree2/file3 tree2/file4
  patch tree1/file1 <<__FILE_PATCH__
  (patch-goes-here)
  __FILE_PATCH__

...by an algorithm which starts by determining all renames, then all
copies, and finally all patches.

Comments?


-- 
Rutger Nijlunsing ---------------------- linux-kernel at tux.tmfweb.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
