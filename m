Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTJPX6U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 19:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbTJPX6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 19:58:20 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:61190 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263258AbTJPX6R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 19:58:17 -0400
Date: Thu, 16 Oct 2003 16:58:11 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031016235811.GE29279@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <20031016230448.GA29279@pegasys.ws> <3F8F2A32.90101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8F2A32.90101@pobox.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This Outlook installation has been found to be susceptible to misuse.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 07:30:58PM -0400, Jeff Garzik wrote:
> jw schultz wrote:
> >Because each hash algorithm has different pathologies
> >multiple hashes are generally better than one but their
> >effective aggregate bit count is less than the sum of the
> >separate bit counts.
> 
> I was coming to this conclusion too...  still, it's safer simply to 
> handle collisions.

And because, in a filesystem, you have to handle collisions
you balance the cost of the hash quality against the cost of
collision.  A cheap hash with low colission rate is probably
better than an expensive hash with a near-zero colission
rate.

> 
> 
> >The idea of this sort of block level hashing to allow
> >sharing of identical blocks seems attractive but i wouldn't
> >trust any design that did not accept as given that there
> >would be false positives.  This means that a write would
> >have to not only hash the block but then if there is a
> >collision do a compare of the raw data.  Then you have to
> 
> yep
> 
> 
> >add the overhead of having lists of blocks that match a hash
> >value and reference counts for each block itself.  Further,
> >every block write would then need to include, at minimum,
> >relinking facilities on the hash lists and hash entry
> >allocations plus the inode block list being updated. Finally
> 
> Consider a simple key-value map, where "$hash $n" is the key and the 
> value is the block of data.  Only three operations need occur:
> * if hash exists (highly unlikely!), read and compare w/ raw data
> * write new block to disk
> * add single datum to key-value index

Nicely described, but each block now needs a reference count
which is incrmented if the raw compare yields a positive and
decremented when a reference to it receives a write.
It may help to also have a reverse reference somewhere
from the block to the hash.

More detail than this gets into writing pseudocode.

> Inode block lists would need to be updated regardless of any collision; 
> that would be a standard and required part of any VFS interaction. And 

Under current schemes if i overwrite an already allocated
block of a file the block list need not be updated unless
the block is relocated.  But that is a nit.

> the internal workings of the key-value index (think Berkeley DB) are 
> static, regardless of any collision.
> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
