Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274372AbRITIjk>; Thu, 20 Sep 2001 04:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274374AbRITIjb>; Thu, 20 Sep 2001 04:39:31 -0400
Received: from mail.scs.ch ([212.254.229.5]:33545 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S274372AbRITIjN>;
	Thu, 20 Sep 2001 04:39:13 -0400
Message-ID: <3BA9AB43.C26366BF@scs.ch>
Date: Thu, 20 Sep 2001 10:39:31 +0200
From: Thomas Sailer <sailer@scs.ch>
Reply-To: t.sailer@alumni.ethz.ch
Organization: SCS
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.3-13jnx i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: via82cxxx_audio locking problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This applies to version 1.1.5 as well as the version in
linux-2.4.10-pre12 and linux-2.4.9-ac12.

1) There is one semaphore (syscall_sem) that is held during
   calls from userspace. It is even kept while going to sleep
   during read and write syscalls. This locks out other users,
   eg. mixers, for a potentially very long time, seconds are
   common but it may almost be arbitrarily long. Try changing
   the volume with eg. gmix while playing something with eg. xmms.

   Dropping and reacquiring syscall_sem around interruptible_sleep_on
   in via_dsp_do_read, via_dsp_do_write and via_dsp_drain_playback
   should solve the problem. Does anyone see a problem with this?

2) When some kind of error happens during read or write after
   some samples have already been dequeued and copied to the user
   buffer, the number of copied bytes should be returned instead
   of the error code, to avoid loosing samples.

3) The use of interruptible_sleep_on results in a small race where
   wake_ups may be lost. Unlikely to hit though.

4) The down_trylock and returning -EAGAIN in via_down_syscall looks
   questionable, EAGAIN with O_NONBLOCK normally means I/O has to
   be completed first, not that there is contention on some internal
   synchronisation primitive.

Jeff, do you object any of this? Would you accept a patch to ameliorate
the situation? Or would you like to fix this yourself?

Tom

PS: Is there any better publicly available chip documentation than
the 120 page PDF file?
