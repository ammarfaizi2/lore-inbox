Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264927AbUAKOVi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 09:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265871AbUAKOVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 09:21:38 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:37331 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264927AbUAKOVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 09:21:36 -0500
Date: Sun, 11 Jan 2004 15:21:10 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Berg Larsen <pebl@math.ku.dk>
Cc: Gunter =?iso-8859-1?Q?K=F6nigsmann?= <gunter.koenigsmann@gmx.de>,
       linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync loss (With Patch).
Message-ID: <20040111142110.GA28148@ucw.cz>
References: <20040111081046.GA25497@ucw.cz> <Pine.LNX.4.40.0401111326480.16947-100000@shannon.math.ku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0401111326480.16947-100000@shannon.math.ku.dk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 01:46:41PM +0100, Peter Berg Larsen wrote:

> On Sun, 11 Jan 2004, Vojtech Pavlik wrote:
> 
> > > I dont have a machine with active multiplexing so the the patch is
> > > untested. It warns when the mouse is removed, and tries to recover
> > > if multiplexing is disabled.
> >
> > It's nice, but er definitely shouldn't call i8042_enable_mux() from the
> > interrupt handler, because i8042_command() waits for characters arriving
> > in the interrupt handler, so we could get into rather nasty recursions.
> 
> Are you sure? The i8042_command does spin_lock_irqsave(&i8042_lock,
> flags), i8042_wait_read, i8042_read_data and unlock. It seems a good place
> for me as the 8042s buffer is just flush by the interrupt. Well except for
> the fact it is in the interrupt handler :)

Ahh, yeah, I forgot. Gee, and I wrote i8042_command.

> I cannot see a simple/fast solution: All data read in the interrupt must
> be processed otherwise kbd data might be lost. I dont want
> I8042_BUFFER_SIZE calls to serio_rescan/reconnect, as serio is not smart
> enought to only do it once. The mux port number(s) must be remembered if
> serio is called after the loop. I dont like any further calls to
> i8042_flush as it troughs away both kbd and aux data.

Consider the loop gone. It already is in my version.

> hmm, I actually want the handler to look something like:
> 
>  if (str & I8042_STR_MUXERR)
>           i8042_handle_aux_data
>  else
>           i8042_handle_kbd_data
> 
> That way i8042_flush can call handle_*_data depending on what to flush.
> 
> Peter
 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
