Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSFQPRG>; Mon, 17 Jun 2002 11:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSFQPRF>; Mon, 17 Jun 2002 11:17:05 -0400
Received: from 01-025.118.popsite.net ([66.19.120.25]:260 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S312973AbSFQPRE>;
	Mon, 17 Jun 2002 11:17:04 -0400
Date: Mon, 17 Jun 2002 11:01:08 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
Cc: "'akpm@zip.com.au'" <akpm@zip.com.au>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'devfs@oss.sgi.com'" <devfs@oss.sgi.com>
Subject: Re: Inexplicable disk activity trying to load modules on devfs
Message-ID: <20020617150108.GA4989@nevyn.them.org>
Mail-Followup-To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>,
	"'akpm@zip.com.au'" <akpm@zip.com.au>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'devfs@oss.sgi.com'" <devfs@oss.sgi.com>
References: <6134254DE87BD411908B00A0C99B044F039645EB@mowd019a.mow.siemens.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6134254DE87BD411908B00A0C99B044F039645EB@mowd019a.mow.siemens.ru>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 10:59:26AM +0400, Borsenkow Andrej wrote:
> >> 
> >> I just booted into 2.4.19-pre10-ac2 for the first time, and noticed 
> >> something very odd: my disk activity light was flashing at about 
> >> half-second intervals, very regularly, and I could hear the disk 
> >> moving. I was only able to track it down to which disk controller, via 
> >> /proc/interrupts (are there any tools for monitoring VFS activity? 
> >> They'd be really useful). Eventually I hunted down the program causing 
> >> it: xmms. 
> >> 
> >> The reason turned out to be that I hadn't remembered to build my sound 
> >> driver for this kernel version. Every half-second xmms tried to open 
> >> /dev/mixer (and failed, ENOENT). Every time it did that there was 
> >> actual disk activity. Easily reproducible without xmms. Reproducible 
> >> on any non-existant device in devfs, but not for nonexisting files on 
> >> other filesystems. Is something bypassing the normal disk cache 
> >> mechanisms here? That doesn't seem right at all. 
> >> 
> >
> >
> >syslog activity from a printk, perhaps? 
> 
> No. It is most probably devfsd trying to load sound modules.
> 
> This is exactly the reason Mandrake does not enable devfs in kernel-secure.
> You can badly hit your system by doing in a loop ls /dev/foo for some device
> foo that is configured for module autoloading.
> 
> It is very fascist decision; the slightly more forgiving way is to disable
> devfsd module autoloading (or disable devfsd entirely, just run it once
> after all drivers are loaded to execute actions) but then you lose support
> for hot plugging and some people do use kernel-secure on desktops. 

For the curious, the reason is that modprobe writes even failed attempts
to a log in /var/log/ksymoops, and calls fdatasync() on that file
afterwards.  There is no way to disable this without removing that
directory, as a design decision.  I don't personally see the point in
logging attempts which fail because there is no driver...


-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
