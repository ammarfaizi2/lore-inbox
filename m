Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316664AbSFJFap>; Mon, 10 Jun 2002 01:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316672AbSFJFao>; Mon, 10 Jun 2002 01:30:44 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:21236 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316664AbSFJFan>; Mon, 10 Jun 2002 01:30:43 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Sun, 9 Jun 2002 23:28:07 -0600
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 54 missing null pointer checks in 2.4.17
Message-ID: <20020610052807.GB20388@turbolinux.com>
Mail-Followup-To: Dawson Engler <engler@csl.Stanford.EDU>,
	linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
In-Reply-To: <200206100355.UAA17040@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2002  20:55 -0700, Dawson Engler wrote:
> 2	|	/fs/dcache.c
> 1	|	/fs/sysctl.c
> 
> /u2/engler/mc/oses/linux/2.4.17/fs/intermezzo/dcache.c
> /u2/engler/mc/oses/linux/2.4.17/fs/intermezzo/sysctl.c

It looks like you are dropping part of the path out of the short list.
There is a file fs/dcache.c, but also fs/intermezzo/dcache.c where the
error is shown.  I have passed these errors on to the InterMezzo mailing
list.

> /u2/engler/mc/oses/linux/2.4.17/fs/jbd/journal.c
> 	 * Do we need to do a data copy?
> 	 */
> 
> 	if (need_copy_out && !done_copy_out) {
> 		char *tmp;
> Start --->
> 		tmp = jbd_rep_kmalloc(jh2bh(jh_in)->b_size, GFP_NOFS);
> 
> 		jh_in->b_frozen_data = tmp;
> Error --->
> 		memcpy (tmp, mapped_data, jh2bh(jh_in)->b_size);

Note that jbd_rep_kmalloc() is a special case, and will not currently
return NULL.  This macro calls  __jbd_rep_kmalloc(..., retry=1) which
means "repeat the allocation until it succeeds" so the code path
"if (!retry) return NULL" can never actually happen from this caller.
The logic is somewhat convoluted, so it is not surprising that the
checker didn't distinguish this case (it would have to have done the
"constant" evaluation to drop the NULL return path from the code).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

