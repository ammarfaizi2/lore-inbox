Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318775AbSHWMRq>; Fri, 23 Aug 2002 08:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318779AbSHWMRp>; Fri, 23 Aug 2002 08:17:45 -0400
Received: from codepoet.org ([166.70.99.138]:19596 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S318775AbSHWMRm>;
	Fri, 23 Aug 2002 08:17:42 -0400
Date: Fri, 23 Aug 2002 06:21:50 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4-ac1
Message-ID: <20020823122149.GA21809@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200208231046.g7NAk2914276@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208231046.g7NAk2914276@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 23, 2002 at 06:46:02AM -0400, Alan Cox wrote:
> o	Abort IDE cd reads immediately on medium	(Erik Andersen)
> 	error as that isnt correctable

Note that is this only 1/2 of a fix however...

Suppose for example we write the following stupid app:

    int fd;
    char buf[1024*1024];

    fd = open("/dev/cdrom", O_RDONLY | O_NONBLOCK);

    lseek(fd, offset_near_bad_sector, SEEK_SET);

    if (read(fd, buf, sizeof(buf)) < 0) {
	perror("read");
	return EXIT_FAILURE;
    }
    return 0;

So it wants to read 512 sectors at 'offset_near_bad_sector'.
Lets suppose that the 10th sector after this offset is bad.
So it reads 9 sectors just fine.  Then it hits the bad spot.
After the ide layer decides to pass the error to ide-cd, the
ide-cd driver now calls cdrom_end_request(), per the patch
now in 2.4.20-pre4-ac1, and we abort trying to read the 10th
sector, as expected.

But then the driver proceeds to try and read the other 502
sectors before it throws away the 1MB and returns an EIO to
user space!

Reading the rest of the N sectors after an IO error (only to
throw it all away), is terribly stupid.  It means that when
there is a group of bad sectors on the media, user space
stays stuck in D state for several minutes before we even
find out about the bad sector.  And if you think about why
bad sectors show up on CD-ROM media (at my house think of
children, playing with CDs and sharp objects), you will
realize that groups of bad sectors on the media is actually
the common case...

I spent an hour last night trying to track down where it was
doing the broken "keep reading after an IO error" logic but
I've not yet been able to come up with a proper fix,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
