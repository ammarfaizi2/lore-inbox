Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUE3CWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUE3CWF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 22:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUE3CWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 22:22:05 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:60034 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261563AbUE3CWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 22:22:02 -0400
Message-ID: <40B94546.4040605@yahoo.com.au>
Date: Sun, 30 May 2004 12:21:58 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@zip.com.au>,
       Stuart Young <cef-lkml@optusnet.com.au>, linux-kernel@vger.kernel.org,
       Rob Landley <rob@landley.net>, seife@suse.de
Subject: Re: swappiness=0 makes software suspend fail.
References: <200405280000.56742.rob@landley.net> <20040528215642.GA927@elf.ucw.cz> <200405291905.20925.cef-lkml@optusnet.com.au> <40B85024.2040505@linuxmail.org> <20040529223648.GB1535@elf.ucw.cz>
In-Reply-To: <20040529223648.GB1535@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> Andrew, in 2.6.6 shrink_all_memory() does not work if swappiness ==
> 0. shrink_all_memory() calls balance_pgdat(), that calls
> shrink_zone(), and that calls refill_inactive_zone(), which looks at
> swappiness.
> 
> Additional parameter to all these calls neutralizing swappiness would
> help, as would temporarily setting swappiness to 100 in
> shrink_all_memory. Is there a less ugly solution?

I have a cleanup patch that allows this sort of thing to easily
be passed into the lower levels of reclaim functions. I don't
know if it would be to Andrew's taste though...

It basically replaces all function parameters in vmscan.c with

struct scan_control {
	unsigned long nr_to_scan;
	unsigned long nr_scanned;
	unsigned long nr_reclaimed;
	unsigned int gfp_mask;
	struct page_state ps;
	int may_writepage;
};

So you could easily add a field for swsusp.

Until something like this goes through, please don't fuglify
vmscan.c any more than it is... do the saving and restoring
thing that Nigel suggested please.
