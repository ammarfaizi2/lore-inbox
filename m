Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268162AbUIKQng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268162AbUIKQng (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 12:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268169AbUIKQnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 12:43:35 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:11281 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268162AbUIKQnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 12:43:32 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] udev: udevd shall inform us abot trouble
Date: Sat, 11 Sep 2004 19:43:21 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200409081018.43626.vda@port.imtp.ilyichevsk.odessa.ua> <20040910203046.GA19655@kroah.com>
In-Reply-To: <20040910203046.GA19655@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409111943.21225.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I built udev with:
> >
> > USE_LOG = true
> > DEBUG = false
> >
> > but udevd does not log anything under such setting (all
> > udevd messages are coded as debug messages).
> >
> > This patch improves situation by changing some dbg()'s
> > into info()'s.
>
> No, I don't like this change, as it increases the size of udevd pretty
> unnecessarily (errors like what happened to you are very rare, and we
> could blame them on pilot error...)

I do not fully agree, but it is not that important.

So far, udev is working fine for me.
I've seen only two regressons of udev versus devfs, both are not
very serious:

1. amixer races with udev if run directly after modprobe,
like this:

modprobe snd-via82xx
modprobe snd-mixer-oss
modprobe snd-pcm-oss
amixer set 'Master',0 90%,90% unmute
amixer set 'Master Mono',0 90% unmute
amixer set 'PCM',0 90%,90% unmute
amixer set 'Headphone',0 90%,90% unmute

Well, I lied a bit. These lines are from my home box, which is not
udev'ified yet. At the job, I sit on i815 box, and there amixer
fails to set volume. It happens 100% of the time. Adding "sleep 1"
after modprobing helps. With devfs it worked without sleep.

2. I have no processes on /dev/tty1. Nobody have open descriptors to it,
it is not a ctty for anyone. tty1 still has messages printed by init at boot
before init closed its stdin, stdout and stderr.

If I switch to vc1 and start to move a mouse (I have gpm running), it is
very sluggish. That's because hotplug+udev constantly registers and de-registers
vcs[a]N devices. Agian, I do not see such thing with devfs.
--
vda

