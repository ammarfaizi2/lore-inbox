Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266768AbUH1F0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266768AbUH1F0i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 01:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268179AbUH1F0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 01:26:38 -0400
Received: from holomorphy.com ([207.189.100.168]:9124 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266768AbUH1F0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 01:26:34 -0400
Date: Fri, 27 Aug 2004 22:26:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org
Subject: [0/4] standardized waitqueue hashing
Message-ID: <20040828052627.GA2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
	linux-kernel@vger.kernel.org
References: <20040826014745.225d7a2c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826014745.225d7a2c.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 01:47:45AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/
> - nicksched is still here.  There has been very little feedback, except that
>   it seems to slow some workloads on NUMA.
> - Added a __must_check to the x86 copy_*_user functions.  This means that
>   with a sufficiently recent gcc, all unchecked copy_*_user() calls will
>   generate a warning.
>   I fixed a few things, but binfmt_elf.c is a mess.
>   It's not clear how to apply the same debug check to put_user() and
>   friends.

The following patch series consolidates the various instances of
waitqueue hashing to use a uniform structure and share the per-zone
hashtable among all waitqueue hashers. This is expected to increase the
number of hashtable buckets available for waiting on bh's and inodes
and eliminate statically allocated kernel data structures for greater
node locality and reduced kernel image size. Some attempt was made to
look similar to Oleg Nesterov's suggested API in order to provide some
kind of credit for independent invention of something very similar (the
original versions of these patches predated my public postings on the
subject of filtered waitqueues).

These patches have the further benefit and intention of enabling aio
to use filtered wakeups by standardizing the data structure passed to
wake functions so that embedded waitqueue elements in aio structures
may be succesfully passed to the filtered wakeup wake functions, though
this patch series doesn't implement that particular functionality.

Successfully stress-tested on x86-64 and ia64.


-- wli
