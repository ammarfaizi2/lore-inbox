Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130770AbQJ1QHY>; Sat, 28 Oct 2000 12:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130985AbQJ1QHP>; Sat, 28 Oct 2000 12:07:15 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:64272 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130770AbQJ1QGh>;
	Sat, 28 Oct 2000 12:06:37 -0400
Message-ID: <39FAF93B.83420C30@mandrakesoft.com>
Date: Sat, 28 Oct 2000 12:05:15 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: kumon@flab.fujitsu.co.jp, Andi Kleen <ak@suse.de>,
        Alexander Viro <viro@math.psu.edu>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Olaf Kirch <okir@monad.swb.de>
Subject: Re: [PATCH] Re: Negative scalability by removal of lock_kernel()?(Was: 
 Strange performance behavior of 2.4.0-test9)
In-Reply-To: <39F957BC.4289FF10@uow.edu.au>,
			<39F92187.A7621A09@timpanogas.org>
			<Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>
			<20001027094613.A18382@gruyere.muc.suse.de>
			<39F957BC.4289FF10@uow.edu.au> <200010271257.VAA24374@asami.proc.flab.fujitsu.co.jp> <39FAF4C6.3BB04774@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> --- linux-2.4.0-test10-pre5/fs/locks.c  Tue Oct 24 21:34:13 2000
> +++ linux-akpm/fs/locks.c       Sun Oct 29 02:31:10 2000
> @@ -125,10 +125,9 @@
>  #include <asm/semaphore.h>
>  #include <asm/uaccess.h>
> 
> -DECLARE_MUTEX(file_lock_sem);
> -
> -#define acquire_fl_sem()       down(&file_lock_sem)
> -#define release_fl_sem()       up(&file_lock_sem)
> +spinlock_t file_lock_lock = SPIN_LOCK_UNLOCKED;
> +#define acquire_fl_lock()      spin_lock(&file_lock_lock);
> +#define release_fl_lock()      spin_unlock(&file_lock_lock);

It seems like better concurrency could be achieved with reader-writer
locks.  Some of the lock test routines simply scan the list, without
modifying it.

-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and screaming like a cheerleader."
                        |      -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
