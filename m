Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVDKQNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVDKQNp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVDKQKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:10:13 -0400
Received: from hermes.domdv.de ([193.102.202.1]:15891 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261818AbVDKQBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:01:50 -0400
Message-ID: <425A9F6A.8080200@domdv.de>
Date: Mon, 11 Apr 2005 18:01:46 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Oops in swsusp
References: <4259B425.4090105@domdv.de> <200504110859.00961.rjw@sisk.pl>
In-Reply-To: <200504110859.00961.rjw@sisk.pl>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday, 11 of April 2005 01:17, Andreas Steinmetz wrote:
> 
>>Pavel,
>>during testing of the encrypted swsusp_image on x86_64 I did get an Oops
>>from time to time at memcpy+11 called from swsusp_save+1090 which turns
>>out to be the memcpy in copy_data_pages() of swsusp.c.
>>The Oops is caused by a NULL pointer (I don't remember if it was source
>>or destination).
> 
> 
> It's quite important, however.  If it's the destination, it's probably a bug in
> swsusp.  Otherwise, the problem is more serious.  Could you, please,
> add BUG_ON(!pbe->address) right before the memcpy() and retest?

Here's the result:

BUG_ON(!pbe->address) hits, so is seems to be a swsusp problem.

So I added a BUG_ON(!to_copy) as shown below (mangled for mailing):

if (saveable(zone, &zone_pfn)) {
       struct page * page;
       BUG_ON(!to_copy);
       page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
       pbe->orig_address = (long) page_address(page);
       /* copy_page is not usable for copying task structs. */
       BUG_ON(!pbe->address);
       memcpy((void *)pbe->address, (void *)pbe->orig_address,
              PAGE_SIZE);
       pbe++;
       to_copy--;
}

The BUG_ON(!to_copy) hits, too.

So it seems that the result sum of saveable() increases between
count_data_pages() and copy_data_pages(). The problem seems to be
easiest hit when starting a larger GUI application and suspending during
application startup. It does ususally take a few suspend/resume
iterations to hit the bug.

Pavel,
the crypto stuff in swsusp.c starts in data_write() which is called
after copy_data_pages() if I'm right. In this case the crypto stuff
can't be the culprit.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
