Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291812AbSBHVJF>; Fri, 8 Feb 2002 16:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291818AbSBHVI4>; Fri, 8 Feb 2002 16:08:56 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:15570 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S291813AbSBHVIo>; Fri, 8 Feb 2002 16:08:44 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200202082107.g18L7wx26206@eng2.beaverton.ibm.com>
Subject: Re: patch: aio + bio for raw io
To: bcrl@redhat.com (Benjamin LaHaise)
Date: Fri, 8 Feb 2002 13:07:58 -0800 (PST)
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20020208025313.A11893@redhat.com> from "Benjamin LaHaise" at Feb 08, 2002 01:53:13 AM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Quick message: this patch makes aio use bio directly for brw_kvec_async.  
> This is against yesterday's patchset.  Comments?
> 
> 		-ben

Hi Ben,

I am looking at the 2.5 patch you sent out. I have few questions/comments:

1) brw_kvec_async() does not seem to split IO at BIO_MAX_SIZE. I thought
   each bio can handle only BIO_MAX_SIZE (ll_rw_kio() is creating one bio
   for each BIO_MAX_SIZE IO). 

   And also, currently BIO_MAX_SIZE is only 64K. Infact, if I try to issue
   64K IO using submit_bio(), I get following BUG() on my QLOGIC controller.

	kernel BUG at ll_rw_blk.c:1336 

	Code is: BUG_ON(bio_sectors(bio) > q->max_sectors); 

        	bio_sectors(bio) is 128 
        	q->max_sectors is 64 (for QLOGIC ISP) 

   Is this going to be fixed ? Can "bio" should be able to handle any
   size IO ? Or we should issue create a new bio for each BIO_MAX_SIZE IO ?


2) Could you please make map_user_kvec() generic enough to handle mapping
   of mutliple iovecs to single kvec (to handle readv/writev). I think
   this is a very easy change:

	* Add alloc_kvec() and take out the kmalloc() from map_user_kvec().
	* Change map_user_kvec() to start mapping from kvec->veclet[kvec->nr]
      	  instead of kvec->veclet[0]

  This way allocation for kvec to hold all the iovecs can be done at higher
  level and map_user_kvec() can be called in a loop once for each iovec.

  Then we can add read/writev support for RAW IO very easily. I am looking
  at making use of kvec for RAW IO and also add support for readv/writev.
  (I already sent a patch to do this - but since you ported all your AIO
   work to 2.5, we can work on your infrastructure :)

Please let me know what you think.

Thanks,
Badari
