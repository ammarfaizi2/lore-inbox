Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWGGRXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWGGRXa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWGGRXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:23:30 -0400
Received: from javad.com ([216.122.176.236]:58123 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S932221AbWGGRXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:23:24 -0400
From: Sergei Organov <osv@javad.com>
To: Andrew Morton <akpm@osdl.org>
Cc: gregkh@suse.de, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
 transfers
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<20060630001021.2b49d4bd.akpm@osdl.org>
Date: Fri, 07 Jul 2006 21:23:01 +0400
In-Reply-To: <20060630001021.2b49d4bd.akpm@osdl.org> (Andrew Morton's
 message
	of "Fri, 30 Jun 2006 00:10:21 -0700")
Message-ID: <87veq9cosq.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
> On Fri, 30 Jun 2006 01:48:02 -0400
> Andy Gay <andy@andynet.net> wrote:
[...]
>> +	if (tty && urb->actual_length) {
>> +		tty_buffer_request_room(tty, urb->actual_length);
>> +		tty_insert_flip_string(tty, data, urb->actual_length);
>
> Is it correct to ignore the return value from those two functions?
>
>> +		tty_flip_buffer_push(tty);

It seems that there is much worse problem here. The amount of data that
has been inserted by the tty_insert_flip_string() could be up to
URB_TRANSFER_BUFFER_SIZE (=4096 bytes) and may easily exceed
TTY_THRESHOLD_THROTTLE (=128 bytes) defined in the
char/n_tty.c. Pushing this data to the n_tty line discipline may then
overflow the line discipline buffer resulting in silent data loss. The
line discipline will call throttle() callback some time later then, but
it will be too late :(

This problem I've seen in my own driver with 2.4.x kernels, and I had
just re-checked it still exists with 2.6.17.4 kernel [had a hope Alan
changes to tty buffers fixed it, but no luck]. Besides, there are at
least 2 drivers in the kernel tree that try to deal with this problem,
char/hvsi.c, and serial/crisv10.c. For example, here is comment from
hvsi.c:

/*
 * We could get 252 bytes of data at once here. But the tty layer only
 * throttles us at TTY_THRESHOLD_THROTTLE (128) bytes, so we could overflow
 * it. Accordingly we won't send more than 128 bytes at a time to the flip
 * buffer, which will give the tty buffer a chance to throttle us. Should the
 * value of TTY_THRESHOLD_THROTTLE change in n_tty.c, this code should be
 * revisited.
 */

So, how is it supposed to work? Am I missing something?

Please also notice that attempts to overcome the problem in the drivers
look like fragile hacks that depend on intimate details of particular
line discipline. Any ideas how to fix it in general? Nice occasion to
apply "stable interfaces are evil" once again? ;)

-- 
Sergei.
