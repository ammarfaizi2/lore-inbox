Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266546AbTAGMAW>; Tue, 7 Jan 2003 07:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267047AbTAGMAW>; Tue, 7 Jan 2003 07:00:22 -0500
Received: from users.linvision.com ([62.58.92.114]:18919 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S266546AbTAGMAV>; Tue, 7 Jan 2003 07:00:21 -0500
Date: Tue, 7 Jan 2003 13:08:33 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: krushka@iprimus.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: File system corruption
Message-ID: <20030107130832.A4953@bitwizard.nl>
References: <0301062138130A.01466@paul.home.com.au> <1041865580.17472.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041865580.17472.17.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 03:06:20PM +0000, Alan Cox wrote:
> Might be interesting to see what it does given a totally not FAT
> environment (eg fill the disk start to end with each sector filled
> with its sector number repeatedly) and see what comes out the other
> end.

How about the following program to do this. 

			Roger. 


/* Written By R.E.Wolff@BitWizard.nl 
 *
 * This program is distributed under GPL. */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

int main (int argc, char **argv)
{
  int i;
  int ascii = 0; 
  int size = 512;
  long long secno;
  char *buf; 
  int s; 

  for (i=1;i<argc;i++) {
    if (strcmp (argv[i], "-a") == 0) {
      ascii = 1;
    }
    if (strcmp (argv[i], "-b") == 0) {
      ascii = 0;
    }

    if (strncmp (argv[i], "-s", 2) == 0) {
      if (strlen (argv[i]) > 2)
	size = atoi (argv[i]+2);
      else
	/* Sorry. Will crash if you specify -s as the last argument */
	size = atoi (argv[++i]);
    }
  }

  buf = malloc (size + 16); 

  if (!buf) {
    fprintf (stderr, "Can't allocate buffer.\n");
    exit (1);
  }

  secno = 0; 
  while (1) {
    if (ascii) {
      sprintf (buf, "%lld\n", secno);
      s = strlen (buf); 
      for (i=s;i<size;i+=s)
	sprintf (buf+i, "%lld\n", secno);
    } else {
      for (i=0;i<size;i+=sizeof (long long)) 
	*(long long *)(buf+i) = secno; 
    }
    if (write (1, buf, size) < 0)
      break;
    secno++;
  }
  exit (0); 
}

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
