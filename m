Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbTD1CAM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 22:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbTD1CAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 22:00:12 -0400
Received: from user72.209.42.38.dsli.com ([209.42.38.72]:36113 "EHLO
	nolab.conman.org") by vger.kernel.org with ESMTP id S263268AbTD1CAL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 22:00:11 -0400
Date: Sun, 27 Apr 2003 22:12:26 -0400 (EDT)
From: Mark Grosberg <mark@nolab.conman.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
In-Reply-To: <Pine.LNX.4.53.0304272203570.14901@chaos>
Message-ID: <Pine.BSO.4.44.0304272207431.23296-100000@kwalitee.nolab.conman.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 27 Apr 2003, Richard B. Johnson wrote:

> You don't save anything but one system call time which is inconsequential
> compared to the time necessary to exec (load a file, etc). Also, it is
> worthless for anything except the most basic 'system()' or popen()

Actually, my original proposal will work for popen and all sorts of piping
because of the file descriptor map. For example:

   int   in[2], out[2];
   char *null_argv[] = { NULL };
   int   fmap[4];
   pid_t p;

   pipe(in);
   pipe(out);

   fmap[0] = in[0];                     /* STDIN  */
   fmap[1] = out[1];                    /* STDOUT */
   fmap[2] = open("/dev/null", O_RDWR); /* STDERR */
   fmap[3] = -1;                        /* end    */

   p = nexec("/bin/cat",
             null_argv,
             NULL,
             filmap);


In this case you save the extra closes the child would have to do and you
save the dup's.

> All it does is add kernel bloat and duplicate existing kernel code
> (both). Learn Unix instead of trying to make it VMS with spawn().

Ahem, I happen to know Unix very well, thank you very much. Please read my
proposed API before flaming it out and assuming I know nothing of UNIX,
kernel development, or operating systems in general!

Do you honestly think that just because I picked a name spawn() that
happens to be in VMS (and MS-DOS C compilers) that I am inexperienced to
Unix. Nope. I just happen to be a BSD user in general and don't frequent
LKML.... and now I remember WHY!

And there _ARE_ issues this does solve as were already pointed out because
of the linear scan that must be made on the file descriptor array for the
close-on-exec flag (which this API could happily say it ignores since it
builds a _WHOLE_NEW file descriptor array).

L8r,
Mark G.

