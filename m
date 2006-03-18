Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWCRUCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWCRUCA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 15:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWCRUCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 15:02:00 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:26334
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750876AbWCRUCA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 15:02:00 -0500
Subject: Re: [patch 2/2] alarm unsigned signed conversion fixup
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20060318142831.114986000@localhost.localdomain>
References: <20060318142827.419018000@localhost.localdomain>
	 <20060318142831.114986000@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 21:02:12 +0100
Message-Id: <1142712132.17279.130.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-18 at 15:18 +0000, Thomas Gleixner wrote:
> plain text document attachment (alarm-fixup-unsigned-signed.patch)
> alarm() calls the kernel with an unsigend int timeout in seconds.
> The value is converted to a timeval which is used to setup the
> itimer. The tv_sec field of the timeval is a long, which causes
> the timeout to be negative on 32 bit machines if seconds > INT_MAX.
> Also this was silently caught before the hrtimer merge. 
> To avoid fixups all over the place the duplicated sys_alarm code 
> is moved to itimer.c.

Also this needs a better explanation.

The timeval_to_jiffies conversion converted the resulting negative value
to MAX_JIFFIES_PER_LONG.

hrtimer treats the negative value as expired. The valid range for
alarm() is 1 .. UINT_MAX, so ignoring the conversion problem would cause
early expiry and break valid userspace code.

	tglx


