Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135983AbRDTSzX>; Fri, 20 Apr 2001 14:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135978AbRDTSzO>; Fri, 20 Apr 2001 14:55:14 -0400
Received: from lysithea.xerox.com ([208.140.33.22]:23541 "EHLO
	lysithea.eastgw.xerox.com") by vger.kernel.org with ESMTP
	id <S135983AbRDTSzI>; Fri, 20 Apr 2001 14:55:08 -0400
Message-Id: <200104201854.OAA06769@mailhost.eng.mc.xerox.com>
To: linux-kernel@vger.kernel.org
cc: leisner@rochester.rr.com
Subject: Re: kernel threads and close method in a device driver
Date: Fri, 20 Apr 2001 14:54:53 -0400
From: "Marty Leisner" <mleisner@eng.mc.xerox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I ment to send this correspondence to the list.
It seems to be working much better now -- but is this
CLONE_FILES flag correct?

Is there a device to look at which does a kernel_thread on open,
and kills the thread on close (I'd like to see an example).

Thanks for the help...

Marty

- ------- Forwarded Message

To: Andi Kleen <ak@suse.de>
Subject: Re: kernel threads and close method in a device driver 
In-Reply-To: Your message of "Tue, 17 Apr 2001 23:43:39 +0200."
             <20010417234339.A18288@gruyere.muc.suse.de> 
Date: Wed, 18 Apr 2001 10:49:04 -0400
From: "Marty Leisner" <mleisner@eng.mc.xerox.com>

In message <20010417234339.A18288@gruyere.muc.suse.de>,   you write:
>On Tue, Apr 17, 2001 at 05:04:28PM -0400, Marty Leisner wrote:
>> 	open device
>> 	do IOCTL (spinning a kernel thread and doing initialization)
>> 
>> There is currently an IOCTL which short-circuits to the close method.
>> Turns out it seems necessary to do this IOCTL -- close never gets 
>> invoked.
>
>Call daemonize() in the kernel thread.
>
>-Andi

It seemed like daemonize was a good idea (after thinking about it,
it makes a lot of sense...there are multiple instances of the file
open...[I'm not used to opening files NOT in user space ;-))]

daemonize wasn't in 2.2.12 (I copied it from 2.2.18):

static void daemonize(void)
{  
        struct fs_struct *fs;

        /*
         * If we were started as result of loading a module, close all of the
         * user space pages.  We don't need them, and if we didn't close them
         * they would be locked into memory.
         */                
        printk("want to daemonize");
        exit_mm(current);

        current->session = 1;
        current->pgrp = 1;

        /* Become as one with the init task */

        exit_fs(current);       /* current->fs->count--; */
        fs = init_task.fs;
        current->fs = fs;
        atomic_inc(&fs->count);
}

This seems reasonable, get rid of your files and inherit init's

However, 
:1 mleisner@piquin; lsof -p 630
COMMAND   PID     USER   FD   TYPE DEVICE SIZE NODE NAME
aicCtrlTh 630 mleisner  cwd    DIR    3,1 1024    2 /
aicCtrlTh 630 mleisner  rtd    DIR    3,1 1024    2 /
aicCtrlTh 630 mleisner    0u   CHR  136,0         2 /dev/pts/0
aicCtrlTh 630 mleisner    1u   CHR  136,0         2 /dev/pts/0
aicCtrlTh 630 mleisner    2u   CHR  136,0         2 /dev/pts/0
aicCtrlTh 630 mleisner    3u   CHR   43,0      8034 /dev/aicdrv

which is the original file handles from the application...

Any hints?  I played around with the CLONE_FILES flag on thread_creation,
and at least now I can get through to close (I have to look at the thread kill strategy).

But now I have (after an open, create thread, close cycle)
bash3 :3 mleisner@piquin; lsof -p 584
COMMAND   PID     USER   FD   TYPE DEVICE SIZE NODE NAME
aicCtrlTh 584 mleisner  cwd    DIR    3,1 1024    2 /
aicCtrlTh 584 mleisner  rtd    DIR    3,1 1024    2 /
aicCtrlTh 584 mleisner    0u   CHR  136,0         2 /dev/pts/0
aicCtrlTh 584 mleisner    1u   CHR  136,0         2 /dev/pts/0
aicCtrlTh 584 mleisner    2u   CHR  136,0         2 /dev/pts/0
bash3 :3 mleisner@piquin; lsmod
Module                  Size  Used by
aicdrv                 18104   0 
nfs                    29656   1  (autoclean)
nfsd                  144060   8  (autoclean)
lockd                  30984   1  (autoclean) [nfs nfsd]
sunrpc                 52516   1  (autoclean) [nfs nfsd lockd]
fa311                   4404   1  (autoclean)

marty
mleisner@eng.mc.xerox.com

- ------- End of Forwarded Message


