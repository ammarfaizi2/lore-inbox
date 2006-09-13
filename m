Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWIMUZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWIMUZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 16:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWIMUZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 16:25:28 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:476 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751073AbWIMUZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 16:25:26 -0400
Subject: Re: [RFC][PATCH] set_page_buffer_dirty should skip unmapped buffers
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Anton Altaparmakov <aia21@cam.ac.uk>, sct@redhat.com,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
In-Reply-To: <20060907223048.GD22549@atrey.karlin.mff.cuni.cz>
References: <20060901101801.7845bca2.akpm@osdl.org>
	 <1157472702.23501.12.camel@dyn9047017100.beaverton.ibm.com>
	 <20060906124719.GA11868@atrey.karlin.mff.cuni.cz>
	 <1157555559.23501.25.camel@dyn9047017100.beaverton.ibm.com>
	 <20060906153449.GC18281@atrey.karlin.mff.cuni.cz>
	 <1157559545.23501.30.camel@dyn9047017100.beaverton.ibm.com>
	 <20060906162723.GA14345@atrey.karlin.mff.cuni.cz>
	 <1157563016.23501.39.camel@dyn9047017100.beaverton.ibm.com>
	 <20060906172733.GC14345@atrey.karlin.mff.cuni.cz>
	 <1157641877.7725.13.camel@dyn9047017100.beaverton.ibm.com>
	 <20060907223048.GD22549@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 15:25:19 -0500
Message-Id: <1158179120.11112.2.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-08 at 00:30 +0200, Jan Kara wrote:
> diff -rupX /home/jack/.kerndiffexclude
> linux-2.6.18-rc6/fs/jbd/commit.c
> linux-2.6.18-rc6-1-orderedwrite/fs/jbd/commit.c
> --- linux-2.6.18-rc6/fs/jbd/commit.c    2006-09-06 18:20:48.000000000
> +0200
> +++ linux-2.6.18-rc6-1-orderedwrite/fs/jbd/commit.c     2006-09-08
> 01:05:35.000000000 +0200
> @@ -160,6 +160,117 @@ static int journal_write_commit_record(j
>         return (ret == -EIO);
>  }
>  
> +void journal_do_submit_data(struct buffer_head **wbuf, int bufs)

Is there any reason this couldn't be static?

> +{
> +       int i;
> +
> +       for (i = 0; i < bufs; i++) {
> +               wbuf[i]->b_end_io = end_buffer_write_sync;
> +               /* We use-up our safety reference in submit_bh() */
> +               submit_bh(WRITE, wbuf[i]);
> +       }
> +} 

I'm rebasing the ext4 work on the latest -mm tree and would like to
avoid renaming this function in the jbd2 clone.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

