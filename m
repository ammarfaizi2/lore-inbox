Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267869AbUIPJKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267869AbUIPJKZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 05:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUIPJKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 05:10:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14981 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267876AbUIPJHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 05:07:17 -0400
Date: Thu, 16 Sep 2004 11:05:40 +0200
From: Jens Axboe <axboe@suse.de>
To: "Bc. Michal Semler" <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD-ROM can't be ejected
Message-ID: <20040916090540.GX2300@suse.de>
References: <200409160025.35961.cijoml@volny.cz> <200409160918.40767.cijoml@volny.cz> <20040916073616.GO2300@suse.de> <200409161013.35454.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200409161013.35454.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16 2004, Bc. Michal Semler wrote:
> Dne ?t 16. zá?í 2004 09:36 jste napsal(a):
> > (don't top post, and don't trim cc list!)

don't trim the cc list!!

> > On Thu, Sep 16 2004, Bc. Michal Semler wrote:
> > > notas:/home/cijoml# mount /cdrom/
> > > notas:/home/cijoml# umount /cdrom/
> > > notas:/home/cijoml# strace -o eject /dev/hdc
> > > eject: unable to eject, last error: Nep?ípustný argument
> > >
> > > As you can see, I dont't enter to directory...
> > >
> > > And output is included
> > >
> > > ioctl(3, CDROMEJECT, 0xbffffac8)        = -1 EIO (Input/output error)
> >
> > That's the important bit, the reason you get EINVAL passed back is
> > because eject tries the floppy eject as well and decides to print the
> > warning from that. It really should just stop of it sees -EIO, only
> > continue if EINVAL/ENOTTY is passed back.
> >
> > Try this little c program and report back what it tells you. Compile
> > with
> >
> > gcc -Wall -o eject eject.c
> >
> > and run without arguments.
> >
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <fcntl.h>
> > #include <string.h>
> > #include <sys/ioctl.h>
> > #include <linux/cdrom.h>
> >
> > int main(int argc, char *argv[])
> > {
> > 	int fd = open("/dev/hdc", O_RDONLY | O_NONBLOCK);
> > 	struct cdrom_generic_command cgc;
> > 	struct request_sense sense;
> >
> > 	memset(&cgc, 0, sizeof(cgc));
> > 	memset(&sense, 0, sizeof(sense));
> >
> > 	cgc.cmd[0] = 0x1b;
> > 	cgc.cmd[4] = 0x02;
> > 	cgc.sense = &sense;
> > 	cgc.data_direction = CGC_DATA_NONE;
> >
> > 	if (ioctl(fd, CDROM_SEND_PACKET, &cgc) == 0) {
> > 		printf("eject worked\n");
> > 		return 0;
> > 	}
> >
> > 	printf("command failed - sense %x/%x/%x\n", sense.sense_key, sense.asc,
> > sense.ascq); return 1;
> > }
> 
> 2.4.27-mh1
> notas:~# /home/cijoml/eject
> ATAPI device hdc:
>   Error: Not ready -- (Sense key=0x02)
>   (reserved error code) -- (asc=0x53, ascq=0x02)
>   The failed "Start/Stop Unit" packet command was:
>   "1b 00 00 00 02 00 00 00 00 00 00 00 "
> command failed - sense 2/53/2

Your tray is still locked, are you sure it isn't mounted?

-- 
Jens Axboe

