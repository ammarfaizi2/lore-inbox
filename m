Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261914AbSJIR6L>; Wed, 9 Oct 2002 13:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261866AbSJIR6G>; Wed, 9 Oct 2002 13:58:06 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:17163 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S261914AbSJIR54>;
	Wed, 9 Oct 2002 13:57:56 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Why does x86_64 support a SuSE-specific ioctl?
Date: Wed, 9 Oct 2002 18:03:08 +0000 (UTC)
Organization: Cistron
Message-ID: <ao1r0s$o8b$1@ncc1701.cistron.net>
References: <Pine.NEB.4.44.0210041654570.11119-100000@mimas.fachschaften.tu-muenchen.de.
	 suse.lists.linux.kernel> <20021005071003.A15345@wotan.suse.de> <1033824115.3425.2.camel@irongate.swansea.linux.org.uk> <ann5s4$87a$1@ncc1701.cistron.net>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1034186588 24843 62.216.29.67 (9 Oct 2002 18:03:08 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <ann5s4$87a$1@ncc1701.cistron.net>,
Miquel van Smoorenburg <miquels@cistron.nl> wrote:
>So you need to know what the _real_ console is so you can write
>a copy to the real console. The only way to find that out is
>to call TIOCGDEV on /dev/console, then scan /dev. That is
>what bootlogd does, I've tried to get TIOCGDEV in the kernel
>since 2.2 days but gave up because it was ignored. So bootlogd
>has always been 'experimental', though it is very useful,
>since it has no kernel support.
>
>Now, to solve this particular problem, there are a few
>alternatives.
>
>One is a TIOCCONS_COPY ioctl, so that output is not redirected
>but copied to the pty.
>
>Another, perhaps more elegant solution is that writes
>to the pty slave that receives the console output should
>go to the real console. A swap instead of a redirect.

That doesn't work since other OSes redirect both input and
output, and while we don't do that we don't want to change
semantics too much.

How about _not_ doing the redirect for filehandles opened
with O_DIRECT ?

--- linux-2.4.19/drivers/char/tty_io.c.orig	Sat Aug  3 02:39:43 2002
+++ linux-2.4.19/drivers/char/tty_io.c	Wed Oct  9 20:01:26 2002
@@ -755,7 +755,7 @@
 	is_console = (inode->i_rdev == SYSCONS_DEV ||
 		      inode->i_rdev == CONSOLE_DEV);
 
-	if (is_console && redirect)
+	if (is_console && redirect && !(file->f_flags & O_DIRECT))
 		tty = redirect;
 	else
 		tty = (struct tty_struct *)file->private_data;

Mike.

