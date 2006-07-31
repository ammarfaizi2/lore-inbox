Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWGaOro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWGaOro (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 10:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWGaOro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 10:47:44 -0400
Received: from mail.gmx.de ([213.165.64.21]:44723 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750863AbWGaOrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 10:47:43 -0400
X-Authenticated: #428038
Date: Mon, 31 Jul 2006 16:47:36 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Adrian Ulrich <reiser4@blinkenlights.ch>
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       matthias.andree@gmx.de, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060731144736.GA1389@merlin.emma.line.org>
Mail-Followup-To: Adrian Ulrich <reiser4@blinkenlights.ch>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
	reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
	tytso@mit.edu, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
References: <1153760245.5735.47.camel@ipso.snappymail.ca> <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl> <20060731125846.aafa9c7c.reiser4@blinkenlights.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731125846.aafa9c7c.reiser4@blinkenlights.ch>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Ulrich schrieb am 2006-07-31:

> > > And EXT3 imposes practical limits that ReiserFS doesn't as well. The big
> > > one being a fixed number of inodes that can't be adjusted on the fly,
> > 
> > Right. Plan ahead.
> 
> Ok: Assume that i've read the mke2fs manpage and added more inodes to
> my filesystem.
> 
> So: What happens if i need to grow my filesystem by 200% after 1-2
> years? Can i add more inodes to Ext3 on-the-fly ?

Since you "grow", you'll be using resize2fs (or growfs or mkfs -G for
UFS). resize2fs and the other tools do exactly that: add inodes - and
you could easily have told this either from reading the resize2fs code
or just trying it on a temp file:

  -- create file system
  dd if=/dev/zero of=/tmp/foo bs=1k count=50000
  /sbin/mke2fs -F -j /tmp/foo

  -- check no. of inodes
  /sbin/tune2fs -l /tmp/foo | grep -i inode | head -2
  # Inode count:              12544
  # Free inodes:              12533

  -- resize
  /sbin/e2fsck -f /tmp/foo
  dd if=/dev/zero bs=1k count=50000 >>/tmp/foo
  /sbin/resize2fs /tmp/foo

  -- check no. of inodes
  /sbin/tune2fs -l /tmp/foo | grep -i inode
  # Inode count:              23296
  # Free inodes:              23285

Trying the same after mke2fs -b 1024 -i 1024 shows that the inode
density will continue to be respected.

FreeBSD 6.1's growfs(8) increases the number of inodes. This is
documented to work since 4.4.

Solaris 8's mkfs -G also increases the number of inodes and apparently
also works for mounted file systems.

This looks rather like an education issue rather than a technical limit.

> A filesystem with a fixed number of inodes (= not readjustable while
> mounted) is ehr.. somewhat unuseable for a lot of people with
> big and *flexible* storage needs (Talking about NetApp/EMC owners)

Which is untrue at least for Solaris, which allows resizing a life file
system. FreeBSD and Linux require an unmount.

> Why are a lot of Solaris-people using (buying) VxFS? Maybe because UFS
> also has such silly limitations? (..and performs awkward with trillions
> of files..?..)

Well, such "silly limitations"... looks like they are mostly hot air
spewn by marketroids that need to justify people spending money on their
new filesystem.

The only problem remains if you grossly overestimate the average file
size and with it underestimate the number of inodes needed. But even
then, I'd be interested to know if that's a real problem for systems
such as ZFS.

-- 
Matthias Andree
