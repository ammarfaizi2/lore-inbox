Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbUAGXdC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUAGXcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:32:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17163 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263053AbUAGXct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:32:49 -0500
Message-ID: <3FFC96FE.9050002@zytor.com>
Date: Wed, 07 Jan 2004 15:32:14 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Jim Carter <jimc@math.ucla.edu>
CC: "Ogden, Aaron A." <aogden@unocal.com>, thockin@sun.com,
       autofs mailing list <autofs@linux.kernel.org>,
       Mike Waychison <Michael.Waychison@sun.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
References: <6AB920CC10586340BE1674976E0A991D0C6BE4@slexch2.sugarland.unocal.com> <Pine.LNX.4.53.0401071440090.21436@simba.math.ucla.edu>
In-Reply-To: <Pine.LNX.4.53.0401071440090.21436@simba.math.ucla.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Carter wrote:
> 
> To my mind the ideal design goes something like this:
> 
> 1.  you can mount a synthetic autofs filesystem on lots of directories,
> including subdirs of other autofs filesystems.
> 
> 2.  Whenever anything tries to access one of those directories (for a
> direct map) or one of its subdirs whether visible or not (indirect map), if
> nothing is mounted on it [and it hasn't been told by a special flag that
> it's non-mountable, see the /home/user/server{A,B} example], the autofs
> kernel module runs a script in user space (in the namespace context of the
> originally requesting process).  Upon exit, if something is now mounted on
> the subdir, fine.  Otherwise, ENOENT.  The module is not required to know
> anything about autofs maps that the userspace helper may or may not
> consult.
> 
> 3.  Periodically the module should check if mounted filesystems are
> potentially unmountable (this seems to be inexpensive), and if so it should
> run the userspace helper to unmount them.  If the unmount fails, the helper
> (not the kernel) should try to distinguish a race condition from a dead NFS
> server, and whether the mount will be viable once the server comes back. If
> not, it should be more aggressive than the present daemon in unmounting. At
> present the module carefully keeps up-to-date a last_used field and a
> timeout potentially different for each mount, but it's probably sufficient
> to merely poll all the mount points periodically all at once, perhaps with
> a one-time exemption when something is first mounted.
> 
> And that's *all* the complexity that should be in the kernel.  That's quite
> complex enough in my opinion.  If the userspace helper needs state, it can
> lock and read/write a file.  I don't really see the need for the autofs
> system to have state beyond "it's mounted".
> 

What you've described above is more or less the autofs v3 design.  There
are reasons why you really want to have a simple-minded timeout in the
kernel, mostly because attempting umount is more expensive than it
should be on some filesystems.  It only needs to be statistically
accurate, though, and thus it does not introduce a race.

Once you have to deal with mount trees (multiple filesystems on the same
mount point which you want to have appear to userspace as a unit),
things get significantly more complex, unfortunately.  Mounting is not a
problem, since the nonprivileged processes are simply held, but
umounting is, since in order to make sure there are no race conditions
userspace needs to be locked out from filesystem "a" while umounting
filesystem "a/b", *or* the equivalent of a direct mount autofs point has
to be imposed on node "a/b" of filesystem "a" which can be atomically
deleted together with the umounting of filesystem "a".

These are the mount traps Al Viro has been architecting.

	-hpa

