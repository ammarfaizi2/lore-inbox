Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSFEWV6>; Wed, 5 Jun 2002 18:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316503AbSFEWV5>; Wed, 5 Jun 2002 18:21:57 -0400
Received: from mail1.mail.iol.ie ([194.125.2.192]:56962 "EHLO
	mail1.mail.iol.ie") by vger.kernel.org with ESMTP
	id <S316500AbSFEWVz>; Wed, 5 Jun 2002 18:21:55 -0400
Message-ID: <3CFE8F11.8060304@antefacto.com>
Date: Wed, 05 Jun 2002 23:22:09 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
CC: Owen Taylor <otaylor@redhat.com>, andersen@codepoet.org,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        Martin Dalecki <dalecki@evision-ventures.com>
Subject: Re: Need help tracing regular write activity in 5 s interval
In-Reply-To: <20020602135501.GA2548@merlin.emma.line.org>	<3CFCA2B0.4060501@antefacto.com> <20020604120434.GA1386@codepoet.org>	<3CFE1B78.9010406@antefacto.com> <20020605155017.251EC2423B5@fresnel.labs.redhat.com> <3CFE3FCB.9040109@antefacto.com>
Content-Type: multipart/mixed;
 boundary="------------020200010206050002060408"
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020200010206050002060408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Padraig Brady wrote:
> Owen Taylor wrote:
> 
>> Padraig Brady <padraig@antefacto.com> writes:
>>
>>> I'm sure it will :-)
>>>
>>> However this it just masking the "problem"
>>
>>
>> Well, the question is, "what is the problem"?
>> Your problem is that a debug message is being output by the kernel and
>> filling your logs. If the debug message doesn't do anybody any good
>> (and it doesn't) then removing the debug message is a fine way of
>> solving the problem.
> 
> 
> True. But I thought there might be (future) side affects of
> cdrom_media_changed() always returning true. Why is it there at all?

I had a quick look at this and basically cdrom_media_changed()
is only valid when there is a disc in the drive. If the drive
is open or empty then it always returns true. There are a couple
of comments saying it's like this to catch buggy drives, but
hence the interface is broken IMHO and should be removed/fixed?

The attached test program illustrates the problem.

Padraig.


--------------020200010206050002060408
Content-Type: text/plain;
 name="tcd.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tcd.c"

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <linux/ioctl.h>
#include <linux/cdrom.h>

/* drives have capabilities (CDC*) like CDC_MEDIA_CHANGED.
   These done with CDROM_SET_OPTIONS ioctl. perhaps magicdev
   should turn this off as it doesn't use anyway? */

int main(void) {
    int cd = open("/dev/cdrom", O_RDONLY|O_NONBLOCK); /* This causes VFS: disk change ... */
    while(1) {
        //int cd = open("/dev/cdrom", O_RDONLY|O_NONBLOCK);
        printf ("media changed[%d]\n", ioctl(cd, CDROM_MEDIA_CHANGED, CDSL_CURRENT));
        /*
        switch (ioctl(cd, CDROM_DRIVE_STATUS, CDSL_CURRENT)) {
            case CDS_DISC_OK: printf("DISK_OK\n"); break;
            case CDS_TRAY_OPEN: printf("TRAY_OPEN\n"); break;
            case CDS_DRIVE_NOT_READY: printf("DRIVE_NOT_READY\n"); break;
            default: printf("default\n"); break;
        }
        */
        //close(cd);
        sleep(2);
    }
}

--------------020200010206050002060408--

