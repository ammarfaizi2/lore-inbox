Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264225AbUFUPG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264225AbUFUPG6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 11:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbUFUPG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 11:06:58 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:821 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264225AbUFUPG4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 11:06:56 -0400
Message-ID: <40D6F986.3010904@microgate.com>
Date: Mon, 21 Jun 2004 10:06:46 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 0.7 (Windows/20040616)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Aloni <da-x@colinux.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing NULL check in drivers/char/n_tty.c
References: <20040621063845.GA6379@callisto.yi.org> <20040620235824.5407bc4c.akpm@osdl.org> <20040621073644.GA10781@callisto.yi.org> <20040621003944.48f4b4be.akpm@osdl.org> <20040621082430.GA11566@callisto.yi.org>
In-Reply-To: <20040621082430.GA11566@callisto.yi.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni wrote:
> Andrew Morton wrote:
> I did a quick grep and it appears that all drivers have set ->chars_in_buffer().
>
> I suspect there are no drivers which fail to set chars_in_buffer. 
> Otherwise normal_poll() would have been oopsing in 2.4, 2.5 and 2.6?

An addition should be made to include/linux/tty_driver.h
to document the chars_in_buffer member of struct tty_driver
and struct tty_operations as a required function.
Currently, the documentation section of this header
does not mention chars_in_buffer.

Related issue:

In looking at this, I noticed struct tty_ldisc
(include/linux/tty_ldisc.h) defines and documents
an optional (optional == NULL) member chars_in_buffer.
N_TTY (drivers/char/n_tty.c) is the only line discipline
that implements this member.

drivers/char/pty.c is the only driver that
uses ldisc.chars_in_buffer, and it checks for
ldisc.chars_in_buffer == NULL before calling.

13 other drivers call ldisc.chars_in_buffer without checking
for ldisc.chars_in_buffer == NULL, but only inside conditional
compilation for debug output. The value is not used, only logged.
These conditional debug items look like cut and paste from
one serial driver to another, and I doubt
they have been recently used (or used at all).

Which would be better?
1. Ignore this
2. Fix conditional debug output to check
    for ldisc.chars_in_buffer==NULL
3. Remove conditional debug output

--
Paul Fulghum
paulkf@microgate.com
