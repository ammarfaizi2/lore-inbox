Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270967AbTHFVk1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 17:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272141AbTHFVk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 17:40:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:7824 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270967AbTHFVkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 17:40:24 -0400
Date: Wed, 6 Aug 2003 14:42:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Spurious -EIO when reading a file being written with O_DIRECT?
Message-Id: <20030806144206.12a18557.akpm@osdl.org>
In-Reply-To: <20030806110805.GG14457@namesys.com>
References: <20030806110805.GG14457@namesys.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin <green@namesys.com> wrote:
>
>    We were reported a problem where if a file being written in directio mode
>     and being read at the same time (in "normal/buffered" mode), then reading
>     process gets -EIO when near the end of file.
> 
>     Initially I thought this is reiserfs-only problemm and digged in that
>     direction, but then it turned out reiserfs does everything correctly
>     and the VFS itself seems to be racey (my current suspiction is directio
>     process uses get_block() that extends the file <schedule> reading process
>     gets the buffer and submits io, then waits for page to become uptodate
>     <schedule> direct io process unmaps buffer's metadata
>     As a result - that page never becomes uptodate and we get -EIO from do_generic_file_read. )
>     If I take i_sem around call to do_generic_file_read in generic_file_read (in 2.4.21-pre10),
>     that of course helps (this is of course not a correct fix, but just a demonstration
>     that some VFS race is in place).
>     The same problem can be observed on ext2 in both 2.4.21-pre10 and in 2.6.0-test2
>     Attached is test_directio.c program, compile it and run with some filename as argument,
>     immediately start "tail" with same filename and you'd get almost immediate
>     I/O error from tail on 2.4 and you'd get same I/O error in 2.6 only after some more waiting.
> 
>     Is this something known and expected (or may be somebody have a fix already? ;) )?

Test a current 2.4 kernel - it has lots of redone O_DIRECT-vs-buffered
locking.

A 2.6 forward-port of that was done by Badari but I lost it and need to
find it again.


