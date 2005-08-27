Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbVH0Xjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbVH0Xjz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 19:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVH0Xjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 19:39:55 -0400
Received: from ozlabs.org ([203.10.76.45]:36815 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750826AbVH0Xjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 19:39:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17168.63953.95070.579096@cargo.ozlabs.ibm.com>
Date: Sun, 28 Aug 2005 09:40:01 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org, akpm@osdl.org, dwmw2@redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove race between con_open and con_close
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a laptop (G3 powerbook) which will pretty reliably hit a race
between con_open and con_close late in the boot process and oops in
vt_ioctl due to tty->driver_data being NULL.

What happens is this: process A opens /dev/tty6; it comes into
con_open() (drivers/char/vt.c) and assign a non-NULL value to
tty->driver_data.  Then process A closes that and concurrently process
B opens /dev/tty6.  Process A gets through con_close() and clears
tty->driver_data, since tty->count == 1.  However, before process A
can decrement tty->count, we switch to process B (e.g. at the
down(&tty_sem) call at drivers/char/tty_io.c line 1626).

So process B gets to run and comes into con_open with tty->count == 2,
as tty->count is incremented (in init_dev) before con_open is called.
Because tty->count != 1, we don't set tty->driver_data.  Then when the
process tries to do anything with that fd, it oopses.

The simple and effective fix for this is to test tty->driver_data
rather than tty->count in con_open.  The testing and setting of
tty->driver_data is serialized with respect to the clearing of
tty->driver_data in con_close by the console_sem.  We can't get a
situation where con_open sees tty->driver_data != NULL and then
con_close on a different fd clears tty->driver_data, because
tty->count is incremented before con_open is called.  Thus this patch
eliminates the race, and in fact with this patch my laptop doesn't
oops.

Could this go into 2.6.13 please?

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.6/drivers/char/vt.c pmac-2.6/drivers/char/vt.c
--- linux-2.6/drivers/char/vt.c	2005-07-17 10:59:52.000000000 +1000
+++ pmac-2.6/drivers/char/vt.c	2005-08-27 22:59:36.000000000 +1000
@@ -2433,7 +2433,7 @@
 	int ret = 0;
 
 	acquire_console_sem();
-	if (tty->count == 1) {
+	if (tty->driver_data == NULL) {
 		ret = vc_allocate(currcons);
 		if (ret == 0) {
 			struct vc_data *vc = vc_cons[currcons].d;
