Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTLMXqi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 18:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265306AbTLMXqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 18:46:38 -0500
Received: from xavier.comcen.com.au ([203.23.236.73]:17171 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S262015AbTLMXqd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 18:46:33 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Ian Kumlien <pomac@vapor.com>
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Date: Sun, 14 Dec 2003 09:49:52 +1000
User-Agent: KMail/1.5.1
References: <200312140407.28580.ross@datscreative.com.au> <200312140916.26005.ross@datscreative.com.au> <1071357683.2024.5.camel@big.pomac.com>
In-Reply-To: <1071357683.2024.5.camel@big.pomac.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312140949.52489.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 14 December 2003 09:21, you wrote:
> On Sun, 2003-12-14 at 00:16, Ross Dickson wrote:
> > On Sunday 14 December 2003 08:28, you wrote:
> > > On Sat, 2003-12-13 at 19:07, Ross Dickson wrote:
> > > > ..APIC TIMER ack delay, reload:16701, safe:16691
> > > 
> > > calibrating APIC timer ...
> > > ..... CPU clock speed is 2079.0146 MHz.
> > > ..... host bus clock speed is 332.0663 MHz.
> > > NET: Registered protocol family 16
> > > ..APIC TIMER ack delay, reload:20791, safe:20779
> > > ..APIC TIMER ack delay, predelay count: 20769
> > > ..APIC TIMER ack delay, predelay count: 20786
> > > ..APIC TIMER ack delay, predelay count: 20716
> > > ..APIC TIMER ack delay, predelay count: 20731
> > > ..APIC TIMER ack delay, predelay count: 20747
> > > ..APIC TIMER ack delay, predelay count: 20762
> > > ..APIC TIMER ack delay, predelay count: 20780
> > > ..APIC TIMER ack delay, predelay count: 20729
> > > ..APIC TIMER ack delay, predelay count: 20740
> > > ..APIC TIMER ack delay, predelay count: 20757
> > 
> > Thanks Ian.
> > From this we see your local apic is indeed counting 1.2 times faster than mine
> > ratio of 333/266 fsb. So the reload:20791 - safe:20779 gives 12 counts time.
> > Given 20791 is 1ms on your system then your 12 counts is 577ns
> > But more importantly from the ack delay theory as your machine like mine is
> > prone to lockups then a lockup could likely have occured at count:20786 having
> > only 240ns time expired. Next worst case was less likely to lockup at count:20780.
> 
> I just had a lockup running with preempt, now trying with preempt
> disabled. This is a clean 2.6.0-test11 with just io-apic and apic v2
> patches.

Thanks for testing, thats not good news.
Try rebooting with kernel args to get back in.

acpi=off noapic

My 600ns is likely too small - try putting 800UL or 1000UL in place of the 600UL 

The v1 patch ((cpu_khz >> 12)+200) gave 700ns additional delay to your existing
code path so I think I was being too optimistic in the initial v2 timing. I made the
initial timing CPU freq dependent on the assumption that a faster cpu would get to
the delay point quicker. 

On my system the v1 patch had 13 counts of total delay whereas my initial the v2
gave only 10 so I think 800UL is the smallest value we should use.

If that does not fix it then it could also be that reading the timer so early may also
be dangerous? or something else? and so then we would go back to v1 apic patch.

> 
> > The only ones any delay would have been added to by the patch would be the
> > count:20786 and count:20780 and it would have been just enough to wait until 
> > the counter got below the safe:20779 so the patch contributes little overhead.
>  
> > > Survived my greptest which no non patched kernel has ever done on this
> > > machine.
> > > 
> > > Has anyone got that extended ringbuffer to work? I haven't been able to
> > > get a complete "boot" dmesg in ages because of all the output all the
> > > drivers make... Does it need a updated dmesg?
> > 
> > This may be what you have already tried:
> > I am not sure where it is in the 2.6 config or indeed if it is different but it is
> > CONFIG_LOG_BUF_SHIFT under kernel hacking on 2.4.23 maybe try 16 for 64K.
> > To match dmesg output try 
> > 
> > dmesg -s65536
> > 
> > (unless dmesg can automatically pick up the expanded ring buffer size on 2.6?)
> 
> Ahhh great!, no, it doesn't auto detect it... Maybe there is a newer
> version, i hate mdk for being so nice to new versions and ignoring the
> old.

My wishful thinking, I don't think any version autodetects but it would be a nice feature.
Ross.
> 
> -- 
> Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net
> 

