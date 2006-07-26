Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWGZQwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWGZQwh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 12:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWGZQwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 12:52:37 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:52151 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S932190AbWGZQwg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 12:52:36 -0400
Date: Wed, 26 Jul 2006 09:52:35 -0700 (PDT)
From: dean gaudet <dean@arctic.org>
To: Jan Kasprzak <kas@fi.muni.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: 3ware disk latency?
In-Reply-To: <20060710141315.GA5753@fi.muni.cz>
Message-ID: <Pine.LNX.4.64.0607260942110.22242@twinlark.arctic.org>
References: <20060710141315.GA5753@fi.muni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006, Jan Kasprzak wrote:

> 	Does anybody experience the similar latency problems with
> 3ware 95xx controllers? Thanks,

i think the 95xx is really bad at sharing its cache fairly amongst 
multiple devices... i have a 9550sx-8lp with 3 exported units: a raid1, a 
raid10 and a jbod.  i was zeroing the jbod with dd and it absolutely 
destroyed the latency of the other two units.

to make things sane i had to add oflag=direct to dd to avoid dirtying all 
of memory... and i had to tell the 3ware to disable write caching on the 
jbod device.

the result is a fairly slow throughput on the dd (20MB/s) ... but at least 
the latency of the raid1 and raid10 aren't being affected any more.

i suspect that telling the 9550sx to not use nvram limits the amount of 
its tiny 128MiB of RAM which can be consumed by that unit.

having to use oflag=direct indicates linux is at least partially at fault 
here... maybe there's some tunable i need to learn about... the system has 
8GiB of ram, maybe the default dirty ratio of 40% is too high.  but i 
suspect the problem is more that with dd dirtying memory immediately it 
causes the system to be stuck at the 40% dirty watermark which causes 
excessive write traffic even to the raid1/raid10 units because they too 
are contributing to the 40% dirty (temporary files and whatnot would hit 
disk when they wouldn't in normal operation).

i think since i'm using 3ware hw raid on this setup with only two units 
normally active it isn't as painful as what you're seeing with what looks 
like 8 JBOD units.

yeah i'm a bit disappointed... i neglected to benchmark this sort of 
concurrency thing when i was experimenting with the 9550sx before turning 
it live.  i'm curious if areca controllers handle this better.

-dean
