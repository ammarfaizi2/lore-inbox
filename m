Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277396AbRJVBN4>; Sun, 21 Oct 2001 21:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277398AbRJVBNr>; Sun, 21 Oct 2001 21:13:47 -0400
Received: from mailout5-0.nyroc.rr.com ([24.92.226.122]:26314 "EHLO
	mailout5.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S277396AbRJVBNh>; Sun, 21 Oct 2001 21:13:37 -0400
Message-ID: <013201c15a96$f3b47a10$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.fbu5gjv.1526gp4@ifi.uio.no> <fa.ltbaijv.13jgcr7@ifi.uio.no>
Subject: Re: The new X-Kernel !
Date: Sun, 21 Oct 2001 21:14:51 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  At present fbdev is just a dumb framebuffer. In time I plan to merge both
> DRI and fbdev into one common interface. Their is alot of ideas on where
> graphics handling should be done. IMO the kernel should only manage the
> state of the hardware amoung the various processes.

The Right Way To Do Graphics, According to Dan (tm):
----------------------------------------------------

1. kernel driver accepts buffers of drawing commands from user-space clients
and sends them to graphics card via DMA. Also provides interface for clients
to allocate pieces of video RAM. Also maintains per-client graphics engine
state that is context-switched as necessary; textures and framebuffers are
demand-paged between system RAM and video RAM. Also provides "global"
controls like graphics mode switching and hardware
cursor position.
(DRI does most of this today)

2. user-space library maps from a convenient platform-neutral API (i.e.
OpenGL) to card-specific buffers of drawing commands.

3. user-space window server process owns the only visible framebuffer in
video RAM. Clients give the window server the address of their private
non-visible framebuffer and wake up the server whenever its contents change.
Window server assembles the visible desktop by blitting client framebuffers
to the visible framebuffer. Window server also dispatches input events
(keypresses/mouse clicks) to appropriate client processes.

(this is basically how Mac OSX works, except OSX does most of these
operations in software so it is very sluggish)

Advantages of this approach:
1. clients running on the local machine get full DMA access to the video
hardware.
2. window server can do real alpha-channel compositing (true
transparent/non-rectangular windows).
3. slow/crashed clients can not harm the window server or other clients.
4. clients don't have to double-buffer because the window server does it for
them.
5. full-screen clients (e.g. games) can be allowed to usurp the window
server and get direct access to input devices and video hardware.
6. to achieve network transparency, a "stub" client can be written that
sends input events and receives drawing commands over a socket.
7. GUI toolkits can offer a retained-mode API that maps high-level commands
(e.g. "draw a button") directly to graphics hardware, instead of long, slow
X protocol streams.

i.e. this system provides a superset of the features we have today, because
it is a "meta" windowing system where every client is equivalent to an X
server or a DRI client.

Disadvantages:
1. would probably require >$1 million investment in software engineering to
implement, could not be done as a free product.
2. demands a sophisticated resource-management system to demand-page
fine-grained resources to and from the video card; may not be fully
implementable on today's graphics hardware.
3. only a single graphics card vendor provides (partial) documentation for a
card that is fast and functional enough to make this idea interesting (ATI).
4. a translation layer would have to be written to emulate X for legacy
clients.
5. Linux/UNIX people mostly don't give a sh*t about good graphics.

Regards,
Dan

