Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263820AbUFNTgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbUFNTgR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 15:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbUFNTgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 15:36:17 -0400
Received: from salzburg.nitnet.com.br ([200.157.204.105]:13188 "EHLO
	nat.cesarb.net") by vger.kernel.org with ESMTP id S263820AbUFNTgJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 15:36:09 -0400
Date: Mon, 14 Jun 2004 16:34:44 -0300
To: David Lang <david.lang@digitalinsight.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] O_NOATIME support
Message-ID: <20040614193444.GC1961@flower.home.cesarb.net>
References: <20040612011129.GD1967@flower.home.cesarb.net> <20040614095529.GA11563@infradead.org> <20040614134652.GA1961@flower.home.cesarb.net> <Pine.LNX.4.60.0406140954210.30433@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0406140954210.30433@dlang.diginsite.com>
User-Agent: Mutt/1.5.6+20040523i
From: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 09:57:11AM -0700, David Lang wrote:
> On Mon, 14 Jun 2004, Cesar Eduardo Barros wrote:
> >On Mon, Jun 14, 2004 at 10:55:29AM +0100, Christoph Hellwig wrote:
> >>On Fri, Jun 11, 2004 at 10:11:29PM -0300, Cesar Eduardo Barros wrote:
> >>>(not subscribed to lkml, please CC: me on replies)
> >>>
> >>>This patch adds support for the O_NOATIME open flag (GNU extension):
> >>>
> >>>int O_NOATIME  	Macro
> >>>  If this bit is set, read will not update the access time of the file.
> >>>  See File Times. This is used by programs that do backups, so that
> >>>  backing a file up does not count as reading it. Only the owner of the
> >>>  file or the superuser may use this bit.
> >>>
> >>>It is useful if you want to do something with the file atime (for
> >>>instance, moving files that have not been accessed in a while to
> >>>somewhere else, or something like Debian's popularity-contest) but you
> >>>also want to read all files periodically (for instance, tripwire or
> >>>debsums).
> >>>
> >
> >Besides, O_NOATIME is most important not for the program that's moving
> >the files elsewhere, but for these checksum-the-world utilities that
> >read every single file they can see, and in the process manage to
> >destroy the usefulness of the atime, or backup programs that also read
> >everything they can touch. Both currently have to use utimes after
> >reading the whole file to restore the atime it had when they began
> >reading, which can take a long time if the file is huge (but note that
> >the mtime doesn't change since they are all reading, not writing).
> >
> >O_NOATIME would also be useful for things like tar --atime-preserve,
> >cpio --reset-access-time, star -atime, pax -t, and others.
> 
> This sounds like the same catagory of use that does a single pass through 
> the data and is destroying our memory useage. should this flag also imply 
> that the data gets thrown away immediatly after being freed by the 
> program?
> 
> that way you don't have to worry if the software reads the data once or 
> ten times, as long as it doesn't go back to it after it has freed it.

No, that would be surprising behaviour. O_NOATIME means the atime
shouldn't be changed -- no more, no less. Nothing prevents me from doing
complex read patterns on the file while using O_NOATIME (for instance,
if I know the internal format of the file, I might use a random access
pattern, read parts of the file more than once, or something like that).

If you want drop-behind, you should be able to say it explicitly (and in
fact most people would probably want it but not O_NOATIME -- for
instance, a media player, after reading the headers, reads the file
mostly in sequence). I believe that would work better as a fcntl (since
you would want to read the headers before setting it to sequential).

-- 
Cesar Eduardo Barros
cesarb@nitnet.com.br
cesarb@dcc.ufrj.br
