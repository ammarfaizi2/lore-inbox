Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbWGaWnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWGaWnM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 18:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWGaWnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 18:43:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46806 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751383AbWGaWnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 18:43:11 -0400
Date: Tue, 1 Aug 2006 08:41:43 +1000
From: Nathan Scott <nathans@sgi.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, xfs@oss.sgi.com
Subject: Re: XFS vs. swsusp
Message-ID: <20060801084143.D2286470@wobbly.melbourne.sgi.com>
References: <20060731215933.GB3612@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060731215933.GB3612@elf.ucw.cz>; from pavel@ucw.cz on Mon, Jul 31, 2006 at 11:59:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 11:59:33PM +0200, Pavel Machek wrote:
> Hi!

Hi there,

> Rafael has patches to add bdev freezing to swsusp. I'd like to know if
> they are neccessary (and why).
> 
> 1) Is sync() enough to guarantee that all the data written before sync
> actually reach the platters?
> 
> (Or is it that data only reach the journal? OTOH that would be okay, too).

It ensures file data reaches its final resting place, and that
metadata changes have been logged.  It does not necessarily
ensure that metadata changes have reached their final resting
place (which can be done during log recovery if need be).

A freeze is one way to ensure all metadata will be written out
(and not just to the log, I mean), unmount is another (d'uh),
and remount,ro is a third.

> 2) If we stop all the user proceses and all the kernel threads, is
> that enough to prevent XFS from writing to disk?

Yes, I believe so (if all user processes and kernel threads are
stopped, who else would be left to initiate I/O?).  There is a
timer driven wakeup done on the per-fs xfssyncd kernel threads,
which do background metadata writeout and will write to the log
periodically... but if those processes are all stopped too, you
should be OK.

cheers.

-- 
Nathan
