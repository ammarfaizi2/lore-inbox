Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129230AbRBES26>; Mon, 5 Feb 2001 13:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbRBES2s>; Mon, 5 Feb 2001 13:28:48 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:50439 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129230AbRBES2i>;
	Mon, 5 Feb 2001 13:28:38 -0500
Message-ID: <3A7EF0A7.343D5B7A@mandrakesoft.com>
Date: Mon, 05 Feb 2001 13:27:51 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mharrell@bittwiddlers.com
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.{1,2pre1} oops in via82cxxx_audio (?)
In-Reply-To: <20010205104406.A10978@bittwiddlers.com> <200102051819.KAA31027@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------83D39AC51830134B7ED64180"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------83D39AC51830134B7ED64180
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> mharrell@bittwiddlers.com
> >Just realized that some of those symbols were defined in the via82cxxx_audio
> >module and I needed to load it to get them recognized.  As long as I don't
> >play any sounds the module will load fine so here is the new and improved
> >ksymoops output

> >>>EIP; d883a0a0 <[via82cxxx_audio]via_intr_channel+90/120>   <=====
> >Trace; d883a15f <[via82cxxx_audio]via_interrupt+2f/70>
> >Trace; c010a2bf <handle_IRQ_event+2f/60>
> >Trace; c010a43e <do_IRQ+6e/b0>
> >Trace; c0108f80 <ret_from_intr+0/20>
> >Trace; c01f480a <acpi_idle+1ea/2b0>
> >Trace; c01f4620 <acpi_idle+0/2b0>
> >Trace; c0107130 <default_idle+0/30>
> >Trace; c01071c2 <cpu_idle+42/60>
> >Trace; c0105000 <empty_bad_page+0/1000>
> >Trace; c0100191 <L6+0/2>
> >Code;  d883a0a0 <[via82cxxx_audio]via_intr_channel+90/120>
> >00000000 <_EIP>:
> >Code;  d883a0a0 <[via82cxxx_audio]via_intr_channel+90/120>   <=====
> >   0:   89 44 f2 04               mov    %eax,0x4(%edx,%esi,8)   <=====

Ouch.  After applying the attached patch, do any of the assertions
trigger?  (You should get a message 'Assertion failed! ...' right before
the oops)

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
--------------83D39AC51830134B7ED64180
Content-Type: text/plain; charset=us-ascii;
 name="via.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via.patch"

Index: drivers/sound/via82cxxx_audio.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/sound/via82cxxx_audio.c,v
retrieving revision 1.1.1.11.2.1
diff -u -r1.1.1.11.2.1 via82cxxx_audio.c
--- drivers/sound/via82cxxx_audio.c	2001/02/04 19:07:03	1.1.1.11.2.1
+++ drivers/sound/via82cxxx_audio.c	2001/02/05 18:24:48
@@ -1649,6 +1649,9 @@
 	u8 status;
 	int n;
 
+	assert (chan != NULL);
+	assert (chan->sgtable != NULL);
+
 	/* check pertinent bits of status register for action bits */
 	status = inb (chan->iobase) & (VIA_SGD_FLAG | VIA_SGD_EOL | VIA_SGD_STOPPED);
 	if (!status)
@@ -1728,6 +1731,8 @@
 {
 	struct via_info *card = dev_id;
 	u32 status32;
+
+	assert (card != NULL);
 
 	/* to minimize interrupt sharing costs, we use the SGD status
 	 * shadow register to check the status of all inputs and

--------------83D39AC51830134B7ED64180--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
