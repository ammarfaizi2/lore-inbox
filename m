Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268392AbUHYCxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268392AbUHYCxA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 22:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268406AbUHYCxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 22:53:00 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:11674 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268392AbUHYCw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 22:52:56 -0400
Subject: Re: fix text reporting in O(1) proc_pid_statm()
From: Albert Cahalan <albert@users.sf.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040824231236.GG2793@holomorphy.com>
References: <1093388816.434.355.camel@cube>
	 <20040824231236.GG2793@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1093402351.434.631.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Aug 2004 22:52:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 19:12, William Lee Irwin III wrote:
> At some point in the past, I wrote:
> >> - *text = mm->exec_vm - ((mm->end_code - mm->start_code) >> PAGE_SHIFT);
> >> - *data = mm->total_vm - mm->shared_vm;
> >> + *text = (mm->end_code - mm->start_code) >> PAGE_SHIFT;
> >> + *data = mm->total_vm - mm->shared_vm - *text;
> 
> On Tue, Aug 24, 2004 at 07:06:56PM -0400, Albert Cahalan wrote:
> > It's actually still wrong. This has been broken for
> > a very long time. It you can fix it, great. Otherwise
> > this is a useless value, since /proc/*/stat provides
> > start_code and end_code already.
> > The statm file is supposed to contain a field known
> > as "trs" or "trss". This is like rss, but text-only.
> > Likewise, statm also contains "drs" or "drss" for data.
> > When you subtract start_code from end_code, you're
> > generating a value known as "tsiz" (the text size).
> > The statm file is supposed to supply trs, not tsiz.
> 
> The current 2.6 semantics are purely virtual, so this merely
> reimplements those semantics more efficiently. The scheme you
> describe would require accounting at the time of pte modification
> to implement in a like fashion, which has been rejected.

Hmmm, why not reject RSS too then? It's the same thing.

If trs and drs and so on were kept, then rss would
just be the sum of them. Per-permission tracking
seems about right:

rss[perms] += change;

(where "perms" is rwx plus shared/private and dirty/clean)

At some point, it would be good to have per-vma rss.
This would be displayed by the pmap command's -x option.
(added to /proc/*/maps right before the filename)


