Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWEWOLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWEWOLm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWEWOLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:11:42 -0400
Received: from smtpout.mac.com ([17.250.248.183]:20711 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932078AbWEWOLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:11:41 -0400
In-Reply-To: <4472E3D8.9030403@garzik.org>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com> <1148379089.25255.9.camel@localhost.localdomain> <4472E3D8.9030403@garzik.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <83B4C39B-1A5E-4734-A5FF-10C3179B535B@mac.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Manu Abraham <abraham.manu@gmail.com>,
       linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Tue, 23 May 2006 10:10:56 -0400
To: Jeff Garzik <jeff@garzik.org>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 23, 2006, at 06:28:40, Jeff Garzik wrote:
> Alan Cox wrote:
>> On Maw, 2006-05-23 at 01:08 -0400, Kyle Moffett wrote:
>>> generation graphics system, I'd be interested in ideas on a new  
>>> or  modified /dev/fbX device that offers native OpenGL rendering   
>>> support.  Someone once mentioned OpenGL ES as a possibility as it
>>
>> So for a low end video card you want to put a full software opengl  
>> es stack into the kernel including the rendering loops which tend  
>> to be large and slow, or dynamically generated code ?

First of all, absolutely not.  I stated elsewhere in the email:
> There would also need to be a way for userspace to trap and emulate  
> or ignore unsupported OpenGL commands.

A GPU which does not support OpenGL at all would look virtually  
identical to the current framebuffer model.  If it does support a few  
2D-acceleration features, those should be exported through a similar  
but distinct interface.  Using 3D on a GPU would trigger something  
like the following series of events:

During boot:
1)  Userspace software renderer connects to a GL-framebuffer device  
first, determines device capabilities, and installs OpenGL traps for  
all unsupported operations that it can software-render (may be none).
2)  Window-server connects to a subset of the available GL- 
framebuffer and input devices.

At client start:
1)  Client connects to the window-server via TCP or UNIX socket.
2)  If client is over UNIX socket, it receives specially-configured  
open filehandles to the graphics device and mmaps those or performs  
other operations via them, otherwise it sends and receives commands  
and textures over the socket and the window-server does those  
operations locally.

For each rendering operation (either directly via filehandle or  
indirectly through TCP to window-server):
1)  Client program loads texture into mapped texture memory  
"allocated from the GPU" (may actually be system RAM, depending on  
card capabilities and memory utilization).
2)  Client program sends OpenGL commands through kernel framebuffer  
device.
3)  Kernel either passes the OpenGL commands to the GPU or if they  
were trapped by the software renderer it passes them to that, which  
can emulate them using more primitive operations.

IMHO, the way it should work is the kernel should export "rendering  
contexts" to which a single client can connect (EX: software  
renderer, window-server, The GIMP, etc).  By default the kernel would  
export a single rendering context associated with the actual display  
device as a whole.  A client can then use kernel calls to subdivide  
its rendering context to other clients such that the client can  
choose between trapping OpenGL calls, passing them up the stack, or  
pre-rendering them to a texture.  This would allow the kernel to  
manage CPU and GPU time, memory (it could "swap" data out from the  
GPU to system RAM if necessary).  If no parent-client trapped a given  
OpenGL command and it was unsupported by the GPU then the kernel  
would return an error to the originating client.

Cheers,
Kyle Moffett

