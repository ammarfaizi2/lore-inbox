Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129895AbQLTNhG>; Wed, 20 Dec 2000 08:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbQLTNg5>; Wed, 20 Dec 2000 08:36:57 -0500
Received: from 196-41-175-2.citec.net ([196.41.175.2]:10217 "EHLO
	penguin.wetton.prism.co.za") by vger.kernel.org with ESMTP
	id <S129811AbQLTNgn>; Wed, 20 Dec 2000 08:36:43 -0500
Date: Wed, 20 Dec 2000 15:05:56 +0200
From: berndj@prism.co.za
To: linux-kernel@vger.kernel.org
Subject: possible pty DoS
Message-ID: <20001220150556.A29985@prism.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello all

I am not subscribed to linux-kernel*; please CC any follow-ups to
berndj@prism.co.za (I probably won't reply from 2000-12-22 to 2001-01-07)

I am running 2.4.0-test12-pre2

This snippet can prevent progress of any other processes that tries to do
a write to a pty:

============
	#include <sys/fcntl.h>
	#include <unistd.h>

	int main()
	{
		int ptm;
		ptm = open("/dev/ptmx", O_WRONLY);
		while (1)
			write(ptm, "hello, world!\n", 14);
	}
============

With this running, and no process eating up the greetings, I can telnet to
my machine; the banner and login prompt appear.  ps -alx at this point
reveals in.telnetd is in do_select().  As soon as I type even one char of
username, another ps reveals in.telnetd now stuck in __down_interruptible()

Lucky I usually leave a few logged in consoles lying around; xterm also
uses pty's!

Some observations:

2.2.12 behaves fine (telnet logins work fine)

2.2.12-2.4.0 diffs between tty_io.c show changes involving up/down/etc. in
do_tty_write().


Bernd Jendrissek
P.S. apologies to all for my void * arithmetic a few months ago; it was a
moment of eager-beaver weakness.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
