Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265719AbUBPSgd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 13:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265740AbUBPSgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 13:36:33 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:1461 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S265719AbUBPSgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 13:36:24 -0500
Date: Mon, 16 Feb 2004 19:36:16 +0100
From: Marc Lehmann <pcg@schmorp.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040216183616.GA16491@schmorp.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402141827200.14025@home.osdl.org>
X-Operating-System: Linux version 2.4.24 (root@cerebro) (gcc version 2.95.4 20011002 (Debian prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I may be a bit late in response, but AFAICS these points have not yet
been mentioned]

On Sat, Feb 14, 2004 at 06:41:20PM -0800, Linus Torvalds <torvalds@osdl.org> wrote:
[discussion on why UTF-8 is the only sane encoding, which I absolutely
agree with, removed]

> In short: the kernel talks bytestreams, and that implies that if you want 
> to talk to the kernel, you HAVE TO USE UTF-8.

This is not the problem at all. It's perfectly easy to write
applications that talk UTF-8 and just UTF-8 with the kernel.

The problem is that the kernel does not use UTF-8, i.e. applications in
the current linux model have to deal with the fact that the kernel
happily breaks the assumed protocol of using UTF-8 by delivering illegal
byte sequences to applications.

There is no way for applications to handle UTF-8 and illegal-utf8 in
a sane way, so most apps will either eat the illegal bytes, skip the
filename, or crash (the latter case is clearly a bug in the app, thr
former cases aren't).

Fixing the VFS to actually enforce what linus claims (2filenames are
utf-8") is a very good idea, imho.

As I understand it, the reason linux currently doesn't, is that this utf-8
rule was obviously non-enforcable in practise in recent years, since
UTF-8 simply wasn't widespread (even today, applications such as bash or
grep are clearly not UTF-8 ready, as they start to crawl in UTF-8 locales
without special patches, and even with special patches).

So the only sane way to implement this enforcement is usign an
additional moutn-flag, e.g. "force-utf8".

An encoding=xyz mount flag OTOH would be total overkill, as the plan
must be to switch to UTF-8 in the long run, while allowing deviating
behaviour in the short run.

Conversely, filesystems such as NTFS, VFAT etc. need to convert from the
fs encoding to UTF-8 and vice versa automatically, at least when this
flag is specified.

It should become the default in some future linux version.

> People understand the problem. And UTF-8 is the solution.

The kernel needs to fully implement it. Just as a kernel accepting:

   open ("directory", O_WRONLY); write (dirfd, ...)...
   open ("/some/file", ...)
   mkdir ("../some/file", ...)

is considered rather broken behaviour from unix kernels (although these
might have been allowed in some dialects or versions of unix) today, this:

   mkdir ("</ encoded using illegal multibyte sequence>", ...)

will be considered broken behaviour in the future. The RFC defining UTF-8
clearly considers this a bug in UTF-8 implementations, the the kernel
in fact does NOT implement UTF-8 right now, although some people claim
that the kernel accepting UTF-8 (and more) is correct behaviour, it isn't
according to the RFC.

> It's getting there. I think even Microsoft has seen the light, and is
> phasing out their crapola (UCS-2LE? Whatever). 

Microsoft and Java officially use UTF-16 nowadays. The funny thing is
that "next character" iterators in both languages skip to the next word
in UCS-2, so the claim of both parties of UTF-16 support is basically a
marketing lie.

> No. Things like "iocharset" are not the solution. They are literally the
> _problem_. The solution is to use something that not only acts as ASCII,
[full agreement]

> And that one true format is UTF-8. End of story. If you try to talk to the 
> kernel in UCS-2 or anything else, you _will_ fail.

Just that the kernel does not support UTF-8. It delivers and accepts
non-UTF-8 strings such as \xc0\x80. The kernel clearly should not deliver
broken characters when the official stanza is that the linux VFS API is
UTF-8 only (see 3.2, Chapater 3, C12, conformance, ony why it currently
isn't UTF-8).

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
