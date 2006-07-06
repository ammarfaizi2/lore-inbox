Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbWGFHyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWGFHyW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 03:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWGFHyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 03:54:22 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:27541 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S964980AbWGFHyW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 03:54:22 -0400
Date: Thu, 6 Jul 2006 09:54:20 +0200
From: DervishD <lkml@dervishd.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Solved] usb-storage device wrongly seen as "write protect is on"
Message-ID: <20060706075420.GB21819@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
References: <20060630131642.GA156@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060630131642.GA156@DervishD>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

 * DervishD <privado@dervishd.net> dixit:
>     I'm having a problem with an usb-storage device (namely a Inovix
> IMP65 MP3 player): when I plug it and I try to mount it, the sd_mod
> driver sees it write protected, so I cannot mount it read-write.
> 
>     If I remount it as read-write (as root, of course), I have
> success and I can use the device normally, being able to write to it
> without problems. If, instead, I manually unload sd_mod and load it
> again, then this time the device is NOT seen as write protected (the
> sd_mod driver says that "write protect is off").

    Well, after following Alan Stern's suggestion and making a trace
of what was happening using usbmon, the problem was solved.

    The stupid device is probably sharing firmware with another model
with SD card or whatever, and tells the kernel it has removable media
inside! Of course the kernel believes that. During the first two
polls (sometimes only the first poll, at least in 2.4.x) the device
reports that the media is write protected. Probably it doesn't want
to accept any WRITE commands until the "removable media" is settled,
or whatever...

    After that, it reports a media change and voilá, the "new" media
is no longer write-protected.

    I don't know why it worked in WinXP and MacOS, but now it works
in my 2.4 kernel. I just do the following:

    $ mount /media/mp3; umount /media/mp3; mount /media/mp3

    The second mount will see the media as write-enabled and will
mount it read-write. Cool!

    Thanks a lot to Alan Stern for solving my problem and showing so
much interest in the issue. And thanks to Andrew Morton, too, for
forwarding my message to the USB developers list :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to... RAmen!
