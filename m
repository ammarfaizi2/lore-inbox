Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262557AbTCMTV1>; Thu, 13 Mar 2003 14:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262558AbTCMTV1>; Thu, 13 Mar 2003 14:21:27 -0500
Received: from packet.digeo.com ([12.110.80.53]:61142 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262557AbTCMTV0>;
	Thu, 13 Mar 2003 14:21:26 -0500
Date: Thu, 13 Mar 2003 11:32:09 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.64-mm6
Message-Id: <20030313113209.0be9f71c.akpm@digeo.com>
In-Reply-To: <p73n0jz4cdt.fsf@amdsimf.suse.de>
References: <20030313032615.7ca491d6.akpm@digeo.com.suse.lists.linux.kernel>
	<p73n0jz4cdt.fsf@amdsimf.suse.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Mar 2003 19:32:06.0884 (UTC) FILETIME=[3B966240:01C2E997]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> Andrew Morton <akpm@digeo.com> writes:
> 
> 
> >   This means that large cache-cold executables start significantly faster.
> >   Launching X11+KDE+mozilla goes from 23 seconds to 16.  Starting OpenOffice
> >   seems to be 2x to 3x faster, and starting Konqueror maybe 3x faster too. 
> >   Interesting.
> > 
> >   This might cause weird thing to happen, especially on small-memory machines.
> 
> That's great. It would be nice to have this as a sysctl or perhaps
> some heuristic based on file size and available memory for 2.6.
> 

We shouldn't be putting this in-kernel, really.  Userspace can obtain
the same results by running madvise(MADV_WILLNEED) against the mapping
immediately after setting it up.  So a simple

	map = mmap(...);
+	if (getenv("MAP_PREFAULT"))
+		madvise(map, len, MADV_WILLNEED);

in glibc is enough.

That will work on 2.4, too.  I haven't tested that though.

