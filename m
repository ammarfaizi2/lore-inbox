Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUBCPA4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 10:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUBCPA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 10:00:56 -0500
Received: from f13.mail.ru ([194.67.57.43]:39173 "EHLO f13.mail.ru")
	by vger.kernel.org with ESMTP id S263544AbUBCPAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 10:00:53 -0500
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: module-init-tools/udev and module auto-loading
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Tue, 03 Feb 2004 18:00:51 +0300
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1Ao22l-000NVq-00.arvidjaar-mail-ru@f13.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You already have the implementation , it is called devfs. Why
reinvent the wheel?

> I guess there will be cries of murder if 'somebody' suggested that if
> a node in /dev is opened, but not there, the kernel can call
> 'modprobe -q /dev/foo' to load whatever alias there might have been?

this is exactly what was described as "unsolvable races in devfs
code". The problem is:

- lookup is run under directory i_sem. If you spawn anything 
  synchronously (waiting for it to finish) and it tries (intentionally
  or not) access the same directory you get deadlock.

- calling it asynchronously does not buy you much because it still
  means you must return -ENOENT first time.

I hope to have fixed the first type of races meaning that either
devfs (after some - significant - cleanup) may be used for that
or another file system written from scratch.

main problems in devfs are associated with the fact that contents
may change asynchronously wrt to upper layer. Removing everything
related to name registration from kernel will give you ligh weight
implementation capable of do what you want.

-andrey
