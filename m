Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265056AbTLKTri (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 14:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265221AbTLKTri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 14:47:38 -0500
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:22262 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S265056AbTLKTrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 14:47:36 -0500
Date: Thu, 11 Dec 2003 12:43:12 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Hua Zhong <hzhong@cisco.com>
Cc: "'Andy Isaacson'" <adi@hexapodia.org>, linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031211124312.E27396@schatzie.adilger.int>
Mail-Followup-To: Hua Zhong <hzhong@cisco.com>,
	'Andy Isaacson' <adi@hexapodia.org>, linux-kernel@vger.kernel.org
References: <20031211125806.B2422@hexapodia.org> <017c01c3c01b$232bd130$d43147ab@amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <017c01c3c01b$232bd130$d43147ab@amer.cisco.com>; from hzhong@cisco.com on Thu, Dec 11, 2003 at 11:15:28AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 11, 2003  11:15 -0800, Hua Zhong wrote:
> > The abstract interface for make_hole() is simple, but it turns into a
> > pretty expensive filesystem operation, I think.  After many cycles of
> > free/allocate, your file would be badly fragmented across the
> > filesystem.  
> 
> Understood. Two filesystems we are using: tmpfs and ext3. For the
> former, fragmentation doesn't matter.
> 
> Hey, I think when I get some cycles I can try to implement this for
> tmpfs (since it's simpler) myself, and post a patch. :-) But before
> that, I want to make sure it's doable.

At distant times in the past (i.e. 2.2 days), we had implemented a "punch"
syscall which did what you wanted for ext3.  I've looked at this for 2.4
at least, and it should be relatively straightforward to implement vmpunch
from vmtruncate, since most of the VM routines that vmtruncate calls
allow both a start and end parameter.  For tmpfs that should be enough.
Then, vmtruncate could just be a special case of vmpunch which punches
from start = i_size to end = -1ULL.

Presumably, if a filesystem didn't support a punch filesystem method
(either because it is unimplemented or because the filesystem doesn't
support holes) it would be implemented as either a truncate (if end is
beyond i_size) or a series of zero writes instead.

At some point we may want to update punch for ext3 again, because it is
useful for various things (e.g. cache or heirarchical filesystems, etc).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

