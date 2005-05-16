Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVEPMdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVEPMdS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 08:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVEPMdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 08:33:17 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:18572 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261576AbVEPMcV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 08:32:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qdpCa0NTPvtMNWv3CcyTwGx4sJ39mba3/1yrUr4/q9ieAB8G80fX/hZf8/QF/dm27ARxACDJ73UQD597CkFb1rREVG14I2ZGh5ukWj4NStmctyz3wSWpU8hcF1kWfqbITX6nnmDk09PwGAwkKG+NyZ4ZUSzLrG6licFECEXTYt8=
Message-ID: <ff80108405051605321df0d764@mail.gmail.com>
Date: Mon, 16 May 2005 13:32:19 +0100
From: Leo Comerford <leocomerford@gmail.com>
Reply-To: lrc1@st-and.ac.uk
To: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
Subject: Re: file as a directory
Cc: Hans Reiser <reiser@namesys.com>, sean.mcgrath@propylon.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <1115739129.3711.117.camel@grape.st-and.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2c59f00304112205546349e88e@mail.gmail.com>
	 <41A1FFFC.70507@hist.no> <41A21EAA.2090603@dbservice.com>
	 <41A23496.505@namesys.com>
	 <1101287762.1267.41.camel@pear.st-and.ac.uk>
	 <1115717961.3711.56.camel@grape.st-and.ac.uk>
	 <4280CAEF.5060202@namesys.com>
	 <1115739129.3711.117.camel@grape.st-and.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/05, Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk> wrote:
> On Tue, 2005-05-10 at 15:53, Hans Reiser wrote:
> > I agree with the below in that sometimes you want to see a collection of
> > stuff as one file, and sometimes you want to see it as a tree, and that
> > file format browsers can be integrated into file system browsers to look
> > seamless to users.
> >
> > A quibble: A name is just a means to select a file; he is completely
> > wrong to think that file browsers will eliminate filenames.
> 
> Yes, even if you think of the whole file system as a single "file", you
> need a way to select the bit you need, and you will use names for that
> (and whether you call that a filename, a file-part name or an object
> name doesn't really matter).
> 
> It is interesting that both he and I gave the example of a book and
> chapters, which is essentially a linear sequence, and the issue was just
> the selection of a part of that sequence. It would also be interesting
> to think about how you could map an arbitrary data structure more
> complicated than a linear sequence (an "object") to disk. This brings up
> issues of serialization and object databases....
> 
> 
Here's how you might go about it.

First, some necesary background. Some (not all) of this I've mentioned
before, mainly on reiserfs-list. I've marked the start of the
"compound object"-related material below.

The fundamental problem with reiser4-style metas is semantic. The core
Unix idiom is that pathnames assert predicates of non-directory files.
So for example "/etc/passwd" should be interpreted as "the file with
inode x is the password file", while "/bin" asserts "this is a binary
executable" of all of its non-directory descendants. In OO terms we
can see these as isAs: '/bin/touch' asserts that the file with that
name isA touch binary and, transitively, isA binary executable
('/bin'). (So pathnames from root are really better not thought of as
names at all, but never mind that now.)

Now in fact this idiom isn't as widely or consistently applied in *nix
as it could be if certain technical barriers were removed. But it's
strong enough to allow us to say that in general *nix directories
exist to provide metadata (in the form of pathnames) about their
non-directory descendants.

Under reiser4, we have two different metadata systems cohabiting in
the same namespace but remaining distinct. (If I want to say something
about a file, I might make a link to it, or I might put something in
its .... directory. Or maybe both.) One is the old Unix pathname
system, designed for finding a file given certain metadata (which is
the password file?). The other is metas, a replacement for stat() and
friends which like them is designed for finding some metadata for a
given file (who owns this file?). It uses the syntax and the API of
Unix filenames but a completely contrary semantics involving
non-directory files which exist to provide metadata about their parent
directories. Many of the difficulties of implementing metas are simply
symptoms of the underlying reality that metas are not namespace
integration but namespace duct-taping.

Now I think Hans is dead right when he says that namespace unification
is vital and that all you need are files and directories. Just
removing the problems that limit the usefulness of the "pathnames are
predicates" convention would achieve a lot. There are many pieces of
metadata that could readily be expressed as pathnames rather than
being stuffed away in stat blocks or ..metas files - ownership and
permissions data, for example.

One limitation to remove is the fact that it's impossible to (using
Sean's language) give a directory an "opaque name". An opaque
directory name would assert a predicate of the directory file itself
and not its descendants, whereas a normal directory name asserts a
predicate of the directory's non-directory descendants and not the
directory itself. So, for example, we might indicate the owner of a
directory by giving it the appropriate opaque name.

Probably the biggest barrier is the fact that it's nigh-impossible to
take a specific (non-directory) file and find its pathnames! We need
the ability to do this for any file, directory or otherwise, and for
all types of pathnames applied to the file.

But of course single-place predicates aren't enough to express all the
file metadata we might want. Sometimes we need relations too.

(**The answer begins here.** Apologies for the long set-up.)

Suppose I am using an improved *nix of the type I am proposing. There
is an image file on my computer named ~/photos/dessau-bauhaus . I have
a short description, stored in a text file, which I want to associate
with the image. I go the the directory

/(something)/description/

and create the following:

/(something)/description/aardvark:

/(something)/description/ is an ordinary directory, and
'/(something)/description' is an ordinary (non-opaque) name such as
directories have in the *nix of today. The only detail is that the
"pathnames are predicates" convention is stronger on this system than
on today's *nixes. So you can be sure that each of the (opaque)
descendants of /(something)/description/ isA
'/(something)/description' while /(something)/description/ itself is
not, unless it happens to be an opaque descendant of itself! (Again,
just as /bin/touch isA binary executable while /bin/ itself is not.)
Call /(something)/description/ a 'predicate-directory' or just a
directory.

/(something)/description/aardvark: (the colon is a delimiter) is
almost an ordinary directory. The calls for dealing with aardvark: are
probably almost exactly the same as those for handling an ordinary
directory; the internal representation of aardvark: may be identical
to that of an ordinary directory. The important difference is
semantic. aardvark: is a 'relation-directory': it expresses an
instance of a relation.

Consequently, '/(something)/description/aardvark' is not an ordinary
directory name. It's opaque: the predicate is asserted of the
directory itself and not its descendants.
/(something)/description/aardvark: isA
'/(something)/description/aardvark'. It therefore also isA
'/(something)/description', and so on transitively. By contrast, no
descendant of /something/description/aardvark: is (for example) a
'/(something)/description', except maybe through some other link. But
'/(something)/description/aardvark' is understood as asserting a file
type for aardvark, just as dessau-bauhaus might have another pathname
which would be understood as asserting that it is a jpeg.

Now I link /(whatever)/photos/dessau-bauhaus to aardvark: by the name

/(something)/description/aardvark:described

and I link the description to aardvark: by the name

/(something)/description/aardvark:description

So: aardvark: is an instance of the relation
'/(something)/description'. (Actually, it's also the only instance of
the more specialised relation '/(something)/description/aardvark', but
I haven't described the necessary tweak to get rid of that nuisance.)
In this instance of the relation, the file elsewhere named
'~/photos/dessau-bauhaus' has the role 'described', and the
description has taken the role 'description'. Now when one searches
for the pathnames of the file ~/photos/dessau-bauhaus,
'/(something)/description/aardvark:described' will be among them. A
person or program that knows the semantics of the
'/(something)/description' relation will be able to find the
description and know it as such. And if you don't know the semantics
you can still poke around inside the instance, like examining an XML
document whose schema you don't have.

So a relation-directory can express arbitrary relationships between
files. It's a bit like the relational model's weakly-typed sister,
where /(something)/description is a table, aardvark: is a row, and
~/photos/dessau-bauhaus is aardvark's entry in the column
/(something)/description/(the various relation-directories):described.
In OOese, /(something)/description is an association, aardvark: is one
of the links of that association, and (the various
relation-directories):described is a role name. (At least, that's the
Rumbaugh-Blaha-Premerlani-Eddy-and-Lorensen version; the UMLese may
vary.)

A relation-directory can have more than two children, and can have as
children predicate-directories (either opaquely or non-opaquely) or
other relation-directories.

But what about compound objects? Here's an example.

/(something)/concatenation/zebra:
/(something)/concatenation/zebra:1
/(something)/concatenation/zebra:2
/(something)/concatenation/zebra:3

This is of course the "concatenated file" example from the Reiser4
paper redone using a relation-directory. Just as with the earlier
description example, zebra is describing a relationship that exists
between its various member files. If we list the pathnames of
~/sometext, we might find that '/(something)/concatenation/zebra:2' is
one of its pathnames, which tells us that it is part 2 of some
specific concatenation. (Of course, we might also find pathnames
telling us that it is part 2 or 42 or some other concatenation, or a
description for ~/dessau-bauhaus, or very important, or whatever.) The
only difference is that in this case we find it useful to have the
relationship itself as an object in the filesystem. Easily done - just
treat the relationship's in-filesystem representation, the
relation-directory, as a file in its own right rather than just a
source of metadata about other files. In other words, just make some
links to the file otherwise known as
'/(something)/concatenation/zebra'. Call it '~/mybook', or
'/etc/passwd' if you're feeling brave. :) Now the real glory of this
system only reveals itself when you combine it with liberal use of
userspace mount() and (less importantly) file methods. That is the
synthesis of the dialectic between the Unix ideal of the file as the
atom of the filesystem and the world of compound documents, etc. - and
it's hoch-Unix. (Your slogan for the day: "bash Is My Object Browser".
Tomorrow: "mount() Is My Serialiser".) But note for now that if we
define 'atomic file' as 'just a simple sequence of bytes', we can
redefine 'file' as 'either an atomic file or a relationship between
files'.

To amplify, though, the "main", "real" purpose (so to speak) of
relation-directories is to express relationships between files. Doing
this properly just happens to give us compund objects for free. As
Rumbaugh, Blaha, Premerlani, Eddy and Lorensen say (in unison?),
"Aggregation is a special form of association, not an independent
concept." Beware the visual/spatial metaphors which subtly warp one's
understanding of the Unix file system. It's not a set of Russian dolls
or a maze of twisty little passages. In particular, files are not
physically inside directories, at any lelel of abstraction. aardvark:
just provides some metadata about ~/photos/dessau-bauhaus, and that's
all that ~/photos does too.

(Great, isn't it? The filesystem namespace: they're not names, and
it's not a space. :) )

On the other hand, garbage collection will be a significant hurdle,
for two reasons. One is cycles. The semantics of predicate-directories
mean that it's unnecessary to permit cycles containing only
predicate-directories, but if you're going to instances of, say the
singly-linked-list-node relation, then the need for cycles is
unavoidable. The other is more sophisticated needs for automatic
deletion. For example, we would probably need
/(something)/description/aardvark: to be marked for deletion as soon
as either of its children were unlinked.

Leo Comerford.
