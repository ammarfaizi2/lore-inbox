Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267447AbTBQOvE>; Mon, 17 Feb 2003 09:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267459AbTBQOvE>; Mon, 17 Feb 2003 09:51:04 -0500
Received: from max.fiasco.org.il ([192.117.122.39]:25097 "HELO
	latenight.fiasco.org.il") by vger.kernel.org with SMTP
	id <S267447AbTBQOu6>; Mon, 17 Feb 2003 09:50:58 -0500
Date: Mon, 17 Feb 2003 17:00:00 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Avi Teperman <teperman@il.ibm.com>, Muli Ben-Yehuda <muli@il.ibm.com>
Subject: hidden assumptions in generic_file_write
Message-ID: <20030217150000.GI6014@latenight.fiasco.org.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Looking at the following code of generic_file_write(), in 2.4, it
looks like there is a hidden assumption on the behavior of
prepare_write() and commit_write() about the behaviour of the file
system specific prepare_write() and commit_write() functions.

		do {
                .....
                kaddr = kmap(page);
                status = mapping->a_ops->prepare_write(file, page, offset, offset+bytes);
                if (status)
                        goto sync_failure;
                page_fault = __copy_from_user(kaddr+offset, buf, bytes);
                flush_dcache_page(page);
                status = mapping->a_ops->commit_write(file, page, offset, offset+bytes);
                if (page_fault)
                        goto fail_write;
                if (!status)
                        status = bytes;

                if (status >= 0) {
                        written += status;
                        count -= status;
                        pos += status;
                        buf += status;
                }
unlock:
                kunmap(page);
                /* Mark it unlocked again and drop the page.. */
                SetPageReferenced(page);
                UnlockPage(page);
                page_cache_release(page);

                if (status < 0)
                        break;
        } while (count);
done:
        ......

Since the data is copied to the page after prepare_write() returns, it 
seems that the assumption is that prepare_write() is synchronous and
the page was already read into memory in case it was not there.

Also, after commit_write(), the code immediately falls through unlock 
which unlocks the page. Since a page is locked during IO, it seems
that commit_write() is synchronous and the page was already written
when it returns.

Can anyone clarify if these two assumptions are correct? if not, where
are we misinterpreting the code? 

Regards, 
Muli Ben-Yehuda, 
Avi Teperman 
