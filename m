Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272220AbTHDUEh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 16:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272221AbTHDUEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 16:04:37 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:10504 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S272220AbTHDUDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 16:03:53 -0400
Date: Mon, 4 Aug 2003 22:03:51 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-ID: <20030804200351.GA24036@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <20030804141548.5060b9db.skraw@ithnet.com> <20030804134415.GA4454@win.tue.nl> <20030804155604.2cdb96e7.skraw@ithnet.com> <Pine.SOL.4.56.0308041458500.22102@orange.csi.cam.ac.uk> <20030804165002.791aae3d.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804165002.791aae3d.skraw@ithnet.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 04:50:02PM +0200, Stephan von Krawczynski wrote:
> On Mon, 4 Aug 2003 15:04:28 +0100 (BST)
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > You ask for examples of applications?  There are millions!  Anything that
> > walks the directory tree for a start, e.g. ls -R, find, locatedb, medusa,
> > du, any type of search and/or indexing engine, chown -R, cp -R, scp
> > -R, chmod -R, etc...
> 
> There is a flaw in this argument. If I am told that mount --bind does just
> about what I want to have as a feature then these applictions must have the
> same problems already (if I mount braindead). So an implementation in fs cannot
> do any _additional_ damage to these applications, or not?

There is a subtle but fundamental difference between mount --bind and
hard links for directories[1]: mounts done under a bind point and
mounts done under the original tree are independant.  An example on a
system (rh9) with the "standard" /dev/pts mounted and no devfs:

root@zalem:~ #1 >mkdir x
root@zalem:~ #2 >mount --bind /dev x
root@zalem:~ #3 >ls -l /dev |head -5
total 305
crw-------    1 root     root      10,  10 Jan 30  2003 adbmouse
crw-r--r--    1 root     root      10, 175 Jan 30  2003 agpgart
crw-------    1 root     root      10,   4 Jan 30  2003 amigamouse
crw-------    1 root     root      10,   7 Jan 30  2003 amigamouse1
root@zalem:~ #4 >ls -l x | head -5
total 306
crw-------    1 root     root      10,  10 Jan 30  2003 adbmouse
crw-r--r--    1 root     root      10, 175 Jan 30  2003 agpgart
crw-------    1 root     root      10,   4 Jan 30  2003 amigamouse
crw-------    1 root     root      10,   7 Jan 30  2003 amigamouse1
root@zalem:~ #5 >ls -l x/pts |head -5
total 0
root@zalem:~ #6 >ls -l /dev/pts | head -5
total 0
crw--w----    1 galibert tty      136,   0 Aug  4 21:56 0
crw--w----    1 galibert tty      136,   1 Aug  4 21:56 1
crw--w----    1 galibert tty      136,   2 Aug  4 21:57 2
root@zalem:~ #7 >mount --bind /tmp x/input
root@zalem:~ #8 >ls -l x/input | head -5
total 25
-rw-r--r--    1 galibert mame            0 Aug  1 23:24 Acrodqnzpn
drwx------    2 galibert mame           48 Jul 31 22:52 galibert
drwx------    2 galibert mame           72 Aug  1 22:17 gsrvdir500
srwxrwxrwx    1 wnn      wnn             0 Aug  4 21:11 jd_sockV4
root@zalem:~ #9 >ls -l /dev/input | head -5
total 0
crw-------    1 root     root      13,  64 Jan 30  2003 event0
crw-------    1 root     root      13,  65 Jan 30  2003 event1
crw-------    1 root     root      13,  74 Jan 30  2003 event10
crw-------    1 root     root      13,  75 Jan 30  2003 event11

You can see that ~root/x and /dev are the same file tree but different
mount spaces.  Because of that you can't have a loop, because a bind
mount can't point to a mount space that is a predecessor of itself.

  OG.

[1] You can mount --bind files.
