Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVADKJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVADKJm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 05:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVADKJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 05:09:41 -0500
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:64655 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261600AbVADKJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 05:09:27 -0500
Subject: Re: [PATCH] get/set FAT filesystem attribute bits
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nicholas Miell <nmiell@comcast.net>, hirofumi@mail.parknet.co.jp,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <41D9C111.2090504@zytor.com>
References: <41D9B1C4.5050507@zytor.com>
	 <1104787447.3604.9.camel@localhost.localdomain>
	 <41D9BA8B.2000108@zytor.com>
	 <1104788816.3604.17.camel@localhost.localdomain>
	 <41D9C111.2090504@zytor.com>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Tue, 04 Jan 2005 10:09:17 +0000
Message-Id: <1104833357.26349.21.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nicholas Miell wrote:
> > On another note, NTFS-style xattrs (aka named streams) are unrelated to
> > Linux xattrs. A named stream is a separate file with a funny name, while
> > a Linux xattr is a named extension to struct stat.

This is incorrect.  NTFS has two different beasts:

- Extended Attributes (EAs) which are just like Linux xattrs and in
Windows a very similar API exists as in Linux for accessing them (on
NTFS volumes only - VFAT does not support EAs in Windows).

- Named streams for which you are pretty much correct that they are like
a file with a funny name but note that named streams share the same
inode as their parent (unnamed) stream.  And this is not just the inode
number, it is the same on-disk inode.  This means that the ACLs, dos
attributes, etc, are all valid for both the unnamed and all named
streams.  So you cannot for example allow user A to access the unnamed
stream but not some named stream and vice versa you cannot allow user B
to access some named stream but not the unnamed stream.  In Windows
these beasts are accessed as filename::namedstreamname and in Linux
there is no existing API to access named streams at all that I am aware
off.  Again, as EAs, in Windows named streams only are supported on NTFS
volumes - VFAT does not support them.

The major difference is that access to named streams is much faster on a
per-stream basis as they are separate entities, i.e. stream A and stream
B share the same inode but are otherwise accessed independently and are
stored independently on disk (and as such can be read/written
simultaneously).  EAs on the other hand are all linked together and are
in fact just one large blob of data.  Resizing one EA modifies
potentially all of them since all EAs are stored in a single byte
stream, not very dissimilar to a named stream in fact.  So EAs are more
suited for storage of constant length structures while named streams are
better suited for variable length data (e.g. icons for executables, name
of document author, etc).

One interesting bit of trivia is that Windows uses named streams very
extensively while it _never_ uses EAs.  In fact I have never seen a
Windows OS or application that uses EAs.  They were added to be
compatible with OS/2 EAs when it came out but since OS/2 died they now
just seem like old baggage/backwards compatibility in Windows that is no
longer used.  (If anyone knows of a Windows application that uses EAs
please let me know.  I would be most interested in knowing about it!)

Hope this clears things up a bit as far as NTFS is concerned...

I don't know what API would be best for accessing named streams on NTFS
but an xattrs like interface is not suitable IMO.  You really want to be
able to open them and access them like normal files.  An interface
similar to the Solaris openat() system call (see
http://docs.sun.com/app/docs/doc/816-0212/6m6nd4nc7?a=view) that has
been discussed on LKML before seems like a good way to deal with this
but I am more interested in getting normal write support into NTFS at
present than I am in fancy features like EAs and named streams...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

