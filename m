Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUD2Cl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUD2Cl4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 22:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbUD2Cl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 22:41:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:30388 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262450AbUD2Clw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 22:41:52 -0400
Date: Wed, 28 Apr 2004 19:40:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: paulus@samba.org, brettspamacct@fastclick.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040428194039.4b1f5d40.akpm@osdl.org>
In-Reply-To: <20040428185342.0f61ed48.akpm@osdl.org>
References: <409021D3.4060305@fastclick.com>
	<20040428170106.122fd94e.akpm@osdl.org>
	<409047E6.5000505@pobox.com>
	<40905127.3000001@fastclick.com>
	<20040428180038.73a38683.akpm@osdl.org>
	<16528.23219.17557.608276@cargo.ozlabs.ibm.com>
	<20040428185342.0f61ed48.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Paul Mackerras <paulus@samba.org> wrote:
>  >
> ...
>  > What I have noticed with 2.6.6-rc1 on my dual G5 is that if I rsync a
>  > gigabyte or so of data over to another machine, it then takes several
>  > seconds to change focus from one window to another.  I can see it
>  > slowly redraw the window title bars.  It looks like the window manager
>  > is getting swapped/paged out.
>  > 
>  > This machine has 2.5GB of ram, so I really don't see why it would need
>  > to swap at all.  There should be plenty of page cache pages that are
>  > clean and not in use by any process that could be discarded.  It seems
>  > like as soon as there is any memory shortage at all it picks on the
>  > window manager and chucks out all its pages. :(
>  > 
> 
>  I suspect rsync is taking two passes across the source files for its
>  checksumming thing.  If so, this will defeat the pagecache use-once logic. 
>  The kernel sees the second touch of the pages and assumes that there will
>  be a third touch.

OK, a bit of fiddling does indicate that if a file is present on both
client and server, and is modified on the client, the rsync client will
indeed touch the pagecache pages twice.  Does this describe the files which
you're copying at all?

One thing you could do is to run `watch -n1 cat /proc/meminfo'.  Cause lots
of memory to be freed up then do the copy.  Monitor the size of the active
and inactive lists.  If the active list is growing then we know that rsync
is touching pages twice.

That would be an unfortunate special-case.
