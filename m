Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266433AbTAHLUR>; Wed, 8 Jan 2003 06:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbTAHLUR>; Wed, 8 Jan 2003 06:20:17 -0500
Received: from smtp03.iprimus.com.au ([210.50.30.52]:19728 "EHLO
	smtp03.iprimus.com.au") by vger.kernel.org with ESMTP
	id <S266433AbTAHLUQ>; Wed, 8 Jan 2003 06:20:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Paul <krushka@iprimus.com.au>
Reply-To: krushka@iprimus.com.au
To: linux-kernel@vger.kernel.org
Subject: Re: Fwd: File system corruption
Date: Wed, 8 Jan 2003 21:35:32 +1000
X-Mailer: KMail [version 1.2]
References: <0301062138130A.01466@paul.home.com.au> <1041865580.17472.17.camel@irongate.swansea.linux.org.uk> <20030107130832.A4953@bitwizard.nl>
In-Reply-To: <20030107130832.A4953@bitwizard.nl>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>
MIME-Version: 1.0
Message-Id: <03010821353200.01198@paul.home.com.au>
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 08 Jan 2003 11:28:53.0754 (UTC) FILETIME=[1FE5D5A0:01C2B709]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger,

Thanks for the programme Roger!

I'm not sure if I did this right but.....

I ran the programme as follows: (I called it sandisktest :)

# ./sandisktest -b | dd of=/dev/hdc

then I dd'd the image of the flash disk to my local disk and viewed the file 
through midnight commander.

What I have found is that just after the start of a sector, usually 43 to 45 
bytes, 6 bytes are skipped and the sequence starts again.  This continues 
until the next sector starts, where the sequence corrects.  This appears to 
happen every 65536 bytes or some multiple of 65536.  It may skip three blocks 
of 65536 and then corrupt on the next block of 65536 bytes.

I would greatly appreciate some other ideas to try, I'm not game to start 
hacking the kernel code quite yet :)

Paul.

BTW:  I also tried a EXT2 FS and it corrupted files just as the FAT16 
filesystem had.

On Tue,  7 Jan 2003 10:08 pm, Rogier Wolff wrote:
> On Mon, Jan 06, 2003 at 03:06:20PM +0000, Alan Cox wrote:
> > Might be interesting to see what it does given a totally not FAT
> > environment (eg fill the disk start to end with each sector filled
> > with its sector number repeatedly) and see what comes out the other
> > end.
>
> How about the following program to do this.
>
> 			Roger.
>
>
> /* Written By R.E.Wolff@BitWizard.nl
>  *
>  * This program is distributed under GPL. */
>
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <string.h>
>
> int main (int argc, char **argv)
> {
>   int i;
>   int ascii = 0;
>   int size = 512;
>   long long secno;
>   char *buf;
>   int s;
>
>   for (i=1;i<argc;i++) {
>     if (strcmp (argv[i], "-a") == 0) {
>       ascii = 1;
>     }
>     if (strcmp (argv[i], "-b") == 0) {
>       ascii = 0;
>     }
>
>     if (strncmp (argv[i], "-s", 2) == 0) {
>       if (strlen (argv[i]) > 2)
> 	size = atoi (argv[i]+2);
>       else
> 	/* Sorry. Will crash if you specify -s as the last argument */
> 	size = atoi (argv[++i]);
>     }
>   }
>
>   buf = malloc (size + 16);
>
>   if (!buf) {
>     fprintf (stderr, "Can't allocate buffer.\n");
>     exit (1);
>   }
>
>   secno = 0;
>   while (1) {
>     if (ascii) {
>       sprintf (buf, "%lld\n", secno);
>       s = strlen (buf);
>       for (i=s;i<size;i+=s)
> 	sprintf (buf+i, "%lld\n", secno);
>     } else {
>       for (i=0;i<size;i+=sizeof (long long))
> 	*(long long *)(buf+i) = secno;
>     }
>     if (write (1, buf, size) < 0)
>       break;
>     secno++;
>   }
>   exit (0);
> }
