Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261657AbSJNNu1>; Mon, 14 Oct 2002 09:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261659AbSJNNu1>; Mon, 14 Oct 2002 09:50:27 -0400
Received: from holomorphy.com ([66.224.33.161]:3471 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261657AbSJNNu0>;
	Mon, 14 Oct 2002 09:50:26 -0400
Date: Mon, 14 Oct 2002 06:52:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [patch, feature] nonlinear mappings, prefaulting support, 2.5.42-F8
Message-ID: <20021014135232.GB4488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <Pine.LNX.4.44.0210141334100.17808-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210141334100.17808-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 02:38:43PM +0200, Ingo Molnar wrote:
> the patch has got an initial review from Linus, Andrew Morton and Hugh
> Dickins, and most of their suggestions are part of the patch already.

hmm


On Mon, Oct 14, 2002 at 02:38:43PM +0200, Ingo Molnar wrote:
> +int sys_remap_file_pages(unsigned long start, unsigned long size,
> +	unsigned long prot, unsigned long pgoff, unsigned long flags)

ISTR suggesting vectorizing this to reduce syscall traffic.

The semantics of faulting in pages on such a region, while not
incorrect, are at least unusual enough to raise the question of
whether it's appropriate for the kernel to fill the pages as opposed
to returning an error to userspace. The requirement of MAP_LOCKED
or PROT_NONE might as well be in-kernel if the file offset contiguity
assumption is not met, since there's no reliable way for userspace to
use the syscall otherwise. sys_remap_file_pages() also interacts in
an unusual way with the semantics of MAP_POPULATE. MAP_POPULATE seems
to perform a non-blocking make_pages_present() operation not shared
with MAP_LOCKED, and filemap_populate() performs the file offset
contiguous prefaulting which again doesn't mix well with the scatter
gather semantics desired. These are the file offset contiguity
assumptions I mentioned.

Also, a stranger phenomenon appears in filemap_populate(), where
nonblock may be true, and so filemap_getpage() will return NULL,
but -ENOMEM is returned if filemap_getpage() returns NULL.

Also, I see a significant portion of filemap_nopage() duplicated in
filemap_getpage(), including long-stale hashtable-related comments.


Bill
