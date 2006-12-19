Return-Path: <linux-kernel-owner+w=401wt.eu-S932870AbWLSRnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932870AbWLSRnr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 12:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932866AbWLSRnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 12:43:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:49144 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932860AbWLSRnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 12:43:46 -0500
Date: Tue, 19 Dec 2006 09:43:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <Pine.LNX.4.64.0612190847270.3479@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612190929240.3483@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins> <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
 <45876C65.7010301@yahoo.com.au> <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
 <45878BE8.8010700@yahoo.com.au> <Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612182342030.3479@woody.osdl.org> <4587B762.2030603@yahoo.com.au>
 <Pine.LNX.4.64.0612190847270.3479@woody.osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-239982295-1166550180=:3483"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-239982295-1166550180=:3483
Content-Type: TEXT/PLAIN; charset=US-ASCII



Btw,
 here's a totally new tangent on this: it's possible that user code is 
simply BUGGY. 

There is one case where the kernel actually forcibly writes zeroes into a 
file: when we're writing a page that straddles the "inode->i_size" 
boundary. See the various writepages in fs/buffer.c, they all contain 
variations on that theme (although most of them aren't as well commented 
as this snippet):

        /*
         * The page straddles i_size.  It must be zeroed out on each and every
         * writepage invocation because it may be mmapped.  "A file is mapped
         * in multiples of the page size.  For a file that is not a multiple of
         * the  page size, the remaining memory is zeroed when mapped, and
         * writes to that region are not written out to the file."
         */
        kaddr = kmap_atomic(page, KM_USER0);
        memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);
        flush_dcache_page(page);
        kunmap_atomic(kaddr, KM_USER0);

Now, this should _matter_ only for user processes that are buggy, and that 
have written to the page _before_ extending it with ftruncate(). That's 
definitely a serious bug, but it's one that can do totally undetected 
depending on when the actual write-out happens.

So what I'm saying is that if we end up writing things earlier thanks to 
the more aggressive dirty-page-management thing in 2.6.19, we might 
actually just expose a long-time userspace bug that was just a LOT harder 
to trigger before..

I'm not saying this is the cause of all this, but we've been tearing our 
hair out, and it migth be worthwhile trying this really really really 
stupid patch that will notice when that happens at truncate() time, and 
tell the user that he's a total idiot. Or something to that effect.

Maybe the reason this is so easy to trigger with rtorrent is not because 
rtorrent does some magic pattern that triggers a kernel bug, but simply 
because rtorrent itself might have a bug.

Ok, so it's a long shot, but it's still worth testing, I suspect. The 
patch is very simple: whenever we do an _expanding_ truncate, we check the 
last page of the _old_ size, and if there were non-zero contents past the 
old size, we complain.

As an attachement is a test-program that _should_ trigger a 
kernel message like

	a.out: BADNESS: truncate check 17000

for good measure, just so that you can verify that the patch works and 
actually catches this case.

(The 17000 number is just the one-hundred _invalid_ 0xaa bytes - out of 
the 200 we wrote - that were summed up: 100*0xaa == 17000. Anything 
non-zero is always a bug).

I doubt this is really it, but it's worth trying. If you fill out a page, 
and only do "ftruncate()" in response to SIGBUS messages (and don't 
truncate to whole pages), you could potentially see zeroes at the end of 
the page exactly because _writeout_ cleared the page for you! So it 
_could_ explain the symptoms, but only if user-space was horribly horribly 
broken.

		Linus

----
diff --git a/mm/memory.c b/mm/memory.c
index c00bac6..79cecab 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1842,6 +1842,33 @@ void unmap_mapping_range(struct address_space *mapping,
 }
 EXPORT_SYMBOL(unmap_mapping_range);
 
+static void check_last_page(struct address_space *mapping, loff_t size)
+{
+	pgoff_t index;
+	unsigned int offset;
+	struct page *page;
+
+	if (!mapping)
+		return;
+	offset = size & ~PAGE_MASK;
+	if (!offset)
+		return;
+	index = size >> PAGE_SHIFT;
+	page = find_lock_page(mapping, index);
+	if (page) {
+		unsigned int check = 0;
+		unsigned char *kaddr = kmap_atomic(page, KM_USER0);
+		do {
+			check += kaddr[offset++];
+		} while (offset < PAGE_SIZE);
+		kunmap_atomic(kaddr,KM_USER0);
+		unlock_page(page);
+		page_cache_release(page);
+		if (check)
+			printk("%s: BADNESS: truncate check %u\n", current->comm, check);
+	}
+}
+
 /**
  * vmtruncate - unmap mappings "freed" by truncate() syscall
  * @inode: inode of the file used
@@ -1875,6 +1902,7 @@ do_expand:
 		goto out_sig;
 	if (offset > inode->i_sb->s_maxbytes)
 		goto out_big;
+	check_last_page(mapping, inode->i_size);
 	i_size_write(inode, offset);
 
 out_truncate:
---1463790079-239982295-1166550180=:3483
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=test.c
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0612190943000.3483@woody.osdl.org>
Content-Description: 
Content-Disposition: attachment; filename=test.c

I2luY2x1ZGUgPHN5cy9tbWFuLmg+DQojaW5jbHVkZSA8c3lzL2ZjbnRsLmg+
DQojaW5jbHVkZSA8dW5pc3RkLmg+DQojaW5jbHVkZSA8c3RyaW5nLmg+DQoN
CmludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikNCnsNCgljaGFyICpt
YXBwaW5nOw0KCWludCBmZDsNCg0KCWZkID0gb3BlbigibWFwZmlsZSIsIE9f
UkRXUiB8IE9fVFJVTkMgfCBPX0NSRUFULCAwNjY2KTsNCglpZiAoZmQgPCAw
KQ0KCQlyZXR1cm4gLTE7DQoJaWYgKGZ0cnVuY2F0ZShmZCwgMTApIDwgMCkN
CgkJcmV0dXJuIC0xOw0KCW1hcHBpbmcgPSBtbWFwKE5VTEwsIDQwOTYsIFBS
T1RfUkVBRCB8IFBST1RfV1JJVEUsIE1BUF9TSEFSRUQsIGZkLCAwKTsNCglp
ZiAoLTEgPT0gKGludCkobG9uZyltYXBwaW5nKQ0KCQlyZXR1cm4gLTE7DQoJ
bWVtc2V0KG1hcHBpbmcsIDB4NTUsIDEwKTsNCglpZiAoZnRydW5jYXRlKGZk
LCAxMDApIDwgMCkNCgkJcmV0dXJuIC0xOw0KCW1lbXNldChtYXBwaW5nLCAw
eGFhLCAyMDApOw0KCWlmIChmdHJ1bmNhdGUoZmQsIDIwMCkgPCAwKQ0KCQly
ZXR1cm4gLTE7DQoJcmV0dXJuIDA7DQp9DQo=

---1463790079-239982295-1166550180=:3483--
