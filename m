Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288102AbSA0P7g>; Sun, 27 Jan 2002 10:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288109AbSA0P7Q>; Sun, 27 Jan 2002 10:59:16 -0500
Received: from [212.204.66.1] ([212.204.66.1]:57359 "EHLO myway.myway.de")
	by vger.kernel.org with ESMTP id <S288102AbSA0P7G>;
	Sun, 27 Jan 2002 10:59:06 -0500
Message-Id: <200201271559.QAA28129@myway.myway.de>
From: "Daniela Engert" <dani@ngrt.de>
To: "Lionel.Bouton@inet6.fr" <Lionel.Bouton@inet6.fr>,
        "Martin Garton" <martin@wrasse.demon.co.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Sun, 27 Jan 2002 16:59:43 +0100 (CET)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.05
In-Reply-To: <Pine.LNX.4.33.0201271412110.32403-100000@wrasse.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: sis.patch.20020123_1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jan 2002 14:31:28 +0000 (GMT), Martin Garton wrote:

>I think I know whats wrong, but I'm not certain. I was expecting 
>pci_init_sis5513() to find the device SiS735, but it finds SiS5513 
>instead. (I understand that SiS735 is the host bridge, whereas SiS5513 is 
>the ide interface) Is my thinking correct?

Your chipset cannot be detected by the surrent SiS IDE patch because it
takes a list based approach to find supported chips and their
capabilities rather than a more intelligent detection scheme (I've sent
Lionel code which shows how to do that). Over time (often a very short
one) a device list is missing valid members. In your case, the SiS
driver doesn't know about your SiS737 chip and it defaults to the least
common denominator - the ancient SiS5513 IDE chip.

>I did a nasty hack to get the device recognised as SiS735, and all is 
>fine. I haven't posted my patch for this since I don't know the Right fix.

You just thave to add it to the device list. There are other chips
missing as well.

>The second problem I had was an OOPS when doing "cat /proc/ide/sis" . I
>think I have tracked this down, and I believe the attached patch fixes it.  

Well, it does but at the expense of correctness ;-)

> 		case ATA_66: p += sprintf(p, active_time[(reg01 & 0x07) >> 4]); break;
>-		case ATA_100: p += sprintf(p, active_time[(reg00 & 0x70)]); break;
>+		case ATA_100: p += sprintf(p, active_time[(reg00 & 0x07)]); break;

The problem is that the calculation of the index into the active time
table is incorrect in *all* three lines above! In the ATA66 case the
shift is wrong and causes an zero value regardless of the register
setting. In the "old" ATA100 case the index is calculated from the
correct bits but is missing the shift by four from the line above;
because of the too large index you see the OOPS. The "new" ATA100 case
is wrong because it takes the wrong bits into calculation.

Ciao,
  Dani


