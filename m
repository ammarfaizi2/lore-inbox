Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130784AbQJ2D3M>; Sat, 28 Oct 2000 23:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131535AbQJ2D3C>; Sat, 28 Oct 2000 23:29:02 -0400
Received: from brutus.conectiva.com.br ([200.250.58.146]:58108 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130784AbQJ2D2u>; Sat, 28 Oct 2000 23:28:50 -0400
Date: Sun, 29 Oct 2000 01:28:38 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: davem@redhat.com
cc: linux-kernel@vger.kernel.org, netdev <netdev@oss.sgi.com>
Subject: tcp.c::wait_for_tcp_memory() buggy ?
Message-ID: <Pine.LNX.4.21.0010290122050.4224-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davem,

I can't quite put my finger on what wait_for_tcp_memory() is
supposed to do, but the code looks EXTREMELY suspect and I've
had a report of somebody looping in the for(;;) loop in that
function without ever exiting and getting his TCP connection
stuck there...

Also, the locking inside the loop seems fragile, to say the
least.

from tcp.c:

  865         if (tcp_memory_free(sk) && !vm_wait)
  866                 break;

  880         release_sock(sk);
  881         if (!tcp_memory_free(sk) || vm_wait)
  882                 current_timeo = schedule_timeout(current_timeo);
  883         lock_sock(sk);

Here we hold the lock for the entire loop (meaning that
other people cannot make the exit condition on line 865
come true.

Except for doing a test on tcp_memory_free(sk), where we
do NOT hold the lock we're so dutifully clinging to during
the rest of the loop...

As I said, I can't put my finger down on what exactly is
wrong, but this code looks subtle enough that, together
with the bugreport I got (on IRC), I have the feeling that
it just _can't_ be right ...

regards, 

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
