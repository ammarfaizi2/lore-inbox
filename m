Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269425AbUIILKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269425AbUIILKo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 07:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269429AbUIILKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 07:10:43 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:48499 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S269425AbUIILKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 07:10:32 -0400
Message-ID: <37312.195.245.190.93.1094728166.squirrel@195.245.190.93>
Date: Thu, 9 Sep 2004 12:09:26 +0100 (WEST)
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Lee Revell" <rlrevell@joe-job.com>,
       "Florian Schmidt" <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20040909120926_89323"
X-Priority: 3 (Normal)
Importance: Normal
References: <20040903120957.00665413@mango.fruits.de>         
    <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu>       
      <1094597710.16954.207.camel@krustophenia.net>         
    <1094598822.16954.219.camel@krustophenia.net>         
    <32930.192.168.1.5.1094601493.squirrel@192.168.1.5>         
    <20040908082358.GB680@elte.hu> <20040908083158.GA1611@elte.hu>
In-Reply-To: <20040908083158.GA1611@elte.hu>
X-OriginalArrivalTime: 09 Sep 2004 11:10:29.0562 (UTC) FILETIME=[9DBB01A0:01C4965D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20040909120926_89323
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

I'm back with some news :)


>* Ingo Molnar wrote:
>
>> * Rui Nuno Capela wrote:
>>
>> > OK, could just someone with a P4 HT/SMP box hand me their working
>> > kernel .config file for me to try? That could be a good starting
>> > point, if not a plain baseline.
>>
>> I'll try the latest VP kernel (-R9) on a P4/HT SMP box in a minute and
>> will send you a .config if it works. [...]
>
> P4/HT SMP works fine here - config attached.
>
> since your lockups occur under X, could you try to disable DRI/DRM in
> your XConfig? Also, would it be possible to connect that box to another
> box via a serial line and enable the kernel's serial console via the
> 'console=ttyS0,38400 console=tty' boot option and run 'minicom' on that
> other box, set the serial line to 38400 baud there too and capture all
> kernel messages that occur when the lockups happens? Also enable the NMI
> watchdog via nmi_watchdog=1.
>


OK. Spent the whole late night building several R9's, enabling modules one
by one, and testing most options in a incremental fashion. Didn't tried
the serial console yet but I found something that's otherwise specific to
my hardware setup, but only exposed with the VP SMP configuration, as I've
been recently reporting.

So the base experiments were conducted by applying on:

    linux-2.6.9-rc1.tar.bz2

the follwing patches in sequence:

    patch-2.6.9-rc1-bk12.bz2
    voluntary-preempt-2.6.9-rc1-bk12-R9

Here are my summary report:

1) My first experiment was using Ingo's .config exactly as he gave me,
with the sole exception that I switched reiserfs support liked in, as
needed by primary/boot disk partitions. It boots OK, fine but missing
alomost every needed module/device support.

2) Switched module (un|auto)loading support. OK.

3) Several config iterations later, which were taken by switching in some
modules I found obvious to be included one by one, I've finally reached
the showstopper: USB support.

4) Then I wandered: the problem must be in one of plugged USB devices. And
right I was: my WACOM GRAPHIRE2 USB tablet was the culprit. Strange
enough, the hid and wacom modules weren't compiled in yet. Some more
iterations later, and it didn't matter if those modules are in or not: if
the tablet is plugged in at boot time the VP+SMP combination freezes.

5) Incidentally I found that I must unplug the tablet at boot time of
freshly built VP+SMP kernel. Then I found that installing the linuxwacom
project [http://linuxwacom.sourceforge.net] drivers, which adds some
changes to mousedev (built-in), evdev and wacom kernel modules, I end up
with a kernel that I can boot and run later already with the tablet
plugged in.

6) Now that had found the major showstopper, I decided to go for audio:
among some other thingies, switched ALSA sound modules on, included the
realtime-lsm patch and built what comes to be my latest VP+SMP working
kernel. And it boots OK. Great.

7) Now let's start jackd... start some client applications, hear some
sound, and... horror! The system hangs completetly. The time it takes to
hang is by no means deterministic. Soon or later it hangs. Hard-reboot is
always the only way around, no magic-sysrq :( Gasp, I've seen this before.

8) Indeed, only by disabling both softirq and hardirq preeemption I get an
usable VP+SMP kernel. But that's no surprise either, it has been always
like that until Q3, which was the latest VP+SMP combination that didn't
suffer with the Wacom tablet presence at boot/init time. I only hoped the
(soft|hard)irq trouble would be solved by R9 time.

Nevertheless, I'm now a lil'bit happier, now that I've catched up on this
VP promise :)

Thanks for the patience.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

P.S. Included is my latest .config.

------=_20040909120926_89323
Content-Type: application/x-gzip-compressed;
      name="config-2.6.9-rc1-bk12-R9.6smp.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config-2.6.9-rc1-bk12-R9.6smp.gz"

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
------=_20040909120926_89323--


