Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286196AbRLTHhv>; Thu, 20 Dec 2001 02:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286195AbRLTHha>; Thu, 20 Dec 2001 02:37:30 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:49414
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S286194AbRLTHhT>; Thu, 20 Dec 2001 02:37:19 -0500
Message-Id: <5.1.0.14.2.20011220022218.01dc2258@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 20 Dec 2001 02:31:44 -0500
To: "David S. Miller" <davem@redhat.com>, Mika.Liljeberg@welho.com
From: Stevie O <stevie@qrpff.net>
Subject: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
Cc: kuznet@ms2.inr.ac.ru, Mika.Liljeberg@nokia.com,
        linux-kernel@vger.kernel.org, sarolaht@cs.helsinki.fi
In-Reply-To: <20011218.122813.63057831.davem@redhat.com>
In-Reply-To: <3C1FA558.E889A00D@welho.com>
 <200112181837.VAA10394@ms2.inr.ac.ru>
 <3C1FA558.E889A00D@welho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:28 PM 12/18/2001 -0800, David S. Miller wrote:
>Unaligned kernel loads and stores must be properly handled by the
>platform code, and on ARM chips where that is possible it is.

I don't know what arch you're using, but I work with ARM7TDMI, which has a 
behavior I believe can be found documented in some obscure .pdf from arm.com:

Unaligned accesses wrap.

If you have this:

[mem.] 00 01 02 03  04 05 06 07
[data] 00 11 22 33  44 55 66 77

in little-endian mode,

*(int*)0x00 == 0x33221100
*(int*)0x01 == 0x00332211
*(int*)0x02 == 0x11003322
*(int*)0x03 == 0x22110033
*(int*)0x04 == 0x77665544

At least, that's how ARM's docs seem to describe it. I work with this cpu 
embedded in a microcontroller (AT91M40800), and these values result:

*(int*)0x00 == 0x33221100
*(int*)0x01 == 0x33221100
*(int*)0x02 == 0x33221100
*(int*)0x03 == 0x33221100
*(int*)0x04 == 0x77665544

An unaligned access to an assembly-declared variable caused me much grief 
once, overwriting the task scheduler's ready-to-run list under certain 
conditions...

The moral of the story:
RISC cpus abhor unaligned accesses.


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

