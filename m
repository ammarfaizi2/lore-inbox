Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967208AbWKYVGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967208AbWKYVGg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 16:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967209AbWKYVGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 16:06:35 -0500
Received: from dvhart.com ([64.146.134.43]:6288 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S967208AbWKYVGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 16:06:35 -0500
Message-ID: <4568AFB1.3050500@mbligh.org>
Date: Sat, 25 Nov 2006 13:03:45 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>
Subject: OOM killer firing on 2.6.18 and later during LTP runs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.6.18-rc7 and later during LTP:
http://test.kernel.org/abat/48393/debug/console.log

oom-killer: gfp_mask=0x201d2, order=0

Call Trace:
  [<ffffffff802638cb>] out_of_memory+0x33/0x220
  [<ffffffff80265374>] __alloc_pages+0x23a/0x2c3
  [<ffffffff802667d2>] __do_page_cache_readahead+0x99/0x212
  [<ffffffff80260799>] sync_page+0x0/0x45
  [<ffffffff804b304c>] io_schedule+0x28/0x33
  [<ffffffff804b32b8>] __wait_on_bit_lock+0x5b/0x66
  [<ffffffff8043d849>] dm_any_congested+0x3b/0x42
  [<ffffffff80262e50>] filemap_nopage+0x14b/0x353
  [<ffffffff8026cf9a>] __handle_mm_fault+0x387/0x93f
  [<ffffffff804b6366>] do_page_fault+0x44b/0x7ba
  [<ffffffff80245a4e>] autoremove_wake_function+0x0/0x2e
oom-killer: gfp_mask=0x280d2, order=0

Call Trace:
  [<ffffffff802638cb>] out_of_memory+0x33/0x220
  [<ffffffff80265374>] __alloc_pages+0x23a/0x2c3
  [<ffffffff8026cde3>] __handle_mm_fault+0x1d0/0x93f
  [<ffffffff804b6366>] do_page_fault+0x44b/0x7ba
  [<ffffffff804b2854>] thread_return+0x0/0xe0
  [<ffffffff8020a405>] error_exit+0x0/0x84

--------------------------------------------------

This doesn't seem to happen every run, unfortnately, only
intermittently, and we don't have much data before that, so
hard to tell how long it's been going on.

Still happening on latest kernels.
http://test.kernel.org/abat/62445/debug/console.log

automount invoked oom-killer: gfp_mask=0x201d2, order=0, oomkilladj=0
lamb-payload invoked oom-killer: gfp_mask=0x201d2, order=0, oomkilladj=0

Call Trace:
  [<ffffffff80264dca>] out_of_memory+0x70/0x262
  [<ffffffff802459f6>] autoremove_wake_function+0x0/0x2e
  [<ffffffff802668bf>] __alloc_pages+0x238/0x2c1
  [<ffffffff80268070>] __do_page_cache_readahead+0xab/0x234
  [<ffffffff8026205c>] sync_page+0x0/0x45
  [<ffffffff804bf888>] io_schedule+0x28/0x33
  [<ffffffff804bfaeb>] __wait_on_bit_lock+0x5b/0x66
  [<ffffffff80446fc9>] dm_any_congested+0x3b/0x42
  [<ffffffff80264158>] filemap_nopage+0x148/0x34e
  [<ffffffff8026e49a>] __handle_mm_fault+0x1f8/0x9b0
  [<ffffffff804c2d0f>] do_page_fault+0x441/0x7b5
  [<ffffffff804c0d61>] _spin_unlock_irq+0x9/0xc
  [<ffffffff804bf121>] thread_return+0x64/0x100
  [<ffffffff804c119d>] error_exit+0x0/0x84

Does at least seem to be the same stack, mostly, and this machine is
using dm it seems, which most of the others aren't
