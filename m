Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUAGXPE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbUAGXPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:15:04 -0500
Received: from simba.math.ucla.edu ([128.97.4.125]:6787 "EHLO
	simba.math.ucla.edu") by vger.kernel.org with ESMTP id S261879AbUAGXO7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:14:59 -0500
Date: Wed, 7 Jan 2004 15:14:58 -0800 (PST)
From: Jim Carter <jimc@math.ucla.edu>
To: "Ogden, Aaron A." <aogden@unocal.com>
Cc: thockin@sun.com, "H. Peter Anvin" <hpa@zytor.com>,
       autofs mailing list <autofs@linux.kernel.org>,
       Mike Waychison <Michael.Waychison@sun.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <6AB920CC10586340BE1674976E0A991D0C6BE4@slexch2.sugarland.unocal.com>
Message-ID: <Pine.LNX.4.53.0401071440090.21436@simba.math.ucla.edu>
References: <6AB920CC10586340BE1674976E0A991D0C6BE4@slexch2.sugarland.unocal.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jan 2004, Ogden, Aaron A. wrote:
> If you've read this far, what I'm trying to say is that having userspace
> related code remain in userland is a good thing since you can restart
> the daemon if something goes wrong.

Hear, hear.  But...

> If you move all of this to
> kernel-space you can't do anything about it if there is a problem.  In
> Solaris there is a command called 'automount' that tells the kernel to
> re-read the automount maps, perhaps it resets the autofs subsystem in
> the kernel as well.  If linux autofs had the same capability we might
> not need the daemon, but until then, having the daemon in userland is a
> good thing.

To my mind the ideal design goes something like this:

1.  you can mount a synthetic autofs filesystem on lots of directories,
including subdirs of other autofs filesystems.

2.  Whenever anything tries to access one of those directories (for a
direct map) or one of its subdirs whether visible or not (indirect map), if
nothing is mounted on it [and it hasn't been told by a special flag that
it's non-mountable, see the /home/user/server{A,B} example], the autofs
kernel module runs a script in user space (in the namespace context of the
originally requesting process).  Upon exit, if something is now mounted on
the subdir, fine.  Otherwise, ENOENT.  The module is not required to know
anything about autofs maps that the userspace helper may or may not
consult.

3.  Periodically the module should check if mounted filesystems are
potentially unmountable (this seems to be inexpensive), and if so it should
run the userspace helper to unmount them.  If the unmount fails, the helper
(not the kernel) should try to distinguish a race condition from a dead NFS
server, and whether the mount will be viable once the server comes back. If
not, it should be more aggressive than the present daemon in unmounting. At
present the module carefully keeps up-to-date a last_used field and a
timeout potentially different for each mount, but it's probably sufficient
to merely poll all the mount points periodically all at once, perhaps with
a one-time exemption when something is first mounted.

And that's *all* the complexity that should be in the kernel.  That's quite
complex enough in my opinion.  If the userspace helper needs state, it can
lock and read/write a file.  I don't really see the need for the autofs
system to have state beyond "it's mounted".

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
