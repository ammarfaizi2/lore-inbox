Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbUJaXYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbUJaXYp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 18:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbUJaXYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 18:24:45 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:32727 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261690AbUJaXYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 18:24:38 -0500
Date: Mon, 1 Nov 2004 10:24:26 +1100
From: Nathan Scott <nathans@sgi.com>
To: mmokrejs@ribosome.natur.cuni.cz
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Filesystem performance on 2.4.28-pre3 on hardware RAID5.
Message-ID: <20041101102426.G5462300@wobbly.melbourne.sgi.com>
References: <20041029111049.GA554@ribosome.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041029111049.GA554@ribosome.natur.cuni.cz>; from mmokrejs@ribosome.natur.cuni.cz on Fri, Oct 29, 2004 at 01:10:49PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 01:10:49PM +0200, mmokrejs@ribosome.natur.cuni.cz wrote:
> Hi Nathan, Marcello and others,
>   the collested meminfo, slabinfo, vmstat output are at
> http://www.natur.cuni.cz/~mmokrejs/crash/

On Sun, Oct 31, 2004 at 11:20:35PM +0100, Martin MOKREJ? wrote:
> Sorry, fixed by soflink. Was actually http://www.natur.cuni.cz/~mmokrejs/tmp/c
rash/

OK, well there's your problem - see the slabinfo output - you
have over 700MB of buffer_head structures that are not being
reclaimed.  Everything else seems to be fine.

> If you tell what kind of memory/xfs debugging I should turn
> on adn *how*, I can do it immediately. I don't have access

I think turning on debugging is going to hinder more than it
will help here.

> to the machine daily, and already had to be in production. :(
> 
> P.S: It is hardware raid5. I use mkfs.xfs version 2.6.13.

Hmm.  Did that patch I sent you help at all?  That should help
free up buffer_heads more effectively in low memory situations
like this.  You may also have some luck with tweaking bdflush
parameters so that flushing out of dirty buffers is started
earlier and/or done more often.  I can't remember off the top
of my head what all the bdflush tunables are - see the bdflush
section in Documentation/filesystems/proc.txt.

Alternatively, pick a filesystem blocksize that matches your
pagesize (4K instead of 512 bytes) to minimise the number of
buffer_heads you end up using.

cheers.

-- 
Nathan
