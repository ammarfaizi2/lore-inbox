Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267372AbTACBTD>; Thu, 2 Jan 2003 20:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267373AbTACBTD>; Thu, 2 Jan 2003 20:19:03 -0500
Received: from bitmover.com ([192.132.92.2]:64935 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267372AbTACBTB>;
	Thu, 2 Jan 2003 20:19:01 -0500
Date: Thu, 2 Jan 2003 17:27:26 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Thomas Ogrisegg <tom@rhadamanthys.org>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lm@bitmover.com
Subject: Re: [PATCH] TCP Zero Copy for mmapped files
Message-ID: <20030103012726.GD6195@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Thomas Ogrisegg <tom@rhadamanthys.org>,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	lm@bitmover.com
References: <20021230012937.GC5156@work.bitmover.com> <1041489421.3703.6.camel@rth.ninka.net> <20030102221210.GA7704@window.dhis.org> <20030102.151346.113640740.davem@redhat.com> <20030103004543.GA12399@window.dhis.org> <1041558987.24809.114.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041558987.24809.114.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 01:56:27AM +0000, Alan Cox wrote:
> On Fri, 2003-01-03 at 00:45, Thomas Ogrisegg wrote:
> > Unfortunately the linux-sendfile is not as good as the HP-UX
> > one. Under HP-UX you can define a "struct iovec" header to
> > be sent before the file is sent.
> 
> Thats a design decision. With TCP_CORK and sensible syscall performance
> those kind of web specific hacks are not appropriate

Indeed.  In case Alan's message wasn't clear: if your syscall overhead
is zero then many "optimizations" become superfluous.  In fact, those
optimizations, one cache miss at a time, tend to be a big part of what
makes the syscall layer so heavyweight.

Linux is amazing in that it is basically the only real operating system
I know of that has stayed so focussed on making the syscall layer be
almost invisible.  it's worth a "rah rah" because you can use the 
operating system like it was libc, there is basically very little 
cost in crossing in/out.

Here's the LMbench context switch benchmark running on a 1.6Ghz Athlon:

load free cach swap pgin  pgou dk0 dk1 dk2 dk3 ipkt opkt  int  ctx  usr sys idl
0.67  73M 577M  25M   0     0    0   0   0   0  4.0  2.0  107  548K  23  77   0
0.67  73M 577M  25M   0     0    0   0   0   0  2.0  2.0  105  549K  19  81   0
0.67  73M 577M  25M   0     0    0   0   0   0  4.0  2.0  107  549K  27  73   0
0.70  73M 577M  25M   0     0    0   0   0   0  2.0  2.0  105  548K  23  77   0

Yeah, that's more than a half a million context switchs/second and each
of those include 2 system calls.  So Linux is doing 2 system calls and
a context switch in 1.8 microseconds.

When you can get in and out of the kernel that fast, your thinking should 
change.  You get to use the kernel more freely.  And you certainly don't
want to do anything to screw that up.  My hat is off to Linus and team 
for working so hard to make these numbers be so good (and keep on working,
see the recent syscall discussion).
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
