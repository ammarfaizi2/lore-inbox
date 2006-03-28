Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWC1Tm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWC1Tm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 14:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWC1Tm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 14:42:26 -0500
Received: from mailfe07.tele2.fr ([212.247.154.204]:34203 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1751293AbWC1TmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 14:42:25 -0500
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Tue, 28 Mar 2006 21:42:10 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org
Cc: dave@mielke.cc
Subject: How should an application ask for uinput module load?
Message-ID: <20060328194210.GD4660@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org, dave@mielke.cc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Given a freshly booted linux box, hence uinput is not loaded (why would
it be, it doesn't drive any real hardware) ; what is the right way(tm)
for an application to have the uinput module loaded, so that it can open
/dev/input/uinput for emulating keypresses?

- With good-old static /dev, we could just open /dev/input/uinput
  (installed by the distribution), and thanks to a
  alias char-major-10-223 uinput
  line somewhere in /etc/modprobe.d, uinput finally gets auto-loaded.

- With devfs, it doesn't look like it works (/dev/misc/uinput is not
  present and opening it just like if it existed doesn't work). But I
  read in archives that it could be feasible.

- With udev, this just cannot work. As explained in an earlier thread,
  even using a special filesystem that would report the opening attempt
  to udevd wouldn't work fine since udevd takes time for creating the
  device, and hence the original program needs to be notified ; this
  becomes racy.

So what is the correct way to do it? I can see two approaches:

Using modprobe:
- try to use /dev/input/uinput ; if it succeeds, fine.
- else, if errno != ENOENT, fail
- else, (ENOENT)
  - try to call `cat /proc/sys/kernel/modprobe` uinput
  - try to use /dev/input/uinput again ; if it succeeds, fine
    - else, assume that it really wasn't compiled, and hence fail.

Triggering auto-load by creating one's own node.
- try to use /dev/input/uinput ; if it suceeds, fine.
- else, if errno != ENOENT, fail
- else, (ENOENT)
  - mknod /somewhere/safe/uinput c 10 223
  - use /somewhere/safe/uinput ; if it succeeds, fine
    - else, assume that it really wasn't compiled, and hence fail.

I guess the same problem arises for loop devices and all such virtual
devices...

Regards,
Samuel
