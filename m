Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130892AbQKJVW4>; Fri, 10 Nov 2000 16:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130768AbQKJVWq>; Fri, 10 Nov 2000 16:22:46 -0500
Received: from [194.213.32.137] ([194.213.32.137]:3332 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130892AbQKJVW1>;
	Fri, 10 Nov 2000 16:22:27 -0500
Message-ID: <20001110213911.A300@bug.ucw.cz>
Date: Fri, 10 Nov 2000 21:39:11 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: jaharkes@cs.cmu.edu
Subject: Re: mount -tcoda /dev/cfs0 /mnt no longer works in -test9 and newer?
In-Reply-To: <20001106103539.A343@bug.ucw.cz> <20001107134841.A31058@cs.cmu.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4bRzO86E/ozDv8r1"
X-Mailer: Mutt 0.93i
In-Reply-To: <20001107134841.A31058@cs.cmu.edu>; from Jan Harkes on Tue, Nov 07, 2000 at 01:48:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=muttWbQtHE

Hi!

> > It complains
> > 
> > coda_read_super: Bad mount data
> > coda_read_super: device index: 0
> > 
> > and will not mount. What do I need to mount coda?
> > 								Pavel
> 
> Miklos Szeredi sent a patch to support multiple mountpoints/coda
> devices. However, the code falls back on the default device (cfs0)
> when the mountdata is incorrect. So the problem must be unrelated
> to the "Bad mount data" error message.
> 
> The code to mount with the correct mountdata looks like this:
> 
>       #include <linux/coda.h>
> 
>       muxfd = open("/dev/cfs0", O_RDWR);
> 
>       struct coda_mount_data mountdata;
>       mountdata.version = CODA_MOUNT_VERSION;
>       mountdata.fd = muxfd
> 
>       error = mount("coda", "/coda", "coda",  MS_MGC_VAL,
> 		    (void *)&mountdata);

This does not work:

open("/dev/cfs0", O_RDWR)               = -1 ENODEV (No such device)
mount("coda", "/mnt", "coda", 0xc0ed0000, 0xbffffc04coda_read_super:
Bad file
coda_read_super: device index: 0
coda_read_super: No pseudo device
) = -1 EINVAL (Invalid argument)
_exit(-1)                               = ?

:-(. [I attached full source to my mount utility.]
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org

--4bRzO86E/ozDv8r1
Content-Type: text/x-csrc
Content-Disposition: attachment; filename="mount.c"


#include <dirent.h>
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <signal.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#ifdef SOLARIS
#include <sys/types32.h>
#include <sys/fcntl.h>
#include <sys/mount.h>
#include <sys/mntent.h>
#include <sys/mnttab.h>
#endif
#include <sys/stat.h>
#include <sys/time.h>
#include "/usr/src/linux/include/linux/coda.h"
#define MS_MGC_VAL 0xC0ED0000 /* magic flag number to indicate "new" flags */


void main(void)
{
	int muxfd = open("/dev/cfs0", O_RDWR);
	int error;

	struct coda_mount_data mountdata;
	mountdata.version = CODA_MOUNT_VERSION;
	mountdata.fd = muxfd;

	error = mount("coda", "/mnt", "coda",  MS_MGC_VAL,
		      (void *)&mountdata);
}

--4bRzO86E/ozDv8r1--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
