Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273709AbRIQVu0>; Mon, 17 Sep 2001 17:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273708AbRIQVuQ>; Mon, 17 Sep 2001 17:50:16 -0400
Received: from colorfullife.com ([216.156.138.34]:43014 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S273706AbRIQVuE>;
	Mon, 17 Sep 2001 17:50:04 -0400
Message-ID: <001701c13fc2$cda19a90$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "\"Ulrich Weigand\"" <Ulrich.Weigand@de.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Deadlock on the mm->mmap_sem
Date: Mon, 17 Sep 2001 23:50:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What happens is that proc_pid_read_maps grabs the mmap_sem as a
> reader, and *while it holds the lock*, does a copy_to_user.  This can
> of course page-fault, and the handler will also grab the mmap_sem
> (if it is the same task).

Ok, that's a bug.
You must not call copy_to_user with the mmap semaphore acquired - linux
semaphores are not recursive.

> Any ideas how to fix this?  Should proc_pid_read_maps just drop the
> lock before copy_to_user?

Yes, and preferable switch to multiline copies - a full page temporary
buffer is allocated, transfering data on a line-by-line base is way too
much overhead (and the current volatile_task is an ugly hack).

--
    Manfred





