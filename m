Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbTEYLJG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 07:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTEYLJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 07:09:06 -0400
Received: from host81-136-131-132.in-addr.btopenworld.com ([81.136.131.132]:38522
	"EHLO mx.homelinux.com") by vger.kernel.org with ESMTP
	id S261835AbTEYLJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 07:09:04 -0400
Date: Sun, 25 May 2003 12:22:14 +0100 (BST)
From: Mitch@0Bits.COM
X-X-Sender: mitch@mx.homelinux.com
Reply-To: Mitch@0Bits.COM
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.21-rc3, writing to /dev/console returns ESPIPE
Message-ID: <Pine.LNX.4.53.0305251215020.2812@mx.homelinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

With 21-rc3, syslogd (sysklogd package)  stopped writing
messages to  /dev/console anymore. In the log files i see:

	May 25 11:14:19 core syslogd: /dev/console: Illegal seek
	May 25 11:14:19 core syslogd 1.4.1: restart (remote reception).

And strace  shows
# strace echo foo >/dev/console

	write(1, "foo\n", 4)                    = -1 ESPIPE (Illegal seek)
	close(1)                                = 0
	munmap(0x40016000, 4096)                = 0
	write(2, "echo: ", 6echo: )             = 6
	write(2, "write error", 11write error)  = 11
	write(2, "\n", 1)                       = 1
	_exit(1)                                = ?

We all understand that /dev/console can't be seeked, but it shouldn't
be so strict in enforcing this or else syslogd and friends will fail
to work. Unfortunately Linux doesn't have a pwritev() to not update
the file pointer.

The checkin on linux-2.4.21-rc3/drivers/char/tty_io.c

+       /* Can't seek (pwrite) on ttys.  */
+       if (ppos != &file->f_pos)
+               return -ESPIPE;

should not be there in my opinion.

Comments ?
Mitch

