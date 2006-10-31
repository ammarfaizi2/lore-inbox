Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423832AbWJaUPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423832AbWJaUPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 15:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423838AbWJaUPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 15:15:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:1080 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423832AbWJaUPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 15:15:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=aDYnmhiFy1ab68ho1PlpAk3US8SyU/ADhL21Qa3UKI28A+YpNXurIuvhQn2R0Oahwsyd9FOziYpYamBPOB16gGktrB8Xu6YDxy8ofGBjAxV7bxmIKD1DyK5Dg4WeSpgkTFtAhqaDstF9rZ9s6SjNXwh8lQm+YxL6B8kd5VMszjg=
Date: Tue, 31 Oct 2006 21:15:02 +0100
From: Luca Tettamanti <kronos.it@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org,
       John Richard Moser <nigelenki@comcast.net>
Subject: Re: Suspend to disk:  do we HAVE to use swap?
Message-ID: <20061031201502.GB5194@dreamland.darkstar.lan>
References: <20061031174006.GA31555@dreamland.darkstar.lan> <200610311905.33667.s0348365@sms.ed.ac.uk> <200610312019.38368.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610312019.38368.rjw@sisk.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Tue, Oct 31, 2006 at 08:19:37PM +0100, Rafael J. Wysocki ha scritto: 
> On Tuesday, 31 October 2006 20:05, Alistair John Strachan wrote:
> > On Tuesday 31 October 2006 17:40, Luca Tettamanti wrote:
> > > Alistair John Strachan <s0348365@sms.ed.ac.uk> ha scritto:
> > > > On Tuesday 31 October 2006 06:16, Rafael J. Wysocki wrote:
> > > > [snip]
> > > >
> > > >> However, we already have code that allows us to use swap files for the
> > > >> suspend and turning a regular file into a swap file is as easy as
> > > >> running 'mkswap' and 'swapon' on it.
> > > >
> > > > How is this feature enabled? I don't see it in 2.6.19-rc4.
> > >
> > > Swap files have been supported for ages. suspend-to-swapfile is very
> > > new, you need a -mm kernel and userspace suspend from CVS:
> > > http://suspend.sf.net
> > 
> > I know, I use swap files, and not a partition. This has prevented me from 
> > using suspend to disk "for ages". ;-)
> > 
> > Is userspace suspend REQUIRED for this feature?
> 
> No, but unfortunately one piece is still missing: You'll need to figure out
> where your swap file's header is located.
> 
> However, if you apply the attached patch the kernel will tell you where it is
> (after you do 'swapon' grep dmesg for 'swap' and use the value in the
> 'offset' field).

Of course it's also possibile to use FIBMAP ioctl:

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/fs.h>

int main(int argc, char **argv) {
        int block = 0;
        int fd;

        if (argc < 2)
                return 1;

        fd = open(argv[1], O_RDONLY);
        if (fd < 0) {
                perror("open()");
                return 1;
        }

        if (ioctl(fd, FIBMAP, &block)) {
                perror("ioctl()");
                return 1;
        }

        close(fd);
        printf("%d\n", block);

        return 0;
}

Probably it's more script friendly (grepping dmesg? hmmm) ;)

Luca
-- 
Non sempre quello che viene dopo e` progresso.
Alessandro Manzoni
