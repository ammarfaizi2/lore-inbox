Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUBSK6o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 05:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUBSK6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 05:58:44 -0500
Received: from h24-82-88-106.vf.shawcable.net ([24.82.88.106]:40582 "HELO
	tinyvaio.nome.ca") by vger.kernel.org with SMTP id S267186AbUBSK6m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 05:58:42 -0500
Date: Thu, 19 Feb 2004 02:59:13 -0800
From: kernel@mikebell.org
To: linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior / UTF-8 filenames
Message-ID: <20040219105913.GE432@tinyvaio.nome.ca>
References: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So then, just about everyone agrees that if you've got a filename with
non-ASCII characters, you should pass it to creat() as UTF-8. You have
to pass it as something, individual encodings like BIG5 and EUC-JP
are unacceptable, and UCS-4's benefits over UTF-8 (simplicity and in
VERY rare cases storage size reductions) aren't worth the stuff it
breaks. Correct?

As I see it, there's no way for the kernel to deal with all the legacy
filenames out there. There's no way the kernel can magically fix them.

So the only thing the kernel could do for those who want to see valid
unicode is have an option to make UTF-8 only filesystems. Best would be
if it was done at mkfs time and always enforced from then on in so that
a non-UTF8 filename can never be created. Because if you want the kernel
to not pass non-UTF8 filenames back to userspace, the ONLY clean way to
do that is to make sure they're not there in the first place. You could
maybe try it with a mount=utf8only flag, but the only thing that could
do then would be to make the files with invalid filenames "disappear".

For filesystems like JFS and NTFS, I think this is the best way in the
long run, have the kernel output as UTF-8 by default, assume UTF-8
inputs, and reject non-UTF8 filenames because they can't really store
the arbitrary string of bytes model anyway.

For others which can, maybe leave it up to the filesystem creator
whether to reject non-UTF8 filenames or to accept invalid ones as well?
Either way, a well-written userspace app shouldn't barf on recieving
invalid UTF-8 from the kernel, we'll have legacy filenames around for a
good long time yet, and it's the only way to be portable to older
linuxes and other UNIXes where you definatly would not be guaranteed
valid UTF-8 no matter what new linux kernels decide.

In any case, the important part is to make sure userspace stops writing
filenames in BIG5 as soon as possible. I don't know if this can be done
nicely in libc, with libc automagically transforming the BIG5 filename
in open() to UTF-8 and the UTF-8 in readdir() to BIG5 based on the
locale, or if we have to rely on every userspace app to store filenames
in UTF-8 by themselves. But that's a decision for the glibc guys. It
doesn't affect that filenames need to start being written to the
filesystem in UTF-8 rather than other encodings, and that the only
decision the kernel has to make is whether or not to reject attempts to
create filenames which are invalid UTF-8.
