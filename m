Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288284AbSA3EHT>; Tue, 29 Jan 2002 23:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288344AbSA3EHA>; Tue, 29 Jan 2002 23:07:00 -0500
Received: from s2.org ([195.197.64.39]:33287 "EHLO kalahari.s2.org")
	by vger.kernel.org with ESMTP id <S288284AbSA3EGx>;
	Tue, 29 Jan 2002 23:06:53 -0500
To: linux-kernel@vger.kernel.org
Subject: How to avoid zombie kernel threads?
From: Jarno Paananen <jpaana@s2.org>
Date: 30 Jan 2002 06:06:50 +0200
Message-ID: <m3hep4qy79.fsf@kalahari.s2.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm coding a driver (can be found from
http://hardsid.sourceforge.net/ is someone is actually interested)
that uses a kernel thread to do the actual work asynchronously from
rest of the world. The thread is created when opening a character
device and exits when the device is closed.

This works fine otherwise but if the user mode process opens and
closes the device multiple times during its lifetime I get N-1
zombie kernel threads where N is the number of opens.

The code goes like this:

in device open:

        DECLARE_MUTEX_LOCKED(sem);
        int rmmod = 0; 

        rmmod = 0;
        notify = &sem;
        kernel_thread(hsid_thread, (void *)sid_data, 0);
        down(&sem);
        notify = NULL;
 

in device close:

        notify = &sem;
        rmmod = 1;
        up(&todoSem); // just to wake the thread to do something
        down(&sem);
        notify = NULL;
        rmmod = 0;

and the thread itself does:

[daemonize() etc.]

    /* Notify the parent */
    if(notify != NULL)
        up(notify);

    for(;;)
    {
        if (rmmod || signal_pending(current))
            break;

        /* We sit here waiting for something to do */
        down_interruptible(&todoSem);

        if (rmmod || signal_pending(current))
            break;

        [actual work]
    }

    if(notify != NULL)
        up(notify);

    return 0;


I think this worked fine in earlier 2.4 versions (not sure though),
but I'm now seeing this in both 2.4.18-pre7 and 2.5.2-dj6, UP and SMP.

Thanks,

// Jarno
