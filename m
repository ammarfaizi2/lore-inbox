Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319218AbSH2PEz>; Thu, 29 Aug 2002 11:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319219AbSH2PEz>; Thu, 29 Aug 2002 11:04:55 -0400
Received: from hdfdns02.hd.intel.com ([192.52.58.11]:47574 "EHLO
	mail2.hd.intel.com") by vger.kernel.org with ESMTP
	id <S319218AbSH2PEy>; Thu, 29 Aug 2002 11:04:54 -0400
Message-ID: <C81D8E612E5DD6119653009027AE9D3EE091D0@FMSMSX36>
From: "Pering, Trevor" <trevor.pering@intel.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: Dominik Brodowski <devel@brodo.de>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: RE: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
Date: Thu, 29 Aug 2002 08:07:51 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And now comes the problem with the policy approach -- what to include in the
policy... event-HZ? Temperature? Mem Bus Freq? The list is endless. But,
here's my thoughts on the matter (not sure this adds anything new, but it
helps clarify it for me, at least). 

Taking the graphics card analogy... Graphics subsystems have evolved over
many years. Initial implementations were just direct-access-framebuffers,
and in fact, were initially often indirect-access frame-buffers (e.g., the
Apple II didn't even have a linear memory map for the character display,
IIRC). Over time, individual companies would develop optimized hardware and
write libraries for it, and then eventually abstractions like OpenGL or
DirectX appeared -- *after* people knew what was useful and what was not. 

In a "well-formed" world, we could probably start off with a very basic
interface, which is what cpufreq has tried to do, and then build policy on
top of that. However, we are already effectively building on top of
abstraction, so things are a little more complicated -- as Linus points out,
just specifying the exact frequency makes no sense anymore.

If you want to continue the graphics analogy, then we're in the position of
trying to write a driver that both handles bitmapped displays as well as
vector plotters. Just allowing direct bitmap access makes *no* sense in this
situation because they are meaningless for a vector plotter, which always
draws lines.

So, if you need to support two sets of graphics drivers, one that provides
draw_point(x,y), and one that provides draw_line(x1,y1,x2,y2) -- what do you
do? I would say you provide draw_line(x1,y1,x2,y2), and which can be reduced
to draw_point(x,y), if necessary. 

So, cpufreq is trying to just support set_freq(x), while some processors
_require_ a call in the form of bound_freq(x1,x2). Exact same situation.

Given that, there are still a couple of open questions:

1) About the policy field -- I think this should be as simple as possible...
because the use is either going to be simple, or way to complex to
effectively capture. So, the enumerated policy is probably best. Start
simple, then add other things if absolutely necessary.

2) To use MHz or something else? The problem is that the number here is
virtually meaningless. It does not translate from machine to machine,
processor to processor, or application to application. So, if you have to
pick a meaningless metric, what do you use? I would actually argue for % of
full capacity instead of MHz, but it doesn't really matter in the end.

3) Thermal overloading -- this, I believe, is a separate issue from the
cpufreq setting for things. I would leave this out of the equation, and let
the lower-level components handle this. I.e., think of "cpufreq" as a
suggestion, and if the suggestion would break something, then it is ignored.
If you really wanted, you could have a policy that is something like
"IgnoreThermal" -- but I think that would be silly.

4) The whole "one number describes processor behavior" is also somewhat
silly -- there is the core frequency, memory bus frequency, internal bus
frequency, etc... multipliers, dividers, PLLs -- everywhere!  Still not sure
what to do about this, at the moment -- but, I think this might be a
convenient use for the policy field. I.e., in "Performance" state it does
one thing (fasted mem bus freq available), in "Conservation" state it does
another (slowest available). But... (see point #1)... should this be a
separate field or not?  Start simple, then build on later, if necessary.

Another way of looking at this is to break the calls up into component
parts:
freq_set_minmax(x,y)
freq_set_exact(x)  (same as freq_set_minmax(x,x))
freq_set_policy(p)
(but then there are synchronization issues...)
freq_synchronize()
etc...

	Trevor


-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Thursday, August 29, 2002 3:54 AM
To: Linus Torvalds
Cc: Dominik Brodowski; cpufreq@www.linux.org.uk;
linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)


>  { min-Hz, max-Hz, policy }
> 

For a few of the processors "event-hz" or similar would be nice. The
Geode supports hardware assisted bursting to full processor speed when
doing SMM, I/O and IRQ handling.


_______________________________________________
Cpufreq mailing list
Cpufreq@www.linux.org.uk
http://www.linux.org.uk/mailman/listinfo/cpufreq
