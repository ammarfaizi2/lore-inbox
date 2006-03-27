Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWC0XbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWC0XbL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 18:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWC0XbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 18:31:11 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:15567 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750825AbWC0XbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 18:31:10 -0500
Date: Mon, 27 Mar 2006 17:31:11 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: phillip@hellewell.homeip.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mcthomps@us.ibm.com, yoder1@us.ibm.com, toml@us.ibm.com,
       emilyr@us.ibm.com, daw@cs.berkeley.edu, sfrench@us.ibm.com,
       sct@redhat.com
Subject: Re: eCryptfs Design Document
Message-ID: <20060327233111.GH4541@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060324222517.GA13688@us.ibm.com> <20060324154920.11561533.akpm@osdl.org> <20060325001345.GC13688@us.ibm.com> <20060324163358.557ac5f7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324163358.557ac5f7.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 04:33:58PM -0800, Andrew Morton wrote:
> I think it would be acceptable to design ecryptfs to assume that its
> underlying store has a 4096-byte "blocksize".  So all the crypto
> operates on 4096-byte hunks and the header is 4096-bytes long and
> things are copied to and from the underlying fs's pagecache in
> 4096-byte hunks.
> 
> That's because 4096 is, for practical purposes, the minimum Linux
> PAGE_CACHE_SIZE.  Globally available and all filesystems support it.

So let's say that locking eCryptfs files to only be accessible on
machines with the same page size as the machine on which the files
were created is unacceptable. eCryptfs will have to be modified a bit
to accommodate that. Now we have several issues to consider. My team
has discussed several potential solutions, but I would like to lay it
all out on the table to see if anyone out there has any suggestions on
how to proceed.

eCryptfs currently keeps the header information in the first page of
the file. This will not work when moving from a host with a page size
of 4K to a host with a page size of 8K (or vice versa). We will be
changing that so that eCryptfs works on extent-based regions of 4096
bytes, as Andrew Morton suggested.

In the current release, eCryptfs writes the header in the first page
of the file (which will soon be changed to the first 4k extent of the
file). This is nice because the header only needs to be generated and
written once (at file creation), and then it can be left alone from
that point forward.

In the current release, changing eCryptfs to operate in terms of
fixed-size (4096-byte) extents will cause page reads and writes in
eCryptfs to ``straddle'' pages in the lower filesystem if the first
extent contains the header. Consider 8K page sizes:

eCryptfs (unencrypted view):
+----------+----------+----------+----------+----------
| EXTENT_0 | EXTENT_1 | EXTENT_2 | EXTENT_3 |   ...    
+----------+----------+----------+----------+----------
|       PAGE_0        |       PAGE_1        |   ...
+---------------------+---------------------+----------

Lower (encrypted form):
+----------+----------+----------+----------+----------
|  HEADER  | EXTENT_0 | EXTENT_1 | EXTENT_2 |   ...    
+----------+----------+----------+----------+----------
|       PAGE_0        |       PAGE_1        |   ...    
+---------------------+---------------------+----------

So, to read or write page 0 via eCryptfs, eCryptfs will have to read
or write extents 0 and 1, which will require accessing both page 0 and
page 1 in the lower filesystem. I do not think that this will be
acceptable in terms of performance, nor will it maintain the pattern
of one page operation in eCryptfs correlating with exactly one page
operation in the lower filesystem. For instance, if eCryptfs writes
page 0 out to disk, and then a crash occurs, then the data will be
left in an inconsistent state.

To achieve page alignment, one solution is to make the header consume
as many extents as will occupy some notion of a ``largest supported
page size.'' If we arbitrarily set that at, say, 64k, then every file
in eCryptfs on a system with a page size of 4k will automatically
consume at least 68k of space (64k header + 4k page), and eCryptfs
still will have to straddle pages for systems with 128k or 256k page
sizes (how may systems out there have page sizes >64k?).

Another solution is to write the ``header'' at the tail 4k of the
file. Then we have to abandon the benefit of having an ``untouchable''
first 4k region of the lower file. Seeks past the end of the file to
truncate to a larger size or to append data will blow away the header
extent, and it will have to be re-written. When should that happen? On
each and every truncate? When the file is closed? If we choose the
latter, then it is easy to lose your file forever if there is a system
crash before the file is closed and the header can be re-written to
its new location.

To complicate matters, in future versions, the header will need to
take multiple extents, and so we have always been planning on
eventually appending some header information at the end of the file
anyway; it looks like we are having to confront some of the issues
involved in doing that right now. In later versions, the header will
contain multiple passphrase and public key packets, along with HMAC
values. The header will need to grow to consume an arbitrary number of
extents, depending on the file size and the number of authentication
token packets. 

To guarantee that the header is always present in the file, when the
eCryptfs function ecryptfs_truncate() is called, it could add on as
many additional pages to the lower file as are necessary to write the
header and then write the header out prior to returning. The overhead
in maintaining several 4k header extents at the end of the file would
be substantial (e.g., for a log file that is constantly being
appended). Plus, if the header spans more than one page, then there
are additional steps necessary to maintain consistency in the event of
an incomplete header write operation (i.e., maintain a temporary
pointer to the prior header location until the header is completely
written out to the new location).

Another idea that we have kicked around involves keeping an eCryptfs
journal file. In this case, the header can be overwritten in the lower
file for a while before it is re-written, but all of the information
necessary to generate that header always exists in a hidden journal
file. If there is a system crash, on the next mount, ecryptfsck will
check the journal file to determine that the header needs to be
written out to the file, and then it can repair the file. Journaling
functionality is something that we gauge to be a fairly large
development effort, and we feel it really should be slated for a
future release (>0.2) of eCryptfs.

So we have several ways to proceed at this point, but before we run
off and implement one of them, does anyone else out there have any
insights?

Thanks,
Mike
