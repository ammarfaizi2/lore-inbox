Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317544AbSGOR2g>; Mon, 15 Jul 2002 13:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317550AbSGOR2f>; Mon, 15 Jul 2002 13:28:35 -0400
Received: from 216-42-72-165.ppp.netsville.net ([216.42.72.165]:33623 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S317544AbSGOR2e>; Mon, 15 Jul 2002 13:28:34 -0400
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
From: Chris Mason <mason@suse.com>
To: "Patrick J. LoPresti" <patl@curl.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <s5gsn2lt3ro.fsf@egghead.curl.com>
References: <20020712162306$aa7d@traf.lcs.mit.edu> 
	<s5gsn2lt3ro.fsf@egghead.curl.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Jul 2002 13:31:49 -0400
Message-Id: <1026754309.4751.438.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-15 at 11:22, Patrick J. LoPresti wrote:
> Consider this argument:
> 
>   Given: On ext3, fsync() of any file on a partition commits all
>          outstanding transactions on that partition to the log.
> 
>   Given: data=ordered forces pending data writes for a file to happen
>          before related transactions are committed to the log.
> 
>   Therefore: With data=ordered, fsync() of any file on a partition
>              syncs the outstanding writes of EVERY file on that
>              partition.
> 
> Is this argument correct?  If so, it suggests that data=ordered is
> actually the *worst* possible journalling mode for a mail spool.
> 

Yes.  In practice this doesn't hurt as much as it could, because ext3
does a good job of letting more writers come in before forcing the
commit.  What hurts you is when a forced commit comes in the middle of
creating the file.  A data write that could have been contiguous gets
broken into two or more writes instead.

> One other thing.  I think this statement is misleading:
> 
>     IF your server is stable and not prone to crashing, and/or you
>     have the write cache on your hard drives battery backed, you
>     should strongly consider using the writeback journaling mode of
>     Ext3 versus ordered.
> 
> This makes it sound like data=writeback is somehow unsafe when
> machines crash.  I do not think this is true.  If your application
> (e.g., Postfix) is written correctly (which it is), so it calls
> fsync() when it is supposed to, then data=writeback is *exactly* as
> safe as any other journalling mode.  

Almost.  data=writeback makes it possible for the old contents of a
block to end up in a newly grown file.  There are a few ways this can
screw you up:

1) that newly grown file is someone's inbox, and the old contents of the
new block include someone else's private message.

2) That newly grown file is a control file for the application, and the
application expects it to contain valid data within (think sendmail).  

> "Battery backed caches" and the
> like have nothing to do with it.  

Nope, battery backed caches don't make data=writeback more or less safe
(with respect to the data anyway).  They do make data=ordered and
data=journal more safe.

> And if your application is written
> incorrectly, then other journalling modes will reduce but not
> eliminate the chances for things to break catastrophically on a crash.
> 
> So if the partition is dedicated to correct applications, like a mail
> spool is, then data=writeback is perfectly safe.  If it is faster,
> too, then it really is a no-brainer.

For mail servers, data=journal is your friend.  ext3 sometimes needs a
bigger log for it (reiserfs data=journal patches don't), but the
performance increase can be significant.

-chris


