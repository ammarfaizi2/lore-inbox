Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263232AbTJPXE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 19:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTJPXE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 19:04:57 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:56070 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263232AbTJPXEw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 19:04:52 -0400
Date: Thu, 16 Oct 2003 16:04:48 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031016230448.GA29279@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031016174927.GB25836@speare5-1-14>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This Outlook installation has been found to be susceptible to misuse.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 11:49:27AM -0600, Val Henson wrote:
> On Thu, Oct 16, 2003 at 10:29:30AM -0700, Larry McVoy wrote:
> > On Wed, Oct 15, 2003 at 11:13:27AM -0400, Jeff Garzik wrote:
> > > Josh and others should take a look at Plan9's venti file storage method 
> > > -- archival storage is a series of unordered blocks, all of which are 
> > > indexed by the sha1 hash of their contents.  This magically coalesces 
> > > all duplicate blocks by its very nature, including the loooooong runs of 
> > > zeroes that you'll find in many filesystems.  I bet savings on "all 
> > > bytes in this block are zero" are worth a bunch right there.
> > 
> > The only problem with this is that you can get false positives.  Val Hensen
> > recently wrote a paper about this.  It's really unlikely that you get false
> > positives but it can happen and it has happened in the field.  
> 
> To be fair, I talked to someone who claims that Venti now checks for
> hash collisions on writes, but that's not what the original paper
> describes and I haven't confirmed it.
> 
> The compare-by-hash paper is only 6 pages long, at least take the time
> to read it before you start using compare-by-hash:
> 
> http://www.usenix.org/events/hotos03/tech/henson.html
> 
> Abstract:
> 
>  "Recent research has produced a new and perhaps dangerous technique
>   for uniquely identifying blocks that I will call
>   compare-by-hash. Using this technique, we decide whether two blocks
>   are identical to each other by comparing their hash values, using a
>   collision-resistant hash such as SHA-1. If the hash values match,
>   we assume the blocks are identical without further ado. Users of
>   compare-by-hash argue that this assumption is warranted because the
>   chance of a hash collision between any two randomly generated blocks
>   is estimated to be many orders of magnitude smaller than the chance
>   of many kinds of hardware errors. Further analysis shows that this
>   approach is not as risk-free as it seems at first glance."
> 
> -VAL (not subscribed to l-k ATM)

Several months ago we encountered the hash collision problem
with rsync.  This brought about a fair amount of discussion
regarding the likelihood of false positives with the result
of some code changes.  I am not educationally equipped to
offer mathematical proofs myself but i can highlight the
salient points.  If you wish more detail you can look it up
in the list archives.

1.  Internal collision: The smaller the hash size to data
    size ratio the greater the likelihood of false
    positives.  A poor quality hash adversely affects this
    but no matter how good the hash is it remains true.

2.  External collision: The smaller hash size to unit count
    ratio the greater liklihood of false positives.  To put
    it in the extreme: if you have 10,000 blocks you are
    almost guaranteed to get false positives on a 16 bit
    hash.  This is similar to filling the namespace.  It is
    external collision that was killing rsync on iso images.

Because each hash algorithm has different pathologies
multiple hashes are generally better than one but their
effective aggregate bit count is less than the sum of the
separate bit counts.

The idea of this sort of block level hashing to allow
sharing of identical blocks seems attractive but i wouldn't
trust any design that did not accept as given that there
would be false positives.  This means that a write would
have to not only hash the block but then if there is a
collision do a compare of the raw data.  Then you have to
add the overhead of having lists of blocks that match a hash
value and reference counts for each block itself.  Further,
every block write would then need to include, at minimum,
relinking facilities on the hash lists and hash entry
allocations plus the inode block list being updated. Finally
in the case of COW due to refcount!=0 you would have to do a
block allocation, even when simply overwriting which could
cause ENOSPACE when an application was simply rewriting an
already allocated block or inside mmap.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
