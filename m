Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965128AbWD0Ote@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbWD0Ote (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 10:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbWD0Ote
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 10:49:34 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:53337 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S965128AbWD0Ote (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 10:49:34 -0400
Message-ID: <4450D9F9.3080904@tls.msk.ru>
Date: Thu, 27 Apr 2006 18:49:29 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Tom Horsley <tom.horsley@ccur.com>
CC: Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bugsy <bugsy@ccur.com>
Subject: Re: CLONE_NEWNS and mount command?
References: <1146142640.23667.9.camel@tweety>	 <20060427130149.GP27946@ftp.linux.org.uk> <1146143102.23667.11.camel@tweety>
In-Reply-To: <1146143102.23667.11.camel@tweety>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Horsley wrote:
[]
> If there is a bug, maybe it is that a /etc/mtab file exists
> at all :-).

This topic has been discussed before (without any real conclusion
if memory serves me right).  The thing is: /etc/mtab IS useful,
as it contains different information compared with /proc/mounts
(irrelevant to CLONE_NEWNS/namespaces).  For example, if I'll

  mount -o loop file /mount/point

mtab will contain
  -oloop=X /path/to/file /mount/point

while /proc/mounts will only have
  file /mount/point

Note the two differences: omission of loop device number (used
by umount to automatically deconfigure loop device) and relative
(to what??) path to `file'.

On the other hand, /proc/mounts often contains more options
than mtab: mtab only lists those options which has been specified
on the command line, omitting defaults, but /proc/mounts lists
them all (like data=ordered for ext3fs).

And on another note, there are cases when you do NOT want to
expose some "internal" mounts to users.  "Classical" example
which bothered me for quite some time is the way udev is set
up on Debian (dunno for other distros): they move-mount /dev
to /dev/.static/dev, but /dev/.static is drwx------, ie ordinary
users can't access it.  Hence, when you run any command which
tries to access mounted filesystems (like df for example), it
complains that it can't stat /dev/.static/dev, which is plain
ugly.  Omitting that entry from /etc/mtab fixes the problem.

That all to say: /proc/mounts and /etc/mtab both has their
good and usages...  And *this*, IMHO, is where the bug is:
neither of the two gives complete information.

/mjt
