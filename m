Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbWBMN7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWBMN7r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 08:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWBMN7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 08:59:47 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:49374 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1751261AbWBMN7q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 08:59:46 -0500
Date: Mon, 13 Feb 2006 14:59:25 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Mark Lord <lkml@rtr.ca>, dgc@sgi.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Message-ID: <20060213135925.GA6173@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Andrew Morton <akpm@osdl.org>, Mark Lord <lkml@rtr.ca>, dgc@sgi.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20060206040027.GI43335175@melbourne.sgi.com> <20060205202733.48a02dbe.akpm@osdl.org> <43E75ED4.809@rtr.ca> <43E75FB6.2040203@rtr.ca> <20060206121133.4ef589af.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206121133.4ef589af.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 84.190.200.95
Subject: dirty pages (Was: Re: [PATCH] Prevent large file writeback starvation)
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006, Andrew Morton wrote:
> Mark Lord <lkml@rtr.ca> wrote:
> >
> > A simple test I do for this:
> > 
> >  $ mkdir t
> >  $ cp /usr/src/*.bz2  t    (about 400-500MB worth of kernel tar files)
> > 
> >  In another window, I do this:
> > 
> >  $ while (sleep 1); do echo -n "`date`: "; grep Dirty /proc/meminfo; done
> > 
> >  And then watch the count get large, but take virtually forever
> >  to count back down to a "safe" value.
> > 
> >  Typing "sync" causes all the Dirty pages to immediately be flushed to disk,
> >  as expected.
> 
> I've never seen that happen and I don't recall seeing any other reports of
> it, so your machine must be doing something peculiar.  I think it can
> happen if, say, an inode gets itself onto the wrong inode list, or
> incorrectly gets its dirty flag cleared.
> 
> Are you using any unusual mount options, or unusual combinations of
> filesystems, or anything like that?

I've been seeing something like this for some time, but kept
silent as I'm forced to use vmware on my Thinkpad T42p (1G RAM,
but CONFIG_NOHIGHMEM=y).
Sometimes 'sync' takes serveral seconds, even when the machine
had been idle for >15mins. I don't have laptop mode enabled.
so far I've not found a deterinistic way to reproduce this behaviour.

Anyway, I temporarily deinstalled vmware (deleted the kernel
modules and rebooted; kernel is still tainted because of madwifi
if that matters).
The behaviour I see with vmware (long 'sync' time) doesn't seem
to happen without it so far, but:

Now copying a 700MB file makes "Dirty" go up to 350MB. It then
slowly decreases to 325MB and stays there. However:

$ time sync

real	0m0.326s
user	0m0.000s
sys	0m0.280s

and output from the dirty monitor one-liner:

Mon Feb 13 14:31:43 CET 2006: Dirty:          325916 kB
Mon Feb 13 14:31:44 CET 2006: Dirty:          325916 kB
Mon Feb 13 14:31:45 CET 2006: Dirty:               4 kB
Mon Feb 13 14:31:46 CET 2006: Dirty:               8 kB


Clearly my notebook's hdd isn't that fast. ;-/
What does "Dirty" in /proc/meminfo really mean?

Kernel is 2.6.15, fs is ext3, .config etc. on request.


Johannes
