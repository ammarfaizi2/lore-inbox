Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVBDMRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVBDMRG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 07:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVBDMRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 07:17:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:13487 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261175AbVBDMQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 07:16:48 -0500
X-Authenticated: #26200865
Message-ID: <420367CF.7060206@gmx.net>
Date: Fri, 04 Feb 2005 13:17:19 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: ncunningham@linuxmail.org, Pavel Machek <pavel@ucw.cz>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Reliable video POSTing on resume
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net>	 <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net>	 <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz>	 <1107474198.5727.9.camel@desktop.cunninghams>	 <4202DF7B.2000506@gmx.net> <9e47339105020321031ccaabb@mail.gmail.com>
In-Reply-To: <9e47339105020321031ccaabb@mail.gmail.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl schrieb:
> Reseting a video card from suspend is essentially the same problem as
> reseting secondary video cards on boot. The same code can address both
> problems.
> 
> Some things to consider....
> 
> 1) With multiple video cards you have to ensure only a single VGA gets
> enabled. Running video reset on a card is going to turn on it's VGA
> emulation. So you have to ensure that VGA emulation on other cards is
> disabled first.

No problem. Let the kernel tell the userspace application which card
to reset.

> 2) I add the 'rom' parameter in sysfs so that you can get to the rom
> contents from a user space app. It's there to support running video
> reset code. "echo 1 >rom" to see the contents, it is not enabled by
> default.

That could be very helpful for secondary cards.

> 3) The user space reset programs have to be serialized because of the
> rule about only a single VGA at a time. Calling vm86 from kernel mode
> is not a good idea. Doing this in user space lets you have two reset
> programs, vm86 and emu86 for non-x86 machines.

With the approach I detailed in the thread starter, this is easily
possible. vesaposter can call the kernel function used to synchronize
in an endless loop and this kernel function would not only be used
to synchronize, but its return value would tell vesaposter what to do
to which card. An alternative would be to restart vesaposter as soon
as it has finished its job, which would make the POSTing reliable
even if the BIOS code hangs or causes crashes. The kernel can simply
store a list of video devices and their respective treatments and
the kernel function called by vesaposter would just iterate through
the list. Hmmm... why not call it

int video_helper(struct video_actions *what_to_do)

and it blocks until we have something to POST. It could contain
all the locking needed to serialize access to the video cards.
OTOH, if starting applications from initramfs at resume time is
easy, we could make video_helper non-blocking and start vesaposter
on demand.


And the problem of locking all application memory: The current tool
for POSTing and restoring video state (vbetool) uses only 27k on
disk. If we put it in initramfs, we could maybe avoid mlock
completely (if we can guarantee initramfs contents aren't swapped
out). And it would be available early enough for initializing
video hardware on boot.


> A starting place for a user space reset program:
> ftp://ftp.scitechsoft.com/devel/obsolete/x86emu/x86emu-0.8.tar.gz
> 
> This thread talks about the VGA routing code:
> http://lkml.org/lkml/2005/1/17/347

Thanks for the pointers! I'll have to compare it to our current
userspace reset and vesa register restoring program
http://www.srcf.ucam.org/~mjg59/vbetool/


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
