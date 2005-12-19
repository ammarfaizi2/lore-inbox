Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbVLSFln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbVLSFln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 00:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbVLSFln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 00:41:43 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:52230 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1030268AbVLSFlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 00:41:42 -0500
Date: Mon, 19 Dec 2005 06:41:24 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Diego Calleja <diegocg@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       matthltc@us.ibm.com
Subject: Re: Linux 2.6.15-rc6
Message-ID: <20051219054124.GL15993@alpha.home.local>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051219023058.6d94b13d.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051219023058.6d94b13d.diegocg@gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 02:30:58AM +0100, Diego Calleja wrote:
> El Sun, 18 Dec 2005 16:47:33 -0800 (PST),
> Linus Torvalds <torvalds@osdl.org> escribió:
> 
> > Matt Helsley:
> >       Add getnstimestamp function
> >       Add timestamp field to process events
> 
> 
> This last change (5650b736ad328f7f3e4120e8790940289b8ac144) "broke" a
> small process event connector test program (the one matt posted here
> http://lkml.org/lkml/2005/9/28/347, slighty modified) due to a headers
> conflict. I think it's due to my setup, but...
> 
> --- a/include/linux/cn_proc.h
> +++ b/include/linux/cn_proc.h
> @@ -26,6 +26,7 @@
> #define CN_PROC_H
> #include <linux/types.h>
> +#include <linux/time.h>
> #include <linux/connector.h>
> 
> 
> 
> and the program:
> 31: #include <stdio.h>
> 32: #include <stdlib.h>
> 33: #include <string.h>
> 34: #include <unistd.h>
> 35: 
> 36: #include <sys/socket.h>
> 37: #include <sys/types.h>
> 38: 
> 39: #include <linux/connector.h>
> 40: #include <linux/netlink.h>
> 41: #include <linux/cn_proc.h>
> 
> 
> 
> This gives me 
> 
> diego@estel 2J2 ~/kernel # LC_ALL='C' make
> gcc -I 2.6/include test_cn_proc.c -o test_cn_proc
> In file included from 2.6/include/linux/cn_proc.h:29,
>                  from test_cn_proc.c:41:
> 2.6/include/linux/time.h:12: error: redefinition of 'struct timespec'
> 2.6/include/linux/time.h:18: error: redefinition of 'struct timeval'
> In file included from 2.6/include/linux/cn_proc.h:29,
>                  from test_cn_proc.c:41:
> 2.6/include/linux/time.h:121:1: warning: "FD_SET" redefined
> In file included from /usr/include/sys/types.h:216,
>                  from /usr/include/stdlib.h:433,
>                  from test_cn_proc.c:32:
> /usr/include/sys/select.h:93:1: warning: this is the location of the previous definitio
> 
> (My "debian testing" box supplies an old and apparently incompatible
> version of connector.h so I had to point gcc to kernel's headers directly)

As a dirty trick, you should be able to avoid this by adding the
following line just before #include <linux/cn_proc.h> :

   #define _LINUX_TIME_H

So that the preprocessor will think it has already included <linux/time.h>
definitions and will not load them again. Of course, if they are needed,
you're lost.

Willy

