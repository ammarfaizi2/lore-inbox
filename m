Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbVKOLPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbVKOLPf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 06:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbVKOLPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 06:15:35 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:43976 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751424AbVKOLPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 06:15:35 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 15 Nov 2005 11:15:25 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: NeilBrown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH ] Fix some problems with truncate and mtime semantics.
In-Reply-To: <1132020190.8802.28.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.64.0511151108340.14874@hermes-1.csi.cam.ac.uk>
References: <20051115125657.9403.patches@notabene>  <1051115020002.9459@suse.de>
 <1132020190.8802.28.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2005, Trond Myklebust wrote:
> On Tue, 2005-11-15 at 13:00 +1100, NeilBrown wrote:
> > Resubmitting this patch to fix truncate/mtime semantics.  
> > 
> > It is against 2.6.14-mm2 and is probably suitable for 2.6.15, but can
> > be held over to 2.6.16 if you are feeling cautious.
> > 
> > NeilBrown
> > 
> > ### Comments for Changeset
> > 
> > SUS requires that when truncating a file to the size that it currently
> > is:
> >   truncate and ftruncate should NOT modify ctime or mtime
> >   O_EXCL SHOULD modify ctime and mtime.
>     ^^^^^ O_CREAT ;-)

O_TRUNC actually ;-)  See:

	http://www.opengroup.org/onlinepubs/009695399/functions/open.html

<quote>
If O_CREAT is set and the file did not previously exist, upon successful 
completion, open() shall mark for update the st_atime, st_ctime, and 
st_mtime fields of the file and the st_ctime and st_mtime fields of the 
parent directory.

If O_TRUNC is set and the file did previously exist, upon successful 
completion, open() shall mark for update the st_ctime and st_mtime fields 
of the file.
</quote>

Given we are talking about truncate, we only care about O_TRUNC.  
O_CREAT/O_EXCL of course set A/C/M time as the file is newly created and 
hence all three values are set to the current system time!

> > Currently mtime and ctime are always modified on most local
> > filesystems (side effect of ->truncate) or never modified (on NFS).
> > 
> > With this patch:
> >   ATTR_CTIME|ATTR_MTIME are sent with ATTR_SIZE precisely when 
> >     an update of these times is required whether size changes or not 
> >     (via a new argument to do_truncate).  This allows NFS to do
> >     the right thing for O_EXCL.
>                           ^^^^^

O_TRUNC...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
