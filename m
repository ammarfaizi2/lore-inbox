Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbWECEKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWECEKt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 00:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbWECEKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 00:10:49 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:58271 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S965083AbWECEKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 00:10:48 -0400
Message-ID: <346629445.24665@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Wed, 3 May 2006 12:11:06 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060503041106.GC5915@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Badari Pulavarty <pbadari@us.ibm.com>
References: <346556235.24875@ustc.edu.cn> <Pine.LNX.4.64.0605020832570.4086@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605020832570.4086@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 08:55:06AM -0700, Linus Torvalds wrote:
> Doing prefetching on a physical block basis is simply not a valid 
> approach, for several reasons:

Sorry!
I made a misleading introduction. I'll try to explain it in more detail.

DATA ACQUISITION

/proc/filecache provides an interface to query the cached pages of any
file. This information is expressed in tuples of <idx, len>, which
more specifically means <mapping-offset, pages>.

Normally one should use 'echo' to setup two parameters before doing
'cat':
        @file
                the filename;
                use 'ALL' to get a list all files cached
        @mask
                only show the pages with non-zero (page-flags & @mask);
                for simplicity, use '0' to show all present pages(take 0 as ~0)

Normally, one should first get the file list using param 'file ALL',
and then iterate through all the files and pages of interested with
params 'file filename' and 'mask pagemask'.

The param 'mask' acts as a filter for different users: it allows
sysadms to know where his memory goes, and the prefetcher to ignore
pages from false readahead.

One can use 'mask hex(PG_active|PG_referenced|PG_mapped)' in its hex form
to show only accessed pages(here PG_mapped is a faked flag), and use
'mask hex(PG_dirty)' to show only dirtied pages.

One can use 
        $ echo "file /sbin/init" > /proc/filecache
        $ echo "mask 0" > /proc/filecache
        $ cat /proc/filecache
to get an idea which pages of /sbin/init are currently cached.

In the proposal, I used the following example, which is proved to be
rather misleading:
        $ echo "file /dev/hda1" > /proc/filecache
        $ cat /proc/filecache
The intention of that example was to show that filesystem dir/inode
buffer status -- which is the key data for user-land pre-caching --
can also be retrieved through this interface.

So the proposed solution is to
        - prefetch normal files on the virtual mapping level
        - prefetch fs dir/inode buffers on a physical block basis

I/O SUBMISSION
How can we avoid unnecessary seeks when prefetching on virtual mapping
level?  The answer is to leave this job to i/o elevators. What we
should do is to present elevators with most readahead requests before
too many requests being submitted to disk drivers.
The proposed scheme is to:
        1) (first things first)
           issue all readahead requests for filesystem buffers
        2) (in background, often blocked)
           issue all readahead requests for normal files
        -) make sure the above requests are of really _low_ priority
        3) regular system boot continues
        4) promote the priority of any request that is now demanded by
           legacy programs

In the scheme, most work is done by user-land tools. The required
kernel support is minimal and general-purpose:
        - an /proc/filecache interface
        - the ability to promote I/O priority on demanded pages

By this approach, we avoided the complicated OSX bootcache solution,
which is a physical-blocks-based, special-handlings-in-kernel solution
that is exactly what Linus is against.

Thanks,
Wu
