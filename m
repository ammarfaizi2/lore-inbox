Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266000AbUAQEKV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 23:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266001AbUAQEKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 23:10:20 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:25512 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266000AbUAQEKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 23:10:16 -0500
From: Lev Makhlis <mlev@despammed.com>
To: linux-kernel@vger.kernel.org
Subject: PROC_BLOCK_SIZE in proc_info_read()
Date: Fri, 16 Jan 2004 23:10:17 -0500
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401162310.17695.mlev@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

proc_info_read() (in fs/proc/base.c) uses this macro to limit the size
of a single read:

#define PROC_BLOCK_SIZE (3*1024)                /* 4K page size but our output 
routines use some slack for overruns */

It seems to me like it's a legacy from array_read() in 2.2.x and can be
safely removed.  Besides an outdated assumption about the page size,
the value is not passed down to (*proc_read)(), so it cannot guard
against any overruns, and serves no useful purpose.
Am I missing anything?

(This is not to be confused with PROC_BLOCK_SIZE in fs/proc/generic.c)

The reason it bothers me is that if you have a process with a really long
command line, then /proc/<pid>/cmdline "contains" up to PAGE_SIZE bytes,
but sys_read() only returns 3072, and needs to be called repeatedly.

