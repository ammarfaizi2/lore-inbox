Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129585AbQLFHcD>; Wed, 6 Dec 2000 02:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbQLFHbx>; Wed, 6 Dec 2000 02:31:53 -0500
Received: from 213-120-137-209.btconnect.com ([213.120.137.209]:17412 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129585AbQLFHbj>;
	Wed, 6 Dec 2000 02:31:39 -0500
Date: Wed, 6 Dec 2000 07:03:11 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Peter Samuelson <peter@cadcamlab.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test12-pre5] optimized get_empty_filp()
In-Reply-To: <14893.28991.629652.495045@wire.cadcamlab.org>
Message-ID: <Pine.LNX.4.21.0012060658310.893-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2000, Peter Samuelson wrote:
> The question is whether or not it is worth taking a lock again (with
> that non-zero cost) to achieve the gain of doing the 92-byte memset and
> the atomic_set in parallel with other CPUs.  In other words, by locking
> and unlocking twice, you reduce the contention on the lock.  Is this,
> however, worth the extra cycles and bus traffic?  I don't know.

Ok, that's a different (opposite) question and so if the answer previously
was "Yes" then obviously the answer to this one is "No". I.e. it is not
worth retaking the lock for the sake of reducing contention on the
lock. And it is not just a couple of extra instructions but it is also a
bus lock (or cache lock if you are lucky, on P6 only). And that is exactly
what my patch does -- removes the unnecessary bus locking and at least 2
instructions.

Regards,
Tigran

PS. Your previous statement (when clarified and explained by you in this
message) made me think that you misread the patch, i.e. saw "+" when there
was "-" -- I removed those lines and not added them... Here is the patch
again for you to see it clearer:

--- linux/fs/file_table.c	Fri Nov 17 19:36:27 2000
+++ work/fs/file_table.c	Tue Dec  5 16:52:06 2000
@@ -40,13 +40,11 @@
 		list_del(&f->f_list);
 		files_stat.nr_free_files--;
 	new_one:
-		file_list_unlock();
 		memset(f, 0, sizeof(*f));
 		atomic_set(&f->f_count,1);
 		f->f_version = ++event;
 		f->f_uid = current->fsuid;
 		f->f_gid = current->fsgid;
-		file_list_lock();
 		list_add(&f->f_list, &anon_list);
 		file_list_unlock();
 		return f;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
