Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUBIQGs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 11:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUBIQGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 11:06:48 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:2975 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264286AbUBIQGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 11:06:45 -0500
Subject: Re: Does anyone still care about BSD ptys?
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: hpa@zytor.com
Content-Type: text/plain
Organization: 
Message-Id: <1076334541.27234.140.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Feb 2004 08:49:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:

> Does anyone still care about old-style BSD ptys,
> i.e. /dev/pty*?  I'm thinking of restructuring
> the pty system slightly to make it more dynamic
> and to make use of the new larger dev_t, and
> I'd like to get rid of the BSD ptys as part of
> the same patch.

The BSD-style ptys are used all the time for
serial port emulation. The SysV-style ones are
useless for this, since they don't have a fixed
mapping from master to slave. You might make a
symlink from /dev/testbox to /dev/ptyp0, then
configure gdb to use /dev/testbox for remote
debugging. Then you start a remserial process
to connect /dev/ttyp0 with port 7455 on some
terminal server, and on the terminal server you
have remserial connect port 7455 to /dev/C7.
Now, whenever you run gdb, you're debugging
a test box over a serial line connected to the
terminal server. With SysV-style ttys, you
can't set up your config as nicely. The above
would likely have a few extra symlinks BTW.

In your use of the larger dev_t, please keep
the first 2047 or 2048 ptys as they are today.
Let the last major use the full 20-bit minor,
while restricting the first 7 minors to 8 bits.
This avoids breaking userspace software.

For example, due to the lack of /proc/*/tty links,
procps uses min+(maj-136)*256 to guess the number
of a SysV-style pty. A 32-bit dev_t will be handled
correctly by procps 3.2 if you extend the pty usage
as explained above.

Adding /proc/*/tty links solves the problem as
well, subject to a linux-2.7.0 version check.


