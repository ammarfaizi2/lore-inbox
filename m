Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbUCTU2B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 15:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbUCTU2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 15:28:01 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:50905
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263529AbUCTU17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 15:27:59 -0500
Date: Sat, 20 Mar 2004 21:28:50 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040320202850.GH9009@dualathlon.random>
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com> <20040320150621.GO9009@dualathlon.random> <20040320121345.2a80e6a0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320121345.2a80e6a0.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 12:13:45PM -0800, Andrew Morton wrote:
> fyi, we don't need the check in page_referenced() and try_to_unmap()
> because do_no_page() does not place pages on the LRU.  It is the ->nopage

yes I've noticed.

> I agree that ->nopage implementations should not be doing what that driver
> is doing.  ->nopage is defined to return a page*: it's crazy to be
> returning someting from there which isn't covered by mem_map[].

I may have been wrong about that sorry, it's still not certain though,
but I had a bug in the code that would mistake a sigbus for a page_t
outside the mem_map, so it could have been a sigbus not a non-ram page.

Also in the meantime I noticed with NUMA it's impossible to handle
non-ram correctly in ->nopage, at least if using the current
page_to_pfn.

> I just don't think it's important enough to be able to cope with
> non-mem_map[] "memory" in do_no_page(), so I agree that requiring ->mmap()
> to synchronously instantiate the pte's and retaining the debug check in
> do_no_page() is a good idea.

I agree, I reistantiated the debug check because we cannot handle
non-ram from there if it's numa (actually discontigmem). If alsa uses
non-ram pages it must be fixed, but I've an hope it was a sigbus
trouble. We'll know more in a few more hours.

(btw, Martin definitely triggered the sigbus with numa, the 0x3()
dereference was a the page_t address to read page->flags >> 24)

it's good to have reminded the API cannot handle non-ram.
