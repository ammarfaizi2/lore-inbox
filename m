Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274868AbTHFGz7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 02:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274881AbTHFGz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 02:55:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:24741 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274868AbTHFGz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 02:55:57 -0400
Date: Tue, 5 Aug 2003 23:57:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: dan@debian.org, linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: ext3 badness in 2.6.0-test2
Message-Id: <20030805235735.4c180fa4.akpm@osdl.org>
In-Reply-To: <16176.41431.279477.273718@gargle.gargle.HOWL>
References: <20030804142245.GA1627@nevyn.them.org>
	<20030804132219.2e0c53b4.akpm@osdl.org>
	<16176.41431.279477.273718@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
>
> > Could have been an IO error, or the block/MD/device layer returned
> > incorrect data.  ext3 used to go BUG a lot in the latter case, but nowadays
> > we try to abort the journal and go read-only.
> > 
> > Without the initial message we do not know.
> 
> Can I add a "me too".....

No.  Go away.

> First, I'm using data=journal - is that supposed to work in 2.6 yet?
> 

I think so.  It's much less tested than ordered mode, but some people have
beat upon it.

> I have a raid5 array across a bunch of SCSI drives and a separate scsi
> drive with boot, swap, and a journal partition.
> I have an ext3 filesystem on the raid5 array with an external journal
> on the journal partition.

oh.  Good to hear that external journals still work.

> The raid5 was rebuilding a spare and I was pounding the filesystem
> over NFS using the SPEC SFS benchmark program (ofcourse the raid5
> rebuild killed the performance reported by SFS, but I expected that.
> 
> Shortly after the rebuild finished, I got an ext3 error (see log
> below) and the journal aborted, and then nfsd Oopsed inside ext3.

> ...
> Aug  6 15:22:05 adams kernel: EXT3-fs error (device md1): ext3_add_entry: bad entry in directory #41
> 009295: rec_len is smaller than minimal - offset=0, inode=3265411686, rec_len=0, name_len=0

It looks like we had a block full of zeroes come back from the device
driver.  I find it distinctly fishy how this happens so much with
ext3-on-md, and so little with ext3-on-just-a-disk.


> Aug  6 15:22:05 adams kernel: Remounting filesystem read-only
> Aug  6 15:22:05 adams kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000

Now that's an ext3 bug. Something like this...

 fs/jbd/transaction.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff -puN fs/jbd/transaction.c~ext3-aborted-journal-fix fs/jbd/transaction.c
--- 25/fs/jbd/transaction.c~ext3-aborted-journal-fix	2003-08-05 23:53:16.000000000 -0700
+++ 25-akpm/fs/jbd/transaction.c	2003-08-05 23:56:47.000000000 -0700
@@ -525,12 +525,18 @@ do_get_write_access(handle_t *handle, st
 			int force_copy, int *credits) 
 {
 	struct buffer_head *bh;
-	transaction_t *transaction = handle->h_transaction;
-	journal_t *journal = transaction->t_journal;
+	transaction_t *transaction;
+	journal_t *journal;
 	int error;
 	char *frozen_buffer = NULL;
 	int need_copy = 0;
 
+	if (is_handle_aborted(handle))
+		return -EROFS;
+
+	transaction = handle->h_transaction;
+	journal = transaction->t_journal;
+
 	jbd_debug(5, "buffer_head %p, force_copy %d\n", jh, force_copy);
 
 	JBUFFER_TRACE(jh, "entry");

_

