Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266364AbUIONrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266364AbUIONrc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266351AbUIONpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:45:40 -0400
Received: from mail.zmailer.org ([62.78.96.67]:44004 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S266333AbUIONoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:44:17 -0400
Date: Wed, 15 Sep 2004 16:44:07 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Andre Bonin <kernel@bonin.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI coprocessors
Message-ID: <20040915134407.GK19844@mea-ext.zmailer.org>
References: <41483BD3.4030405@bonin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41483BD3.4030405@bonin.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 08:55:47AM -0400, Andre Bonin wrote:
> Hey all,
> I'me building an FPGA based pci board for a degree project.  In theory 
> this board could be used as a custom, field programmable coprocessor
> (to accelerate processes).  At which point, it might be nice to be able
> to support it as a processor under the kernel.
> 
> Yes bandwidth, yes it should be PCI-Express but it is still just a 
> degree project, 33mhz is fast enough for the proof of concept.
> 
> Which leads me to my questions:
> 
> 1) Is their support for having two different 'machine types' within one 
> kernel? that is for example, certain executables for intel would get run 
> on an intel processor, and others would get run on processor with type XXXX.

Depending...   If you think of computation intensive things, such have
been implemented in FPGA, usually in "slave mode".  Consider algorithms
that you want to run all the time with heavy load.  (some brute-force
crypto breakings, Seti@Home, ...)  the math that the hardware does must
(by necessity) be rather simple (or broken into simple steps.)

Things that are useful and have in the past been done in co-processors
do include:

  - RSA exponentation
  - 3DES
  - FIR/IIR filters
  - FFT engines
  - Matrix math engines

Depending on used FPGA (RAM-based I presume, anti-fuse stuff is not
reprogrammable), there might exist internal multipliers, and distributed
RAM blocks for intermediate results.  Fairly complicated signal processing
could be done in such a card.

Cheaper FPGAs can be used to implement complexish logic to do strange
serial IO protocols with strict timing requirements, for example.
"Send this word to the remote device", "read back device's lattest
reply".  (e.g. implement a VGA-LCD controller.)


> I heard once someone put native "java" .class support within the kernel 
> (it would call the jvm run time if i remember).  I could maby do this 
> with my own set of libraries and driver.  But differentiating between 
> the types of executable might be hard.

Sure a "micro-java-engine" can be implemented, and then ran.
However a 50-60 M java intructions (byte-codes) per second isn't
all that fancy, especially if you need to access memory rather
frequently...  Your host will likely be able to run JVM faster
than that.  (A P-IV-XEON running at 3+ GHz..)


If you have a deeper look into how e.g. intel e100 ethernet cards
are driven, you will quickly notice that they are given rather simple
task lists -- except in case of "setup" operation, which sends big
magic blob of data to the controller microsequencer.

You want to do something similar, if you can do bus-mastering.
You might introduce "must be 32-bit aligned" requirement, or
whatever your application fancies.  (A 1000x1000 matrix inversion...)

You shall make sure, that you won't be offloading tasks to the external
engine, tasks that your internal engine could do faster (except if you
want to spend the freed time at something else.


> 2) Is their kernel support for PCI coprocessors for thread allocation 
> etc.  I couldn't find any but i can try looking through the code again.


There is nothing such for situations where processors execute different
binary language (and thus different data layouts).

There is some support to offload heavyish cryptographic tasks to
physical co-processors (PCI-cards) .. but going twice over the
32 bit * 33 MHz bus does limit the amount of data processable in
the co-processor.


/Matti Aarnio
