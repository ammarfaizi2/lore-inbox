Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263060AbRFNPOd>; Thu, 14 Jun 2001 11:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263049AbRFNPOX>; Thu, 14 Jun 2001 11:14:23 -0400
Received: from alpo.casc.com ([152.148.10.6]:15504 "EHLO alpo.casc.com")
	by vger.kernel.org with ESMTP id <S263043AbRFNPOQ>;
	Thu, 14 Jun 2001 11:14:16 -0400
From: John Stoffel <stoffel@casc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15144.54236.903016.433760@gargle.gargle.HOWL>
Date: Thu, 14 Jun 2001 11:10:20 -0400
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Rik van Riel <riel@conectiva.com.br>, Tom Sightler <ttsig@tuxyturvy.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6-pre2, pre3 VM Behavior
In-Reply-To: <01061410474103.00879@starship>
In-Reply-To: <Pine.LNX.4.21.0106140013000.14934-100000@imladris.rielhome.conectiva>
	<01061410474103.00879@starship>
X-Mailer: VM 6.92 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> The file _could_ be a temporary file, which gets removed before
>> we'd get around to writing it to disk. Sure, the chances of this
>> happening with a single file are close to zero, but having 100MB
>> from 200 different temp files on a shell server isn't unreasonable
>> to expect.

Daniel> This still doesn't make sense if the disk bandwidth isn't
Daniel> being used.

And can't you tell that a certain percentage of buffers are owned by a
single file/process?  It would seem that a simple metric of

       if ##% of the buffer/cache is used by 1 process/file, start
       writing the file out to disk, even if there is no pressure.

might to the trick to handle this case.  

>> Maybe we should just see if anything in the first few MB of
>> inactive pages was freeable, limiting the first scan to something
>> like 1 or maybe even 5 MB maximum (freepages.min?  freepages.high?)
>> and flushing as soon as we find more unfreeable pages than that ?

Daniel> For file-backed pages what we want is pretty simple: when 1)
Daniel> disk bandwidth is less than xx% used 2) memory pressure is
Daniel> moderate, just submit whatever's dirty.  As pressure increases
Daniel> and bandwidth gets loaded up (including read traffic) leave
Daniel> things on the inactive list longer to allow more chances for
Daniel> combining and better clustering decisions.

Would it also be good to say that pressure should increase as the
buffer.free percentage goes down?  It won't stop you from filling the
buffer, but it should at least start pushing out pages to disk
earlier.  

John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548
