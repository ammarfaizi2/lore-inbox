Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbUDBAfm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 19:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263385AbUDBAfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 19:35:42 -0500
Received: from alcor.twinsun.com ([198.147.65.9]:47006 "EHLO alcor.twinsun.com")
	by vger.kernel.org with ESMTP id S263376AbUDBAfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 19:35:38 -0500
From: Paul Eggert <eggert@gnu.org>
To: Andi Kleen <ak@suse.de>
CC: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, bug-coreutils@gnu.org
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de>
	<20040401220957.5f4f9ad2.ak@suse.de>
Date: Thu, 01 Apr 2004 16:35:20 -0800
Message-ID: <7w3c7nb4jb.fsf@sic.twinsun.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (usg-unix-v)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 10:09:57PM +0200, Andi Kleen wrote:

> just round up to the next second instead of rounding down when going
> from 1s resolution to ns.

Please don't do that.  Longstanding tradition in timestamp code is to
truncate toward minus infinity when converting from a
higher-resolution timestamp to a lower-resolution timestamp.  This
is consistent behavior, and is easy to explain: let's stick to it as a
uniform practice.

There are two basic principles here.  First, ordinary files should not
change spontaneously: hence a file's timestamp should not change
merely because its inode is no longer cached.  Second, a file's
timestamp should never be "in the future": hence one should never
round such timestamps up.

The only way I can see to satisfy these two principles is to truncate
the timestamp right away, when it is first put into the inode cache.
That way, the copy in main memory equals what will be put onto disk.
This is the approach taken by other operating systems like Solaris,
and it explains why parallel GCC builds won't have this problem on
these other systems.

Switching subjects slightly, in
<http://mail.gnu.org/archive/html/bug-coreutils/2004-03/msg00095.html>
I recently contributed code to coreutils that fixes some bugs with "cp
--update" and "mv --update" when files are copied from
high-resolution-timestamp file systems to low-resolution-timestamp
file systems.  This code dynamically determines the timestamp
resolution of a file system by examining (and possibly mutating) its
timestamps.  The current Linux+ext3 behavior (which I did not know
about) breaks this code, because it can cause "cp" to falsely think
that ext3 has nanosecond-resolution timestamps.

How long has the current Linux+ext3 behavior been in place?  If it's
widespread, I'll probably have to think about adding a workaround to
coreutils.  Does the behavior affect all Linux filesystems, or just
ext3?

I'll CC: this message to bug-coreutils to give them a heads-up.
