Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbUCUSwA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 13:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263699AbUCUSwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 13:52:00 -0500
Received: from pop.gmx.net ([213.165.64.20]:42884 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263698AbUCUSv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 13:51:57 -0500
X-Authenticated: #21910825
Message-ID: <405DE3EF.8090508@gmx.net>
Date: Sun, 21 Mar 2004 19:50:23 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] fix tiocgdev 32/64bit emul
References: <405DC698.4040802@pobox.com> <20040321165752.A9028@infradead.org>
In-Reply-To: <20040321165752.A9028@infradead.org>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-03-21 16:57:52, Christoph Hellwig wrote:
> On Sun, Mar 21, 2004 at 11:45:12AM -0500, Jeff Garzik wrote:
>> Yup, looks like a real bug to me...  good catch.
>>
>> Untested but obvious patch attached.
> 
> Isn't that SuSE's strange ioctl hack that has been rejected for mainline
> multiple times?  why does x86_64 have an emulation for it if the ioctl
> isn't implemented anyway?

Since this pops up from time to time, please let me explain what TIOCGDEV
does (if you know already, feel free to scoll to the end) and ask for
alternative solutions.

Quoting http://marc.theaimsgroup.com/?l=linux-kernel&m=89051325309548
On 1998-03-21 20:41:37, Miquel van Smoorenburg wrote:
> This patch introduces a new ioctl, TIOCGDEV. It can be used to find
> out the _real_ device of the serial console.
> 
> I use this so I can first open /dev/console and a pty pair, then use
> TIOCCONS to redirect console output to the pty, and then I can copy
> the console output from the pty to both a logfile and the real console.
> This is useful for a boot-time daemon so all bootup messages can be
> captured and logged...

Further links to relevant messages:
http://marc.theaimsgroup.com/?l=linux-kernel&m=97696542915335
http://marc.theaimsgroup.com/?l=linux-kernel&m=97696701517101
http://marc.theaimsgroup.com/?l=linux-kernel&m=97696788418144

Quoting http://marc.theaimsgroup.com/?l=linux-kernel&m=102929921716152
On 2002-08-14 4:26:45, Linus Torvalds wrote:
> I've always hated the fact that all the boot-time messages get lost,
> simply because syslogd hadn't started, and as a result things like fsck
> ran without any sign afterwards.

http://marc.theaimsgroup.com/?l=linux-kernel&m=102931212924401
http://marc.theaimsgroup.com/?l=linux-kernel&m=103383136010219
http://marc.theaimsgroup.com/?l=linux-kernel&m=103383754113901
http://marc.theaimsgroup.com/?l=linux-kernel&m=103418708112077
http://marc.theaimsgroup.com/?l=linux-kernel&m=103771548020416
http://marc.theaimsgroup.com/?l=linux-kernel&m=103771746822896

Quoting http://marc.theaimsgroup.com/?l=linux-kernel&m=97692840309876
On 2000-12-16 0:55:37, Kurt Garloff wrote:
> some applications do need to know where the console (/dev/console)
> actually maps to. For processes with a controlling terminal, you may see
> it in /proc/$$/stat. However, daemons are supposed to run detached (they
> don't want to get killed by ^C) and some processes like init or bootlogd
> do still need to be able to find out.
> 
> The kernel provides this information -- sort of:
> It contains the TIOCTTYGSTRUCT syscall which returns a struct. Of course,
> it changes between different kernel archs and revisions, so using it is
> an ugly hack. Grab for TIOCTTYGSTRUCT_HACK in the bootlogd.c file of the
> sysvinit sources. Shudder!
> 
> Having a new ioctl, just returning the device no is a much cleaner solution,
> IMHO. So, I created the TIOCGDEV, which Miquel suggests in his sysvinit
> sources. It makes querying the actual console device as easy as
> int tty; ioctl (0, TIOCGDEV, &tty);
> 
> Patches against 2.2.18 and 2.4.0-testX are attached.

Quoting http://marc.theaimsgroup.com/?l=linux-kernel&m=97692912911233
On 2000-12-16 1:11:07, Linus Torvalds wrote:
> Please instead do the same thing /dev/tty does, namely a sane interface
> that shows it as a symlink in /proc (or even in /dev)

Can we do that in sysfs now? Back then, nobody implemented it for /proc
and it now already seems to exist as /sys/class/tty/console/dev

Does /sys/class/tty/console/dev have the semantics needed above?


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

