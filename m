Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287748AbSAAFCd>; Tue, 1 Jan 2002 00:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287744AbSAAFCY>; Tue, 1 Jan 2002 00:02:24 -0500
Received: from femail24.sdc1.sfba.home.com ([24.0.95.149]:52163 "EHLO
	femail24.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S287750AbSAAFCJ>; Tue, 1 Jan 2002 00:02:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: New Scheduler and Digital Signal Processors?
Date: Mon, 31 Dec 2001 16:00:26 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020101050208.OMXO20896.femail24.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've heard several people (including Alan) talk about banging on the 
scheduler to make 8-way systems happy, and the first scheduler surgery patch 
has apparently been accepted to 2.5 now.  Lots of people are talking about a 
scheduler patch with a per-processor task queue, so I'd like to ask a 
question.

What would be involved in a non-symmetrical multi-processor Linux?  Have the 
per-processor task queues, but have them be different types of processes 
using different machine languages?

The reason I ask is TI has a new chip with a DSP built into it, and DSPs are 
eventually bound to replace all the dedicated I/O chips we've got today.  A 
DSP is just a dedicated I/O processor, they can act like modems, sound and 
video, 3D accelerators, USB interface, serial/paralell/joystick, ethernet, 
802.11b wireless and bluetooth...  Just hook it up to the right output 
adapter and feed the DSP the right program and boom, it works.

In theory, you could stick a $5 after-market adapter on the output of your 
DSP video to convert from a VGA plug to a TV plug, and reprogram the DSP to 
produce a different output signal with a driver upgrade.  In software.  Ooh.

DSP is just a processor designed to do I/O. It runs a program telling it how 
to convert input into output.  Ooh.  This is half of unix programming, and 
why we have the pipe command, only now you can unload each pipe stage on a 
dedicated coprocessor, so you can program your sound output chip to do speech 
synthesis or decompress MP3's.  And latency becomes way less of a problem if 
you can dedicate a processor to it.  (Think of a DMA channel that can run a 
filter program on the data it's transporting, and boom: you've got a DSP.)  
In theory, anything you can write as a filter that sits on a pipe could be 
done by a DSP, and in the Unix philosophy that's just about everything.

Now combine together every strange niche I/O chip you've got now and make ONE 
of the suckers, in massive volume, and think "economies of scale".  These 
suckers are going to be CHEAP.  And low power.  The portable market seems to 
be drooling over them, and they're already coming embedded into next 
generation processors.  (A math coprocessor, a built-in DSP...  I heard 
there's an ARM generation in development that's got 4 DSPs built-in...)  A 
machine with a lot of DSPs was half of Steve Jobs' "NeXT" box idea...

So, back to the Linux scheduler.  Right now our approach to these things is 
(if I understand correctly) to feed 'em their program like firmware.  Load 
the driver, DSP gets its program, and it's dedicated to that task.  Okay, 
fun.  And considering lots of them are hooked up to specific I/O devices at 
the other end (an 802.11b antenna, an ethernet jack, etc) that makes sense.

But there's already a company out there (www.dsplinux.net, proprietary dudes) 
that SEEMS to be treating a DSP like a seperate processor, capable of 
scheduling tasks to the DSP (think dynamic DMA channel allocation, I'm not 
sure how the electronics work out here: it would make sense to be able to 
allocate and deallocate them like any other resource, but this is giving 
hardware makers far too much credit).  Considering the range of applications 
you can have for sound cards alone (be a modem, text to speech, midi, mp3 
decompression, mp3 compression during recording, ogg vorbis, etc), wouldn't 
it be nice to be able to program DSPs a little more dynamically than "device 
driver shows it how to be a sound card"?

Right now, the scheduler has sort of been hacked by some people to have the 
concept of "realtime tasks" and "not realtime tasks".  But if you think that 
in five or ten years we may see machines built ENTIRELY out of DSPs (sort of 
like RISC, only more so).  The hyper-multi-threading whatsis thing they're 
doing with the P4 is sort of like this: they have execution cores linked for 
performance and now they're de-linking them because the programmer's better 
at finding paralellism than the hardware is.

Think about the 3D accelerator problem.  Break your screen up into 16 
sections, one DSP sorts the triangles into each quadrant, 16 other DSPs blast 
triangles to frame buffer, and then one more DSP is constantly doing a DMA 
write to the video output to drive your LCD panel at 70hz.  3D acceleration 
becomes a question of having enough DSPs, fast enough, and feeding them the 
right software.  80 million triangles per second is the human visual 
perception threshold, beyond that nvidia's binary-only drivers can go hang...

Am I totally on the wrong track here?  When do we start worrying about this?

Rob

P.S.  The appeal of USB largely seems to be "generic DSP spewing data out to 
some device with another DSP in it, using a known protocol to communicate and 
standard commodity wiring so everything has the same type of plug so you 
don't need adapters.  And the device on the far end may have a little buffer 
if you're lucky".  USB is something we queue requests up for right now, but 
this strikes me as something the paradigm of being able to schedule tasks to 
the DSP might fit?  Maybe not as time slices, but perhaps as something like 
tasklets?
