Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267828AbTAMQ32>; Mon, 13 Jan 2003 11:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267834AbTAMQ31>; Mon, 13 Jan 2003 11:29:27 -0500
Received: from air-2.osdl.org ([65.172.181.6]:13980 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267828AbTAMQ3U>;
	Mon, 13 Jan 2003 11:29:20 -0500
Date: Mon, 13 Jan 2003 08:34:04 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Alexander Puchmayr <alex@olymp.linznet.at>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: USB-Printer status flags question
In-Reply-To: <200301130909.08626.alex@olymp.linznet.at>
Message-ID: <Pine.LNX.4.33L2.0301130820160.1675-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, Alexander Puchmayr wrote:

| On Monday 13 January 2003 05:30, you wrote:
| > Hi Alex,
| >
| > On Sun, 12 Jan 2003, Alexander Puchmayr wrote:
| > | After looking at cups (1.1.18) backend/usb.c and the kernel's
| > | (2.4.19-gentoo-r10) drivers/usb/printer.c I've found some different
| > | interpretations of the LP_* flags from linux/lp.h
| > |
| > | While the kernel seems to use the 8255 status port definitions, which
| > | use (amongst others) the flags,
| > |
| > | #define LP_PSELECD      0x10  /* unchanged input, active high */
| > | #define LP_PERRORP      0x08  /* unchanged input, active low */
| > |
| > | the same bits are defined by POSIX guidelines a few lines above in
| > | linux/lp.h:
| > |
| > | #define LP_OFFL  0x0008
| > | #define LP_NOPA  0x0010
| >
| > Does anyone know where I can find these POSIX guidelines?
| > I tried SUSv3 but didn't see them there.
| > I'm not sure if the comment about POSIX guidelines is referring
| > only to the LP* and lp* namespace (prefixes) or to the bit
| > definitions also.
| >
| > Are you saying that there are apps that depend on the POSIX bit
| > definitions?
| >
| Get cups (I'm using 1.1.18), see backend/usb.c and have a look at the piece
| of code

Well, thanks for posting it...

| #ifdef __linux
|  /*
|   * Show the printer status before we send the file; normally, we'd
|   * do this while we write data to the printer, however at least some
|   * Linux kernels have buggy USB drivers which don't like to be
|   * queried while sending data to the printer...
|   */
|
|   if (ioctl(fd, LPGETSTATUS, &status) == 0)
|   {
|     fprintf(stderr, "DEBUG: LPGETSTATUS returned a port status of
| %02X...\n", status);
|
|     if (status & LP_NOPA)
|       fputs("WARNING: Media tray empty!\n", stderr);
|     else if (status & LP_ERR)
|       fputs("WARNING: Printer fault!\n", stderr);
|     else if (status & LP_OFFL)
|       fputs("WARNING: Printer off-line.\n", stderr);
|   }
| #endif /* __linux */
|
| LP_NOPA, LP_ERR and LP_OFFL are from the POSIX-Part.

and they are the wrong bits to be testing.  LPGETSTATUS doesn't return
POSIX-bits for LP status AFAI can see, in drivers/char/lp.c or in
drivers/usb/printer.c.  It returns 8255-style status bits.

I wouldn't be surprised to find some part of the kernel returning
POSIX LP-status bits and another part returning 8255-status bits,
but I don't see that here.  I see them returning only 8255-status bits
and cups looking for the other.

Is there some reason that cups isn't just testing for 8255-style
status bits instead of the POSIX style?

Go ahead, enlighten me.

| > | Obviously, this leads the cups usb-backend to incorrectly report an
| > | empty media tray when the printer is online, idle and has enough paper.
| > |
| > | This doesn't seem to be something serious, its just a wrong message in
| > | cups log-file.
| >
| > The (Linux 2.4.20) kernel drivers/char/lp.c and drivers/usb/printer.c
| > modules use the 8255 parallel port definitions to read/test the status
| > port.  This matches the USB printer spec (I'm looking at the USB
| > v1.1 printer spec).
| > USB & parport then return that 8-bit value to userspace via an
| > ioctl (LPGETSTATUS).  Is CUPS using a different ioctl, possibly
| > LPGETFLAGS?
| >
|
| See the code piece above - its using LPGETSTATUS
|
| > | PS: Since two different specifications are mixed up, this problem could
| > | also be a kernel problem.
| >
| > Um, it would have been a good thing if a "standard" interface were used
| > for this instead of one that just matches some device's registers,
| > as long as the standard interface weren't severe overkill.
|
| I agree.

-- 
~Randy

