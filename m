Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbVA0AXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVA0AXG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVA0AV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:21:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23725 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262496AbVAZXHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 18:07:17 -0500
Date: Wed, 26 Jan 2005 12:49:04 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Ake <Ake.Sandgren@hpc2n.umu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in 2.4.26 in mm/filemap.c when using RLIMIT_RSS
Message-ID: <20050126144904.GE26308@logos.cnet>
References: <20050126110750.GE7349@hpc2n.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126110750.GE7349@hpc2n.umu.se>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 12:07:50PM +0100, Ake wrote:
> Use of rlim[RLIMIT_RSS] in mm/filemap.c is wrong.
> It is passed down to kernel as a number of bytes but is being used as a
> number of pages.
> 
> There is also a misinformative comment in fs/proc/array.c
> in proc_pid_stat where it says
> mm ? mm->rss : 0, /* you might want to shift this left 3 */
> the number 3 should probably be PAGE_SHIFT-10.

Amazing that this has never been noticed before - I bet not many people use RSS 
limits with madvise().

This transform the rlimit in pages before the comparison, can you please test
it.

--- a/mm/filemap.c.orig	2004-11-17 09:54:22.000000000 -0200
+++ b/mm/filemap.c	2005-01-26 15:21:10.614842296 -0200
@@ -2609,6 +2609,9 @@
 	error = -EIO;
 	rlim_rss = current->rlim ?  current->rlim[RLIMIT_RSS].rlim_cur :
 				LONG_MAX; /* default: see resource.h */
+
+	rlim_rss = (rlim_rss & PAGE_MASK) >> PAGE_SHIFT;
+
 	if ((vma->vm_mm->rss + (end - start)) > rlim_rss)
 		return error;
 
