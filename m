Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWDJHfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWDJHfO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 03:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWDJHfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 03:35:14 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:16515 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750988AbWDJHfM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 03:35:12 -0400
Message-ID: <443A0A6F.2040500@aitel.hist.no>
Date: Mon, 10 Apr 2006 09:34:07 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grzegorz Kulewski <kangur@polcom.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Slow swapon for big (12GB) swap
References: <Pine.LNX.4.63.0604091338030.31989@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.63.0604091338030.31989@alpha.polcom.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski wrote:

> Hi,
>
> I am using big swap here (as a backing for potentially huge tmpfs). 
> And I wonder why swapon on such big (like 12GB) swap takes about 7 
> minutes (continuous disk IO). Is this expected? Why it is like that? 
> Can I do anything to speed it up? Or maybe remove it into the 
> background with low priority or something like that?

I don't know why it is slow.  But you can certainly do something like:

nice swapon /dev/yourdisk &

Then it will happen in the background and with low priority.  Of course,
you can't start filling your tmpfs until this completes.


I don't think tmpfs+swap was made with this sort of use in mind,
so you may want to test the performance when you fill up such a
tmpfs, and compare to the performance of /tmp on a 12GB
ordinary filesystem.  It seems to me that the advantage of /tmp on
tmpfs is lost completely if most of it has to be written to disk anyway.
(Ordinary filesystems are cached too, the "tmpfs advantage" is that
truly temporary (but possibly long-lived) files are never written
to disk _if_ you have enough memory.  /tmp on a plain filesystem
is just as fast due to caching, but may delay other use of the
disk as the ordinary filesystem writes stuff out so it will be
saved for the future.)

If you go for a plain filesystem, consider ext2 which is simple faster
than journalling systems like ext3.  You don't need the added
safety for temporary stuff.  Now ext2 have long fsck times if
something goes wrong, but you don't need to fsck this filesystem.
Have your bootscripts run mke2fs at boot instead of fsck for
this filesystem.  mke2fs on 12GB is fast, much faster than
7 minutes. Expect a few seconds only.

Helge Hafting
