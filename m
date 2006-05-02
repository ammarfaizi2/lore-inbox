Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbWEBVxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWEBVxJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 17:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbWEBVxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 17:53:08 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:42027 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965007AbWEBVxH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 17:53:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=elAOKlhFrH3FkXZIH1Gf94vkFfvdtpltg4P78/XV75Z6Xuvesqul99UQvtc6v6Yw5JzXrxClMgVz7ko1ieXHOOC5m+hTwXoUjOxWxsPG32ozPqzEyTSabasgz9L0Xv0tVdjQb8XeCxnjRem7h12mKM+IYAhBXvHJOw//E5pvZjE=
Message-ID: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
Date: Tue, 2 May 2006 14:53:06 -0700
From: "Jared Hulbert" <jaredeh@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Advanced XIP File System
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will be submitting a new filesystem for inclusion into the kernel as
soon as it is ready.  (It mounts but doesn't like doing much else
right now.)  I would like to get feedback now to mold the development
as we go along.  Please comment on the technical approaches and other
inherent qualities or lack thereof.  Let me know of any serious
obstacles to inclusion in the mainline.  We will Lindent it and clean
it up quite a bit before really submitting.

You may find it at its very boring sourceforge site
https://sourceforge.net/projects/axfs/.  Browse the source at 
http://svn.sourceforge.net/axfs
Or get the tarball at 
http://prdownloads.sourceforge.net/axfs/axfs-0.1.tar.gz?download


What is it?:
- AXFS for Advanced XIP File System.
- Intended to be a root filesystem for embedded systems
- Readonly
- Uses addressable memory such as NOR flash instead of a block device
- Borrows much from CRAMFS with Linear XIP patches
- Allows XIP* of individual pages instead of just individual files
- Uses filemap_xip.c where possible

* By XIP, eXecute In Place, we mean that when a file is mmap'd() the
pages are mapped directly to where they are stored in non volatile
storage, rather than copied to RAM in the page cache and mapped from
there


Why a new filesystem?
- XIP of kernel is mainline, but not XIP of applications.  This
enables application XIP
- Cramfs linear XIP patches not suitable for submission and lack some
features of AXFS
- Design allows for tighter packing of data and higher performance
than XIP cramfs


(Warning - Long explaination of why XIP support is important follows. 
Please read before flaming XIP.)

I've heard people say, "XIP is stupid.  Why on earth would I use
expensive slow flash instead of cheap fast RAM?"  Let me try explain
why it can be smart and why it is actually done in practice.  In fact
many of the mobile handsets that run Linux use XIP CRAMFS today.  If I
take libfoo.so which is about 2MiB and throw it in JFFS2, it
compresses to about 1MiB in flash.  If I store libfoo.so as an XIP
file (uncompressed) in XIP CRAMFS or AXFS it takes up 2MiB of flash. 
That is 1MiB extra flash for XIP.  But the JFFS2 version would need
2MiB of RAM to store that library when used while the XIP system uses
0MiB.  That means XIP uses +1MiB of flash and -2MiB of RAM for
libfoo.so.  So for any extra flash used for XIP, it can save twice
that amount of RAM.  The end result can be lower cost systems on the
small end.  The secret is to choose what to make XIP and what to
compress on flash.

XIP can also increase performance.  Processor caches make the slower
read speed, compared to RAM, of a NOR type flash often used for XIP
not important.  However when an application 'bar' gets started and the
code is mmap()'ed into the process the XIP system creates page table
entries pointing to a physical address for all the code the process
needs.  Without XIP, as I understand it, basically empty page tables
are created.  As code is executed the system page faults and code is
fetched from the filesystem, for example JFFS2, in a rather long
process of copying to RAM, decompressing, and transfering to
userspace.  And of course this happens, interrupting execution of
'bar', every time you access a new page of code.  To misquote Linus
"bow down before me, you scum" Torvalds, "That cost is _bigger_ than
the cost of just copying the page in the first place."  Code that is
XIP takes that a step farther, it _never_  faults and _never_ gets
copied.

To revisit the libfoo.so story lets say that the often used
application 'bar' only calls one function in libfoo and therefore only
pages in 1MiB of libfoo into RAM.  Does this break the XIP argument?
(+1MB Flash for -1MB RAM)  Not with AXFS!  A system designer could
then choose to only XIP the specific pages within libfoo.so that are
actually accessed.  In that way the 2:1 ratio is retained.  The AXFS
effort will include some tools to help identify which pages do what,
to help system designers optimize thier systems for memory usage.
