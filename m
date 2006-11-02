Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752617AbWKBUSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbWKBUSo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 15:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbWKBUSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 15:18:43 -0500
Received: from smtp-out02.alice.it ([85.33.2.6]:56330 "EHLO
	smtp-out02.alice.it") by vger.kernel.org with ESMTP
	id S1752617AbWKBUSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 15:18:43 -0500
Date: Thu, 2 Nov 2006 21:16:09 +0100
From: Giuliano Pochini <pochini@shiny.it>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: rientjes@cs.washington.edu, linux-kernel@vger.kernel.org, tiwai@suse.de,
       jesper.juhl@gmail.com
Subject: Re: [PATCH] Fix potential NULL pointer dereference in echoaudio
 midi.
Message-Id: <20061102211609.7263ef9c.pochini@shiny.it>
In-Reply-To: <200610312326.31526.jesper.juhl@gmail.com>
References: <200610312221.41089.jesper.juhl@gmail.com>
	<Pine.LNX.4.64N.0610311411000.2572@attu4.cs.washington.edu>
	<200610312326.31526.jesper.juhl@gmail.com>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Nov 2006 20:18:38.0394 (UTC) FILETIME=[14DC81A0:01C6FEBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006 23:26:31 +0100
Jesper Juhl <jesper.juhl@gmail.com> wrote:

> On Tuesday 31 October 2006 23:13, David Rientjes wrote:
> > On Tue, 31 Oct 2006, Jesper Juhl wrote:
> > 
> > > In sound/pci/echoaudio/midi.c::snd_echo_midi_output_write(), there's a risk
> > > of dereferencing a NULL 'chip->midi_out'.
> > > This patch contains the obvious fix as also used a bit higher up in the 
> > > same function.
> > > 
> > 
> > How about just adding an early test:
> > 	if (!chip->midi_out)
> > 		goto out;


The point of that check is to make sure is doesn't access chip->midi_out
when (surprise!) it is NULL. This can only happen in the rare (possible?)
case snd_echo_midi_output_close() is called while the timer handler is
running. I have another proposal which IMHO is smp-safer that just moving
the check. In that case we should also put a spinlock around the
chip->midi_out=0 in the snd_echo_midi_output_close() callback.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-kernel/pci/echoaudio/midi.c__orig	2006-11-02 20:39:45.000000000 +0100
+++ alsa-kernel/pci/echoaudio/midi.c	2006-11-02 20:44:22.000000000 +0100
@@ -213,7 +213,7 @@ static void snd_echo_midi_output_write(u
 	sent = bytes = 0;
 	spin_lock_irqsave(&chip->lock, flags);
 	chip->midi_full = 0;
-	if (chip->midi_out && !snd_rawmidi_transmit_empty(chip->midi_out)) {
+	if (!snd_rawmidi_transmit_empty(chip->midi_out)) {
 		bytes = snd_rawmidi_transmit_peek(chip->midi_out, buf,
 						  MIDI_OUT_BUFFER_SIZE - 1);
 		DE_MID(("Try to send %d bytes...\n", bytes));
@@ -264,9 +264,11 @@ static void snd_echo_midi_output_trigger
 		}
 	} else {
 		if (chip->tinuse) {
-			del_timer(&chip->timer);
 			chip->tinuse = 0;
+			spin_unlock_irq(&chip->lock);
+			del_timer_sync(&chip->timer);
 			DE_MID(("Timer removed\n"));
+			return;
 		}
 	}
 	spin_unlock_irq(&chip->lock);


--
Giuliano.
