Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266290AbUHBGNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266290AbUHBGNk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 02:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUHBGNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 02:13:40 -0400
Received: from digitalimplant.org ([64.62.235.95]:27066 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S266290AbUHBGNi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 02:13:38 -0400
Date: Sun, 1 Aug 2004 23:13:27 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: -mm swsusp: fix highmem handling
In-Reply-To: <20040728222300.GA16671@elf.ucw.cz>
Message-ID: <Pine.LNX.4.50.0408012308370.4359-100000@monsoon.he.net>
References: <20040728222300.GA16671@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Jul 2004, Pavel Machek wrote:

> Swsusp was not restoring highmem properly. I did not find a nice place
> where to restore it, through, so it went to swsusp_free.

That's too late, and will be called if suspend failed, to clean up any
allocated memory. The proper place seems to be in swsusp_resume().

> I'm not sure why you are saving state before save_processor_state.
> swsusp_arch_resume will overwrite this, anyway. Is it to make something
> balanced?

Yes, so it matches the calls in swsusp_suspend() - Previously there was a
hack that did kernel_fpu_end() after calling save_processor_state(), to
pass in_atomic() checks. By restoring the state after we've snapshotted on
suspend prevents this from being a problem.

In general, if we assume that save_processor_state() does anything to the
CPU, besides just benign register saving, we have to make sure that it's
put into the same state on resume before we restore state..


	Pat
