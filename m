Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUDBV5e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 16:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUDBV5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 16:57:34 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:47028 "EHLO kiwi.cs.ucla.edu")
	by vger.kernel.org with ESMTP id S261184AbUDBV5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 16:57:32 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       bug-coreutils@gnu.org
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de>
	<20040401220957.5f4f9ad2.ak@suse.de> <7w3c7nb4jb.fsf@sic.twinsun.com>
	<20040402011411.GE28520@mail.shareable.org>
	<87wu4yohtp.fsf@penguin.cs.ucla.edu>
	<20040402162338.GB32483@mail.shareable.org>
	<87ad1uw1m2.fsf@penguin.cs.ucla.edu>
	<20040402210722.GE653@mail.shareable.org>
From: Paul Eggert <eggert@CS.UCLA.EDU>
Date: Fri, 02 Apr 2004 13:56:54 -0800
In-Reply-To: <20040402210722.GE653@mail.shareable.org> (Jamie Lokier's
 message of "Fri, 2 Apr 2004 22:07:22 +0100")
Message-ID: <87u102ujq1.fsf@penguin.cs.ucla.edu>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

>> Do you mean for mtime versus atime (versus ctime)?  Yes, in that case
>> getxattr etc. would be a better choice.
>
> No, I mean that they currently call fstat().  In future they'd need to
> call fstat()+getxattr().

Coreutils currently assumes that the time stamp resolution is a
per-filesystem quantity, and it keeps track of all the filesystems
that it's seen, so the number of extra calls to getxattr for this
purpose would be quite small.  This is all assuming that other
programs aren't mutating the file system mounts while 'cp' is running,
but that assumption is already hardwired in several other places.

> With that in mind, we'd need to be clear that the resolution actually
> stored may exceed the resolution advertised.  I don't know whether
> that breaks coreutils' assumption.

I think it'd be good enough for coreutils.

What's the next step to get this sort of thing running?  (I haven't
had much luck getting my (rare) Linux patches accepted....)

PS.  While we're on the subject, I'd like to add a utimens system
call, which behaves like utime/utimes except that it specifies a
nanosecond-resolution time stamp.  This will allow programs like 'cp
-p', 'mv', and 'tar' to copy timestamps correctly; currently they lose
the low order part of the time stamps when copying.
