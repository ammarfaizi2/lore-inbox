Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWEZQ3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWEZQ3H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWEZQ3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:29:06 -0400
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:28324 "EHLO
	pne-smtpout4-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751046AbWEZQ3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:29:05 -0400
Message-Id: <20060526161129.557416000@gmail.com>
User-Agent: quilt/0.44-1
Date: Fri, 26 May 2006 19:11:29 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [patch 00/13] input: force feedback updates, second time
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Major update for the force feedback support, including a new force feedback
driver interface and two new HID ff drivers.

This is the same patchset that I sent 10 days ago, now with the following
changes:

- ugly cond_locking dropped
- 80-column rule now followed
- some function opening braces newlined and unneeded braces removed
- DECLARE_BITMAP used in input_ff_timer()
- effects are fd specific instead of the previous behaviour [1]
- uses setup_timer()
- no new module added, but code is instead compiled into input module
  (input.c is renamed to input-core.c)
- EXPORT_SYMBOL_GPL() used
- no -ENOSYS return values
- non-atomic bit operations used in most places of input-ff.c
- some comments are added
- new patch for -ENOMEM => -ENOSPC in iforce-ff.c
- UINPUT_VERSION define added in uinput.h
- drop obsolete static function declaration from hid-lgff.c
- pr_debug() used

[1] There are no known ff programs that depend on the old behaviour. Daniel
Remenak, who has been coding linux ff support for several programs, agrees
to the change. The old behaviour is not documented anywhere, so most likely
nobody even knew about it (Daniel didn't).

I described this in another mail already, but here it is again:

old behaviour:
- fd1 opened
- fd1: effects 0, 1 are created
- fd2 opened
- fd2: effects 2, 3 are created
- fd2 closed
=> effects 0, 1, 2, 3 get deleted
- fd1 uses effects
=> failure
- fd1 closed

new behaviour:
- fd1 opened
- fd1: effects 0, 1 are created
- fd2 opened
- fd2: effects 2, 3 are created
- fd2 closed
=> effects 2, 3 get deleted
- fd1 uses effects
- fd1 closed
=> effects 0, 1 get deleted

(fd1 and fd2 are of the same process and the same device)


-- 
Anssi Hannula
