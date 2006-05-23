Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWEWK26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWEWK26 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 06:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWEWK26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 06:28:58 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:34226 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751323AbWEWK25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 06:28:57 -0400
Message-ID: <4472E3D8.9030403@garzik.org>
Date: Tue, 23 May 2006 06:28:40 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Kyle Moffett <mrmacman_g4@mac.com>, Manu Abraham <abraham.manu@gmail.com>,
       linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com> <1148379089.25255.9.camel@localhost.localdomain>
In-Reply-To: <1148379089.25255.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2006-05-23 at 01:08 -0400, Kyle Moffett wrote:
>> generation graphics system, I'd be interested in ideas on a new or  
>> modified /dev/fbX device that offers native OpenGL rendering  
>> support.  Someone once mentioned OpenGL ES as a possibility as it  
> 
> So for a low end video card you want to put a full software opengl es
> stack into the kernel including the rendering loops which tend to be
> large and slow, or dynamically generated code ?

Indeed, consider the extent of that phrase "dynamically generated code."

To do modern OpenGL (mostly fragment and vertex shaders), you basically 
must have a compiler front-end (C-like language), a code generator (JIT) 
backend for your architecture (x86, x86-64, ...), and a code generator 
backend for your GPU.

Further, as Keith Whitwell and others have rightly pointed out, a modern 
GPU needs such advanced resource management that the X server (or 
whatever driver) essentially becomes a _multi-tasking scheduler_. 
Consider the case of two resource-hungry 3D processes rendering to the 
same X11 screen, and you'll see why a GPU scheduler is needed.

Modern graphics is highly aligned with the Cell processor programming 
model:  shipping specialized binary code elsewhere, to be remotely executed.

OTOH, I think a perfect video driver would be in kernel space, and do

* delivery of GPU commands from userspace to hardware, hopefully via 
zero-copy DMA.  For older cards without a true instruction set, "GPU 
commands" simply means userspace prepares hardware register 
read/write/test commands, and blasts the sequence to hardware at the 
appropriate moment (a la S3 Savage's BCI).
* delivery of bytecode commands (faux GPU commands) from userspace to 
kernel to hardware.  Much like today's ioctls, but much more efficient 
delivery.  Used for mode switching commands, basic monitor management 
commands, and other not-vendor-specific operations that belong in the 
kernel.
* interrupt and DMA handling
* multi-context, multi-thread GPU resource scheduler (2D/3D context 
switching is lumped in here too)
* suspend and resume

and nothing else.

	Jeff


