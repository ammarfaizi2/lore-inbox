Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbVBLIIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVBLIIx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 03:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbVBLIIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 03:08:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58807 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262399AbVBLIIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 03:08:18 -0500
Date: Sat, 12 Feb 2005 00:08:00 -0800
From: Paul Jackson <pj@sgi.com>
To: Ray Bryant <raybry@sgi.com>
Cc: taka@valinux.co.jp, hugh@veritas.com, akpm@osdl.org, haveblue@us.ibm.com,
       marcello@cyclades.com, raybry@sgi.com, raybry@austin.rr.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration --
 sys_page_migrate
Message-Id: <20050212000800.5ecee064.pj@sgi.com>
In-Reply-To: <20050212032620.18524.15178.29731@tomahawk.engr.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
	<20050212032620.18524.15178.29731@tomahawk.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor comments ... nothing profound.

Ray wrote:
> once we agree on what the authority model should be.

Are the usual kill-like permissions sufficient?
You can migrate the pages of a process if you can kill it.

===

In the following routine, tighten up some vertical spacing,
add { ... } , ...

The migrated and count manipulations are confusing my
feeble brain.  Is this thing supposed to return 0 if all
count pages are migrated?  Sure seems that it does, as it
returns 'migrated', which is 'count - migrated', but that
migrated is really count, so it returns 'count - count',
which is zero.  Huh ...  The phrase 'return migrated' would
make me think it returned some count of how many were
migrated on success, not zero.

The variable name 'remains' is rather elaborate for what
looks like a trivial return case.  But perhaps it actually
provides a better clue to the return value, which apparently
is the number of pages _not_ migrated successfully.

Think carefully about what each variable represents, and
then use each variable consistently.

And try to avoid the embedded 'return remains'.  A function
header comment, saying what this routine does and returns might
be helpful.

=========================================================================
static int
migrate_vma_common(struct list_head *page_list, short *node_map, int count)
{
	int pass, remains, migrated;
	struct page *page;

	for (pass = 0; pass < 10; msleep(10), pass++) {
		remains = try_to_migrate_pages(page_list, node_map);
		if (remains < 0)
			return remains;

		migrated = 0;
		if (!list_empty(page_list)) {
			list_for_each_entry(page, page_list, lru)
				migrated++;
		} else {
			migrated = count;
			break;
		}
		migrated = count - migrated;
	}
	return migrated;
}
=========================================================================

Better init tmp_new_nodes, node_map to 0, or if tmp_old_news fails to
allocate, you might try freeing bogus values for the other two in
sys_page_migrate():

===============================================================
+       short *tmp_old_nodes;
+       short *tmp_new_nodes;
+       short *node_map;
+       ...
+
+
+       tmp_old_nodes = (short *) kmalloc(size, GFP_KERNEL);
+       tmp_new_nodes = (short *) kmalloc(size, GFP_KERNEL);
+       node_map = (short *) kmalloc(MAX_NUMNODES*sizeof(short), GFP_KERNEL);
================================================================

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
