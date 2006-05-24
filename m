Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932629AbWEXHGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbWEXHGU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 03:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbWEXHGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 03:06:20 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:3219 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932629AbWEXHGT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 03:06:19 -0400
Message-ID: <44740533.7040702@aitel.hist.no>
Date: Wed, 24 May 2006 09:03:15 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Jon Smirl <jonsmirl@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com> <200605230048.14708.dhazelton@enter.net> <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com> <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com>
In-Reply-To: <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
>
> The one really significant potential problem with the exo-kernel model 
> for graphics is that the kernel *must* have a stable way to display 
> kernel panics regardless of current video mode, framebuffer settings, 
> 3D rendering, etc.  The kernel driver should be able to provide some 
> fundamental operations for compositing text on top of the framebuffer 
> at the primary viewport regardless of whatever changes userspace makes 
> to the GPU configuration.  We don't have this now, but I see it as an 
> absolute requirement for any replacement graphics system.  This means 
> that the kernel driver should be able to understand and modify the 
> entire GPU state to the extent necessary for such a text console.
I am not so sure I want this at all.
In the early 90's, I used unix machines wich did exactly this - spamming the
framebuffer console with occational messages while X was running.
Yuck yuck yuck yuck yuck .  .  .

Now, a panic/oops message is sure better than a silent hang, but that's 
it, really.
Anything less than that should just go in a logfile where the admin can look
it up later.  The very ability to write on the console will alway be abused
by some application programmer or kernel driver module vendor. 

Blindly writing on the console won't be very useful either, the user might
be running a game or video which overwrites the message within 1/30s anyway.
Well, perhaps it can be done better than that, with some thought. I.e. :

* block all further access to /dev/fb0, processes will wait.
* Mark graphichs memory "not present" for any process that have it mapped,
   so as to pagefault anyone using it directly.  (read-only is not enough,
  processes should see the graphichs memory they expect, not
  the kernel message)
* Try to allocate memory for saving the screen image (assuming the
   machine won't hang completely, it will often keep running after an oops)
* Annoy the user by showing the message
* Provide some way of letting the user decide when to proceed, such
   as pressing a key
* Restore the saved screen memory (if that allocation was successful)
* Mark framebuffer memory present, releasing pagefaulted processes
* Unblock /dev/fb0

So, kernel messages can be done.  But if the plan just is to blindly
write messages to the framebuffer, then please drop it.  I really hate
stupid messages on top of my windows, especially when the X display
is _scrolled_ without invalidating the windows. :-(

Helge Hafting
