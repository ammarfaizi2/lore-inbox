Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbTJEQTY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 12:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbTJEQTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 12:19:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28941 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263147AbTJEQTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 12:19:22 -0400
Date: Sun, 5 Oct 2003 17:19:16 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: JFFS2 swsusp / signal cleanup.
Message-ID: <20031005171916.B21478@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
References: <1065266733.16088.91.camel@imladris.demon.co.uk> <20031005161155.GA753@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031005161155.GA753@elf.ucw.cz>; from pavel@ucw.cz on Sun, Oct 05, 2003 at 06:11:55PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 05, 2003 at 06:11:55PM +0200, Pavel Machek wrote:
> Is flush_signals() really so stupid to do? Goal was to make
> modifications to code as simple as possible, and as most pieces do not
> expect to be interrupted, pretending signal never happened seems like
> good idea...

What if that signal was necessary for the operation of the thread, and
dropping it would cause a problem?

Since you're effectively using signal handling to cause a false pending
signal indication, surely the correct cleanup is to re-calculate the
pending signal indication.  That way, we won't be throwing away signals.

I'm also wondering if there could be a problem with (ab)using TASK_STOPPED
here - could a stopped task be woken prematurely and thereby sent spinning
in refrigerator() by a non-stopped process sending a SIGCONT at just the
right time?

Maybe we want a TASK_FROZEN state to describe the "frozen, may not be woken
by anything except thawing" state?

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
