Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276642AbRJ2ROm>; Mon, 29 Oct 2001 12:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276766AbRJ2ROc>; Mon, 29 Oct 2001 12:14:32 -0500
Received: from tangens.hometree.net ([212.34.181.34]:420 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S276642AbRJ2ROR>; Mon, 29 Oct 2001 12:14:17 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: Linux 2.4.13-ac4
Date: Mon, 29 Oct 2001 17:14:53 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9rk2qd$li0$1@forge.intermeta.de>
In-Reply-To: <20011029084736.A3152@suse.cz> <E15yA5r-0002Ha-00@the-village.bc.nu> <20011029173853.B4041@suse.cz>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1004375693 21130 212.34.181.4 (29 Oct 2001 17:14:53 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 29 Oct 2001 17:14:53 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

>On Mon, Oct 29, 2001 at 10:56:35AM +0000, Alan Cox wrote:
>> > bytes read from the 8254 get swapped. I've got some indirect evidence
>> > that this also could happen with the original i8254. 
>> 
>> Im hoping not. That would imply we interrupted someone half way through
>> reading the counter which means the locking is screwed up.

>Some old DOS assembly sources say that this sometimes happens without
>any interrupts at all - just that the chip is sometimes confused. It'd

Hm. If this is like the 8253 (ugh, way way back in the good old 8085
days I really wired and programmed such a bugger on my CP/M system...), 
then the problem is, that the 16 bit counter is read in two 8 bit portions. 
And if you do this:

   Hi        Lo

 00000000 11111111   ----> read low byte:   11111111

Counter increments

 00000001 00000000   ----> read high byte:  00000001

=> Counter is 00000001 11111111 which is wrong. :-) 

Sames goes for decrement, I have forgotten in which direction this
bugger counts.

There was a trick when CPUs had much less MHz:

read low byte   -> A
read high byte  -> B
read low byte   -> C

If A and C are the same, then the counter didn't change while reading:

byte a, b, c;

a = inb(lowbyte);

for(;;) {
  b = inb(hibyte);
  c = inb(lobyte);
  if(c == a)
    break;
  a = c;
}

result = b<<8+a;

This assumes that you can't get _two_ changes in the high byte while
reading the ports in a row.

>be definitely worth printing the bad and good values when a problem is
>detected, so that we know what's happening.

This will happen all the time, so printing out is neither a good idea
nor is the read problem described above an error. It is just a quirk
in using an 8 bit chip in an 16 bit environment without being able to
"latch" the count.

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
