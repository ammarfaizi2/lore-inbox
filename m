Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265631AbUBPPFQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 10:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265641AbUBPPFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 10:05:16 -0500
Received: from mail.shareable.org ([81.29.64.88]:11140 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265631AbUBPPFF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 10:05:05 -0500
Date: Mon, 16 Feb 2004 15:05:01 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: stty utf8
Message-ID: <20040216150501.GC16658@mail.shareable.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0402141827200.14025@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> People understand the problem. And UTF-8 is the solution.

Linus, I agree 100%.
My own filesystems have UTF-8 file names, of course.

There are still practical problems, two of which stand out:

1. Just because you hope a filesystem is UTF-8, does not preclude
   readdir() from returning non-UTF-8 names.  (These are far too
   easy to create by accident).

   Because of that, programs which interpret the result of
   readdir() as text, yet are expected to handle any name without
   silently rejecting them or aborting, are forced into strange
   compromises which break basic expectations.

   Spot the bug in this perl script:

     perl -e 'for (glob "*") { rename $_, "ņi-".$_ or die "rename: $!\n"; }'

   (NB: The prefix string is N WITH CEDILLA followed by "i-").

   (Hint: it mangles perfectly fine non-ASCII file names).

   Perl has no perfect behaviour to offer, because what should that
   behaviour be if readdir() might return a non-UTF-8 byte sequence
   as a name?


2. Terminals are not all UTF-8, and some never will be.

   So when someone types something like this on a non-UTF-8
   terminal, they get non-UTF-8 filename:

       vi el-niño.txt

   It isn't just a problem of display.  Now you have created a
   filename which isn't valid UTF-8, and GUI programs may complain,
   perhaps refusing to let you select the file.

   Furthermore, how exactly do you expect a user to use UTF-8 on
   the filesystem when their terminal is not (or sometimes is not)
   using UTF-8?


==> This problem would be very nicely solved with an additional
    terminal flag.  We have "stty ocrnl", "onlcr", "igncr" etc. to
    translate between terminal line endings and the unix convention of
    LF at the end of each line.  Why not create "stty utf8" so that
    non-UTF-8 terminals and UTF-8 terminals alike can work with a
    Linux convention that all programs enter and display UTF-8?  It
    would simplify a lot of things.


-- Jamie

