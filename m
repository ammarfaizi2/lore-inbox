Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292705AbSCMISQ>; Wed, 13 Mar 2002 03:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292718AbSCMISG>; Wed, 13 Mar 2002 03:18:06 -0500
Received: from dsl-213-023-043-170.arcor-ip.net ([213.23.43.170]:50827 "EHLO
	starship") by vger.kernel.org with ESMTP id <S292705AbSCMIR4>;
	Wed, 13 Mar 2002 03:17:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, wli@holomorphy.com
Subject: Re: 2.4.19pre2aa1
Date: Wed, 13 Mar 2002 09:12:00 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>, wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
In-Reply-To: <20020312041958.C687@holomorphy.com> <20020312233117.E14628@holomorphy.com> <3C8E98B2.159FA546@zip.com.au>
In-Reply-To: <3C8E98B2.159FA546@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16l3rc-0000Cu-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 13, 2002 01:09 am, Andrew Morton wrote:
> Andrea introduced some subtly changed buffer locking rules, and
> this causes ext3 to deadlock under heavy load.  Until we sort
> this out, I'm afraid that the -aa VM is not suitable for production
> use with ext3.
> 
> ext2 is OK and I *assume* it's OK with reiserfs.  The problem occurs
> when a filesystem performs:
> 
> 	lock_buffer(dirty_bh);
> 	allocate_something(GFP_NOFS);
> 
> without having locked the buffer's page.  sync_page_buffers()
> can perform a wait_on_buffer() against dirty_bh.  (I think.
> I'm not quite up-to-speed with the new buffer state bits yet).

Note that this is a perfect example of the tangle-of-states problem we
discussed on IRC.  This problem comes up because of the uholy way in
which pages and buffers are tangled together (page->buffer->page...).
The solution imho is to get rid of buffer_heads and divide their
current functionality between struct page and struct bio.

Cleaning up the state mess is just one of the reasons for doing it, of
course, but it's not all that unimportant.

-- 
Daniel
