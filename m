Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268727AbUHZL5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268727AbUHZL5R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268751AbUHZLyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:54:05 -0400
Received: from mail.shareable.org ([81.29.64.88]:198 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S268820AbUHZLtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:49:49 -0400
Date: Thu, 26 Aug 2004 12:48:43 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Spam <spam@tnonline.net>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826114843.GE30449@mail.shareable.org>
References: <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1939276887.20040826114028@tnonline.net> <20040826024956.08b66b46.akpm@osdl.org> <839984491.20040826122025@tnonline.net> <20040826032457.21377e94.akpm@osdl.org> <742303812.20040826125114@tnonline.net> <20040826035500.00b5df56.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826035500.00b5df56.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> No.  All of the applications which you initially identified can be
> implemented by putting the various bits of data into a single file and
> getting applications to agree on the format of that file.
> 
> For example, some image file formats already support embedded metadata, do
> they not?

Same for MP3s and their metadata tags.  _That_ kind of data should be
part of the contents of the file: it is intended to be transported.

It is useful to auto-extract it from the file's data stream, using
format-specific programs, and offer that metadata in separate files
where it is easy to use e.g. by shell scripts and indexing programs,
which can then work independently of file formats.

That kind of metadata should be _derived_ from the file's data stream,
and ideally the extraction should be automatic, with userspace
assistance.  It may be useful for the filesystem to record what's
extracted, for fast access and indexing.

The same applies to thumbnails.  The only difference is that these may
take longer to compute.  But they're the same thing: something
calculated from the file's data stream, which may (or may not) be
stored in the filesystem so it doesn't have to be recomputed each
time.  It might even be worth expiring the metadata from disk if it
hasn't been used for a while and can be recomputed.

These are the same as looking into archives or structured files.  The
only difference is that the unpacked views might not be stored on the
filesystem (but they might be, if the filesystem knows how to cache
views for faster future access).[*]

Those are all examples of data derived from the data stream of a flat
file.  They are useful applications, and all work fine with FTP, cp,
cat <a >b, and email attachments, _no application changes required_.

There's another kind of metadata which isn't intended for transport.
That would be things like the classic attributes: permissions,
timestamps.  It would also include things like author information when
the file format cannot carry it.

-- Jamie


[*] - A fancier variant, which is hard without good fs support, it
writing to structured files through a view.  I.e. modifying files
inside a .tar.gz, or (this is useful) inside an
{MS,Open,Gnome,K}Office container file or *SQL database table.  To do
this efficiently, the file's main data stream is regenerated on demand
from the view's data.  As I said, it requires good, special fs support
to do it efficiently (fancy caching).  With appropriate userspace
libraries you can make apps work with container files on all other
OSes (just like .tar.gz and *Office containers at the moment) but are
significantly faster to work with on Linux (no need to serialise and
(de-)compress except on demand) and more visible to the standard unix
scripting tools.
