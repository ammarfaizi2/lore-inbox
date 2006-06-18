Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWFRXAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWFRXAs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 19:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWFRXAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 19:00:48 -0400
Received: from mailfe08.tele2.fr ([212.247.154.236]:52420 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1750727AbWFRXAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 19:00:47 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Mon, 19 Jun 2006 01:00:41 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [GIT PATCH] Remove devfs from 2.6.17
Message-ID: <20060618230041.GG4744@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	greg@kroah.com
References: <20060618221343.GA20277@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060618221343.GA20277@kroah.com>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH, le Sun 18 Jun 2006 15:13:43 -0700, a écrit :
> Since 2.6.13 came out, I have seen no complaints about the fact that
> devfs was not able to be enabled anymore,

There has been at least my complaint about udev not being able to
auto-load modules on /dev entry lookup (28th March 2006):

« Given a freshly booted linux box, hence uinput is not loaded (why
would it be, it doesn't drive any real hardware) ; what is the right
way(tm) for an application to have the uinput module loaded, so that it
can open /dev/input/uinput for emulating keypresses?

- With good-old static /dev, we could just open /dev/input/uinput
  (installed by the distribution), and thanks to a
  alias char-major-10-223 uinput
  line somewhere in /etc/modprobe.d, uinput gets auto-loaded.

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
»

Neither solution looks good to me... Just opening /dev/input/uinput
should be sufficient, and udev doesn't let that for now.

The same situation holds for other virtual devices (loop, snd-seq-dummy,
...).

Samuel
