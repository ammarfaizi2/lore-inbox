Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274033AbRISQTe>; Wed, 19 Sep 2001 12:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274056AbRISQTZ>; Wed, 19 Sep 2001 12:19:25 -0400
Received: from geos.coastside.net ([207.213.212.4]:9413 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S274033AbRISQTO>; Wed, 19 Sep 2001 12:19:14 -0400
Mime-Version: 1.0
Message-Id: <p05100307b7ce752abd7c@[207.213.214.37]>
In-Reply-To: <20010919155332.A980@mindsw.com>
In-Reply-To: <20010919155332.A980@mindsw.com>
Date: Wed, 19 Sep 2001 09:19:25 -0700
To: Sandip Bhattacharya <sandip@webyarn.com>, linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: procfs feature or bug?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:53 PM +0530 2001-09-19, Sandip Bhattacharya wrote:
>I was trying out the multipage procfs entries, when i found out that i
>was having a problem. 
>
>I am trying to use the "hack" by Paul Russell to allow mangling of
>filepos using ``*start'' entries as my personal page offset. Now, for
>multipage entries, whatever i set as *start should be coming back to
>me as offset when the next page is called.
>
>But in fs/proc/generic.c in proc_file_read() at the end we have (
>after the first page has been "copied_to_user")
>
>  *ppos += start < page ? (long) start : n;
>
>But this _adds_ the contents of start to the offset, in the case where
>I am supplying the offset in ``start''. Shouldn't this just be
>_replacing_ ? 'Cause in this case the offsets get cumulatively added,
>causing an oops at the end for me :(
>
>Or am I missing something big???

Per the comment:

>		/* This is a hack to allow mangling of file pos independent
>  		 * of actual bytes read.  Simply place the data at page,
>  		 * return the bytes, and set `start' to the desired offset
>  		 * as an unsigned int. - Paul.Russell@rustcorp.com.au
>		*/

*ppos represents the offset in the *file*, not the buffer, so 
cumulative is correct. So when you do your read, you need to 
interpret it thus. I've been using it in one case as a record number, 
where the records are variable length. I set *start to 1, and treat 
is as an index into a (virtual) array of records.
-- 
/Jonathan Lundell.
