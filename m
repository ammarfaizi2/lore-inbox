Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274872AbRJVPNR>; Mon, 22 Oct 2001 11:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274774AbRJVPNH>; Mon, 22 Oct 2001 11:13:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8699 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S274174AbRJVPMv>; Mon, 22 Oct 2001 11:12:51 -0400
Message-ID: <3BD43758.32646D49@mvista.com>
Date: Mon, 22 Oct 2001 08:12:24 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: How should we do a 64-bit jiffies?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on POSIX timers where there is defined a CLOCK_MONOTONIC. 
The most reasonable implementation of this clock is that it is "uptime"
or jiffies.  The problem is that it is most definitely not MONOTONIC
when it rolls back to 0 :(  Thus the need for 64-bits.

As it turns out, the only code that needs to know about the high order
bits is the code that increments jiffies and the POSIX timer code. 
Every thing else can continue to use the current definition with no
problem.

The solution needs to account for the Endianess of the platform.  Here
are the possible solutions I have come up with:

1.) Define jiffies in the arch section of the code using asm.  Looks
like this for x86:

__asm__( ".global jiffies\n\t"
         ".global jiffiesll\n"
         ".global jiffiesh\n"
         "jiffiesll:\n"
         "jiffies: \n\t"

         ".long 0\n"
         "jiffiesh: \n\t"
         ".long 0");

The up side of this method is that none of the current using code needs
to be aware of the change.  We just remove  "unsigned long volatile
jiffies;" from timer.c.

The down side of this method is that all platforms must do something
similar.

2.) Use a C structure that depends on ENDIAN defines:

 #if defined(__LITTLE_ENDIAN)
      union {
        long long jiffiesll;
        struct {
        int jiffiesl
        int jiffiesh
        } jiffieparts;
 }jiffiesu; 
 #elif defined(__BIG_ENDIAN)
     union {
        long long jiffies64;
        struct {
        int jiffiesh
        int jiffiesl
        } jiffieparts;
 }jiffiesu; 
 #else
 #error "I'm probably missing #include <asm/byteorder.h>"
 #endif
 #define jiffies jiffiesu.jiffieparts.jiffiesl
 #define jiffiesll jiffiesu.jiffies64

The down side with this method is that jiffies can not be used as a
local or structure
element, i.e. it is now a reserved name in the kernel.  

3.)  Define jiffies as 64 bit and use C casts to get to the low order
part:

u64 jiffies_u64;

#define jiffies (unsigned long volatile)jiffies_u64

Here again the down side is  that jiffies can not be used as a local or
structure
element, i.e. it is now a reserved name in the kernel.  

I am sure there are other ways to approach this and I would like to hear
them.  

Approach 1.) requires that all platforms be changed at the same time. 
Approaches 2.) and 3.) require that we find all occurrences of jiffies
should not be "defined" to something else.  The Ibm tick less patch
found most of these, but I am sure there are more lurking in drivers.

Comments?

George
