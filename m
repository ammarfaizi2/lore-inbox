Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbTILFZV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 01:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbTILFZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 01:25:21 -0400
Received: from [63.205.85.133] ([63.205.85.133]:44275 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261685AbTILFZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 01:25:16 -0400
Date: Thu, 11 Sep 2003 22:33:35 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Cc: mc@cs.stanford.edu
Subject: Re: [PATCH 2/3] netpoll: netconsole
Message-ID: <20030912053335.GJ41254@gaz.sfgoth.com>
References: <20030910074256.GD4489@waste.org.suse.lists.linux.kernel> <p73znhdhxkx.fsf@oldwotan.suse.de> <20030910082435.GG4489@waste.org> <20030910082908.GE29485@wotan.suse.de> <20030910090121.GH4489@waste.org> <20030910160002.GB84652@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910160002.GB84652@gaz.sfgoth.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitchell Blank Jr wrote:
> The netconsole problem is only if the net driver calls printk() with
> its spinlock held (but when not called from netconsole).  Then printk()
> won't know that it's unsafe to re-enter the network driver.

BTW, this isn't neccesarily a netconsole-only thing.  For instance, has
anyone ever audited all of the serial and lp drivers to make sure that
nothing they call can call printk() while holding a lock?  This sounds
fairly serious - we could have any number of simple error cases that would
cause a deadlock with the right "console=" setting.

It'd be interesting if we could do something like:
  1. For every function that appears as a "struct console -> write()" call,
     follow every possible code path and make a list of every lock that they
     can try to acquire exclusively.
  2. Then scan the entire code base see if we ever call can printk() while
     holding that same lock.

I'm cc:'ing the Stanford Checker team... maybe they'd be interested in adding
something like this to their automated tests.

-Mitch
