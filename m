Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269056AbUHZPss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269056AbUHZPss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 11:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269066AbUHZPss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 11:48:48 -0400
Received: from mail.shareable.org ([81.29.64.88]:22214 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269056AbUHZPsb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 11:48:31 -0400
Date: Thu, 26 Aug 2004 16:44:46 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Christophe Saout <christophe@saout.de>
Cc: Rik van Riel <riel@redhat.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826154446.GG5733@mail.shareable.org>
References: <Pine.LNX.4.44.0408261011410.27909-100000@chimarrao.boston.redhat.com> <1093530277.11694.54.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093530277.11694.54.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:
> I think Hans' idea is (I don't know if it is a good idea nor if it is
> doable, but at least it sounds interesting) to have special compound
> files where you can do something like this:
> 
> cp text.txt test.compound/test.txt
> cp image.jpg test.compound/image.jpg
> 
> And if you read test.compound (the main stream) you get a special format
> that contains all the components. You can copy that single stream of
> bytes to another (reiser4) fs and then access test.compound/test.txt
> again.

(To Rik especially), this is the design which more or less satisfies
lots of different goals at once.

I wrote:
> Properly implemented metadata can:
> 
>   (1) operate in both modes simultaneously;
>   (2) work with unaware applications;
>   (3) provide performance enhancements to aware applications;
>   (4) provide storage enhancements to both;
>   (5) provide useful features that work with standard unmodified unix tools,

(1) is by design.

You can copy these "files" safely using cp or cat or ftp.
You can email them.  They're flat files.  That's (2).

You can poke around inside them.

Applications which do poke around inside get performance gains,
because they don't have to serialise the flat format every time they
"load" or "save" a file.  For example, if you have a huge OpenOffice
document containing lots of sub-documents and pictures.  We can
imagine a version of OpenOffice which just opens the sub-documents,
and writes the ones which are changed after editing.  Also, another
program such as a viewer, post-processor or search indexing program
only needs to read the parts which have changed; it doesn't have to
decode the whole thing after a change.  That's (3).

We already know how useful this is with big mailboxes, hence people
switching to maildir.  Now imagine the attachments in each message are
also viewable, cat'able etc., and that the filesystem stores each
message compressed automatically, or in aggregate (your choice) and
that you can use both mbox and maildir tools on the same mailbox. That's (4).

You can ls, cp, grep, less, vi, gqview etc. the pieces of files, and
every supported file format needs just one tool to provide the
interface to its contents.  That's (5).

While I'm here I might as well add:

  (6) improve support for real time search indexing.

The "view coherency" mechanism which is needed for efficient
userspace VFS support has just the right properties to keep informing
an indexer of changes.  They could even enforce operation orderings if
we cared about _perfect_ real-timeness, although we probably don't.

  (7) yet another way of doing distros.

Why not just install .tgz or .zip files of entire binary packages, and
let the filesystem unpack the bits that are needed when they're
needed.  Some platforms (i.e. Java) do this already with .jar files
and it's quite popular.  This would extend it in a versatile way.

Rik, I hope I've explained how those 5 properties are satisfied by
Hans Reiser's brilliant design (ahem, great minds think alike, and
remember Linus likes files-as-directories too :).  But if I haven't
please do pick holes.

> The only thing I'm worrying about with this approach is what happens if
> someone tries to simultaneously open test.compound and
> test.compound/test.txt.

It is possible to implement it so that every change to one file
immediately affects the other in the appropriate way, _as if_ the
other file is regenerated every time before reading it.

This is what I mean by coherent views.  It can be done even when
userspace is doing the work, and the obvious mechanisms just happen to
have the property of being useful in other ways (like a better
dnotify, but I digress...).  They're just an ordinary cache coherency
protocols.

However, if you are writing a few bytes to test.compound, then the
coherent view in test.compound/test.txt is probably a corrupt or
non-existent file, because test.compound's intermediate state is a
truncated and/or corrupt archive file, until you've written some more.

That doesn't look nice, but it's exactly the same problem as you get
when you're writing to a file that another program is reading.  If you
do that on a live http server, for example editing a .html file, very
occasionally someone will see a truncated file.  Even if your editor
uses renames to update atomically, sometimes you need to update more
than one file atomically.  It can be done, but rarely is.

Is there a solution to this?  The obvious one is when you're writing
to test.compound, don't read from test.compound/test.txt.  That's _no
different_ from the advice which says when you're saving a file from
OpenOffice, don't load it into a document viewer during the time you're
writing it, and don't serve it.

The other advice is to save to a different file and call rename().
Again, you get pretty much the same results as now: it atomically
changes, and currently open references to the old contents will
continue to reference the old contents.

There's another solution: transactions.  reiser4 offers some kind of
transaction facility, doesn't it?  This is a fine example of when
might want to declare that a sequence of writes needs to be a single
transaction, visible only when the whole sequence is complete.  Perfect!

I don't know reiser4's interface to that, but it would make a lot of
sense to have a simple shell tool called "atomic", to wrap a sequence
of operations.  That would be useful for writing files _and_ useful
for those pesky "update several files on the web server at once"
moments.  (Yes I know you can build a hard link tree and rename the
root directory, although even that doesn't always work).

-- Jamie
