Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267763AbUHEQNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267763AbUHEQNu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 12:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267766AbUHEQNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 12:13:50 -0400
Received: from holomorphy.com ([207.189.100.168]:36292 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267763AbUHEQNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 12:13:32 -0400
Date: Thu, 5 Aug 2004 09:13:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1
Message-ID: <20040805161328.GA17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040805031918.08790a82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805031918.08790a82.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 03:19:18AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc3/2.6.8-rc3-mm1/
> - Added David Woodhouse's MTD tree to the "external trees" list
> - Dropped the staircase scheduler, mainly because the schedstats patch broke
>   it.
>   We learned quite a lot from having staircase in there.  Now it's time for
>   a new scheduler anyway.

On some arches, e.g. ia64, it appears that timer ticks can be taken
very, very early. In order to avoid oopsing on a prof_buffer that
hasn't yet been bootmem allocated, check prof_buffer in profile_hit().


--- mm1-2.6.8-rc3/kernel/profile.c.orig	2004-08-06 01:24:10.000000000 -0700
+++ mm1-2.6.8-rc3/kernel/profile.c	2004-08-06 01:49:55.000000000 -0700
@@ -171,7 +171,7 @@
 {
 	unsigned long pc;
 
-	if (prof_on != type)
+	if (prof_on != type || !prof_buffer)
 		return;
 	pc = ((unsigned long)__pc - (unsigned long)_stext) >> prof_shift;
 	atomic_inc(&prof_buffer[min(pc, prof_len - 1)]);
