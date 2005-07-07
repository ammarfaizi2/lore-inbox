Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVGGRDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVGGRDq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 13:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVGGRDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 13:03:46 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:28129 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261404AbVGGRDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 13:03:40 -0400
Message-ID: <42CD600C.2000105@anagramm.de>
Date: Thu, 07 Jul 2005 19:02:04 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Lenz Grimmer <lenz@grimmer.com>, Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp]
 IBM HDAPS Someone interested? (Accelerometer))
References: <42C8D06C.2020608@grimmer.com> <20050704061713.GA1444@suse.de> <42C8C978.4030409@linuxwireless.org> <20050704063741.GC1444@suse.de> <1120461401.3174.10.camel@laptopd505.fenrus.org> <20050704072231.GG1444@suse.de> <1120462037.3174.25.camel@laptopd505.fenrus.org> <20050704073031.GI1444@suse.de> <42C91073.80900@grimmer.com> <20050704110604.GL1444@suse.de> <20050707080323.GF1823@suse.de>
In-Reply-To: <20050707080323.GF1823@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Just for the records....
-----
root@ecam:~$ ./headpark /dev/hda
head not parked 4c
-----

HDD is a desktop Maxtor Diamond MaxPlus 9 120GB
on a Promise Ultra133 TX2 IDE Controller.

Well, sure, it's not a notebook HDD, but maybe it's possible
to give headpark a more generic way to get the heads parked?

Are the commands different per HDD model / manufacturer?
Then we might need some information to send the proper
commands to the different types?!
And if there is no headpark command, might it be valuable to send
the HDD a shutdown instead?

PS:
I'm working on an embedded PowerPC (MPC8540) system which
will be turned into a high-resolution portable camera in
the future (with acceleration sensors for the right image
orientation). Therefore it will likely be another candidate
for a Drop'n'Park or Drop'n'Stop (tm) feature as are planning
to put a 2.5" notebook HDD into the cam, too.

Greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19

Jens Axboe wrote:
> On Mon, Jul 04 2005, Jens Axboe wrote:
> 
>>On Mon, Jul 04 2005, Lenz Grimmer wrote:
>>
>>>-----BEGIN PGP SIGNED MESSAGE-----
>>>Hash: SHA1
>>>
>>>Hi,
>>>
>>>Jens Axboe wrote:
>>>
>>>
>>>>It isn't too pretty to rely on such unreliable timing anyways. I'm 
>>>>not too crazy about spinning the disk down either, it's useless wear 
>>>>compared to just parking the head.
>>>
>>>Fully agreed, and that's the approach the IBM Windows driver seems to
>>>take - you just hear the disk park its head when the sensor kicks in
>>>(you can hear it) - the disk does not spin down when this happens.
>>>
>>>Could this be some reserved ATA command that only works with certain#
>>>drives?
>>
>>Perhaps the IDLE or IDLEIMMEDIATE commands imply a head parking, that
>>would make sense. As you say, you can hear a drive parking its head.
>>Here's a test case, it doesn't sound like it's parking the hard here.
> 
> 
> ATA7 defines a park maneuvre, I don't know how well supported it is yet
> though. You can test with this little app, if it says 'head parked' it
> works. If not, it has just idled the drive.
> 
> 
> #include <stdio.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <string.h>
> #include <sys/ioctl.h>
> #include <linux/hdreg.h>
> 
> int main(int argc, char *argv[])
> {
> 	unsigned char buf[8];
> 	int fd;
> 
> 	if (argc < 2) {
> 		printf("%s <dev>\n", argv[0]);
> 		return 1;
> 	}
> 
> 	fd = open(argv[1], O_RDONLY);
> 	if (fd == -1) {
> 		perror("open");
> 		return 1;
> 	}
> 
> 	memset(buf, 0, sizeof(buf));
> 	buf[0] = 0xe1;
> 	buf[1] = 0x44;
> 	buf[3] = 0x4c;
> 	buf[4] = 0x4e;
> 	buf[5] = 0x55;
> 
> 	if (ioctl(fd, HDIO_DRIVE_TASK, buf)) {
> 		perror("ioctl");
> 		return 1;
> 	}
> 
> 	if (buf[3] == 0xc4)
> 		printf("head parked\n");
> 	else
> 		printf("head not parked %x\n", buf[3]);
> 
> 	close(fd);
> 	return 0;
> }
> 
