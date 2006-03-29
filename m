Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWC2UOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWC2UOq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 15:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWC2UOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 15:14:46 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:10172 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751185AbWC2UOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 15:14:45 -0500
Date: Wed, 29 Mar 2006 14:14:53 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, phillip@hellewell.homeip.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mcthomps@us.ibm.com,
       yoder1@us.ibm.com, toml@us.ibm.com, emilyr@us.ibm.com,
       daw@cs.berkeley.edu, sfrench@us.ibm.com
Subject: Re: eCryptfs Design Document
Message-ID: <20060329201453.GA28743@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060324222517.GA13688@us.ibm.com> <20060324154920.11561533.akpm@osdl.org> <20060325001345.GC13688@us.ibm.com> <20060324163358.557ac5f7.akpm@osdl.org> <20060327233111.GH4541@us.ibm.com> <1143561657.3356.24.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143561657.3356.24.camel@orbit.scot.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 11:00:56AM -0500, Stephen C. Tweedie wrote:
> Sorry, but you have to deal with that anyway.  There is no guarantee
> that a page write is atomic.

Since this is the case, we really do not lose any guarantees by
allowing situations where eCryptfs does two page reads or writes on
the lower filesystem for one page read or write on the eCryptfs
filesystem. If we allow for this under some circumstances, I think we
have a good solution for the page alignment problem, balancing
correctness and performance needs. The idea is to make the common case
fast while making every case correct.

The first step will be to make eCryptfs operate on 4K-block chunks
rather than on PAGE_SIZE chunks. This should not be a very difficult
modification, and it will even result in faster performance on hosts
with page sizes over 4K, since unnecessary encryption and decryption
will be avoided. This is at least necessary to make eCryptfs files
movable between hosts with different page sizes at the moment.

Then, if the host has a page size of either 4K or 8K, we will make the
default header size 8K. This will cover, by default, all hosts where
the page size is either 4K or 8K (which is the vast majority); no page
straddling will occur, and so page reads and writes will be one-to-one
between the eCryptfs and the lower files. If the host's page size is
greater than 8K, then the header will, by default, occupy the host's
page size. This will take care of the page alignment problem for the
majority of the use case scenarios. The only time pages will not be
aligned is if a file is created on a host with a page size less than
or equal to 8K and then the file is transferred to a host with a page
size greater than 8K. In that case, two-to-one page reads and writes
will occur, causing a performance hit, but it will still work. In any
case, userspace tools can always convert the header to an appropriate
size for optimal performance if need be.

In future versions of eCryptfs, where the header data can span more
than 8K, then eCryptfs will spill over that header information onto
the end of the file, rewriting on truncate events, as previously
discussed in this thread. This will incur a performance hit on every
truncate event. Again, userspace tools (i.e., ecryptfstune) can resize
the header at the beginning of the file to store all of the data in
order to improve performance if need be. In any case, we anticipate
that header extent spill-over will be a rare event.

When HMAC support is enabled in future versions, the quantity of data
necessary to store the HMAC data may frequently be larger than 8K; we
can just make the header for HMAC-verified files something like 64K by
default then, and only very large files will require the header
information to spill over to the end of the file. The optimal header
size with HMAC turned on will need to be determined via analysis.

> Would it be possible simply to shift metadata to a subdir, so file
> foo has the header in .encfs/foo ?  That may be a performance cost
> you don't want to bear, especially for small files, of course.  If
> the header can be shrunk enough, xattrs might also be possible;
> although that has its own problems, such as compatibility with NFS
> etc.

Keeping the meta-data together with the data in the lower file has
always been a key feature of the eCryptfs filesystem. Divorcing the
crypto meta-data necessary to access the data for any given file
should be an absolute last resort. In any case, keeping groups of 4K
extents of header data in the front or on the end of the file does not
impose a significant degree of design or implementation complexity on
eCryptfs.

Thanks,
Mike
