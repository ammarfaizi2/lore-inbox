Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263668AbUCYWW1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUCYWW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:22:27 -0500
Received: from gprs214-160.eurotel.cz ([160.218.214.160]:14721 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263668AbUCYWWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:22:24 -0500
Date: Thu, 25 Mar 2004 23:22:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
Subject: Re: swsusp with highmem, testing wanted
Message-ID: <20040325222205.GC2179@elf.ucw.cz>
References: <20040324235702.GA497@elf.ucw.cz> <20040325073244.GE3377@suse.de> <20040325115129.GB300@elf.ucw.cz> <20040325121418.GK3377@suse.de> <20040325150129.GI1505@openzaurus.ucw.cz> <20040325152749.GP3377@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325152749.GP3377@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Having special "poll" mode for block drivers might do the trick, but
> > thats lot of work.
> 
> Maybe I'm missing something, but why doesn't the regular io paths
> work?

(Basically) you want to replace all kernel data with kernel data saved
on disk. How do you do that using normal i/o paths? If you'll read
"new" data 4KB at a time, you'll crash... because you still need "old"
data to do the reading, and "new" data may fit on same physical spot
in memory.

There are two solutions to this:

* require half of memory to be free during suspend. That way you can
read "new" data onto free spots, then cli and copy

* assume we had special "polling" ide driver that only uses memory
between 0-640KB. That way, I'd have to make sure that 0-640KB is free
during suspending, but otherwise it would work...

Do you see the problem now?

> > Which operations are allowed to access highmem? Can I rely on
> > block device read/write not accessing highmem?
> 
> You mean modify highmem pages, or?

I'd like to know this. Suppose I ask block subsystem to read from disk
into page @1.8GB. All the highmem contains trash. Will block subsystem
be able to work in this situation?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
