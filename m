Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275079AbTHGFjD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 01:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275080AbTHGFjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 01:39:03 -0400
Received: from angband.namesys.com ([212.16.7.85]:60081 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S275079AbTHGFir
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 01:38:47 -0400
Date: Thu, 7 Aug 2003 09:38:46 +0400
From: Oleg Drokin <green@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Spurious -EIO when reading a file being written with O_DIRECT?
Message-ID: <20030807053846.GC19048@namesys.com>
References: <20030806110805.GG14457@namesys.com> <20030806144206.12a18557.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806144206.12a18557.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Aug 06, 2003 at 02:42:06PM -0700, Andrew Morton wrote:
> >    We were reported a problem where if a file being written in directio mode
> >     and being read at the same time (in "normal/buffered" mode), then reading
> >     process gets -EIO when near the end of file.
> > 
> >     Initially I thought this is reiserfs-only problemm and digged in that
> >     direction, but then it turned out reiserfs does everything correctly
> >     and the VFS itself seems to be racey (my current suspiction is directio
> >     process uses get_block() that extends the file <schedule> reading process
> >     gets the buffer and submits io, then waits for page to become uptodate
> >     <schedule> direct io process unmaps buffer's metadata
> >     As a result - that page never becomes uptodate and we get -EIO from do_generic_file_read. )
> >     If I take i_sem around call to do_generic_file_read in generic_file_read (in 2.4.21-pre10),
> >     that of course helps (this is of course not a correct fix, but just a demonstration
> >     that some VFS race is in place).
> >     The same problem can be observed on ext2 in both 2.4.21-pre10 and in 2.6.0-test2
> >     Attached is test_directio.c program, compile it and run with some filename as argument,
> >     immediately start "tail" with same filename and you'd get almost immediate
> >     I/O error from tail on 2.4 and you'd get same I/O error in 2.6 only after some more waiting.
> >     Is this something known and expected (or may be somebody have a fix already? ;) )?
> Test a current 2.4 kernel - it has lots of redone O_DIRECT-vs-buffered
> locking.

Stupid me.
I mean I tested with 2.4.22-pre10 which is pretty current.
I mean, there were no changes to buffers code in between 2.4.22-pre10 .. 2.4.22-rc1

> A 2.6 forward-port of that was done by Badari but I lost it and need to
> find it again.

Since it did not help 2.4.22 code, I think 2.6.0 won't benefit from it too.
The testcase is really easy and everyone can reproduce the problem easily.

Bye,
    Oleg
