Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269098AbUHXXJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269098AbUHXXJM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 19:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269108AbUHXXJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 19:09:12 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:27079 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S269120AbUHXXHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 19:07:20 -0400
Subject: Re: fix text reporting in O(1) proc_pid_statm()
From: Albert Cahalan <albert@users.sf.net>
To: wli@holomorphy.com
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1093388816.434.355.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Aug 2004 19:06:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - *text = mm->exec_vm - ((mm->end_code - mm->start_code) >> PAGE_SHIFT);
> - *data = mm->total_vm - mm->shared_vm;
> + *text = (mm->end_code - mm->start_code) >> PAGE_SHIFT;
> + *data = mm->total_vm - mm->shared_vm - *text;

It's actually still wrong. This has been broken for
a very long time. It you can fix it, great. Otherwise
this is a useless value, since /proc/*/stat provides
start_code and end_code already.

The statm file is supposed to contain a field known
as "trs" or "trss". This is like rss, but text-only.
Likewise, statm also contains "drs" or "drss" for data.
When you subtract start_code from end_code, you're
generating a value known as "tsiz" (the text size).
The statm file is supposed to supply trs, not tsiz.

Back in the days of a.out, statm also contained lrs
for libraries. ELF broke this.

The statm VM size is supposed to count IO mappings.
So if your X server maps 64 MB of video RAM, then
the statm file should have a value 64 MB larger than
the status file has.


