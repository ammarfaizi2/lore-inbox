Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267285AbTAMIA1>; Mon, 13 Jan 2003 03:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267310AbTAMIA1>; Mon, 13 Jan 2003 03:00:27 -0500
Received: from [80.66.38.208] ([80.66.38.208]:531 "HELO cerberos")
	by vger.kernel.org with SMTP id <S267285AbTAMIAZ>;
	Mon, 13 Jan 2003 03:00:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Alexander Puchmayr <alex@olymp.linznet.at>
Reply-To: alex@olymp.linznet.at
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: USB-Printer status flags question
Date: Mon, 13 Jan 2003 09:09:08 +0100
User-Agent: KMail/1.4.3
References: <Pine.LNX.4.33L2.0301121928220.32468-100000@dragon.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33L2.0301121928220.32468-100000@dragon.pdx.osdl.net>
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301130909.08626.alex@olymp.linznet.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 January 2003 05:30, you wrote:
> Hi Alex,
>
> On Sun, 12 Jan 2003, Alexander Puchmayr wrote:
> | After looking at cups (1.1.18) backend/usb.c and the kernel's
> | (2.4.19-gentoo-r10) drivers/usb/printer.c I've found some different
> | interpretations of the LP_* flags from linux/lp.h
> |
> | While the kernel seems to use the 8255 status port definitions, which
> | use (amongst others) the flags,
> |
> | #define LP_PSELECD      0x10  /* unchanged input, active high */
> | #define LP_PERRORP      0x08  /* unchanged input, active low */
> |
> | the same bits are defined by POSIX guidelines a few lines above in
> | linux/lp.h:
> |
> | #define LP_OFFL  0x0008
> | #define LP_NOPA  0x0010
>
> Does anyone know where I can find these POSIX guidelines?
> I tried SUSv3 but didn't see them there.
> I'm not sure if the comment about POSIX guidelines is referring
> only to the LP* and lp* namespace (prefixes) or to the bit
> definitions also.
>
> Are you saying that there are apps that depend on the POSIX bit
> definitions?
>
Get cups (I'm using 1.1.18), see backend/usb.c and have a look at the piece 
of code

#ifdef __linux
 /*
  * Show the printer status before we send the file; normally, we'd
  * do this while we write data to the printer, however at least some
  * Linux kernels have buggy USB drivers which don't like to be
  * queried while sending data to the printer...
  */

  if (ioctl(fd, LPGETSTATUS, &status) == 0)
  {
    fprintf(stderr, "DEBUG: LPGETSTATUS returned a port status of 
%02X...\n", status);

    if (status & LP_NOPA)
      fputs("WARNING: Media tray empty!\n", stderr);
    else if (status & LP_ERR)
      fputs("WARNING: Printer fault!\n", stderr);
    else if (status & LP_OFFL)
      fputs("WARNING: Printer off-line.\n", stderr);
  }
#endif /* __linux */

LP_NOPA, LP_ERR and LP_OFFL are from the POSIX-Part.

> | Obviously, this leads the cups usb-backend to incorrectly report an
> | empty media tray when the printer is online, idle and has enough paper.
> |
> | This doesn't seem to be something serious, its just a wrong message in
> | cups log-file.
>
> The (Linux 2.4.20) kernel drivers/char/lp.c and drivers/usb/printer.c
> modules use the 8255 parallel port definitions to read/test the status
> port.  This matches the USB printer spec (I'm looking at the USB
> v1.1 printer spec).
> USB & parport then return that 8-bit value to userspace via an
> ioctl (LPGETSTATUS).  Is CUPS using a different ioctl, possibly
> LPGETFLAGS?
>

See the code piece above - its using LPGETSTATUS

> | PS: Since two different specifications are mixed up, this problem could
> | also be a kernel problem.
>
> Um, it would have been a good thing if a "standard" interface were used
> for this instead of one that just matches some device's registers,
> as long as the standard interface weren't severe overkill.

I agree. 

Greetings
	Alex

