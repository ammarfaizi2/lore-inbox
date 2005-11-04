Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbVKDHE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbVKDHE2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 02:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbVKDHE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 02:04:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:26824 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751409AbVKDHE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 02:04:28 -0500
Subject: tty locking again :)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 18:03:40 +1100
Message-Id: <1131087820.4680.248.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan !

(Asking you since I know you did some TTY locking work a while ago).

I noticed that there doesn't seem to be any kind of locking in
tty_(un)register_driver. It can very easily race with tty_open() doing a
get_tty_driver(). Shouldn't tty_(un)register_driver be changed to take
the tty_sem at least while manipulating the list ?

I noticed that while chasing a different bug (a driver bug actually),
but I don't see how we are protected here. And considering the race I
found in the driver, I tend to think we aren't protected at all

FYI. The hvc driver issue was basically that it was allowing struct
console->device (the kernel console callback to link to the tty driver)
to return the tty_driver pointer before it called tty_register_driver,
thus a racing tty_open() of the default console was blow up accessing
driver->ttys.

Ben.



