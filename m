Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266296AbTAIMex>; Thu, 9 Jan 2003 07:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266408AbTAIMex>; Thu, 9 Jan 2003 07:34:53 -0500
Received: from oak.sktc.net ([208.46.69.4]:21950 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id <S266296AbTAIMew>;
	Thu, 9 Jan 2003 07:34:52 -0500
Message-ID: <3E1D6E2B.6060504@sktc.net>
Date: Thu, 09 Jan 2003 06:42:19 -0600
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021201
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Tonino <ttonino@users.sourceforge.net>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Asterisk] DTMF noise
References: <D6889804-2291-11D7-901B-000393950CC2@karlsbakk.net> <3E1BD88A.4080808@users.sf.net> <3E1C1CDE.8090600@sktc.net> <3E1C889F.70303@users.sf.net>
In-Reply-To: <3E1C889F.70303@users.sf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Tonino wrote:

> The original idea does one better by splitting high and low bands first. 

<snip>

> But it may be more expensive computationally than doing twice the number 
> of Goertzel filters.

Not really - the Goertzel filter is a fairly cheap filter. A filter to 
split the low band frequencies off from the high band, then doing the 8 
Goertzel filters for tone detection burns more MIPS than just doing the 
8 Goertzel filters. Furthurmore, the result is the same - you get the 
energies in the 8 tones.


> Harmonics seem like a bad idea. In between frequencies are better, but 
> using the total band energy must be the most sure way to detect 
> interference.
> 

Not really. The problem with the total energy approach is that the least 
amount of real noise will prevent tone detection, and if you set the 
threshold high enough that white noise does not prevent tone detection 
then you get falsing in voice.

If you have 1mW/Hz of white noise, then that is 2700 mW of noise power 
across the band. With voice, you get one of two types of "noise" - 
either voiced signals with lots of energy at harmonicly related 
frequencies, or unvoiced fricatives ("s", "f") that are basically white 
noise. A voiced signal with a total power of 2000 mW of power and a 
fundemental at one of the tone frequencies might have 1000 mW of power 
at the tone energy, and the remaining 1000 mW on the harmonics. Yet, if 
your noise threshold is set to not be blocked by the white noise case 
(2700 mW of power), then it would accept the voice case (1000 mW of power).

The 16 filter algorithm is the one we use in radio - it lets us pick a 
tone out of a staticy signal without falsing on voice.

It helps to think of looking at the signal on an audio spectrum analyzer 
- a DTMF tone looks like 2 peaks. If the signal in question has more 
than 2 peaks, it isn't DTMF.

