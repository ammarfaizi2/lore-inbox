Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751915AbWI1PEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbWI1PEV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 11:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbWI1PEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 11:04:21 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:53200 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751224AbWI1PET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 11:04:19 -0400
Subject: [PATCH] JBD: Make journal_do_submit_data static
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Andrew Morton <akpm@osdl.org>, Jan Kara <jack@suse.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Anton Altaparmakov <aia21@cam.ac.uk>, sct@redhat.com,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
In-Reply-To: <451AF4B5.1090607@sandeen.net>
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
	 <1158179120.11112.2.camel@kleikamp.austin.ibm.com>
	 <20060913203817.b6711381.akpm@osdl.org>  <451AF4B5.1090607@sandeen.net>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 10:03:56 -0500
Message-Id: <1159455836.12007.2.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-27 at 17:01 -0500, Eric Sandeen wrote:
> Andrew Morton wrote:
> > On Wed, 13 Sep 2006 15:25:19 -0500
> > Dave Kleikamp <shaggy@austin.ibm.com> wrote:
> > 
> >>> +void journal_do_submit_data(struct buffer_head **wbuf, int bufs)
> >> Is there any reason this couldn't be static?
> > 
> > Nope.
> 
> With this change, journal_brelse_array can also be made static in
> recovery.c, and removed from jbd.h, I think.

Looks like it.  Here's a patch to do that:

JBD: Make journal_brelse_array static

It's always good to make symbols static when we can, and this also
eliminates the need to rename the function in jbd2

suggested by Eric Sandeen

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Eric Sandeen <sandeen@sandeen.net>

diff --git a/fs/jbd/recovery.c b/fs/jbd/recovery.c
index 445eed6..11563fe 100644
--- a/fs/jbd/recovery.c
+++ b/fs/jbd/recovery.c
@@ -46,7 +46,7 @@ static int scan_revoke_records(journal_t
 #ifdef __KERNEL__
 
 /* Release readahead buffers after use */
-void journal_brelse_array(struct buffer_head *b[], int n)
+static void journal_brelse_array(struct buffer_head *b[], int n)
 {
 	while (--n >= 0)
 		brelse (b[n]);
diff --git a/include/linux/jbd.h b/include/linux/jbd.h
index a6d9daa..fe89444 100644
--- a/include/linux/jbd.h
+++ b/include/linux/jbd.h
@@ -977,7 +977,6 @@ extern void	   journal_write_revoke_reco
 extern int	journal_set_revoke(journal_t *, unsigned long, tid_t);
 extern int	journal_test_revoke(journal_t *, unsigned long, tid_t);
 extern void	journal_clear_revoke(journal_t *);
-extern void	journal_brelse_array(struct buffer_head *b[], int n);
 extern void	journal_switch_revoke_table(journal_t *journal);
 
 /*

-- 
David Kleikamp
IBM Linux Technology Center

