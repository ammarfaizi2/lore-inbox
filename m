Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbTBOTmJ>; Sat, 15 Feb 2003 14:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbTBOTmI>; Sat, 15 Feb 2003 14:42:08 -0500
Received: from quechua.inka.de ([193.197.184.2]:27778 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S264919AbTBOTmH>;
	Sat, 15 Feb 2003 14:42:07 -0500
X-Mailbox-Line: From aj@dungeon.inka.de  Sat Feb 15 20:51:59 2003
Subject: 2.5.61/usb: poll does not time out
From: Andreas Jellinghaus <aj@dungeon.inka.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1045338900.486.20.camel@simulacron>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 15 Feb 2003 20:55:01 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

poll() should return as soon as there is some event.
unplugging a usb device will cause poll to set
revents to POLLERR|POLLHUP.

But the poll() syscall is not returned, instead
the kernel waits for the timeout to count down /
in the case poll with a negative value to wait
forever. This way an application will never
notice that the usb device has been removed.

here is a strace on a test app.
the kernel waits full 10 seconds (the timeout used),
even though the usb device was removed in the first
five seconds.

send(4, "<15>Feb 15 20:47:52 usbtoken[947"..., 52, 0) = 52
rt_sigaction(SIGPIPE, {SIG_DFL}, NULL, 8) = 0
poll([{fd=3, events=POLLIN|POLLPRI|POLLOUT|POLLERR,
revents=POLLERR|POLLHUP}], 1, 10000) = 1
time([1045338482])                      = 1045338482
getpid()                                = 9477
writev(2, [{"usbtoken[9477]: device removed. "..., 41}],
1usbtoken[9477]: device removed. exiting.
) = 41
rt_sigaction(SIGPIPE, {0x400edf48, [], 0x4000000}, {SIG_DFL}, 8) = 0
send(4, "<15>Feb 15 20:48:02 usbtoken[947"..., 61, 0) = 61

was it meant to be that way?

if so: how can i work around this (in a nice way) ?

i could:
a) use short timeouts and a permanent loop (not nice)
b) use the hotplug script when it is called with "remove"
   to find the app with which has the device still open
   and kill the process / send some signal. also not nice.

Andreas



