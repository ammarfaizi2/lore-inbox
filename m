Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVAaUu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVAaUu1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 15:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVAaUu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 15:50:27 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:14359 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261358AbVAaUuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 15:50:12 -0500
Date: Mon, 31 Jan 2005 20:49:24 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Jayant Roplekar <jay_roplekar@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel bug: mm/rmap.c:483 and related {now 2.6.8}
In-Reply-To: <BAY101-F30CAC730D634C205C71635FE7C0@phx.gbl>
Message-ID: <Pine.LNX.4.61.0501312026340.8954@goblin.wat.veritas.com>
References: <BAY101-F30CAC730D634C205C71635FE7C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005, Jayant Roplekar wrote:
> I had reported a week ago that with  a custom 2.6.10 (tainted with ndiswrapper
> a windows driver loader) I got error above and that I could not reproduce it

Yes, at that time you had a page being allocated while both page_count
and page_mapcount were 1, strongly suggesting it was already in use.
And not matching any other Bad page warnings or rmap.c BUGs reported.

> after Hugh Dickins patch to 2.6.10.  Now I have sudden rash of similar errors
> and lock ups with 2.6.8.1-10mdk  (my daily use kernel)  in the last couple of
> days.  This *does not* use Hugh's patch.

> I ran memtest overnight with 19 passes and no errors.

Thanks for giving that a thorough run, memory seems exonerated... yet I
don't trust this machine at all: have you tried manufacturer diagnostics?

> I  have VIA motherboard and a matrox AGP card.  Following might be relevant
> CONFIG_AGP_VIA=m
> CONFIG_DRM=y
> CONFIG_DRM_MGA=m

> #### Following message appears three times in syslog at (Jan 29 08:27:03)
> #### and at (Jan 29 08:27:08) with identical addresses and
> #### then the machine was rebooted
> Jan 29 08:25:02 Bad page state at prep_new_page ('X', page c1251ae0)
> Jan 29 08:25:02 flags:0x20000004 mapping:00006a00 mapcount:0 count:0

Again, something I've not seen reported before: mapping:00006a00, when
mapping should be NULL (or at least a pointer into kernel memory).  You
say message reappeared twice with identical addresses: was that mapping
the same each time?  bad_page would reset it to NULL each time non-NULL
found there.  But since that non-NULL doesn't look at all like a kernel
address, it seems something is scribbling on your mem_map array of
struct pages: I've no idea what.

Hugh

> #### After the reboot there were no issues. On the next boot half an hour
> #### after the boot following stuff appears in the log
> 
> Jan 30 08:33:38 kernel BUG at mm/rmap.c:407!
> Jan 30 08:33:38 invalid operand: 0000 [#1]
> Jan 30 08:33:38 EIP:    0060:[page_remove_rmap+68/112] Not tainted VLI
> Jan 30 08:33:38 eax: 00000000 ebx: 00104000 ecx: c039f1d0 edx: c1327000
> Jan 30 08:33:38 esi: cda49530 edi: 0032b000 ebp: cd02bb78 esp: cd02bb78
> Jan 30 08:33:38 Process net_applet (pid: 5428, threadinfo=cd02a000 task=d125da30)

> Jan 30 08:53:37 kernel BUG at mm/rmap.c:407!
> Jan 30 08:53:37 invalid operand: 0000 [#2]
> Jan 30 08:53:37 EIP:    0060:[page_remove_rmap+68/112] Not tainted VLI
> Jan 30 08:53:37 eax: 00000000 ebx: 0031c000 ecx: c039f1d0 edx: c1191a00
> Jan 30 08:53:37 esi: cd5edc70 edi: 0038d000 ebp: d1475e74 esp: d1475e74
> Jan 30 08:53:37 Process pixie (pid: 4271, threadinfo=d1474000 task=d1471480)

> Jan 30 08:53:37 Bad page state at prep_new_page ('kjournald', page c1191a00)
> Jan 30 08:53:37 flags:0x20000014 mapping:00000000 mapcount:0 count:0

> #### The machine was up for 4 hours after the above, then there was
> #### following error which I think is due to above, then I had to do a power
> #### button due to lockup
> 
> Jan 30 13:32:01 Assertion failure in journal_dirty_data() at
> fs/jbd/transaction.c:985: "jh->b_transaction == journal->j_committing_transaction"
> Jan 30 13:32:01 kernel BUG at fs/jbd/transaction.c:985!
