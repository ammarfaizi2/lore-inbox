Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbTIPKSJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 06:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTIPKSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 06:18:09 -0400
Received: from mail-06.iinet.net.au ([203.59.3.38]:27349 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261824AbTIPKSF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 06:18:05 -0400
Message-ID: <3F66E360.9090101@ii.net>
Date: Tue, 16 Sep 2003 18:18:08 +0800
From: Wade <neroz@ii.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Yu Chen <dychen@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix memleak in emu10k1/midi.c (was: Re: [CHECKER] 32 Memory
 Leaks on Error Paths)
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
In-Reply-To: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
Content-Type: multipart/mixed;
 boundary="------------010306030001070703060207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010306030001070703060207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David Yu Chen wrote:
> Hi All,
> 
[snip]
> [FILE:  2.6.0-test5/sound/oss/emu10k1/midi.c]
> [FUNC:  emu10k1_seq_midi_open]
> [LINES: 498-514]
> [VAR:   midi_dev]
>  493:	if (card->open_mode)		/* card is opened native */
>  494:		return -EBUSY;
>  495:			
>  496:	DPF(2, "emu10k1_seq_midi_open()\n");
>  497:	
> START -->
>  498:	if ((midi_dev = (struct emu10k1_mididevice *) kmalloc(sizeof(*midi_dev), GFP_KERNEL)) == NULL)
>  499:		return -EINVAL;
>  500:
>  501:	midi_dev->card = card;
>  502:	midi_dev->mistate = MIDIIN_STATE_STOPPED;
>  503:	init_waitqueue_head(&midi_dev->oWait);
>         ... DELETED 5 lines ...
>  509:
>  510:	dsCardMidiOpenInfo.refdata = (unsigned long) midi_dev;
>  511:
>  512:	if (emu10k1_mpuout_open(card, &dsCardMidiOpenInfo) < 0) {
>  513:		ERROR();
> END -->
>  514:		return -ENODEV;
>  515:	}
>  516:
>  517:	card->seq_mididev = midi_dev;
>  518:		
>  519:	return 0;
> ---------------------------------------------------------


Can I ask again why the Checker is not released? I know that you don't 
have to release the source since you are not distributing it, but why 
not? AFAICS this would be a great asset to Open Source projects in 
general, not just the kernel.

(Patch correct? looked obvious)




--------------010306030001070703060207
Content-Type: text/plain;
 name="emu10k1_midi_memleak.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="emu10k1_midi_memleak.diff"

--- linux-2.6.0-test5.old/sound/oss/emu10k1/midi.c	2003-09-09 21:24:39.000000000 +0800
+++ linux-2.6.0-test5.new/sound/oss/emu10k1/midi.c	2003-09-16 18:08:23.000000000 +0800
@@ -511,6 +511,7 @@
 
 	if (emu10k1_mpuout_open(card, &dsCardMidiOpenInfo) < 0) {
 		ERROR();
+		kfree(midi_dev);
 		return -ENODEV;
 	}
 

--------------010306030001070703060207--

