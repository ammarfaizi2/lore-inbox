Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBGVKe>; Wed, 7 Feb 2001 16:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129536AbRBGVKY>; Wed, 7 Feb 2001 16:10:24 -0500
Received: from colorfullife.com ([216.156.138.34]:9227 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129032AbRBGVKS>;
	Wed, 7 Feb 2001 16:10:18 -0500
Message-ID: <3A81B9C8.476E66CF@colorfullife.com>
Date: Wed, 07 Feb 2001 22:10:32 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: single copy pipe/fifo
In-Reply-To: <3A81AE75.3CEF5577@colorfullife.com> <14977.46399.167035.94694@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Manfred Spraul writes:
>  > * if you run 2 instances on a dual cpu P II/350 it's a big win, but if
>  > you run only one instance, then the bw_pipe processes will jump from one
>  > cpu to the other and it's only a small improvement (~+15%).
> 
> wake_up_interruptible_sync is meant specifically to avoid
> this cpu hopping behavior.
>
I use it whereever possible, but in this case it's not possible:
pipe is empty.

process 1 (on cpu 1)
	write(fd,buf,64kB).
	* creates kiobuf
	* sleeps.

process 2 (on cpu 1)
	read(fd,buf,64kB).
	* reads the data
	* now it must wake up, but it will return from the syscall, thus
wake_up_interruptible().
	* wakeup notices that cpu1 is busy and sends process 1 to cpu 2
	* read returns
	read(fd, buf, 64kB)
	* no data waiting, sleeps.

process 1 (on cpu 2)
	* write returns
	write(fd, buf, 64 kB)
	* creates kiobuf
	* wake_up_interruptible_sync(), since it will schedule
	* schedule()
but now schedule will pull process 2 to cpu 2

I haven't verified the sequence with kdb, but I'm certain that this
happens.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
