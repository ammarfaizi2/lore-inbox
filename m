Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTKKKlQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 05:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTKKKlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 05:41:16 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:10765 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263014AbTKKKlO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 05:41:14 -0500
Date: Tue, 11 Nov 2003 02:41:10 -0800
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031111104110.GD17240@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Qvw7.5Qf.9@gated-at.bofh.it> <QxRl.17Y.9@gated-at.bofh.it> <Qy0W.1sk.9@gated-at.bofh.it> <QyaB.1GK.17@gated-at.bofh.it> <QzSZ.4x1.1@gated-at.bofh.it> <QCHh.X6.3@gated-at.bofh.it> <3FB0B10E.9060907@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB0B10E.9060907@softhome.net>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message is may contain confidential information.  Unauthorised disclosure will be prosecuted to the fullest extent of the law.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 10:51:10AM +0100, Ihar 'Philips' Filipau wrote:
> Florian Weimer wrote:
> >Andreas Dilger wrote:
> >
> >
> >>>This is fast turning into a creeping horror of aggregation.  I defy 
> >>>anybody
> >>>to create an API to cover all the options mentioned so far and *not* 
> >>>have it
> >>>look like the process_clone horror we so roundly derided a few weeks ago.
> >>
> >>	int sys_copy(int fd_src, int fd_dst)
> >
> >
> >Doesn't work.  You have to set the security attributes while you open
> >fd_dst.
> 
>   int new_fd = sys_copy( int src_fd );  /* cloned copy, out of any fs */
>   fchmod( new_fd, XXX_WHAT_EVER );      /* do the job. */
>   ...
>   flink(new_fd, "/some/path/some/file/name"); /* commit to fs */

The associate open file descriptor with a new path system
call (flink here) has already been rejected for solid
security reasons.

>   close(new_fd);  /* bye-bye */
> 
>   I beleive this can be more useful. Not only in naive tries to replace 
> cp(1) with kernel ;-)

Eliminating the flink and using file descriptors you wind up
with something like:

	in_fd = open(oldpath, O_RDONLY);
	fstat(in_fd, statbuf);
	out_fd = open(newpath, O_WRONLY|flags, statbuf->st_mode);
	sendfile(out_fd, in_fd, 0, statbuf->st_size);
	close(out_fd);
	close(in_fd);

So if you can do it with open file descriptors why do you
need a new system call?

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
