Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135468AbQL3USc>; Sat, 30 Dec 2000 15:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135475AbQL3USW>; Sat, 30 Dec 2000 15:18:22 -0500
Received: from hermes.mixx.net ([212.84.196.2]:40206 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S135468AbQL3USK>;
	Sat, 30 Dec 2000 15:18:10 -0500
From: Daniel Phillips <phillips@innominate.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [RFC] Generic deferred file writing
Date: Sat, 30 Dec 2000 19:58:10 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012291913350.1722-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10012291913350.1722-100000@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <00123020452307.00966@gimli>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I saw you put in the if (PageDirty) -->writepage and related code
over the last couple of weeks I was wondering if you realize how close
we are to having generic deferred file writing in the VFS.  I took some
time today to code this little hack and it comes awfully close to doing
the job.  However, *** Warning, do not run this on a machine you care
about, it will mess it up ***.

The advantages of deferred file writing are pretty obvious.  Right now
we are deferring just the writeout of data to the disk, but we can also
defer the disk mapping, so that metadata blocks don't have to stay
around in cache waiting for data blocks to get mapped into them one at
a time - a whole group can be done in one flush.  There is more scope
for the filesystem to optimize allocation - we just need some kind of
->get_blocks call that maps n file blocks in one operation.  Sometimes
we'll be able to write files, read them back and erase them without
ever hitting the disk, or even the filesystem.  Sequences of short
writes will cost a lot less cpu and hit less cache.  There are probably
other advantages as well.

For this to work properly there has to be an analog of kflushd for
pages.  We don't have that yet, and it's some distance away - so I'm
not even beginning to suggest this is a 2.4.0 thing.

In the patch below I didn't try to write the error handling exactly
right and the indenting is wrong.  It's just meant to show the idea
clearly.  Instead of mapping each file page to storage as we normally do
in generic_file_write we just mark it dirty and let page_launder or
Marcelo's new flushing code call the filesystem later.

This code worked well enough to copy some files and directories in uml,
and still have them there after a reboot.  Beyond that - patching it
into test13-pre5 on a real machine resulted in a toasted passwd file,
so there's some work to do yet.

Here it is...

--- 2.4.0-test12.clean/mm/filemap.c	Sat Dec  9 09:13:23 2000
+++ 2.4.0-test12/mm/filemap.c		Sat Dec 30 19:56:24 2000
@@ -2449,6 +2449,16 @@
 			PAGE_BUG(page);
 		}
 
+	if (!offset && bytes == PAGE_SIZE)
+	{
+		kaddr = page_address(page);
+		status = copy_from_user(kaddr+offset, buf, bytes);
+		flush_dcache_page(page);
+		SetPageUptodate(page);
+		SetPageDirty(page); /* set_page_dirty in test13 */
+	}
+	else
+	{
 		status = mapping->a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (status)
 			goto unlock;
@@ -2458,6 +2468,7 @@
 		if (status)
 			goto fail_write;
 		status = mapping->a_ops->commit_write(file, page, offset, offset+bytes);
+	}
 		if (!status)
 			status = bytes;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
