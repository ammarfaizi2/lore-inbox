Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287578AbSANQZh>; Mon, 14 Jan 2002 11:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287615AbSANQZ1>; Mon, 14 Jan 2002 11:25:27 -0500
Received: from [62.245.135.174] ([62.245.135.174]:12732 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S287578AbSANQZN>;
	Mon, 14 Jan 2002 11:25:13 -0500
Message-ID: <3C430662.71C4F3D8@TeraPort.de>
Date: Mon, 14 Jan 2002 17:25:06 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: vanl@megsinet.net
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/14/2002 05:25:06 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/14/2002 05:25:13 PM,
	Serialize complete at 01/14/2002 05:25:13 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: [2.4.17/18pre] VM and swap - it's really unusable
> 
> 
> Ken,
> 
> Attached is an update to my previous vmscan.patch.2.4.17.c
> 
> Version "d" fixes a BUG due to a race in the old code _and_
> is much less agressive at cache_shrinkage or conversely more
> willing to swap out but not as much as the stock kernel.
> 
> It continues to work well wrt to high vm pressure.
> 
> Give it a whirl to see if it changes your "-j" symptoms.
> 
> If you like you can change the one line in the patch
> from "DEF_PRIORITY" which is "6" to progressively smaller
> values to "tune" whatever kind of swap_out behaviour you
> like.
> 
> Martin
> 
Martin,

 looking at the "d" version, I have one question on the piece that calls
swap_out:

@@ -521,6 +524,9 @@
        }
        spin_unlock(&pagemap_lru_lock);

+       if (max_mapped <= 0 && (nr_pages > 0 || priority <
DEF_PRIORITY))
+               swap_out(priority, gfp_mask, classzone);
+
        return nr_pages;
 }


 Curious on the conditions where swap_out is actually called, I added a
printk and found actaully cases where you call swap_out when nr_pages is
already 0. What sense does that make? I would have thought that
shrink_cache had done its job in that case.

shrink_cache: 24 page-request, 0 pages-to swap, max_mapped=-1599,
max_scan=4350, priority=5
shrink_cache: 24 page-request, 0 pages-to swap, max_mapped=-487,
max_scan=4052, priority=5
shrink_cache: 29 page-request, 0 pages-to swap, max_mapped=-1076,
max_scan=1655, priority=5
shrink_cache: 2 page-request, 0 pages-to swap, max_mapped=-859,
max_scan=820, priority=5

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
