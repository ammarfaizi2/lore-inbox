Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbTDYAzN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 20:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbTDYAzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 20:55:13 -0400
Received: from [12.47.58.68] ([12.47.58.68]:58253 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262739AbTDYAzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 20:55:12 -0400
Date: Thu, 24 Apr 2003 18:05:03 -0700
From: Andrew Morton <akpm@digeo.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.68 2/2] i_size atomic access
Message-Id: <20030424180503.2c2a8bea.akpm@digeo.com>
In-Reply-To: <1051230056.2448.16.camel@ibm-c.pdx.osdl.net>
References: <1051230056.2448.16.camel@ibm-c.pdx.osdl.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2003 01:07:17.0049 (UTC) FILETIME=[03878A90:01C30AC7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
> Andrew, can we get these patches in to -mm?
> 

I don't like them really.

Yes, I know, a bug is a bug is a bug and it should be fixed.  But the fix
is fugly and the bug seems to be very theoretical.  And the patches appear
to not address all the i_size accesses down in filesystems.

The patches add barriers and cache footprint to fastpaths, and we don't get
a lot back.  As far as I know the bug has only been demonstrated when one
CPU is spinning on stat() and the other is waggling the file size across
the 4G boundary.

I'd be interested in seeing if the race is demonstrable anywhere else,
because the stat() problem can be plugged just by taking i_sem in
sys_stat().


So yeah, I know it _should_ be fixed, but it gives me the creeps, and the
fix may not be complete anyway.

And if the race _does_ hit, what is the effect?  Assuming stat() was fixed
with i_sem, I don't think the race has a very serious effect.  We won't
oops, or corrupt filesystems, or be insecure.  Maybe some
probably-already-racy application gets a page of zeroes instead of live
data.  Or maybe not - I'd need to think about that some more.


