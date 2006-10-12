Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWJLUHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWJLUHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 16:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWJLUHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 16:07:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40382 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750904AbWJLUHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 16:07:37 -0400
Message-ID: <452EA06F.4060701@redhat.com>
Date: Thu, 12 Oct 2006 15:07:11 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jan Kara <jack@suse.cz>, Badari Pulavarty <pbadari@us.ibm.com>,
       Eric Sandeen <sandeen@sandeen.net>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 ext3 panic.
References: <20061009225036.GC26728@redhat.com>	<20061010141145.GM23622@atrey.karlin.mff.cuni.cz>	<452C18A6.3070607@redhat.com>	<1160519106.28299.4.camel@dyn9047017100.beaverton.ibm.com>	<452C4C47.2000107@sandeen.net>	<20061011103325.GC6865@atrey.karlin.mff.cuni.cz>	<452CF523.5090708@sandeen.net>	<20061011142205.GB24508@atrey.karlin.mff.cuni.cz>	<1160589284.1447.19.camel@dyn9047017100.beaverton.ibm.com>	<452DAA26.6080200@redhat.com>	<20061012122820.GK9495@atrey.karlin.mff.cuni.cz> <20061012094036.e1a3f9f1.akpm@osdl.org>
In-Reply-To: <20061012094036.e1a3f9f1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> On Thu, 12 Oct 2006 14:28:20 +0200
> Jan Kara <jack@suse.cz> wrote:
>
>   
>> Where can we call
>> journal_dirty_data() without PageLock?
>>     
>
> block_write_full_page() will unlock the page, so ext3_writepage()
> will run journal_dirty_data_fn() against an unlocked page.
>
> I haven't looked into the exact details of the race, but it should
> be addressable via jbd_lock_bh_state() or j_list_lock coverage
I'm testing with something like this now; seem sane?

journal_dirty_data & journal_unmap_data both check do 
jbd_lock_bh_state(bh) close to the top... journal_dirty_data_fn has checked 
buffer_mapped before getting into journal_dirty_data, but that state may
change before the lock is grabbed.  Similarly re-check after we drop the lock.

-Eric

Index: linux-2.6.18-1.2737.fc6/fs/jbd/transaction.c
===================================================================
--- linux-2.6.18-1.2737.fc6.orig/fs/jbd/transaction.c
+++ linux-2.6.18-1.2737.fc6/fs/jbd/transaction.c
@@ -967,6 +967,13 @@ int journal_dirty_data(handle_t *handle,
 	 */
 	jbd_lock_bh_state(bh);
 	spin_lock(&journal->j_list_lock);
+
+	/* Now that we have bh_state locked, are we really still mapped? */
+	if (!buffer_mapped(bh)) {
+		JBUFFER_TRACE(jh, "unmapped, bailing out");
+		goto no_journal;
+	}
+		
 	if (jh->b_transaction) {
 		JBUFFER_TRACE(jh, "has transaction");
 		if (jh->b_transaction != handle->h_transaction) {
@@ -1028,6 +1036,11 @@ int journal_dirty_data(handle_t *handle,
 				sync_dirty_buffer(bh);
 				jbd_lock_bh_state(bh);
 				spin_lock(&journal->j_list_lock);
+				/* Since we dropped the lock... */
+				if (!buffer_mapped(bh)) {
+					JBUFFER_TRACE(jh, "Got unmapped");
+					goto no_journal;
+				}
 				/* The buffer may become locked again at any
 				   time if it is redirtied */
 			}

