Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWFWN6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWFWN6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWFWN6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:58:00 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:26006
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750704AbWFWNlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:41:22 -0400
Message-ID: <449BEF80.2080301@microgate.com>
Date: Fri, 23 Jun 2006 08:41:20 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] kill TTY_DONT_FLIP
References: <1151002928.15500.21.camel@amdx2.microgate.com> <1151069137.4549.11.camel@localhost.localdomain>
In-Reply-To: <1151069137.4549.11.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Looks good to me on a first review.

I looked at the paths taken by n_tty_receive_buf()
for how they would effect read_chan():

* tty state (put_tty_queue,eraser,finish_erasing,etc)
* read wakeups
* start_tty/stop_tty
* put_char/opost

everything looks OK without TTY_DONT_FLIP

2.0.X relied on the BKL (and dinosaurs roamed the Earth)

2.1.X introduced TTY_DONT_FLIP to prevent read_chan and
n_tty_receive_buf from executing at the same time.

2.2.15 added tty->read_lock around the N_TTY read buffer,
which is the only thing needing protection in this context.

The usual progression to finer grained locking.
This looks like a safe removal.

The review also revealed a spot in reset_buffer_flags()
where tty->read_lock needs to be extended around
modifications of canon_head, canon_data, and read_flags.
I'll make a patch for that.

-- 
Paul Fulghum
Microgate Systems, Ltd.
