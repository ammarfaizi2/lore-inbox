Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277288AbRJVR4l>; Mon, 22 Oct 2001 13:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277278AbRJVR43>; Mon, 22 Oct 2001 13:56:29 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:24582 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S277277AbRJVR4Y>; Mon, 22 Oct 2001 13:56:24 -0400
Date: Mon, 22 Oct 2001 12:56:22 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200110221756.MAA08417@tomcat.admin.navo.hpc.mil>
To: jsimmons@transvirtual.com, Jesse Pollard <jesse@cats-chateau.net>
cc: Tim Jansen <tim@tjansen.de>, linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons <jsimmons@transvirtual.com>:
> > On Sunday 21 October 2001 14:17, Tim Jansen wrote:
> > > On Sunday 21 October 2001 19:40, James Simmons wrote:
> > > > It sets the hardware state of the keyboards and the
> > > > mice. The user runs apps that alter the state. The second user comes
> > > > along and log in on desktop two. He runs another small application to
> > > > test the mice. It changes the state which in turn effects the person on
> > > > desktop one.
> > >
> > > Isn't this a driver problem? If two processes can interfere when using the
> > > same device the driver should only allow one access (one device file
> > > opened) at a time. And if two processes need to access it it should be
> > > managed by a daemon.
> > 
> > Neither - It is a resource allocation problem, which all UNIX style systems
> 
> [snip]...
> 
> I think everyone has misunderstood me. I know I'm not the most clear
> person sometimes. I'm just talking about fine grain locking of some kind
> between input devices. I really like to see "direct input" in OpenGL
> someday. You need some kind of locking between OpenGL and the X server in
> this case just like you have with graphics.

I may not have been complete - 

Your initial example was of a force feedback mouse (or data glove), where
the process that has the device open dies.

Between the process failure, some other process (not owned by the same user)
may modify characteristics of the device in an inappropriate way. Then the
original user starts using it again.

Resource allocation requires the device to be initialized to a base, known
state. That state MUST NOT be modified by session other than the one that
allocated it. The driver may or may not be currently "open" by a process.

It is a security violation to leak state information or to have that state
information modified by any but the owner of that state.

Some "devices" (like the Xserver is a device), already do this. If the
attached allocator (the X login) becomes inoperable (X server dies), then
the state of the device is reset (logged out), and allocation of the "device"
reclaimed (logged out in this case). All physical devices associated with
the X server must also be reset (mouse/keyboard/frame buffer...).

Resource allocation is easier to visualize when it is a tape drive.

The actions of a resource allocator must/should be:

1. initialize the resource/device to a known state.
2. control access to the resource/device (prevent access).
3. be able to grant access to the resource/device to user sessions.
4. prevent multiple sessions from accessing the resource/device
   simultaneously.
5. reclaim the resource/device (abort all outstanding access) and
   return to step 1.

Some procedure (as outlined, though not complete) would prevent your
"state" misconfiguration where multiple users had access to a single user
resource (tape, mouse, keyboard, data glove, etc).

I've already had to deal with "inadvertant" use of state information leaking
across sessions (audio devices). Personally, I think it is time for a resource
management system.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
