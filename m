Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290241AbSAPABh>; Tue, 15 Jan 2002 19:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290268AbSAPABf>; Tue, 15 Jan 2002 19:01:35 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:23280 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S290241AbSAPABQ>;
	Tue, 15 Jan 2002 19:01:16 -0500
Date: Tue, 15 Jan 2002 16:59:51 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alexander Viro <viro@math.psu.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
Message-ID: <20020115165951.R11251@lynx.adilger.int>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@math.psu.edu>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0201131536480.27390-100000@weyl.math.psu.edu> <E16Qa0W-0001kH-00@starship.berlin> <20020115140436.L11251@lynx.adilger.int> <E16Qcha-0001lF-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16Qcha-0001lF-00@starship.berlin>; from phillips@bonn-fries.net on Wed, Jan 16, 2002 at 12:09:10AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 16, 2002  00:09 +0100, Daniel Phillips wrote:
> On January 15, 2002 10:04 pm, Andreas Dilger wrote:
> > Well, I doubt the difference will be more than a few bytes, if you compare
> > the cpio archive sizes after compression with gzip.
> 
> Side note: I have a hard time understanding the dual thinking that goes
> something like: "we have to save every nanosecond of CPU but wasting disk is
> ok because, um, disk is cheap, and everybody has more than they need anyway,
> and reading it takes zero time and oh yes, everybody has disks, don't they?"

OK, I agree somewhat that we need to save disk space, just as I agree we
should reduce CPU usage.  That said, would you want to save a few CPU
cycles if (for example) it meant we didn't use the ELF binary format,
and had to change?  Yes, we went from a.out to ELF, but it was a major
pain even when Linux was far less widely used.

> > But then every person who wants to build a kernel will have to have
> > the patched version of cpio until such a time it is part of the standard
> > cpio tool...
> 
> If we go with little-endian then only big-endian architectures will need
> the patch, and they tend to need patches for lots of things anyway.  Or
> if you like I'll write a little utility that goes through the file and
> byteswaps all the int fields.

But the proposed cpio format (AFAIK) has ASCII numbers, which is what you
were originally complaining about.  I see that cpio(1) says that "by
default, cpio creates binary format archives... and can read archives
created on machines with a different byte-order".

Excluding alignment issues (which can also be handled relatively easily),
is there a reason why we chose the ASCII format over binary, especially
since the binary format _appears_ to be portable (assuming endian
conversions at decoding time), despite warnings to the contrary?

> > (which may be "never").  I would much rather use the currently
> > available tools than save 20 bytes off a 900kB kernel image.
> 
> What if it's more than 20 bytes?

Well, anything less than half a sector (or a network packet) isn't
really measurable.

Well, a few quick tests show (GNU cpio version 2.4.2), with raw sizes
in "blocks" as output by cpio, compressed sizes in bytes:

find <dir> | cpio -o -H <format> | gzip -9 | wc -c

dir		  bin (default)		newc (proposed)
		  raw	   gzip		  raw	   gzip
/sbin		15121	3289678		12952	2769451
/etc		 8822	 689517		 8996	 693700
/usr/local/sbin	 1895	 385461		 1899	 385764

The binary format reports lots of "truncating inode number", but for
the purpose of initramfs, that is not an issue as we don't anticipate
more than 64k files.  I don't know why the /sbin test is so heavily
in favour of the newc (ASCII) format, but I repeated it to confirm
the numbers.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

