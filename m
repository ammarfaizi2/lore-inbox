Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318076AbSHZLtv>; Mon, 26 Aug 2002 07:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318079AbSHZLtv>; Mon, 26 Aug 2002 07:49:51 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:21006 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318076AbSHZLtv>; Mon, 26 Aug 2002 07:49:51 -0400
Date: Mon, 26 Aug 2002 12:54:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4-ac2
Message-ID: <20020826125406.A25513@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200208261035.g7QAZ4G19985@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208261035.g7QAZ4G19985@devserv.devel.redhat.com>; from alan@redhat.com on Mon, Aug 26, 2002 at 06:35:04AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 06:35:04AM -0400, Alan Cox wrote:
> o	Khttpd race fixes				(Dan Kegel)

This includes some wrong documentation updates:

+   kHTTPd is *not* currently compatible with tmpfs.  Trying to serve
+   files stored on a tmpfs partition is known to cause kernel oopses
+   as of 2.4.18.  This is due to the same problem that prevents sendfile()
+   from being usable with tmpfs.  A tmpfs patch is floating around that seems
+   to fix this, but has not been released as of 27 May 2002.
+   kHTTPD does work fine with ramfs, though.

This is _not_ a problem with tmpfs, but with khttpd.  The same problem
is also present with nay filesystem that uses the pagecache but not
generic_file_read or a non-trivial wrapper around generic_file_read, such
as smbfs, ncpff, nfs, (open-)gfs, or xfs.  This might not always mean
those filesystems don't work at all with khttpd, but at least it opens
race conditions.  khttpd uses do_generic_file_read directly instead of
using a file operation, and the problem is that do_generic_file_read
should never have been exported to allow such a layering violation.
sendfile() and the loop driver have the same issue. In 2.5 of those
only the loop issue is still existant, and I plan to fix that one and
make do_generic_file_read static.

+   There is debate about whether to remove kHTTPd from the main
+   kernel sources.  This will probably happen in the 2.5 kernel series,
+   after which khttpd will still be available as a patch.

khttpd is gone in 2.5

