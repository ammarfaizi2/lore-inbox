Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264053AbRFNVen>; Thu, 14 Jun 2001 17:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264072AbRFNVec>; Thu, 14 Jun 2001 17:34:32 -0400
Received: from alpo.casc.com ([152.148.10.6]:38360 "EHLO alpo.casc.com")
	by vger.kernel.org with ESMTP id <S264053AbRFNVeT>;
	Thu, 14 Jun 2001 17:34:19 -0400
From: John Stoffel <stoffel@casc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15145.11683.861734.853957@gargle.gargle.HOWL>
Date: Thu, 14 Jun 2001 17:33:23 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: John Stoffel <stoffel@casc.com>, Roger Larsson <roger.larsson@norran.net>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6-pre2, pre3 VM Behavior
In-Reply-To: <Pine.LNX.4.33.0106141750260.28370-100000@duckman.distro.conectiva>
In-Reply-To: <15145.8435.312548.682190@gargle.gargle.HOWL>
	<Pine.LNX.4.33.0106141750260.28370-100000@duckman.distro.conectiva>
X-Mailer: VM 6.92 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rik> There's another issue.  If dirty data is written out in small
Rik> bunches, that means we have to write out the dirty data more
Rik> often.

What do you consider a small bunch?  32k?  1Mb?  1% of buffer space?
I don't see how delaying writes until the buffer is almost full really
helps us.  As the buffer fills, the pressure to do writes should
increase, so that we tend, over time, to empty the buffer.  

A buffer is just that, not persistent storage.  

And in the case given, we were not seeing slow degradation, we saw
that the user ran into a wall (or inflection point in the response
time vs load graph), which was pretty sharp.  We need to handle that
more gracefully.  

Rik> This in turn means extra disk seeks, which can horribly interfere
Rik> with disk reads.

True, but are we optomizing for reads or for writes here?  Shouldn't
they really be equally weighted for priority?  And wouldn't the
Elevator help handle this to a degree?

Some areas to think about, at least for me.  And maybe it should be
read and write pressure, not rate?  

 - low write rate, and a low read rate.
   - Do seeks dominate our IO latency/throughput?

 - low read rate, higher write rate (ie buffers filling faster than
   they are being written to disk)
   - Do we care as much about reads in this case?  
   - If the write is just a small, high intensity burst, we don't want
     to go ape on writing out buffers to disk, but we do want to raise the
     rate we do so in the background, no?

- low write rate, high read rate.
  - seems like we want to keep writing the buffers, but at a lower
    rate. 

Just some thoughts...

John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548
