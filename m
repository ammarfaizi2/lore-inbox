Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267835AbTAHPlJ>; Wed, 8 Jan 2003 10:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267836AbTAHPlJ>; Wed, 8 Jan 2003 10:41:09 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:41621 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267835AbTAHPlF>; Wed, 8 Jan 2003 10:41:05 -0500
Reply-to: Wolfgang Fritz <wolfgang.fritz@gmx.net>
To: linux-kernel@vger.kernel.org
From: Wolfgang Fritz <wolfgang.fritz@gmx.net>
Subject: Re: [Asterisk] DTMF noise
Date: Wed, 08 Jan 2003 16:49:06 +0100
Organization: None
Message-ID: <3E1C4872.7080508@gmx.net>
References: <D6889804-2291-11D7-901B-000393950CC2@karlsbakk.net> <3E1BD88A.4080808@users.sf.net> <3E1C1CDE.8090600@sktc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en, de-de, de
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.7; AVE: 6.17.0.2; VDF: 6.17.0.12; host: gurke)
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.7; AVE: 6.17.0.2; VDF: 6.17.0.12; host: gurke)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David D. Hagood wrote:
 > Thomas Tonino wrote:
 >
 >> Roy Sigurd Karlsbakk wrote:
 >>
 >>> so - we DO NOT need a 'simplistic' DTMF decoder.
 >>
 >>
 >>
 >> You need a good one. But good can be simplistic, is what I'm saying.
 >>
 >> DTMF was designed to be easy to decode reliably. Complex doesn't
 >> automatically mean better.
 >>
 >
 > I haven't looked at the code, but I'd recommend using a bank of Goertzel
 > filters -
 >
 >
 > 
http://www.google.com/search?hl=en&lr=&ie=ISO-8859-1&q=Goertzel+filter+DTMF&btnG=Google+Search 

 >
 >
 > The basic idea is that you have 8 filters (for the 4 row and 4 column
 > frequencies), as well as 8 filters looking at the first harmonic of the
 > 8 frequencies. You then compare the energies in each frequency - if you
 > see significant energy in the harmonic filter bank, discard the signal.
 > That prevents you from detecting speech as DTMF, since speech will
 > usually have harmonics that a good DTMF signal won't.

That is done in the isdn_audio DTMF detection but did not work very well
with a number of phone sets I tested which seem to generate DTMF tones with
strong harmonics. They may be out of spec but they exist.

I have a patch which adds a simple energy comparison and some
plausablility checks to the DTMF eval code but does not look at the
harmonics. That improved the detection with above phone sets.

Maybe it would be better to reenable harmonic checks but comparing
harmonic levels to the level of the fundamental instead of using
absolute values as in the present implementation.

OTOH I don't think its a good approach to check harmonics anyway but to
check other non DTMF frequencies in the main speech band and only accept
a DTMF if a DTMF frequency pair is present but no signal on the non DTMF
frequencies (no signal = xxx dB below the detected DTMF levels).

There exists a long text about DTMF detection somewhere on the net (I 
may have the link in the office but I'm on vacation now). What I 
remember is that a "correct" DTMF detection requires much more computing 
power as the present i4l implementation needs (much longer audio samples 
for the goertzel filter, a larger number of frequencies to check) and a 
standard test procedure with a lot of test cases which are not available 
to mortal humans (audio tapes from Bellcore IIRC)

Wolfgang
 >
 > Since the Goertzel filters are simple, they can be implemented in fixed
 > point math rather than floating point. At work, we've done this on a
 > Motorola 56301 DSP, which is a fixed-point DSP. I think there's an app
 > note from Moto on this - I'll check when I get into work today.
 >
 > -
 > To unsubscribe from this list: send the line "unsubscribe 
linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/
 >




