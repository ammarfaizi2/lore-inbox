Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131589AbQJ2KIQ>; Sun, 29 Oct 2000 05:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131599AbQJ2KIH>; Sun, 29 Oct 2000 05:08:07 -0500
Received: from linuxcare.com.au ([203.29.91.49]:52489 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S131589AbQJ2KHx>; Sun, 29 Oct 2000 05:07:53 -0500
From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14843.61434.167836.293141@argo.linuxcare.com.au>
Date: Sun, 29 Oct 2000 20:38:02 +1100 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: page->mapping == 0
In-Reply-To: <Pine.LNX.4.10.10010262325440.864-100000@penguin.transmeta.com>
In-Reply-To: <14841.7644.853174.666385@argo.linuxcare.com.au>
	<Pine.LNX.4.10.10010262325440.864-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@linuxcare.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I have tracked down why I am getting the oops with page->mapping == 0
in block_read_full_page.  Well, at least if not the ultimate cause,
then the penultimate cause.  It's basically yet another truncate bug
(tm).  I have some fairly detailed traces which I can send you if you
like, but the executive summary is that a page can get truncated out
from under us while we are sleeping in lock_page.  The scenario I
observed is this:

Process A goes to read some data from a file.  It finds or makes a
page cache page and starts the read into the page.

Process B goes to read the same data from the same file.  It gets down
into do_generic_file_read, finds the existing page cache page,
increments its count, sees that it is not up-to-date, and calls
lock_page, which calls ___wait_on_page.

At some later time the read completes, the page becomes up-to-date and
process B is woken.  But by this time process C is running.  It is
also trying to read the same data from the same file.  It completes
the read without blocking and then does a truncate on the file (in
preparation for rewriting it; the canonical example is when several
bashes exit at the same time, and they all go to read and rewrite
the ~/.bash_history file).

So process C calls vmtruncate() which calls truncate_inode_pages()
which calls truncate_complete_page() on all of the complete pages of
the file.  That in turn calls remove_inode_page() which calls
__remove_inode_page() which sets page->mapping to NULL.  (This code
doesn't seem to check page->count at all.)

Then process B actually gets to run.  It returns from ___wait_on_page
to lock_page to do_generic_file_read.  It now has the page locked but
it is no longer really the page it wants.  It has page->mapping set to
NULL and it isn't on the page list for the mapping any more.  The code
in do_generic_file_read doesn't check this but just charges on to call
mapping->a_ops->readpage.

I am not any kind of expert on the page cache but it seems to me that
maybe after locking the page we should check if it is still the page
we want (i.e. page->mapping and page->index are still correct), and go
back and look up the page again if not.  Presumably there will be
quite a few places besides do_generic_file_read where that check would
be needed also.

Regards,
Paul.

-- 
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
