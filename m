Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272396AbTGZAUU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 20:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272397AbTGZAUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 20:20:20 -0400
Received: from tantale.fifi.org ([216.27.190.146]:9881 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S272396AbTGZAUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 20:20:12 -0400
To: Eli Barzilay <eli@barzilay.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Repost: Bug with select?
References: <16112.10166.989608.288954@mojave.cs.cornell.edu>
	<16159.28266.868297.372200@mojave.cs.cornell.edu>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 25 Jul 2003 17:35:17 -0700
In-Reply-To: <16159.28266.868297.372200@mojave.cs.cornell.edu>
Message-ID: <877k66qg56.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Barzilay <eli@barzilay.org> writes:

> [This is a second post, since I didn't get any replies the first time.
> It looks more like a bug now, which sounds strange for something that
> common...]
> 
> When I run the following program, and block the terminal's output
> (C-s), the `select' doesn't seem to have any effect, resulting in a
> 100% cpu usage (this is on a RH8, with 2.4.18).  I wouldn't be
> surprised if I'm doing something stupid, but it does seem to work fine
> on Solaris.
> 
> Is there anything wrong with this, or is this some bug?
> 
> ======================================================================
> #include <unistd.h>
> #include <fcntl.h>
> int main() {
>   int flags, fd, len; fd_set writefds;
>   fd = 1;
>   flags = fcntl(fd, F_GETFL, 0);
>   fcntl(fd, F_SETFL, flags | O_NONBLOCK);
>   while (1) {
>     FD_ZERO(&writefds);
>     FD_SET(fd, &writefds);
>     len = select(fd + 1, NULL, &writefds, NULL, NULL);
>     if (!FD_ISSET(fd,&writefds)) exit(0);
>     len = write(fd, "hi\n", 3);
>   }
>   fcntl(fd, F_SETFL, flags);
> }
> ======================================================================

Looks like a bug to me.
Strace says:

select(2, NULL, [1], NULL, NULL)        = 1 (out [1])
write(1, "hi\n", 3)                     = -1 EAGAIN (Resource temporarily unavailable)

forever.

Then select() should not return fd 1 as writable, at least not
reapeatedly.

Phil.
