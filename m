Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277375AbRJJTr3>; Wed, 10 Oct 2001 15:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277379AbRJJTrV>; Wed, 10 Oct 2001 15:47:21 -0400
Received: from maild.telia.com ([194.22.190.101]:58089 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S277375AbRJJTrI>;
	Wed, 10 Oct 2001 15:47:08 -0400
Message-Id: <200110101947.f9AJlI424270@maild.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Justin A <justin@bouncybouncy.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Buffers, dbench and latency
Date: Wed, 10 Oct 2001 21:42:10 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20011010003636Z271005-760+23005@vger.kernel.org> <20011010012500.A6551@bouncybouncy.net>
In-Reply-To: <20011010012500.A6551@bouncybouncy.net>
Cc: safemode <safemode@speakeasy.net>, Andrew Morton <akpm@zip.com.au>,
        Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I merge two comment... since they are related!

On Wednesday 10 October 2001 04:51, Andrea Arcangeli wrote:
> Of course if xmms runs after the soundcard dma ring dried out, then
> there will be a dropout, but it would need seconds of scheduler latency
> to generate such a dropout which isn't going to happen.

On Wednesday 10 October 2001 07:25, Justin A wrote:
> On Tue, Oct 09, 2001 at 08:36:56PM -0400, safemode wrote:
> > Heavily io bound processes (dbench 32)  still causes something as light
> > as an mp3 player to skip, though.   That probably wont be fixed intil
> > 2.5, since
>
> What buffer size are you using in your mp3 player?  I have xmms set to
> 5000ms or so and it never skips.  mpg321(esd or oss) also never skips no
> matter what I do, but the original mpg123-oss will with even light load
> on the cpu/disk.
>
> This is with 2.4.10-ac9+preempt on an athlon 700
>

5000 ms == 5 s of buffered audio, assume 44100 k samples/s of 16 bit and 2 
channels (5 channels is not that unusual) this gives a buffer of  882 kB ! or
215 pages! (Justin could probably fill in the actual details, but it does not 
really matter for the discussion below)

I do not think this is the size of the DMA ring buffer...

This is what I think is the situation, I have not read the xmms source - it 
could be implemented by one non blocking thread, but the analysis holds
anyway (IMHO):

* One thread reads from disk to a xmms ring buffer of 5000 ms, this will
   give that tread lots of time to try to keep it big enough.

* Another thread, reads from this buffer, and writes to the DMA ring buffer.
  (usually fragmented in several parts)
  When it gets full - this tread goes to sleep...

In this situation we could have two causes for dropouts.

* The second thread is really a RT tread. It gets woken up when one
  fragment has been used by the Audio DMA, i.e. new data can be
  written (often it got blocked in the write, and thus only needs to get
  the CPU for a brief moment). But it has to react in time...

  Checking the source for emu10k1:
  default fragment length is 20 ms, total default bufflen is 500 ms
  but, maximum buff size is 65536 Bytes = 16 pages
  this gives a DMA buffer time in our example (44100 16 bit, stereo) 
  of: 370 ms

  So this process has an absolute RT limit of 370 ms, not seconds!
  + this is the part were different low latency approaches work, since
     you might stay in kernel for longer times than this, there are loops
     over page descriptors where used data might not be in cache...
     The 10 ms figure claimed for 2.4.10 is not the whole truth...
  + The process buffer needs to be locked in memory, as all code
     that needs to execute to read from it and write to DMA buffer.
     Since a 5 s buffer will be written, and then staying idle for 5 s,
     before it is used (read) the next time...

* The same for the other process - it has more time to spare, but
  it has to keep the process buffer with data. And it is usually some sort
  of CPU hog - decoding compressed audio streams. It has to get
  scheduled in and allowed to run.

Note: dbench threads as most IO limited ones behaves nice from a
  scheduler viewpoint - mostly waiting on IO resources.
  On my computer they use less CPU (0.3 % each) than
  artsd (10.8% and 1.1%) and noatune (1.9%). And that is not strange
  in any way since the audio processes actually has to do some
  calculations...

  Now the scheduler has to choose - a process mostly waiting on
  IO or one that actually uses a part of its time slice...

  If you are not running with lower nicelevel or SCHED_FIFO/RT
  to guarantee that you will be selected on next rescheduling - you
  will be in trouble...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
