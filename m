Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269370AbUHZTN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269370AbUHZTN0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269356AbUHZTNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:13:18 -0400
Received: from mail.shareable.org ([81.29.64.88]:54982 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269417AbUHZTLh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:11:37 -0400
Date: Thu, 26 Aug 2004 20:09:42 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826190942.GV5733@mail.shareable.org>
References: <Pine.LNX.4.44.0408261315240.27909-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408261019580.2304@ppc970.osdl.org> <20040826172703.GR5733@mail.shareable.org> <Pine.LNX.4.58.0408261030350.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408261030350.2304@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Well, you _could_ make it do a "tar", but what's the point? That really 
> doesn't add any value as far as user space is concerned.
> 
> Think of it this way: if the directory and the "default stream" associated 
> with it aren't independent, then user space already has the information, 
> and the stream is pointless. In fact, the stream is _worse_ than 
> pointless, because it hides the fact that there is no independent 
> information.
> 
> See my point? 

I see your point, but I agree 50%.

(1) One of the uses of "streams" is to have extra information which
    accompanies a file, and is separate from the flat file's information.

    For example, metadata like "this C source file is in UTF-8",
    "the author is Jamie (nowhere to put it in the data file)" and
    "Jamie's signature".

(2) Filesystem settings like "compress this", and perhaps "permissions".

(3) Filesystem information like "this file has been compressed by 59%,
    uses 5 1k blocks".

(4) Another use, which is more akin to containers, is to _present_ the
    information of the flat file in a different way.

    For example, the id tags and comments of any media file, the component
    parts of any media file, license (of course :), and expanded or
    decoded views such as inside an archive file, filesystem image, or
    other structured storage file (.doc :).

    Those alternate views are useful just because they can be accessed
    using ordinary unix tools, no matter what the obscure codec format
    provided it's supported.  With a bit of effort a standard
    presentation for certain kinds of data may arise.

(5) There is also data which is _calculated_ from the flat file or its
    extra metadata, and which the kernel guarantees is either
    consistent with the file, not set at all, or at least is
    invalidated if the file is changed.  It may be calculated on demand
    through the kernel interface, or applications may simply have to
    calculate it themselves when they don't have an up to date value.

    For example MD5 or SHA1 digests of the flat file, or of its parts.
    The key thing is that these are always up to date, not dependent
    on weak tests like mtime.

    Partial checksums for speeding up rsync and other delta algorithms.
    Computed thumbnails, MP3 average power levels, character encoding
    extracted from parsing old HTML META tags.  Anything really that
    can be calculated and usefully cached.

    This is similar to (4), but I'm emphasising things that
    may take a while to compute, may be cached with the filesystem
    itself helping to decide when to evict, and writing them won't
    affect the data they're calculated from, if writing is allowed at all.

    The only really important of these are MD5 or SHA1 digests, or
    some other way of tracking modifications like a strong serial number.

    All other computed cached data can be maintained by applications
    elsewhere, if they know when the data has been modified since the
    last time.  (Though there are advantages to making the data
    disappear if the file is deleted, or move if it's renamed).


The thing with these different categories is that we want different
behaviour when serialising the data for a backup or to copy it.

We probably always (1) to be copied.

(2) is questionable: it's like unix file permissions, you might want
to copy it; you might not.

(3) Shouldn't be copied or stored except for special reasons.  It's a
bit like /proc: it's not meant to be stored on your backup CD and it's
definitely not meant to be written during a restore. :)

(4) Should never be copied if you're copying the flat file, because
it's exactly the same information, just accessed differently.  You
might want to copy it by itself for some reason though, and you
certainly would like to work with it from scripts and applications.
These streams are special in another way: they might themselves
decompose into further streams.  Just think of a AVI file containing
an OGG file containing a FLAC containing metadata and data streams, or
something like that.  They happen.

(5) shouldn't be copied if you're transmitting a file, as a matter of
data integrity among other things.  You might want it on the backup,
then again maybe only some of the values.  Probably never the crypto digests.


To summarise: most data inside a directory-as-file should _not_
usually be copied and transported.  A little of it, (1), should be
copied if the serialised form will have it, and some of the other
metadata should be copied under special circumstances.

I've suggested that we could simply not have (1), and recommend that
only reproducible, non-essential data appears inside the directory.
Everything essential would be part of the serialised, flat file.

However, you seem to like (1), metadata which should be serialised and
copied around, and which is not part of the flat file.

Note that (1) will only be copied around on systems which handle
"extra forks" anyway -- things like Samba and MacOS compatibility.
FTP and HTTP obviously won't copy the metadata of (1), although HTTP
WebDAV might allow it to be visible as properties.

All that suggests a common structure for the directory inside a
"container" -- one where the metadata to be copied by default is
clearly distinguished from the metadata which should never by copied,
or which is cached, or which is a view.  Possibly it should be
distinguished by name, although permission bits or (not sure I like
this) meta-metadata could serve the same role without being name
dependent.

-- Jamie
