Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVAXTMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVAXTMZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVAXTLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:11:52 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:31357 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261572AbVAXTHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:07:55 -0500
Date: Mon, 24 Jan 2005 19:07:17 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Jay Roplekar <jay_roplekar@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel bug: mm/rmap.c:483
In-Reply-To: <200501231055.08965.jay_roplekar@hotmail.com>
Message-ID: <Pine.LNX.4.61.0501241813560.5795@goblin.wat.veritas.com>
References: <200501231055.08965.jay_roplekar@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2005, Jay Roplekar wrote:
> I am not sure this is a fixed problem in 2.6.11-rc2 based on my read of the 
> changelog, hence this email. Here is the summary:
> 
> 1. I  started with vanilla 2.6.10 where I replaced ieee1394 drivers from trunk 
> rev 1251 patched in. My kernel is tainted due to ndiswrapper that loads 
> windows drivers for my wireless PCI card.

Thanks for identifying that.

> One out of 4 times I actually 
> booted 2.6.10  and manually brought up wlan0 I got 'reboot needed etc 
> messages' .  Please note that  using similar approach in 2.6.8 does not cause 
> this issue.   Following is the error in /var/log/messages ( I did not  paste 
> everything to be brief):
> 
> Jan 22 08:26:58 localhost kernel: Bad page state at prep_new_page (in process 
> 'net_applet', page c1323a00)
> Jan 22 08:26:58 localhost kernel: flags:0x20000004 mapping:00000000 mapcount:1 
> count:1

This is a different case from any I've seen reported before: we've seen
several "mapcount:1 count:0" reports, but here you have "mapcount:1 count:1"
which is evidence plus confirmation that the page is really in use.

Yet prep_new_page is being called while (re!)allocating this page that's
already in use.  Sounds like a disagreement between page counts and the
buddy system.  But the most obvious cause of that, misuse of a high-order
page by freeing a lower-order page from within it, should hit the BUG_ON
in put_page_testzero before ever getting this far.

So, sorry, I've no idea.

> Jan 22 08:26:58 localhost kernel: Backtrace:
> Jan 22 08:26:58 localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
> Jan 22 08:26:58 localhost kernel:  [<c0103cde>] dump_stack+0x1e/0x20
> Jan 22 08:26:58 localhost kernel:  [bad_page+117/176] bad_page+0x75/0xb0
> Jan 22 08:26:58 localhost kernel:  [<c013c1b5>] bad_page+0x75/0xb0
> Jan 22 08:26:58 localhost kernel:  [prep_new_page+40/112] 
> prep_new_page+0x28/0x70
> Jan 22 08:26:58 localhost kernel:  [<c013c4d8>] prep_new_page+0x28/0x70

You've edited out the full stacktrace for brevity; and were probably
quite right to do so, the state of this page is not likely to have
anything to do with the process it's now being allocated to.

> #####
> Jan 22 08:26:58 localhost kernel: ------------[ cut here ]------------
> Jan 22 08:26:58 localhost kernel: kernel BUG at mm/rmap.c:483!

And this is just a consequence of bad_page resetting mapcount from 1 to 0
(well, from 0 to -1 if you delve into how those counts are implemented):
just further confirmation that the reallocated page was really in use.

> 2.  I patched in Hugh's patch  to 2.6.10 and recompiled. At reboot I ran 
> memtest86 v 1.26, 3 times without any error.  Then rebooting  in 2.6.10 and 
> doing  ifup wlan0 gave me system freeze and unfortunately nothing in the log.
> Since then I have  not  seen the same error again after 3 reboots and 2-3 cold 
> boots followed by ifup. I also tried cycles  of ifdown and ifup without  any 
> errors.  

Both that patch and memtest86 are good responses,
though I doubt my patch will actually help us much in your case.

> 3. I am not sure if I should post my whole config here hence I just pasting 
> DRM related entries here in reference to your original email to Jose`.  I 
> have VIA motherboard and a matrox  agp card, [FWIW most of the config is same 
> as for 2.6.8 kernel  that did not show the rmap sympton]
> 
> CONFIG_AGP_VIA=m
> CONFIG_DRM=y
> CONFIG_DRM_MGA=m

DRM again, hmm, thanks, yes, useful info.

> I will be glad to provide any other info needed. You may  bcc to my email if 
> this is better discussed off the list. [Although I will anxiously  check 
> lkml.org everyday or use RSS feed]. I am not subsribed as We are not 
> worthy :-)

Your worthiness is manifest, in all you've said, and left unsaid.

All I can say for now is, please let us know if you get more such traces.

Thanks,
Hugh
