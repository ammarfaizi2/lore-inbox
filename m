Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVC0EFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVC0EFZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 23:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVC0EFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 23:05:25 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:33494 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261415AbVC0EFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 23:05:19 -0500
Date: Sat, 26 Mar 2005 23:05:18 -0500
To: linux-kernel@vger.kernel.org
Cc: Jesper Juhl <juhl-lkml@dif.dk>, "H. Peter Anvin" <hpa@zytor.com>,
       Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Squashfs without ./..
Message-ID: <20050327040518.GA12072@delft.aura.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jesper Juhl <juhl-lkml@dif.dk>, "H. Peter Anvin" <hpa@zytor.com>,
	Kyle Moffett <mrmacman_g4@mac.com>
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr> <20050323174925.GA3272@zero> <Pine.LNX.4.62.0503241855350.18295@numbat.sonytel.be> <20050324133628.196a4c41.Tommy.Reynolds@MegaCoder.com> <d1v67l$4dv$1@terminus.zytor.com> <3e74c9409b6e383b7b398fe919418d54@mac.com> <424324E4.9000003@zytor.com> <Pine.LNX.4.62.0503251444060.2498@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503251444060.2498@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.6+20040907i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 02:59:14PM +0100, Jesper Juhl wrote:
> On Thu, 24 Mar 2005, H. Peter Anvin wrote:
> > Note that Linux always accepts . and .. so it's just a matter of making them
> > appear in readdir.
> > 
> I'm working on that, but it's a learning experience for me, so it's going 
> a bit slow - but I'll get there.

Check the top of coda_venus_readdir in fs/coda/dir.c.

Coda's directories internally don't have the '.' and '..' as the first
two entries. In general it works just fine, I think there was one
application where it was causing a problem so now we use 'f_pos == 0'
and 'f_pos == 1' to spit out those entries based on dcache data.
f_pos >= 2 goes through the normal directory, but we skip the
out-of-order '.' and '..' entries.

Btw. the '.' and '..' entries are used by applications that are linked
against libc5 for the getpwd() implementation. I guess it was the only
way to get path information before the introduction of the dcache.

Oh, and the find -noleaf thing, a workaround for filesystems that don't
count subdirectories is to set the directory linkcount to 1 instead of
2 + number of subdirs. The find optimization then subtracts 2, and as a
result thinks there are (unsigned)-1 aka. UINT_MAX subdirectories and
find will end up calling stat() on every directory entry.

Jan

