Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267829AbUIPINq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267829AbUIPINq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 04:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267840AbUIPINq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 04:13:46 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:61956 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S267829AbUIPINh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 04:13:37 -0400
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: Re: CD-ROM can't be ejected
Date: Thu, 16 Sep 2004 10:13:35 +0200
User-Agent: KMail/1.6.2
References: <200409160025.35961.cijoml@volny.cz> <200409160918.40767.cijoml@volny.cz> <20040916073616.GO2300@suse.de>
In-Reply-To: <20040916073616.GO2300@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409161013.35454.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne èt 16. záøí 2004 09:36 jste napsal(a):
> (don't top post, and don't trim cc list!)
>
> On Thu, Sep 16 2004, Bc. Michal Semler wrote:
> > notas:/home/cijoml# mount /cdrom/
> > notas:/home/cijoml# umount /cdrom/
> > notas:/home/cijoml# strace -o eject /dev/hdc
> > eject: unable to eject, last error: Nep?ípustný argument
> >
> > As you can see, I dont't enter to directory...
> >
> > And output is included
> >
> > ioctl(3, CDROMEJECT, 0xbffffac8)        = -1 EIO (Input/output error)
>
> That's the important bit, the reason you get EINVAL passed back is
> because eject tries the floppy eject as well and decides to print the
> warning from that. It really should just stop of it sees -EIO, only
> continue if EINVAL/ENOTTY is passed back.
>
> Try this little c program and report back what it tells you. Compile
> with
>
> gcc -Wall -o eject eject.c
>
> and run without arguments.
>
> #include <stdio.h>
> #include <stdlib.h>
> #include <fcntl.h>
> #include <string.h>
> #include <sys/ioctl.h>
> #include <linux/cdrom.h>
>
> int main(int argc, char *argv[])
> {
> 	int fd = open("/dev/hdc", O_RDONLY | O_NONBLOCK);
> 	struct cdrom_generic_command cgc;
> 	struct request_sense sense;
>
> 	memset(&cgc, 0, sizeof(cgc));
> 	memset(&sense, 0, sizeof(sense));
>
> 	cgc.cmd[0] = 0x1b;
> 	cgc.cmd[4] = 0x02;
> 	cgc.sense = &sense;
> 	cgc.data_direction = CGC_DATA_NONE;
>
> 	if (ioctl(fd, CDROM_SEND_PACKET, &cgc) == 0) {
> 		printf("eject worked\n");
> 		return 0;
> 	}
>
> 	printf("command failed - sense %x/%x/%x\n", sense.sense_key, sense.asc,
> sense.ascq); return 1;
> }

2.4.27-mh1
notas:~# /home/cijoml/eject
ATAPI device hdc:
  Error: Not ready -- (Sense key=0x02)
  (reserved error code) -- (asc=0x53, ascq=0x02)
  The failed "Start/Stop Unit" packet command was:
  "1b 00 00 00 02 00 00 00 00 00 00 00 "
command failed - sense 2/53/2


2.6.9-rc2
notas:~# mount /cdrom/
notas:~# umount /cdrom/
notas:~# /home/cijoml/eject
Here isn't opened
command failed - sense 2/53/2
notas:~# eject /cdrom/
program eject is using a deprecated SCSI ioctl, please convert it to SG_IO
program eject is using a deprecated SCSI ioctl, please convert it to SG_IO
program eject is using a deprecated SCSI ioctl, please convert it to SG_IO
Here is cd-rom opened
eject: unable to eject, last error: Nepøípustný argument
notas:~# /home/cijoml/eject
Here is cd-rom opened
eject worked

