Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbUAXXgY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 18:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbUAXXgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 18:36:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:49828 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262446AbUAXXgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 18:36:22 -0500
Date: Sat, 24 Jan 2004 15:35:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Request: I/O request recording
Message-Id: <20040124153551.24e74f63.akpm@osdl.org>
In-Reply-To: <20040124181026.GA22100@codeblau.de>
References: <20040124181026.GA22100@codeblau.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner <felix-kernel@fefe.de> wrote:
>
> I would like to have a user space program that I could run while I cold
> start KDE.  The program would then record which I/O pages were read in
> which order.  The output of that program could then be used to pre-cache
> all those pages, but in an order that reduces disk head movement.
> Demand Loading unfortunately produces lots of random page I/O scattered
> all over the disk.

I wrote a similar thing in September of 2001.  What you do is:

- Reboot the system, wait until everything is steady-state (eg: X has
  started, applications are loaded).

- Load a kernel module which dumps the current contents of the pagecache
  (filename/offset-into-file) into a file.

  (The kernel module writes to modprobe's stdout, so you just do

	modprobe fboot-dump > /tmp/fboot-dump.out

   I'm very proud of this.)

- Post-process the resulting output into a database which is used on the
  next reboot.

- reboot

- This time a userspace application cuts in real early and reads the
  database and preloads all the pagecache using "optimal" I/O patterns so
  that everything which you will need in the subsequent boot is already in
  memory.


So it's all an attempt to optimise the boot-time I/O patterns.  It was
pretty much a waste of time, gaining only 10% or so, from memory.  You
could get just as much or more speedup from simply launching all the
initscripts in parallel, although this did tend to break stuff.

Anyway, the code's ancient but might provide some ideas:

	http://www.zip.com.au/~akpm/linux/fboot.tar.gz


