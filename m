Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265851AbUAKMqs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 07:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265860AbUAKMqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 07:46:48 -0500
Received: from imf.math.ku.dk ([130.225.103.32]:20650 "EHLO imf.math.ku.dk")
	by vger.kernel.org with ESMTP id S265851AbUAKMqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 07:46:46 -0500
Date: Sun, 11 Jan 2004 13:46:41 +0100 (CET)
From: Peter Berg Larsen <pebl@math.ku.dk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Gunter =?iso-8859-1?Q?K=F6nigsmann?= <gunter.koenigsmann@gmx.de>,
       <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync
 loss (With Patch).
In-Reply-To: <20040111081046.GA25497@ucw.cz>
Message-ID: <Pine.LNX.4.40.0401111326480.16947-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 Jan 2004, Vojtech Pavlik wrote:

> > I dont have a machine with active multiplexing so the the patch is
> > untested. It warns when the mouse is removed, and tries to recover
> > if multiplexing is disabled.
>
> It's nice, but er definitely shouldn't call i8042_enable_mux() from the
> interrupt handler, because i8042_command() waits for characters arriving
> in the interrupt handler, so we could get into rather nasty recursions.

Are you sure? The i8042_command does spin_lock_irqsave(&i8042_lock,
flags), i8042_wait_read, i8042_read_data and unlock. It seems a good place
for me as the 8042s buffer is just flush by the interrupt. Well except for
the fact it is in the interrupt handler :)

I cannot see a simple/fast solution: All data read in the interrupt must
be processed otherwise kbd data might be lost. I dont want
I8042_BUFFER_SIZE calls to serio_rescan/reconnect, as serio is not smart
enought to only do it once. The mux port number(s) must be remembered if
serio is called after the loop. I dont like any further calls to
i8042_flush as it troughs away both kbd and aux data.

hmm, I actually want the handler to look something like:

 if (str & I8042_STR_MUXERR)
          i8042_handle_aux_data
 else
          i8042_handle_kbd_data

That way i8042_flush can call handle_*_data depending on what to flush.

Peter



