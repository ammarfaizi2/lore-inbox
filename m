Return-Path: <linux-kernel-owner+w=401wt.eu-S1760764AbWLHQeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760764AbWLHQeL (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760769AbWLHQeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:34:11 -0500
Received: from pra.praprr.net ([217.147.94.29]:56753 "EHLO lkcl.net"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1760764AbWLHQeK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:34:10 -0500
From: "Luke Kenneth Casson Leighton" <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org, kernel-discuss@handhelds.org
Cc: lkcl@lkcl.net
Subject: parallel boot device initialisation (kernel-space not userspace)
Date: Fri, 8 Dec 2006 16:34:02 +0000 (UTC)
X-Real-Sender: lkcl@lkcl.net
X-Postman-SMTP-Auth: 0,0
X-Mailer: postman 2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <4758137481lkcl@lkcl.net>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: lkcl@lkcl.net
X-SA-Exim-Scanned: No (on lkcl.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello darlings,

well i actually followed the FAQ http://www.tux.org/lkml/#s3-17
on this one, and got to try 'do a search' bit, and when searches
for 'parallel boot initialisation' came up with discussions about
parallel ports, and articles on ibm developerworks about sysvinit,
i made the decision to post this anyway.

I Have A Great Idea(tm) and would like to describe it concisely
to see if anyone likes it and hopefully hasn't thought of it before
so i'm not consuming people's time.

The idea is: parallel device initialisation of built-in modules, to
reduce kernel boot time.

parallel initialisation is taken care of in user-space by modifying
udev coldplug scripts to watch subsets of the /sys/class/*/event
files disappearing, and by using things like depinit, startpar for
suse, gentoo's parallel startup system (inspired by depinit)


.. but is there _anything_ like this actually in the linux kernel
itself?

i don't believe so, and the reasoning i base that on is that when
i boot my devices (be it a pc or be it an HTC smartphone device
i'm helping to reverse-engineer) the kernel startup log is always
the same, and that multiple messages coming from the same device
(printks) are always grouped together.

i realise that that's slightly faulty reasoning: it could
be that device initialisation is so regular like clockwork that
the output is always the same...

anyway.

now i have to try some things, as an experiment.  and i would
like to start with asic3 platform_device, because it contains
dynamically-created lists of child devices and so is a model
example of the kind of dependency-hierarchy that's needed.

so, i seek people's advice on this rather naive approach: simply
set up a workqueue and call schedule_work() on each of the asic3
child platform_devices.

does that sound reasonable, or is it just too simplistic?

l.

p.s. see last few lines of asic3_probe, here, where 
platform_add_devices() is called:

http://handhelds.org/cgi-bin/cvsweb.cgi/linux/kernel26/drivers/soc/asic3_base.c?rev=1.28&content-type=text/x-cvsweb-markup

p.p.s. whilst my 1.2ghz fujitsu laptop (debian/unstable) with depinit
takes only 20 seconds to get from 1st process being run (/sbin/depinit)
to xorg running, it takes ANOTHER 20 seconds to get from kernel boot
up to 1st process (/sbin/depinit) !  that's with a standard debian
kernel - hence my interest in cutting that time to ... well...
under 5 seconds would be nice.

