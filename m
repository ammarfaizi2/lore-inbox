Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263554AbUDBJW0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 04:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbUDBJW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 04:22:26 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:57591 "EHLO kiwi.cs.ucla.edu")
	by vger.kernel.org with ESMTP id S263554AbUDBJWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 04:22:24 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       bug-coreutils@gnu.org
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de>
	<20040401220957.5f4f9ad2.ak@suse.de> <7w3c7nb4jb.fsf@sic.twinsun.com>
	<20040402011411.GE28520@mail.shareable.org>
From: Paul Eggert <eggert@CS.UCLA.EDU>
Date: Fri, 02 Apr 2004 01:22:10 -0800
In-Reply-To: <20040402011411.GE28520@mail.shareable.org> (Jamie Lokier's
 message of "Fri, 2 Apr 2004 02:14:11 +0100")
Message-ID: <87wu4yohtp.fsf@penguin.cs.ucla.edu>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> All Linux filesystems - the nanoseconds field is retained on in-memory
> inodes by the generic VFS code.

It's OK to do that, so long as 'stat' and 'fstat' truncate the
user-visible time stamps to the resolution of the filesystem.  This
shouldn't cost much.

> AFAIK there is no way to determine the stored resolution using file
> operations alone.

Would it be easy to add one?  For example, we might extend pathconf so
that pathconf(filename, _PC_MTIME_DELTA) returns the file system's
mtime stamp resolution in nanoseconds.

I write "mtime" because I understand that some Microsoft file systems
use different resolutions for mtime versus ctime versus atime, and
mtime resolution is all that I need for now.  Also, the NFSv3 protocol
supports a delta quantity that tells the NFS client the mtime
resolution on the NFS server, so if you assume NFSv3 or better the
time stamp resolution is known for remote servers too.

> This behaviour was established in 2.5.48, 18th November 2002.
> The behaviour might not be restricted to Linux, because non-Linux NFS
> clients may be connected to a Linux NFS server which has this behaviour.

Ouch.  Then it sounds like there's no easy workaround for existing
systems.  Still it'd be nice to fix the bug for future systems.
