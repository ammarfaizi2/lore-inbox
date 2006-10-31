Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423698AbWJaWYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423698AbWJaWYx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 17:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423706AbWJaWYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 17:24:53 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:60048 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423698AbWJaWYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 17:24:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fRmF8o/cLF4f2SDlChaKKJHCTd+pCr60nga1fMLmK6oNIk4Ml8Ekb0nMsvXdN3TN/sa+mzsEgEMpW8rnGPVs79dOEIH9kmcUsNWA7NLAThlYs6VWHYXrtIUnCtOZ1g4WojV6CwV0hbqy9TgZLGCYWZY50HzgeJPBIjFdyrzlJks=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [PATCH] Fix potential NULL pointer dereference in echoaudio midi.
Date: Tue, 31 Oct 2006 23:26:31 +0100
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, Giuliano Pochini <pochini@shiny.it>,
       Takashi Iwai <tiwai@suse.de>, Jesper Juhl <jesper.juhl@gmail.com>
References: <200610312221.41089.jesper.juhl@gmail.com> <Pine.LNX.4.64N.0610311411000.2572@attu4.cs.washington.edu>
In-Reply-To: <Pine.LNX.4.64N.0610311411000.2572@attu4.cs.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610312326.31526.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 October 2006 23:13, David Rientjes wrote:
> On Tue, 31 Oct 2006, Jesper Juhl wrote:
> 
> > In sound/pci/echoaudio/midi.c::snd_echo_midi_output_write(), there's a risk
> > of dereferencing a NULL 'chip->midi_out'.
> > This patch contains the obvious fix as also used a bit higher up in the 
> > same function.
> > 
> 
> How about just adding an early test:
> 	if (!chip->midi_out)
> 		goto out;
> 
> and adding a label for out before the chip->lock unlock?  We still need to 
> clear chip->midi_full so we still require the spinlock, but there's no 
> reason we should be testing chip->midi_out multiple times since the 
> remaining code path in its entirety depends on it.
> 

Sure, that's an alternative solution. Probably a superiour one since, as 
you say, we'll then only be testing 'chip->midi_out' once.

Here's a patch that makes that change instead.
I'll leave it up to the powers-that-be to pick the one they like best :)


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff --git a/sound/pci/echoaudio/midi.c b/sound/pci/echoaudio/midi.c
index e31f0f1..0385b4e 100644
--- a/sound/pci/echoaudio/midi.c
+++ b/sound/pci/echoaudio/midi.c
@@ -213,7 +213,9 @@ static void snd_echo_midi_output_write(u
 	sent = bytes = 0;
 	spin_lock_irqsave(&chip->lock, flags);
 	chip->midi_full = 0;
-	if (chip->midi_out && !snd_rawmidi_transmit_empty(chip->midi_out)) {
+	if (!chip->midi_out)
+		goto out;
+	if (!snd_rawmidi_transmit_empty(chip->midi_out)) {
 		bytes = snd_rawmidi_transmit_peek(chip->midi_out, buf,
 						  MIDI_OUT_BUFFER_SIZE - 1);
 		DE_MID(("Try to send %d bytes...\n", bytes));
@@ -243,6 +245,7 @@ static void snd_echo_midi_output_write(u
 		mod_timer(&chip->timer, jiffies + (time * HZ + 999) / 1000);
 		DE_MID(("Timer armed(%d)\n", ((time * HZ + 999) / 1000)));
 	}
+ out:
 	spin_unlock_irqrestore(&chip->lock, flags);
 }
 


