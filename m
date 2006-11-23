Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933709AbWKWTsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933709AbWKWTsw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 14:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933719AbWKWTsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 14:48:52 -0500
Received: from s1.mailresponder.info ([193.24.237.10]:12041 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S933709AbWKWTsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 14:48:51 -0500
Subject: 'False' IO error when copying from cdrom drive
From: Mathieu Fluhr <mfluhr@nero.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Nero AG
Date: Thu, 23 Nov 2006 20:48:25 +0100
Message-Id: <1164311305.3013.25.camel@de-c-l-110.nero-de.internal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I am currently facing a really weird thing. It seems that it is related
to the block driver (or whatever else related to block devices).

I explain: First take this really simple program:
----8<------------------------------------------------------------------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>


int main(int argc, char **argv)
{
  if(argc < 2)
    return 0;
  
  int iFD = open(argv[1], O_RDONLY | O_NONBLOCK);
  if(iFD == -1)
    perror("open");

  while(1)
    sleep(1);

  return 0;
}
----8<-----------------------------------------------------------------

Apparently, it just open a file in read only mode, and non-blocking. 
If you use it for opening an IDE DVD recorder, it will just grab a file
descriptor, without checking if the media is present or not.
 -> This is normally how the /dev/hdXX device file should be open to 
    use CDROM_SEND_PACKET ioctl.

(Note: Feel free to correct me if I am wrong)


Ok. Now take a full DVD (I tested DVD+R, +RW and -R), with more than 
4 300 000 000 bytes (very important :), and perform the following:

0. Open the tray of your recorder
1. Launch this small program above, passing the recorder device file as 
   argument and let it run in background.
2. then put the disc in the device and mount it
3. try to copy to whole content on the hard drive

-> You will get an error like the following:
  > kernel: attempt to access beyond end of device
  > kernel: hdb: rw=0, want=8388612, limit=8388604

If you do not launch this small program in background, everything works
like a charm.

What is really astonishing, is that no matter the media, no matter the
device, this 'limit' is ALWAYS 8388604. Which - as far as I debugged -
make exactly 4 294 965 248 bytes (that is where the 4 300 000 000 bytes
come from).

So am I think that there must be somehow a value corruption, as:
1. the limit shown in the kernel error log is wrong
2. whitout running this small prog, everything works fine.

Regards,
Mathieu

