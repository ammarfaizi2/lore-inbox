Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129790AbRAZTIU>; Fri, 26 Jan 2001 14:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129982AbRAZTIK>; Fri, 26 Jan 2001 14:08:10 -0500
Received: from hermes.mixx.net ([212.84.196.2]:8197 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129790AbRAZTIG>;
	Fri, 26 Jan 2001 14:08:06 -0500
Message-ID: <3A71CA8D.A50B70E0@innominate.de>
Date: Fri, 26 Jan 2001 20:05:49 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: inode->i_dirty_buffers redundant ?
In-Reply-To: <200101251047.QAA16434@vxindia.veritas.com> <20010125164432.A12984@redhat.com> <3A708722.C21EC12A@innominate.de> <20010126113507.J11607@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
> Hi,
> 
> On Thu, Jan 25, 2001 at 09:05:54PM +0100, Daniel Phillips wrote:
> > "Stephen C. Tweedie" wrote:
> > > We also maintain the
> > > per-page buffer lists as caches of the virtual-to-physical mapping to
> > > avoid redundant bmap()ping.
> >
> > Could you clarify that one, please?
> 
> The buffer contains a physical label for the block's location on disk.
> The page cache is indexed purely by logical location, so doing IO
> to/from the page cache requires us to lookup the physical locations of
> each block within the page.
> 
> Caching the buffer_heads for page cache pages means that once those
> lookups are done once, further IO on the same page can bypass the
> lookup and go straight to disk.

OK, this was just a terminology problem - I normally say 'filesystem
block' or just 'block' where you said 'physical', and if you say
'physical' to me, I'll hear 'physical memory address' :-/  I was also
confused by 'bmap', which to me means the bad old way of
generic_reading, and to you means 'mapping a buffer to a disk
location'.  Um.  Which I would express as 'mapping a buffer to a block'.

Leaving that confusing behind, I am now working out an approach to
mapping an inode's index blocks into the page cache.  Probably, I am
reinventing the wheel, but here it is.  I plan to create another
address_space mapping in the inode's ext2-private area, called
i_index_mapping.  This maps all possible index blocks onto the
i_index_mapping, IOW, for each possible data block we can directly
compute the index into the i_index_mapping at which we will search for
the datablock's parent index block.  Normally we will find the index
block there (because it was read recently) and not have to search down
through its parents as we must with the buffer cache approach.  Perhaps
then the inode->dirty_buffers list can go away.

Obviously the impact on ext2_get_block is fairly major, but I think the
end result will be simpler than what we have now.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
