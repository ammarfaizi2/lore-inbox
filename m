Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264640AbSIQVxc>; Tue, 17 Sep 2002 17:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264641AbSIQVxc>; Tue, 17 Sep 2002 17:53:32 -0400
Received: from users.linvision.com ([62.58.92.114]:30105 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S264640AbSIQVx2>; Tue, 17 Sep 2002 17:53:28 -0400
Date: Tue, 17 Sep 2002 23:58:22 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Mark C <gen-lists@blueyonder.co.uk>
Cc: linux-usb-users <linux-usb-users@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-usb-users] Re: Problems accessing USB Mass Storage
Message-ID: <20020917235822.C26741@bitwizard.nl>
References: <Pine.LNX.4.33L2.0209171119430.14033-100000@dragon.pdx.osdl.net> <3D878788.2030603@cypress.com> <20020917125817.B11583@one-eyed-alien.net> <3D878CF7.3040304@cypress.com> <1032297193.1276.23.camel@stimpy.angelnet.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032297193.1276.23.camel@stimpy.angelnet.internal>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 10:13:13PM +0100, Mark C wrote:
> On Tue, 2002-09-17 at 21:13, Thomas Dodd wrote:
> 
> > 
> > Give that a go Mark.
> > 
> > Try a few values like 25, 50, 75, and 100. with bs=1k and
> > unset (default 512 byte).
> 
> If I'm reading this correctly, I have been trying:
> 
> [root@stimpy mark]# dd if=/dev/sda of=tmp/tmp.img skip=50 \
> bs=1k                                                                                                         dd: reading `/dev/sda': Input/output error
> 0+0 records in
> 0+0 records out

Guys, 

When dd is told to skip a certain number of input blocks it doesn't
seek past them, but reads them and then discards them. Thus if you're
not supposed to read sectors 1-100 then this will not work. 

Try the following program: 


/* seek.c (C) R.E.Wolff@harddisk-recovery.nl */
/* 
	gcc -Wall -O2 seek.c -o seek 
*/

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>

#ifndef O_LARGEFILE
#define O_LARGEFILE     0100000
#endif
long long lseek64 (int fd, long long offset, int whence);


int main (int argc,char **argv)
{
  long long off;
  long long tt;

  if(argc < 2)
        exit(0);        /* don't seek at all */

  if (strncmp (argv[1],"0x",2) )
    sscanf (argv[1],"%Ld",&off);
  else
    sscanf (argv[1],"%Lx",&off);

  if (argc > 3) {
    if (strncmp (argv[3],"0x",2) )
      sscanf (argv[3],"%Ld",&tt);
    else
      sscanf (argv[3],"%Lx",&tt);
    if (argv[2][0] == '+')
      off += tt;
    else
      off -= tt;
  }
  
  errno = 0;
  if ((lseek64 (0,off,SEEK_CUR) < 0) &&
      (errno != 0))
    perror ("seek");
  exit (0);
}


with the command: 

	dd if=/dev/sda of=firstpart 

(Get the partition table)

	(seek 0x100000;dd of=secondpart) < /dev/sda 

Get everything beyond 1Mb. If this works, then we have to figure out
how low we can make the "0x100000" number to get all of the data.

Hypothesis: The partition table specifies that the data starts
on sector 200, and they didn't implement sectors 1-199.....
Cheap basterds. 

(My memory stick is just over 128 * 10^6 bytes, and not even
close to 128 * 2^20 bytes....)

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currenly in such an       * 
* excursion: The stable situation does not include humans. ***************
