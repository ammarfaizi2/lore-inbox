Return-Path: <linux-kernel-owner+w=401wt.eu-S965048AbWLTNg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbWLTNg3 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 08:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbWLTNg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 08:36:29 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:43168 "EHLO
	tirith.ics.muni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965048AbWLTNg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 08:36:29 -0500
Message-ID: <45893C1C.60305@gmail.com>
Date: Wed, 20 Dec 2006 14:35:24 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: locking issue (hardirq+softirq+user)
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

an user still gets NMI watchdog warning, that the machine deadlocked.

The code is something like this:

DEFINE_SPINLOCK(lock);

isr() /* i.e. hardirq context */
{
spin_lock(&lock);
...
spin_unlock(&lock);
}

timer() /* i.e. softirq context */
{
unsigned int f;
spin_lock_irqsave(&lock, f) /* stack shows, that it locks here */
...
spin_unlock_irqrestore(&lock, f)
...
mod_timer();
}

tty_open_or_whatever() /* i.e. user context */
{
unsigned int f;
spin_lock_irqsave(&lock, f)
...
spin_unlock_irqrestore(&lock, f)
}

init()
{
mod_timer();
request_irq();
register_that_open_with_something();
}

What's the correct locking approach in this situation? Is that correct (I tried
to go through Rusty Russel's guide to locking, but I didn't get it in this
case)? There were many spin_lock recursions in the driver
(drivers/char/isicom.c), which I removed, but it still deadlocks on SMP.

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
