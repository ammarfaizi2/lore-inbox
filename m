Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWIKKYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWIKKYf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 06:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWIKKYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 06:24:35 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:64932 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932136AbWIKKYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 06:24:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Tb/QYn1LmRFCnpMd/6JXi0XF8G9Vd0I98UC1dud0AgkrbpxxyEikkkaMp6mk6Q4S85sPOGqxr74IWLGhugoP2/pplFUOVSUVxTkYJ/kJjX2spYonuLsPRAKF7sffvtXBxAhhJUoQEgGT6oXBkuUXuaHJVkeg4T8PNbifP2cLAU4=
Message-ID: <4505394F.6060806@gmail.com>
Date: Mon, 11 Sep 2006 12:24:15 +0200
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: SATA powersave patches
References: <20060908110346.GC920@elf.ucw.cz> <45015767.1090002@gmail.com> <20060908123537.GB17640@elf.ucw.cz> <4501655F.5000103@gmail.com> <20060910224815.GC1691@elf.ucw.cz>
In-Reply-To: <20060910224815.GC1691@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Pavel Machek.

Pavel Machek wrote:
> Thanks... I got it to work (on 2 the old tree, I was not able to
> forward-port it), but power savings were not too big (~0.1W, maybe).
> 
> I'm getting huge (~1W) savings by powering down SATA controller, as in
> ahci_pci_device_suspend().

Yeah, it only turns off SATA PHY, so it doesn't result in huge saving. 
IIRC, it was somewhere around 5 percent on my notebook w/ static 
linksave mode (turning PHY off on empty port).  But link powersaving 
introduces virtually no recognizable delay, so it's nice to have.

Can you check if there is any difference between [D/H]IPS and static? 
ICH6M on my notebook can't do DIPS/HIPS, so I couldn't compare them 
against static.

> It would be great to be able to power SATA
> controller down, then power it back up when it is needed... I tried
> following hack, but could not get it to work. Any ideas?

1. One way to do it would be by dynamic power management.  It would be 
nice to have wake-up mechanism at the block layer.  Idle timer can run 
in the block layer or it can be implemented in the userland.

ATM, this implies that the attached devices are powered down too 
(spindown).  As spinning up takes quite some time, we can implement 
another level of dynamic PM w/ shorter delay to wake up - drives are not 
spinned down but controllers are powered down completely.

In any case, channel reset and following revalidation are necessary on 
wake up - if the device is still spinning, this shouldn't take too long 
but it will introduce noticeable delay - probably under or around a sec.

2. Another hacky way would be implementing it as an extension of link 
powersaving.  I don't think this is a good idea tho.  Waking up a 
controller usually involves link reset which in turn requires 
revalidation and reconfiguration of attached device, which should be 
done from exception handler.

The reason why your hack doesn't work is probably this reason.  You need 
to pass the command to EH and tell it to perform full wake-up sequence 
and retry the command.

So, I think option #1 is the way to go - implementing leveled dynamic 
power management infrastructure and adding support in the block layer. 
What do you think?

Thanks.

-- 
tejun
