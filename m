Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVBOULq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVBOULq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVBOUK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:10:26 -0500
Received: from manson.clss.net ([65.211.158.2]:24704 "HELO manson.clss.net")
	by vger.kernel.org with SMTP id S261864AbVBOUGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:06:33 -0500
Message-ID: <20050215200633.10668.qmail@manson.clss.net>
From: "Alan Curry" <pacman-kernel@manson.clss.net>
Subject: Re: Pty is losing bytes
To: torvalds@osdl.org (Linus Torvalds)
Date: Tue, 15 Feb 2005 15:06:33 -0500 (EST)
Cc: schwab@suse.de (Andreas Schwab), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org> from "Linus Torvalds" at Feb 15, 2005 11:08:07 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes the following:
>
>Does the problem go away if you change the default value of "chunk" (in 
>drivers/char/tty_io.c:do_tty_write) from 4096 to 2048? If so, that means 
>that the pty code has _claimed_ to have written 4kB, and only ever wrote 
>4kB-1 bytes. That in turn implies that "ldisc.receive_room()" disagrees 
>with "ldisc.receive_buf()".
>

That does fix it for me, in 2.6.10-as3 (the -as3 patch doesn't touch anything
near the pty code, so it should be good for vanilla 2.6.10 too).

I noticed while testing that the "lost byte" is occasionally more than one
byte. It's always one byte at the 4k mark, but sometimes a larger group of
bytes is lost around the 8k mark, and (more rarely) an even larger group of
bytes is lost at the 12k mark.

$ ls -l /etc/mime.types
-rw-r--r--    1 root     root        15723 Apr  9  2002 /etc/mime.types
$ while :; do ./ptytest < /etc/mime.types | wc -c ; sleep 1 ; done
  15722
  15710
  15722
  15710
  15722
  15710
  15722
  15722
  15682
(and so on)

