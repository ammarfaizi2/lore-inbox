Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTDHWJN (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 18:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbTDHWJN (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 18:09:13 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:16850 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP id S261868AbTDHWJL (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 18:09:11 -0400
Message-ID: <3E934DB7.1000503@kegel.com>
Date: Tue, 08 Apr 2003 15:31:19 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: fsync() on unix domain sockets?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let's say someone had written a win32 emulator that
ran in userspace, and was using unix domain sockets
to emulate win32 named pipes.  (Yes, this is how
Wine does it at the moment, but it's a poor fit,
and they're thinking of switching to emulating them 100%
in userspace so they can get the semantics right.)

It turns out that in this situation, it would be handy
for fsync() to work on unix domain sockets.  This would
require a bit of plumbing to let sockets expose an fsync() method,
together with an fsync() method for unix domain sockets.
After thinking about this a bit, I couldn't resist
writing that method for stream sockets.  Being a kernel newbie,
I am unsure if I got the locking and reference counting right.
Anyone care to peek at it and see if there are glaring problems?
(If not, I guess I could go do the needed plumbing and see how it works in practice.)

Thanks,
Dan

/* to be added to net/unix/af_unix.c */

static long unix_stream_fsync(unix_socket * sk)
{
     int err;
     long timeo;
     unix_socket *other;

     DECLARE_WAITQUEUE(wait, current);

     timeo = sock_sndtimeo(sk, 0);

     err = -ENOTCONN;
     other = unix_peer_get(sk);
     if (!other)
         goto out;

     unix_state_rlock(sk);
     add_wait_queue(sk->sleep, &wait);
     unix_state_runlock(sk);
     for (;;) {
         int breakme;

         unix_state_rlock(other);
         breakme = !skb_queue_len(&other->receive_queue) ||
             other->err ||
             (other->shutdown & RCV_SHUTDOWN) ||
             !timeo;
         unix_state_runlock(other);
         if (breakme)
             break;
         if (signal_pending(current))
             goto out_sig;
         set_current_state(TASK_INTERRUPTIBLE);
         timeo = schedule_timeout(timeo);
     }

     err = 0;
out_run:
     __set_current_state(TASK_RUNNING);
     unix_state_rlock(sk);
     remove_wait_queue(sk->sleep, &wait);
     unix_state_runlock(sk);
     sock_put(other);

out:
     return err;

out_sig:
     err = sock_intr_errno(timeo);
     goto out_run;
}
-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

