Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267446AbUIPVtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267446AbUIPVtG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 17:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267589AbUIPVtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 17:49:06 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:50693 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S267446AbUIPVsy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 17:48:54 -0400
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Jens Axboe <axboe@suse.de>
Subject: Re: CD-ROM can't be ejected
Date: Thu, 16 Sep 2004 23:48:51 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200409160025.35961.cijoml@volny.cz> <200409161419.38264.cijoml@volny.cz> <20040916122400.GB3544@suse.de>
In-Reply-To: <20040916122400.GB3544@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409162348.51806.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne èt 16. záøí 2004 14:24 Jens Axboe napsal(a):
> On Thu, Sep 16 2004, Bc. Michal Semler wrote:
> > Dne ?t 16. zá?í 2004 12:22 Jens Axboe napsal(a):
> > > On Thu, Sep 16 2004, Bc. Michal Semler wrote:
> > > > > > > On Thu, Sep 16 2004, Bc. Michal Semler wrote:
> > > > > > > > notas:/home/cijoml# mount /cdrom/
> > > > > > > > notas:/home/cijoml# umount /cdrom/
> > > > > > > > notas:/home/cijoml# strace -o eject /dev/hdc
> > > > > > > > eject: unable to eject, last error: Nep?ípustný argument
> > > > > > > >
> > > > > > > > As you can see, I dont't enter to directory...
> > > > > > > >
> > > > > > > > And output is included
> > > > > > > >
> > > > > > > > ioctl(3, CDROMEJECT, 0xbffffac8)        = -1 EIO
> > > > > > > > (Input/output error)
> > > > > > >
> > > > > > > That's the important bit, the reason you get EINVAL passed back
> > > > > > > is because eject tries the floppy eject as well and decides to
> > > > > > > print the warning from that. It really should just stop of it
> > > > > > > sees -EIO, only continue if EINVAL/ENOTTY is passed back.
> > > > > > >
> > > > > > > Try this little c program and report back what it tells you.
> > > > > > > Compile with
> > > > > > >
> > > > > > > gcc -Wall -o eject eject.c
> > > > > > >
> > > > > > > and run without arguments.
> > > > > > >
> > > > > > > #include <stdio.h>
> > > > > > > #include <stdlib.h>
> > > > > > > #include <fcntl.h>
> > > > > > > #include <string.h>
> > > > > > > #include <sys/ioctl.h>
> > > > > > > #include <linux/cdrom.h>
> > > > > > >
> > > > > > > int main(int argc, char *argv[])
> > > > > > > {
> > > > > > > 	int fd = open("/dev/hdc", O_RDONLY | O_NONBLOCK);
> > > > > > > 	struct cdrom_generic_command cgc;
> > > > > > > 	struct request_sense sense;
> > > > > > >
> > > > > > > 	memset(&cgc, 0, sizeof(cgc));
> > > > > > > 	memset(&sense, 0, sizeof(sense));
> > > > > > >
> > > > > > > 	cgc.cmd[0] = 0x1b;
> > > > > > > 	cgc.cmd[4] = 0x02;
> > > > > > > 	cgc.sense = &sense;
> > > > > > > 	cgc.data_direction = CGC_DATA_NONE;
> > > > > > >
> > > > > > > 	if (ioctl(fd, CDROM_SEND_PACKET, &cgc) == 0) {
> > > > > > > 		printf("eject worked\n");
> > > > > > > 		return 0;
> > > > > > > 	}
> > > > > > >
> > > > > > > 	printf("command failed - sense %x/%x/%x\n", sense.sense_key,
> > > > > > > sense.asc, sense.ascq); return 1;
> > > > > > > }
> > > > > >
> > > > > > 2.4.27-mh1
> > > > > > notas:~# /home/cijoml/eject
> > > > > > ATAPI device hdc:
> > > > > >   Error: Not ready -- (Sense key=0x02)
> > > > > >   (reserved error code) -- (asc=0x53, ascq=0x02)
> > > > > >   The failed "Start/Stop Unit" packet command was:
> > > > > >   "1b 00 00 00 02 00 00 00 00 00 00 00 "
> > > > > > command failed - sense 2/53/2
> > > > >
> > > > > Your tray is still locked, are you sure it isn't mounted?
> > > >
> > > > Yes I am. This is written into console and I am logged only into this
> > > > console and I copied whole commands from login to eject... :(
> > >
> > > For the third time, don't trim the cc list! group reply please.
> > >
> > > Something else must be keeping your drive locked. What else do you have
> > > running in the system? It's enough if one app is just holding the drive
> > > open, the drive wont get unlocked on umount then.
> >
> > only thing which access cdrom is cpudynd and it access harddrive too....
> >
> > notas:~# fuser /dev/hdc
> > /dev/hdc:             8102
> > notas:~# ps aux|grep 8102
> > root      8102  0.0  0.1  1536  456 ?        SNs  13:49
> > 0:00 /usr/sbin/cpudynd -i 1 -p 0.5 0.9 -l 7 -t 120 -h /dev/hda,/dev/hdc
>
> well there you go, that is what is keeping the drive locked. cdrom
> cannot know which process locked it or not, all it knows is that the
> usage count is non-zero on umount, so it doesn't unlock the tray.

Well I killed cpudyn and everything behaves the same... :(

# fuser /dev/hdc
#

Michal
