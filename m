Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319322AbSHVLX7>; Thu, 22 Aug 2002 07:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319323AbSHVLX7>; Thu, 22 Aug 2002 07:23:59 -0400
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:10644 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S319322AbSHVLX6>; Thu, 22 Aug 2002 07:23:58 -0400
Message-ID: <20020822112806.28099.qmail@thales.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Thu, 22 Aug 2002 13:28:05 +0200
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: MM patches against 2.5.31
References: <3D644C70.6D100EA5@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D644C70.6D100EA5@zip.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2002 at 07:29:04PM -0700, Andrew Morton wrote:
> 
> I've uploaded a rollup of pending fixes and feature work
> against 2.5.31 to
> 
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.31/2.5.31-mm1/
> 
> The rolled up patch there is suitable for ongoing testing and
> development.  The individual patches are in the broken-out/
> directory and should all be documented.

Sorry, but we still have the page release race in multiple places.
Look at the following (page starts with page_count == 1):

Processor 1                          Processor 2
refill_inactive: lines 378-395
   as page count == 1 we'll
   continue with line 401

                                     __pagevec_release: line 138
				       calls release_pages
				     release_pages: line 100-111
				       put_page_test_zero brings the
				       page count to 0 and we'll continue
				       at line 114. Note that this may
				       happen while another processor holds
				       the lru lock, i.e. there is no
				       point in checking for page count == 0
				       with the lru lock held because
				       the lru lock doesn't protect against
				       decrements of page count after
				       the check.
  line 401: page_cache_get
  resurrects the page, page
  count is now 1.
  lines 402-448.
  line 448 calls __pagevec_release

__pagevec_release: line 138
  calls release_pages
release_pages: lines 100-111
  put_page_test_zero brings the
  page count back to 0 (!!!)
  i.e. we continue at line 114:

  lines 114-123.
  The page count == 0 check in line
  123 is successful and the page
  is returned to the buddy allocator
  
				       lines 114-123.
				       The page count == 0 check in line
				       123 is successful, i.e. the page
				       is returned to the buddy allocator
				       a second time. ===> BOOM


Neither the lru lock nor any of the page count == 0 checks can
prevent this from happening.

    regards   Christian

-- 
THAT'S ALL FOLKS!
