Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVCGXi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVCGXi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVCGXhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:37:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31435 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261964AbVCGXNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:13:37 -0500
Subject: Re: [RFC] ext3/jbd race: releasing in-use journal_heads
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1110230527.15117.625.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050304160451.4c33919c.akpm@osdl.org>
	 <1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050307123118.3a946bc8.akpm@osdl.org>
	 <1110229687.15117.612.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050307131113.0fd7477e.akpm@osdl.org>
	 <1110230527.15117.625.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: multipart/mixed; boundary="=-S3XYun7wACwaWuoBoO3Z"
Message-Id: <1110237205.15117.702.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 07 Mar 2005 23:13:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-S3XYun7wACwaWuoBoO3Z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 2005-03-07 at 21:22, Stephen C. Tweedie wrote:

> altgr-scrlck is showing a range of EIPs all in ext3_direct_IO->
> invalidate_inode_pages2_range().  I'm seeing
> 
> invalidate_inode_pages2_range()->pagevec_lookup()->find_get_pages()

In invalidate_inode_pages2_range(), what happens if we lookup a pagevec,
get a bunch of pages back, but all the pages in the vec are beyond the
end of the range we want?

That's quite possible: pagevec_lookup() gets told how many pages we
want, but not the index of the end of the range.

The loop over the pages in the pagevec contains this:

                        lock_page(page);
                        if (page->mapping != mapping || page->index > end) {
                                unlock_page(page);
                                continue;
                        }
                        wait_on_page_writeback(page);
                        next = page->index + 1;

Now, if all of the pages have page->index > end, we'll skip them all...
but we'll do it before we've advanced "next" to indicate that we've made
progress.  The next iteration is just going to start in the same place. 

Truncate always invalidates to EOF, which is probably why we haven't
seen this before.  But O_DIRECT is doing limited range cache
invalidates, and is getting stuck here pretty repeatably.

I'm currently testing the small patch below; it seems to be running OK
so far, although it hasn't been going for long yet.  I'll run a longer
test in the morning.

--Stephen


--=-S3XYun7wACwaWuoBoO3Z
Content-Disposition: inline; filename=invalidate-livelock.patch
Content-Type: text/plain; name=invalidate-livelock.patch; charset=ISO-8859-15
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi1leHQzL21tL3RydW5jYXRlLmMuPUswMDAyPS5vcmlnDQorKysgbGludXgt
Mi42LWV4dDMvbW0vdHJ1bmNhdGUuYw0KQEAgLTI3MSwxMiArMjcxLDEzIEBAIGludCBpbnZhbGlk
YXRlX2lub2RlX3BhZ2VzMl9yYW5nZShzdHJ1Y3QNCiAJCQlpbnQgd2FzX2RpcnR5Ow0KIA0KIAkJ
CWxvY2tfcGFnZShwYWdlKTsNCisJCQlpZiAocGFnZS0+bWFwcGluZyA9PSBtYXBwaW5nKQ0KKwkJ
CQluZXh0ID0gcGFnZS0+aW5kZXggKyAxOw0KIAkJCWlmIChwYWdlLT5tYXBwaW5nICE9IG1hcHBp
bmcgfHwgcGFnZS0+aW5kZXggPiBlbmQpIHsNCiAJCQkJdW5sb2NrX3BhZ2UocGFnZSk7DQogCQkJ
CWNvbnRpbnVlOw0KIAkJCX0NCiAJCQl3YWl0X29uX3BhZ2Vfd3JpdGViYWNrKHBhZ2UpOw0KLQkJ
CW5leHQgPSBwYWdlLT5pbmRleCArIDE7DQogCQkJaWYgKG5leHQgPT0gMCkNCiAJCQkJd3JhcHBl
ZCA9IDE7DQogCQkJd2hpbGUgKHBhZ2VfbWFwcGVkKHBhZ2UpKSB7DQo=

--=-S3XYun7wACwaWuoBoO3Z--
