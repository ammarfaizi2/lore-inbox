Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268246AbUHXT6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268246AbUHXT6D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 15:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268254AbUHXT6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 15:58:03 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:28921 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S268246AbUHXT5v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 15:57:51 -0400
Subject: Re: Fw: [PATCH][2/7] xattr consolidation - LSM hook changes
From: Steve French <smfltc@us.ibm.com>
To: agruen@suse.de
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <OF345C1231.77C9FF56-ON87256EFA.006BDEFF-86256EFA.006B8F02@us.ibm.com>
References: <OF345C1231.77C9FF56-ON87256EFA.006BDEFF-86256EFA.006B8F02@us.ibm.com>
Content-Type: text/plain
Organization: IBM
Message-Id: <1093377261.15535.35.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Aug 2004 14:54:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> On Tue, 2004-08-24 at 04:52, viro@parcelfarce.linux.theplanet.co.uk
> wrote:
> > On Mon, Aug 23, 2004 at 08:54:14PM -0400, James Morris wrote:
> > > On Mon, 23 Aug 2004, Stephen Smalley wrote:
> > > 
> > > > On Mon, 2004-08-23 at 15:03, Christoph Hellwig wrote:
> > > 
> > > > > Given that the actual methods take a dentry this sounds like a
> bad design.
> > > > > Can;t you just pass down the dentry through all of the ext2
> interfaces?
> > > > 
> > > > Changing the methods to take an inode would be even better,
> IMHO, as the
> > > > dentry is unnecessary.  That would simplify SELinux as well.
> > > 
> > > This could work for all in-tree filesystems with xattrs, except
> CIFS,
> > > which passes the dentry to it's own build_path_from_dentry()
> function.  
> > > 
> > > (In this case, they probably want to use d_path() and have a
> vfsmnt added 
> > > to the methods?).
> > 
> > No.  Think for a second and you'll see why - we are doing an
> operation that
> > by definition should not depend on where we have mounted the
> filesystem in
> > question.
> 
> Hm. I seem to recall that Al didn't want to change this within the 2.6
> series -- is this still the case? I would favor switching from
> dentries
> to inodes in the xattr iops. Steve, can you live with inodes?
> 
> Cheers,
> -- 
> Andreas Gruenbacher <agruen@suse.de>
> SUSE Labs, SUSE LINUX AG

CIFS (the network protcol) has no way to make network requests by inode
number.  In addition the cifs vfs generates inode numbers on the client
system since we can not trust that the ones returned by the server will
always be unique.   So while inode numbers might be unique on the local
client system they would not be much good on the server which may have
multiple mounts to other e.g. AFS or NFS servers (exported under a
single SMB/CIFS share (and there is no easy way to guarantee universal
unique inode numbers across a network with multiple servers in which
servers export directories that span across multiple server volumes). 
If the protocol were extended there might be a way to combine the
server's inode number with a volume UUID that could be used for inode #
based requests - if servers were upgraded to add such a feature.  In any
case for CIFS it is far easier for us to deal with the file name
(dentries) or an open file instance (file struct) as we do now. 

If the interface changes to passing in only the inodes, I would have to
either find an instance of an open file associated with the inode or
find a dentry associated with the inode in order to be able to build a
request to send to the server.  Dentries or open file instances are
easiest for CIFS.


