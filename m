Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316838AbSG3V4q>; Tue, 30 Jul 2002 17:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316840AbSG3V4q>; Tue, 30 Jul 2002 17:56:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41221 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316838AbSG3V4p>; Tue, 30 Jul 2002 17:56:45 -0400
Date: Tue, 30 Jul 2002 14:59:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Greg KH <greg@kroah.com>, Vojtech Pavlik <vojtech@suse.cz>,
       <linux-kernel@vger.kernel.org>,
       <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
In-Reply-To: <3D4708FD.7040002@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0207301448200.2051-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Jul 2002, Jeff Garzik wrote:
> 
> Agreed, but u16 is even better :)  Why use the '__' prefix when standard 
> kernel types do not need them?

The __ thing is actually fairly useful, for a few reasons

 - "u16" is namespace pollution and mustn't be exported by standard 
   user-level header files, since a program might use it as a variable 
   name.

 - it shows which things are purely krnel internal (u16 is 
   kernel-internal, but a structure with __u16 is in a structure exported
   to user space. Of course, some people seem to think that you should 
   always use the __u16 form, which is wrong. The underscores have
   meaning, and the meaning is exactly that: exported to user space
   headers as a size)

 - typedef's are nasty, in that you cannot mix them. With a #define, you 
   can just have

	#ifndef NULL
	#define NULL ((void *)0)
	#endif

   and if everybody follows that convention, duplicating a few #defines 
   isn't a problem.

   The same is _not_ true of typedefs. With typedefs, there can be only 
   one, and trying to avoid duplication with magic preprocessor rules 
   easily gets nasty. Sure, you can make up a rule like

	#ifndef __typedef_xxxx_t
	typedef ... xxxx_t;
	#endif

   but it's nowhere near as convenient as for #defines, and there is no 
   standard for this.

   This nastiness is why everybody (including things like glibc) ends up 
   having to have an internal type and an external type anyway. Have you
   ever wondered by the glibc header files internally use things like
   __off_t, __locale_t etc? This is why. To avoid duplicate defines, 
   especially in the presense of complex #ifdef __BSD_SOURCE__ etc, the 
   internal type is defined unconditionally. The externally visible type 
   is only defined if it should be.

See the crap in <linux/types.h> on how the linux headers define things
like u_int8_t int8_t uint8_t depending on different #defines. Which is why 
it is so convenient to have _one_true_ internal type (__u8) which you can 
always depend on, regardless of who compiles you and with what options. 

All the other types (inluding the "standard" uint8_t) simply cannot be 
depended on. 

		Linus

