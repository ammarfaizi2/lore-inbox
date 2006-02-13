Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWBMU3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWBMU3X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWBMU3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:29:23 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:23973 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S964838AbWBMU3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:29:22 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43F0EBE1.8000001@s5r6.in-berlin.de>
Date: Mon, 13 Feb 2006 21:28:17 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 7/8] don't mangle INQUIRY if cmddt or evpd bits are set
References: <E1F6vyJ-00009k-3Z@ZenIV.linux.org.uk> <43EA7226.60306@s5r6.in-berlin.de> <20060208230559.GK27946@ftp.linux.org.uk> <43F0B1AB.6010708@s5r6.in-berlin.de> <20060213181839.GA27946@ftp.linux.org.uk>
In-Reply-To: <20060213181839.GA27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.55) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Mon, Feb 13, 2006 at 05:19:55PM +0100, Stefan Richter wrote:
>>BTW, a Prolific based enclosure indeed seems to be unable to handle
>>CD-ROMs after scsiinfo treatment. An enclosure based on an old
>>revision of TI StorageLynx apparently causes mode_sense -> check
>>condition/ unit attention loops when scsiinfo tries to access some
>>mode page.
> 
> The former is best treated by using the hardware in question as a pissuary,
> to make sure that its contents matches the quality of design.

I have got the impression that most of IEEE 1394a/ USB 2.0 combo bridges 
on the market are now based on Prolific chips.

> The latter
> might be more interesting - RBC devices are only required to implement
> MODE SENSE/SELECT page 6; they shouldn't get messed by the rest, but at
> least some of them blindly respond with page 6 to _every_ MODE SENSE.
> So that might be a good reason to blacklist.

Some more findings:
  - The TI StorageLynx based bridge reports device type 0 (TYPE_DISK).
    The problem occurs apparently with page 4 and page 8. Sbp2 has a
    fix since yesterday which sets the skip_ms_page_8 flag.
    http://marc.theaimsgroup.com/?l=linux1394-devel&m=113969287630893
  - Another bridge made by the same manufacturer but based on TI
    StorageLynx revision A features the same MODE SENSE bug. This bridge
    reports type 14 (TYPE_RBC).
  - I tested a tenth bridge now, based on Initio INIC-2430F. The bridge
    reports TYPE_DISK and seems to support all pages which scsiinfo is
    interested in. Sd_mod is a different story: After sd_mod accesses
    page 8, the kernel panics. (This is discussed in another thread. The
    mentioned sbp2 patch catches this bridge as a skip_ms_page_8
    candidate too, thus avoids the panic. I will eventually check what
    sd_mod is doing; the sbp2 patch is not the real fix.)

Of course sg does not care for any black list flags (like sd_mod and 
sr_mod do), but considering the nature of the bugs and anticipated usage 
of affected devices, there is hardly a reason for further safeguards in 
sbp2, let alone sg.
-- 
Stefan Richter
-=====-=-==- --=- -==-=
http://arcgraph.de/sr/
