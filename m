Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbTCaWQg>; Mon, 31 Mar 2003 17:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbTCaWQf>; Mon, 31 Mar 2003 17:16:35 -0500
Received: from holomorphy.com ([66.224.33.161]:47045 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261872AbTCaWQd>;
	Mon, 31 Mar 2003 17:16:33 -0500
Date: Mon, 31 Mar 2003 14:27:33 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 64GB NUMA-Q after pgcl
Message-ID: <20030331222733.GT30140@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <20030328040038.GO1350@holomorphy.com> <20030330231945.GH2318@x30.local> <20030331042729.GQ30140@holomorphy.com> <20030331052214.GV13178@holomorphy.com> <20030331230251.F626@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030331230251.F626@nightmaster.csn.tu-chemnitz.de>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 30, 2003 at 09:22:14PM -0800, William Lee Irwin III wrote:
>> Miscellaneous side effects happen, like follow_page() and
>> get_user_pages() need to return pfn's instead of struct pages.

On Mon, Mar 31, 2003 at 11:02:51PM +0200, Ingo Oeser wrote:
> Hmm, but you know, that users of get_user_pages() play games with
> pages? They need to lock them into memory, mark them eventually
> dirty, map them to a struct scatterlist and much more.
> I worked on an API (I called it the page-walk-api), to make this
> more and more transparent. 

There are no changes of semantics, it finds the struct page, does
page_cache_get() and fiddles with the struct page just like before, but
it needs to use the pfn as the handle to the thing when returning it to
the caller, not the struct page pointer.

The caller invariably needs the page structures to do anything, but
it also often needs the subpfn (which pfn inside the area tracked by
the struct page). The pfn is just the most compact way to pass that
information. Things end up doing pfn_to_page() to get at the page
structures that are returned in current mainline, and just use the
low bits of the pfn to reconstruct the offset into the page for copying
and bitblitting and so on.


On Mon, Mar 31, 2003 at 11:02:51PM +0200, Ingo Oeser wrote:
> So if this work will go into 2.6.x, then the page-walk-API will
> be needed, or else the driver writers playing tricks with
> virtual<->physical<->bus address conversions will go nuts.
> So which kernel is the target of this development?

My target for this has always been 2.7; earlier kernels can take
things on at the maintainer's discretion. I expect it to live out
of tree for a substantial amount of time. =(


-- wli
