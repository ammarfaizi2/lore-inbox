Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129703AbRAQTyC>; Wed, 17 Jan 2001 14:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130036AbRAQTxw>; Wed, 17 Jan 2001 14:53:52 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:30981 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129703AbRAQTxm>; Wed, 17 Jan 2001 14:53:42 -0500
Date: Wed, 17 Jan 2001 14:57:26 -0500
From: Chris Mason <mason@suse.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: set_page_dirty/page_launder deadlock
Message-ID: <31670000.979761446@tiny>
In-Reply-To: <Pine.LNX.4.10.10101141054530.4086-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sunday, January 14, 2001 10:56:10 AM -0800 Linus Torvalds
<torvalds@transmeta.com> wrote:

>> Marcelo Tosatti writes:
>>  > 
>>  > While taking a look at page_launder()...
>> 
>>  ...
>> 
>>  > set_page_dirty() may lock the pagecache_lock which means potential
>>  > deadlock since we have the pagemap_lru_lock locked.
>> 
> 
> Well, as the new shm code doesn't return 1 any more, the whole locked page
> handling should just be deleted. ramfs always just re-marked the page
> dirty in its own "writepage()" function, so it was only shmfs that ever
> returned this special case, and because of other issues it already got
> excised by Christoph..
> 

Then I'm confused by the code in 2.4.1pre8:

-chris

/*
 * Move the page from the page cache to the swap cache
 */
static int shmem_writepage(struct page * page)
{
	int error;
	struct shmem_inode_info *info;
	swp_entry_t *entry, swap;

	info = &page->mapping->host->u.shmem_i;
	if (info->locked)
		return 1;
	swap = __get_swap_page(2);
	if (!swap.val)
		return 1;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
