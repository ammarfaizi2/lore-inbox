Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287863AbSABQHM>; Wed, 2 Jan 2002 11:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287865AbSABQHD>; Wed, 2 Jan 2002 11:07:03 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:499 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S287863AbSABQG5>; Wed, 2 Jan 2002 11:06:57 -0500
Date: Wed, 2 Jan 2002 10:06:56 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200201021606.KAA37969@tomcat.admin.navo.hpc.mil>
To: landley@trommello.org, linux-kernel@vger.kernel.org
Subject: Re: New Scheduler and Digital Signal Processors?
In-Reply-To: <20020101050208.OMXO20896.femail24.sdc1.sfba.home.com@there>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@trommello.org>:
> 
> I've heard several people (including Alan) talk about banging on the 
> scheduler to make 8-way systems happy, and the first scheduler surgery patch 
> has apparently been accepted to 2.5 now.  Lots of people are talking about a 
> scheduler patch with a per-processor task queue, so I'd like to ask a 
> question.
> 
> What would be involved in a non-symmetrical multi-processor Linux?  Have the 
> per-processor task queues, but have them be different types of processes 
> using different machine languages?

1. booting
2. interrupts
3. context switching
4. memory management
5. I/O

> 
> The reason I ask is TI has a new chip with a DSP built into it, and DSPs are 
> eventually bound to replace all the dedicated I/O chips we've got today.  A 
> DSP is just a dedicated I/O processor, they can act like modems, sound and 
> video, 3D accelerators, USB interface, serial/paralell/joystick, ethernet, 
> 802.11b wireless and bluetooth...  Just hook it up to the right output 
> adapter and feed the DSP the right program and boom, it works.

Most of these processors have dedicated memory, not sense of context, and no
understanding of clock interrupts other than for their dedicated design
functions.

For such a configuration you would have to have a kernel OS for each processor,
written in it's custom instruction set.

Otherwise, you have security problems out the wazu.

Most of these processors are NOT general purpose. They are dedicated to
solving ONE specific problem at a time.

> In theory, you could stick a $5 after-market adapter on the output of your 
> DSP video to convert from a VGA plug to a TV plug, and reprogram the DSP to 
> produce a different output signal with a driver upgrade.  In software.  Ooh.

Not on a millisecond by millisecond abasis.

> DSP is just a processor designed to do I/O. It runs a program telling it how 
> to convert input into output.  Ooh.  This is half of unix programming, and 
> why we have the pipe command, only now you can unload each pipe stage on a 
> dedicated coprocessor, so you can program your sound output chip to do speech 
> synthesis or decompress MP3's.  And latency becomes way less of a problem if 
> you can dedicate a processor to it.  (Think of a DMA channel that can run a 
> filter program on the data it's transporting, and boom: you've got a DSP.)  
> In theory, anything you can write as a filter that sits on a pipe could be 
> done by a DSP, and in the Unix philosophy that's just about everything.

First two sentences are correct (well.. include the Ooh.). This processor
is running a dedicated program. It doesn't do page faults. It can take a long
time (relatively) to load the program. Unloading a user context is not usually
available.

You have to think of it more as a dedicated vector processor.
One user, One task. Context switching is not possible.

> Now combine together every strange niche I/O chip you've got now and make ONE 
> of the suckers, in massive volume, and think "economies of scale".  These 
> suckers are going to be CHEAP.  And low power.  The portable market seems to 
> be drooling over them, and they're already coming embedded into next 
> generation processors.  (A math coprocessor, a built-in DSP...  I heard 
> there's an ARM generation in development that's got 4 DSPs built-in...)  A 
> machine with a lot of DSPs was half of Steve Jobs' "NeXT" box idea...

Yes, and those DSPs only handled one function each.

> So, back to the Linux scheduler.  Right now our approach to these things is 
> (if I understand correctly) to feed 'em their program like firmware.  Load 
> the driver, DSP gets its program, and it's dedicated to that task.  Okay, 
> fun.  And considering lots of them are hooked up to specific I/O devices at 
> the other end (an 802.11b antenna, an ethernet jack, etc) that makes sense.
> 
> But there's already a company out there (www.dsplinux.net, proprietary dudes) 
> that SEEMS to be treating a DSP like a seperate processor, capable of 
> scheduling tasks to the DSP (think dynamic DMA channel allocation, I'm not 
> sure how the electronics work out here: it would make sense to be able to 
> allocate and deallocate them like any other resource, but this is giving 
> hardware makers far too much credit).  Considering the range of applications 
> you can have for sound cards alone (be a modem, text to speech, midi, mp3 
> decompression, mp3 compression during recording, ogg vorbis, etc), wouldn't 
> it be nice to be able to program DSPs a little more dynamically than "device 
> driver shows it how to be a sound card"?

This just goes back to the old dedicated vector CPUs provided to DOS to make
a fast, single application run.

> Right now, the scheduler has sort of been hacked by some people to have the 
> concept of "realtime tasks" and "not realtime tasks".  But if you think that 
> in five or ten years we may see machines built ENTIRELY out of DSPs (sort of 
> like RISC, only more so).  The hyper-multi-threading whatsis thing they're 
> doing with the P4 is sort of like this: they have execution cores linked for 
> performance and now they're de-linking them because the programmer's better 
> at finding paralellism than the hardware is.

The scheduler keeps track of process contexts. If the DSP is being used
for a video, then it may be requested to do Audio... the process context must
be saved/restored - along with the entire program (swap, not paging). Usually
the DSP in question cannot determine, nor identify processes. The stream data
very well. They do not have a general purpose bus. Usually all that is
available is:

   PCI ---> program memory
                   |
                   V
    control ----> DSP -----> output (input)
                   ^
    PCI            |
    data ----------+

Output/input is frequently analog. Sometimes instead of PCI data you get
a direct port into memory (example: AGP).

The DSP internal registers are not always available. They are to be initialized
when the program is started.

The usual problem is speed. These chips are fast, but not at context switching
or program load.

The program memory is loaded (slow - could take a .01 second, may take longer
depending on the size of the program).
The program is started and runs very fast.
Data can only be provided/accepted at PCI speed (relatively slow compaired to
CPU).

> Think about the 3D accelerator problem.  Break your screen up into 16 
> sections, one DSP sorts the triangles into each quadrant, 16 other DSPs blast 
> triangles to frame buffer, and then one more DSP is constantly doing a DMA 
> write to the video output to drive your LCD panel at 70hz.  3D acceleration 
> becomes a question of having enough DSPs, fast enough, and feeding them the 
> right software.  80 million triangles per second is the human visual 
> perception threshold, beyond that nvidia's binary-only drivers can go hang...

Absolutely - a dedicated single use problem. Solved by SGI. Very expensive.

> Am I totally on the wrong track here?  When do we start worrying about this?

Shouldn't have to worry about anything. This type of hardware has been around
for at least 30 years.

I'd rather see someone figure out how to do NUMA via multiple AGP ports
connecting to multiple motherboards....

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
