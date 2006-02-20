Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWBTA4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWBTA4T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWBTA4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:56:19 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:6927 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751167AbWBTA4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:56:18 -0500
Date: Mon, 20 Feb 2006 01:56:17 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Phillip Susi <psusi@cfl.rr.com>, Alan Stern <stern@rowland.harvard.edu>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
Message-ID: <20060220005617.GB90469@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Pavel Machek <pavel@ucw.cz>, Phillip Susi <psusi@cfl.rr.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	Alon Bar-Lev <alon.barlev@gmail.com>,
	Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0602191138470.9165-100000@netrider.rowland.org> <43F8C464.3000509@cfl.rr.com> <20060219194343.GA15311@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219194343.GA15311@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 08:43:44PM +0100, Pavel Machek wrote:
> Kernel can not tell the diference, and just because you don't like the
> behaviour does not mean we have to work around hardware limitation.
> 
> You deal with it. Post a patch.

It would take more than one patch, but it could be done:

Suspend time:

  1- Freeze all processes enough that no filesystem activity happens
  anymore.

  2- Do a map of the currently-opened files.  That is, for each opened
  file, find a workable path to it.  If you have the dentry, you have
  it.  Otherwise, on a filesystem that supports inodes, just
  sillyrename them to something in /.suspend.  For the non-inode
  filesystems, require not dropping the dentries for reliable suspend.
  They probably need to keep them in some form anyway for handling
  multiple opens of the same file.

  3- Sync the filesystems to the point that they're in clean state.

  4- Add the path mapping from (2) to the suspend image.

  5- Allow userspace to pick up any information it finds relevant
  about the filesystems/devices and put that info in the image too.


Resume time:

  6- Resume userspace checks the existing devices, find a mapping (or
  a lack of) using the information from (5) and the paths from (4)

  7- Rebuild the userspace from the image.

  8- Re-open/remap the files from the paths, sillyrenamed entries are
  unlinked once reopened.  Paths not found and filesystems not found
  are send to a virtual file on a virtual filesystem that just -EIOs
  or SEGVs mmaps.


Pros:
- You never lose filesystems or files, ever.  Only thing you can lose
  is processes.

- You can touch files in the suspended filesystems (device plugging,
  restart on the wrong kernel) without damage.

- You can remount the filesystems ro after 3, which allows access to
  whatever files the chrome may like.

- You only have to save the anonymous pages and the metadata.

Cons:
- Suspend may be slower since the write patterns are more dispersed
  than just swap.  OTOH, it will be no slower than sync(1).


There are probably things I haven't thought of, but I think it's the
kind of approach you need to be sure to be reliable no matter what.

  OG.

