Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284472AbRLRS2D>; Tue, 18 Dec 2001 13:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284451AbRLRS1y>; Tue, 18 Dec 2001 13:27:54 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:19173 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284472AbRLRS1n>; Tue, 18 Dec 2001 13:27:43 -0500
Message-ID: <3C1F8A9E.3050409@redhat.com>
Date: Tue, 18 Dec 2001 13:27:42 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011211
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33.0112181216341.1237-100000@admin> <Pine.LNX.4.33.0112180922500.2867-100000@penguin.transmeta.com> <20011218105459.X855@lynx.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

> On Dec 18, 2001  09:27 -0800, Linus Torvalds wrote:
> 
>>Maybe the best thing to do is to educate the people who write the sound
>>apps for Linux (somebody was complaining about "esd" triggering this, for
>>example).
>>
> 
> Yes, esd is an interrupt hog, it seems.  When reading this thread, I
> checked, and sure enough I was getting 190 interrupts/sec on the
> sound card while not playing any sound.  I killed esd (which I don't
> use anyways), and interrupts went to 0/sec when not playing sound.
> Still at 190/sec when using mpg123 on my ymfpci (Yamaha YMF744B DS-1S)
> sound card.


Weel, evidently esd and artsd both do this (well, I assume esd does now, it 
didn't do this in the past).  Basically, they both transmit silence over the 
sound chip when nothing else is going on.  So even though you don't hear 
anything, the same sound output DMA is taking place.  That avoids things 
like nasty pops when you start up the sound hardware for a beep and that 
sort of thing.  It also maintains state where as dropping output entirely 
could result in things like module auto unloading and then reloading on the 
next beep, etc.  Personally, the interrupt count and overhead annoyed me 
enough that when I started hacking on the i810 sound driver one of my 
primary goals was to get overhead and interrupt count down.  I think I 
suceeded quite well.  On my current workstation:

Context switches per second not playing any sound: 8300 - 8800
Context switches per second playing an MP3: 9200 - 9900
Interrupts per second from sound device: 86
%CPU used when not playing MP3: 0 - 3% (magicdev is a CPU pig once every 2 
seconds)
%CPU used when playing MP3s: 0 - 4%

In any case, it might be worth the original poster's time in figuring out 
just how much of his lost CPU is because of playing sound and how much is 
actually caused by the windowing system and all the associated bloat that 
comes with it now a days.





-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

