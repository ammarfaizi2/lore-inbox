Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbULPB6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbULPB6U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbULPBzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:55:38 -0500
Received: from gprs215-43.eurotel.cz ([160.218.215.43]:46978 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262546AbULPBQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 20:16:38 -0500
Date: Thu, 16 Dec 2004 02:15:49 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Time goes crazy in 2.6.9 after long cli [was Re: USB making time drift]
Message-ID: <20041216011549.GD6285@elf.ucw.cz>
References: <20041213002751.GP16322@dualathlon.random> <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com> <20041213112853.GS16322@dualathlon.random> <20041213124313.GB29426@atrey.karlin.mff.cuni.cz> <20041213125844.GY16322@dualathlon.random> <20041213191249.GB1052@elf.ucw.cz> <20041214023651.GT16322@dualathlon.random> <20041214095939.GC1063@elf.ucw.cz> <20041214152558.GB16322@dualathlon.random> <20041214220239.GA19221@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214220239.GA19221@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Are you using CONFIG_HPET_TIMER by chance? It seems to be missing some
> > > strategic -1, TSC (etc) get it right.
> > 
> > I'm not using hpet because it's an old hardware, this is with timer_tsc.
> > It must be reproducible in any machine out there, especially with
> > machines with usb it should be reproducible even without any userspace
> > testcase doing iopl/cli/sti. Time will go silenty in the future at every
> > usb irq (they often last 3/4msec).
> 
> How much drift do you see?
> 
> I have machine with UHCI here, and am using usb most of the time
> (bluetooth for gprs connection), and did not notice too bad
> drift. ntpdate does some adjustment each time I connect to the
> network, but it 

Okay, I have good news and bad news. Bad news is that it is broken on
my machine, too. Good news is that breakage is not at all subtle.

root@amd:/home/pavel/misc# time ./latency

0.00user 0.00system 1.69 (0m1.694s) elapsed 0.17%CPU
root@amd:/home/pavel/misc# time ./latency

0.00user 0.00system 4293.47 (71m33.478s) elapsed 0.00%CPU
root@amd:/home/pavel/misc#

71 minutes when it ran for 2.5 seconds?!

root@amd:~# ntpdate tak.cesnet.cz
16 Dec 02:04:24 ntpdate[6385]: adjust time server 195.113.144.238
offset 0.010865 sec
root@amd:~# ntpdate tak.cesnet.cz
16 Dec 02:08:07 ntpdate[6405]: step time server 195.113.144.238 offset
85.903997 sec
root@amd:~# ntpdate tak.cesnet.cz
16 Dec 02:09:02 ntpdate[6410]: step time server 195.113.144.238 offset
4.306853 sec
root@amd:~# ntpdate tak.cesnet.cz
16 Dec 02:09:11 ntpdate[6411]: adjust time server 195.113.144.238
offset -0.028829 sec
root@amd:~# ntpdate tak.cesnet.cz
16 Dec 02:09:27 ntpdate[6413]: step time server 195.113.144.238 offset
4.283117 sec
root@amd:~# ntpdate tak.cesnet.cz
16 Dec 02:09:47 ntpdate[6415]: step time server 195.113.144.238 offset
4.286300 sec
root@amd:~#

It seems that each cycle of attached program (needs root) breaks
system time by 4 seconds... I do not know why it printed 71minutes
there. That seems like some underflow somewhere.. Strange, now it
happened again.

void
main(void)
{
        int i;
        iopl(3);
        while (1) {
                asm volatile("cli");
                //              for (i=0; i<20000000; i++)
                for (i=0; i<1000000000; i++)
                        asm volatile("");
                asm volatile("sti");
                sleep(1);
        }
}

Actually it seems to create some sort havoc in timer
subsystem... Actually it is reproducible:

root@amd:/home/pavel/misc# date; time ./latency ; date; sleep 1; date; sleep 1; date; sleep 1; date
Thu Dec 16 02:14:18 CET 2004

0.00user 0.00system 4293.51 (71m33.516s) elapsed 0.00%CPU
Thu Dec 16 03:25:51 CET 2004
Thu Dec 16 02:14:18 CET 2004
Thu Dec 16 02:14:19 CET 2004
Thu Dec 16 02:14:20 CET 2004
root@amd:/home/pavel/misc# date; time ./latency ; date; sleep 1; date; sleep 1; date; sleep 1; date
Thu Dec 16 02:14:23 CET 2004

0.00user 0.00system 4293.52 (71m33.521s) elapsed 0.00%CPU
Thu Dec 16 03:25:56 CET 2004
Thu Dec 16 03:25:57 CET 2004
Thu Dec 16 02:14:23 CET 2004
Thu Dec 16 02:14:24 CET 2004
root@amd:/home/pavel/misc#

							Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
