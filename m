Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129211AbRBWVnz>; Fri, 23 Feb 2001 16:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129232AbRBWVnq>; Fri, 23 Feb 2001 16:43:46 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:4363 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S129211AbRBWVn0>;
	Fri, 23 Feb 2001 16:43:26 -0500
Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 23 Feb 2001 20:14:40 +0000 (GMT)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Francis Galiegue <fg@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.1-ac16: add CDROM_LOCKDOOR ioctl to IDE floppies
In-Reply-To: <Pine.LNX.4.21.0102191406060.884-100000@toy.mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0102232009180.31418-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francis, do I understand that you can remove the disk while it is
mounted? If so, there is a later version of ide-floppy.c (0.96) on
sourceforge.net which for some reason hasn't made it into the -ac kernels.
With 2.4.2 vanilla and ide-floppy 0.96 I don't get this problem, it also
removes some i/o error messages I was seeing.
Ken

On Mon, 19 Feb 2001, Francis Galiegue wrote:

> Patch below. It Work For Me(tm) with an IDE ZIP drive.
> 
> --- drivers/ide/ide-floppy.c.old        Mon Feb 19 13:39:55 2001
> +++ drivers/ide/ide-floppy.c    Mon Feb 19 13:48:53 2001
> @@ -1517,15 +1517,21 @@
>                                  unsigned int cmd, unsigned long arg)
>  {
>         idefloppy_pc_t pc;
> +       int prevent = (arg) ? 1 : 0;
> 
>         switch (cmd) {
>         case CDROMEJECT:
> +               prevent = 0;
> +               /* fall through */
> +       case CDROM_LOCKDOOR:
>                 if (drive->usage > 1)
>                         return -EBUSY;
> -               idefloppy_create_prevent_cmd (&pc, 0);
> -               (void) idefloppy_queue_pc_tail (drive, &pc);
> -               idefloppy_create_start_stop_cmd (&pc, 2);
> +               idefloppy_create_prevent_cmd (&pc, prevent);
>                 (void) idefloppy_queue_pc_tail (drive, &pc);
> +               if (cmd == CDROMEJECT) {
> +                       idefloppy_create_start_stop_cmd (&pc, 2);
> +                       (void) idefloppy_queue_pc_tail (drive, &pc);
> +               }
>                 return 0;
>         case IDEFLOPPY_IOCTL_FORMAT_SUPPORTED:
>                 return (0);
> 
> 
>
 

