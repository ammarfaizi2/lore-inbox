Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268077AbUIUVht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268077AbUIUVht (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 17:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268079AbUIUVht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 17:37:49 -0400
Received: from open.hands.com ([195.224.53.39]:61833 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268077AbUIUVho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 17:37:44 -0400
Date: Tue, 21 Sep 2004 22:48:42 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: David Zeuthen <david@fubar.dk>
Cc: HAL list <hal@freedesktop.org>, kde-devel@mail.kde.org,
       linux-kernel@vger.kernel.org
Subject: Re: USB Media card - works at boot-up, removal works, re-insert doesn't
Message-ID: <20040921214842.GJ1105@lkcl.net>
References: <20040921180217.GE1105@lkcl.net> <1095792743.5501.29.camel@localhost.localdomain> <20040921202911.GH1105@lkcl.net> <1095800905.4970.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095800905.4970.8.camel@localhost.localdomain>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2004 at 11:08:24PM +0200, David Zeuthen wrote:
> On Tue, 2004-09-21 at 21:29 +0100, Luke Kenneth Casson Leighton wrote:
> > hi david,
> > 
> > okay i tracked down a bit further, i think i outlined a bit towards the
> > end of the original message:
> > 
> 
> This is quite interesting,
> 
> > * umount -l /media/usbdisk7 is being done but konqueror still has
> >   directory handles open on it.
> > 
> > * therefore ioctl("/dev/sdc", BLKRRPART) returns an error "Device Busy".
> > 
> > * therefore no notifications go to the child volumes.
> > 
> > i "solved" the problem by doing this drastic and vicious assault on
> > KDE programs:
> > 
> > 	system("lsof %s | cut -d' ' -f2 | sort | uniq | xargs kill -TERM",
> > 	       mount_point);
> > 
> > when that is done from HAL just before the unmount -l, the problem goes
> > away.
> > 
> 
> Heh :-)
> 
> > *beam* :)
> > 
> > ... of course, i wouldn't dream of suggesting to anyone that this
> > technique actually be used in a production environment, but it _does_
> > work.
> > 
> > *lol*.
> > 
> > but seriously, the problems are caused, i believe, by KDE's kio_kfile
> > plugin, which does "directory notify" requests.
> > 
> > i'm endeavouring to track down whether disabling "dir notify" solves the
> > problem of konqueror keeping directory handles open.
> > 
> 
> To me, it seems like a severe kernel bug if a userspace process,
> *especially* if it's unprivileged, can keep the kernel from emitting
> hotplug remove events when a device is physically detached. It would be
> interesting to create a minimal program to reproduce this.

that's quite straightforward: i guess that an appx 30 character perl program
or a 3 line python program 'd do the job.

or just using opendir() in c, here y'go...


	#include <stdio.h>
	#include <dirent.h>

	int main(int argc, char *argv[])
	{
		opendir(argv[1]);
		sleep(3600);
	}

compile and test:

	lkcl@highfield:~/src$ gcc opendir.c
	lkcl@highfield:~/src$ ./a.out /tmp &
	[2] 23520
	lkcl@highfield:~/src$ 
	lkcl@highfield:~/src$ 
	lkcl@highfield:~/src$ lsof /tmp
	COMMAND   PID USER   FD   TYPE DEVICE SIZE  NODE NAME
	a.out   23520 lkcl    3r   DIR    3,2 4096 96983 /tmp
	lkcl@highfield:~/src$ konqueror file:/tmp &
	[3] 23527
	lkcl@highfield:~/src$ konqueror: WARNING: KGenericFactory: instance requested but no instance name passed to the constructor!
	lsof /tmp
	COMMAND     PID USER   FD   TYPE DEVICE SIZE  NODE NAME
	a.out     23520 lkcl    3r   DIR    3,2 4096 96983 /tmp
	konqueror 23527 lkcl  128r   DIR    3,2 4096 96983 /tmp


[of course, changing it to "umount -lf" _also_ solves the
 problem by making konqueror break: result, after the first remove,
 you have to manually close konqueror, insert the media, remove
 the media card (again), reinsert it (again), re-run konqueror]

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

