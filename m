Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279248AbRJWFLF>; Tue, 23 Oct 2001 01:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279246AbRJWFKq>; Tue, 23 Oct 2001 01:10:46 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:55300 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S279245AbRJWFKh>;
	Tue, 23 Oct 2001 01:10:37 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: george anzinger <george@mvista.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How should we do a 64-bit jiffies? 
In-Reply-To: Your message of "Mon, 22 Oct 2001 08:12:24 MST."
             <3BD43758.32646D49@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Oct 2001 15:10:48 +1000
Message-ID: <1164.1003813848@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001 08:12:24 -0700, 
george anzinger <george@mvista.com> wrote:
>I am working on POSIX timers where there is defined a CLOCK_MONOTONIC. 
>The most reasonable implementation of this clock is that it is "uptime"
>or jiffies.  The problem is that it is most definitely not MONOTONIC
>when it rolls back to 0 :(  Thus the need for 64-bits.

If you want to leave existing kernel code alone so it still uses 32 bit
jiffies, just maintain a separate high order 32 bit field which is only
used by the code that really needs it.  On 32 bit machines, the jiffie
code does

  old_jiffies = jiffies++;
  if (jiffies < old_jiffies)
  	++high_jiffies;

You will need a spin lock around that on 32 bit systems, but that is
true for anything that tries to do 64 bit counter updates on a 32 bit
system.  None of your suggestions will work on ix86, it does not
support atomic updates on 64 bit fields in hardware.

