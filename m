Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291845AbSBHVWJ>; Fri, 8 Feb 2002 16:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291844AbSBHVUc>; Fri, 8 Feb 2002 16:20:32 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:14809 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S291845AbSBHVTb>;
	Fri, 8 Feb 2002 16:19:31 -0500
Message-Id: <m16ZIPF-000OVeC@amadeus.home.nl>
Date: Fri, 8 Feb 2002 21:18:05 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: pbadari@us.ibm.com (Badari Pulavarty)
Subject: Re: patch: aio + bio for raw io
cc: linux-kernel@vger.kernel.org
In-Reply-To: <200202082107.g18L7wx26206@eng2.beaverton.ibm.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200202082107.g18L7wx26206@eng2.beaverton.ibm.com> you wrote:

> 1) brw_kvec_async() does not seem to split IO at BIO_MAX_SIZE. I thought
>   each bio can handle only BIO_MAX_SIZE (ll_rw_kio() is creating one bio
>   for each BIO_MAX_SIZE IO). 

>   And also, currently BIO_MAX_SIZE is only 64K. Infact, if I try to issue
>   64K IO using submit_bio(), I get following BUG() on my QLOGIC controller.

>        kernel BUG at ll_rw_blk.c:1336 

>        Code is: BUG_ON(bio_sectors(bio) > q->max_sectors); 

>                bio_sectors(bio) is 128 
>                q->max_sectors is 64 (for QLOGIC ISP) 

this is a bio bug. BIO should split if needed.
(Oh and qlogic hw can easily handle 1024 sector-sized requests)



> 2) Could you please make map_user_kvec() generic enough to handle mapping
>   of mutliple iovecs to single kvec (to handle readv/writev).

I think the "move all readv/writev to one single kvec" is a mistake. The
OPPOSITE should happen. If you submit a huge single vector it should be
split up internally. This would also be the fix for the "submit the entire
vector so far and sync wait on it after 512Kb" performance bug in the normal
rawio code, since it can just submit partial (say 256Kb sized) vectors and
wait for ANY one of them before going over a 512Kb boundary.

Sure readv/writev are not optimal now. but that is because the kernel waits for
IO complete per vector element instead of submitting them all async and
waiting at the end (or in the aio case, not wait at all).

Gretings,
  Arjan van de Ven.
