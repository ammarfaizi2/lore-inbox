Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbVDFKCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVDFKCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 06:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVDFKCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 06:02:06 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:53944 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S262156AbVDFKB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 06:01:58 -0400
Message-Id: <6.0.0.20.2.20050406163929.06ef07b0@mailsv2.y.ecl.ntt.co.jp>
X-Mailer: QUALCOMM Windows Eudora Version 6J-Jr3
Date: Wed, 06 Apr 2005 19:01:18 +0900
To: "Stephen C. Tweedie" <sct@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
From: Hifumi Hisashi <hifumi.hisashi@lab.ntt.co.jp>
Subject: Re: Linux 2.4.30-rc3 md/ext3 problems (ext3 gurus : please
  check)
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       vherva@viasys.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1112740856.4148.145.camel@sisko.sctweedie.blueyonder.co.uk
 >
References: <20050326162801.GA20729@logos.cnet>
 <20050328073405.GQ16169@viasys.com>
 <20050328165501.GR16169@viasys.com>
 <16968.40186.628410.152511@cse.unsw.edu.au>
 <20050329215207.GE5018@logos.cnet>
 <16970.9679.874919.876412@cse.unsw.edu.au>
 <20050330115946.GA7331@logos.cnet>
 <1112740856.4148.145.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

At 07:40 05/04/06, Stephen C. Tweedie wrote:
 >Sorry, was offline for a week last week; I'll try to look at this more
 >closely tomorrow.  Checking the buffer_uptodate() without either a
 >refcount or a lock certainly looks unsafe at first glance.
 >
 >There are lots of ways to pin the bh in that particular bit of the
 >code.  The important thing will be to do so without causing leaks if
 >we're truly finished with the buffer after this flush.
 >

I have measured the bh refcount before the buffer_uptodate() for a few days.
I found out that the bh refcount sometimes reached to 0 .
So, I think following modifications are effective.

diff -Nru 2.4.30-rc3/fs/jbd/commit.c 2.4.30-rc3_patch/fs/jbd/commit.c
--- 2.4.30-rc3/fs/jbd/commit.c	2005-04-06 17:14:47.000000000 +0900
+++ 2.4.30-rc3_patch/fs/jbd/commit.c	2005-04-06 17:18:49.000000000 +0900
@@ -295,6 +295,7 @@
  		struct buffer_head *bh;
  		jh = jh->b_tprev;	/* Wait on the last written */
  		bh = jh2bh(jh);
+		get_bh(bh);
  		if (buffer_locked(bh)) {
  			spin_unlock(&journal_datalist_lock);
  			unlock_journal(journal);
@@ -302,11 +303,14 @@
  			if (unlikely(!buffer_uptodate(bh)))
  				err = -EIO;
  			/* the journal_head may have been removed now */
+			put_bh(bh);
  			lock_journal(journal);
  			goto write_out_data;
  		} else if (buffer_dirty(bh)) {
+			put_bh(bh);
  			goto write_out_data_locked;
  		}
+		put_bh(bh);
  	} while (jh != commit_transaction->t_sync_datalist);
  	goto write_out_data_locked;



 >
 >> > If some of the write succeeded and some failed, then I believe the
 >> > correct behaviour is to return the number of bytes that succeeded.
 >> > However this change to the return status (remember the above patch is
 >> > a reversal) causes any failure to over-ride any success. This, I
 >> > think, is wrong.
 >>
 >> Yeap, that part also looks wrong.
 >
 >Certainly it's normal for a short read/write to imply either error or
 >EOF, without the error necessarily needing to be returned explicitly.
 >I'm not convinced that the Singleunix language actually requires that,
 >but it seems the most obvious and consistent behaviour.
 >
 >--Stephen

When an O_SYNC flag is set , if commit_write() succeed but 
generic_osync_inode() return
error due to I/O failure, write() must fail .

I think that following error handling code is rational in 
do_generic_file_write() .

	if (file->f_flags & O_SYNC)
		err = (status < 0) ? status : written;
	else
		err = written ? written : status;
	out:

	return err;


Thanks. 

