Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129228AbQK1QPP>; Tue, 28 Nov 2000 11:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129295AbQK1QPF>; Tue, 28 Nov 2000 11:15:05 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1920 "EHLO
        chaos.analogic.com") by vger.kernel.org with ESMTP
        id <S129228AbQK1QOz>; Tue, 28 Nov 2000 11:14:55 -0500
Date: Tue, 28 Nov 2000 10:44:29 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tigran Aivazian <tigran@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: bug in count_open_files() or a strange granularity?
In-Reply-To: <Pine.LNX.4.21.0011281459080.1254-100000@penguin.homenet>
Message-ID: <Pine.LNX.3.95.1001128103938.365A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000, Tigran Aivazian wrote:

> Hi,
> 
> A simple experiment:
> 
> a) insert a code like this in the open() routine of some driver:
> 
>        struct files_struct *files = current->files;
>        extern int count_open_files(struct files_struct *, int);
> 
>        printk(KERN_ERR "%s has %d files open\n",
>                         current->comm, count_open_files(files, files->max_fdset));
> 
> b) write a program that opens that device and sleeps indefinitely. Run it,
> you will see:
> 
> op has 32 files open
> 
> c)  # lsof -p 659 | nl
>      1  COMMAND PID   USER   FD   TYPE DEVICE    SIZE   NODE NAME
>      2  op      659 tigran  cwd    DIR    3,6    4096 225730
> /home/tigran/C/files
>      3  op      659 tigran  rtd    DIR    3,6    4096      2 /
>      4  op      659 tigran  txt    REG    3,6   14142 225732
> /home/tigran/C/files/op
>      5  op      659 tigran  mem    REG    3,6  434945 295227
> /lib/ld-2.1.92.so
>      6  op      659 tigran  mem    REG    3,6 4776568 295234
> /lib/libc-2.1.92.so
>      7  op      659 tigran    0u   CHR    4,9         348027 /dev/tty9
>      8  op      659 tigran    1u   CHR    4,9         348027 /dev/tty9
>      9  op      659 tigran    2u   CHR    4,9         348027 /dev/tty9
>     10  op      659 tigran    3r   CHR 10,184          98313
> /dev/cpu/microcode
> 
> so, we see that the process has only 9 files open and yet
> count_open_files() claims there are 32. Is this a bug of
> count_open_files() or is this a minimal granularity (because there are 32
> builtin descriptors in files_struct->fd_array[])?
> 
> I know that there is no problem due to the way it is called in
> copy_files() -- it would only be above 32. But for what I want to use it,
> I need the _correct_ number of open file descriptors and not some "rounded
> up to 32" one.   
> 
> (kernel assumed test12-pre2)
> 
> Regards,
> Tigran
> 

Yes. This is probably related to the previously-reported MOD_INC_USE_COUNT
macro in the drivers. The open count is now handled in the call to
the driver's open(). The MOD_INC_USE_COUNT and the MOD_DEC_USE_COUNT
should now be defined to do nothing for kernels that already handle
the counts in the calls.
 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
