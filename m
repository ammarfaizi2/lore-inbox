Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292961AbSB0VmY>; Wed, 27 Feb 2002 16:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292583AbSB0Vlp>; Wed, 27 Feb 2002 16:41:45 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:55989 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292985AbSB0VlJ>;
	Wed, 27 Feb 2002 16:41:09 -0500
Importance: Normal
Sensitivity: 
Subject: get_pid() performance numbers
To: lse-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, davej@suse.de
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFEB8A84A2.A3F343ED-ON85256B6D.006F46D4@pok.ibm.com>
From: "Rajan Ravindran" <rajancr@us.ibm.com>
Date: Wed, 27 Feb 2002 16:40:55 -0500
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.9a |January 7, 2002) at
 02/27/2002 04:40:59 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



As we mentioned earlier get_pid() takes a long time to find the
next available pid once the last pid reaches the PID_MAX. This
is due to a constant rescan of the task list while progressing
only one pid at time, yielding an O(n**2) problem.

Here are some of the performance numbers we measured
with the user level test program getpid.c.

Run 1:
      getpid -p 32777 -n 10 -s 2

which will try to create 32777 process, eventually get_pid can't
find any free pid after 32767, so it will delete 10 pids randomly
from the existing list and start calculating the time taken to
find the available pid (which we deleted).
Argument -s # is to generate new sequence of random integers.


Output of old algorithm
-----------------------
start creating 32777 processes
reached max pid <32768>
removing pids: <32766> <6138> <31103> <9796> <8527>
               <20693> <22994> <14848> <18477> <7977>
spent 1.162768 seconds in finding <6138>
spent 1.21490 seconds in finding <7977>
spent 2.326478 seconds in finding <8527>
spent 3.224940 seconds in finding <9796>
.........
.........
spent 49.813094 seconds in finding <32766>

Output of new algorithm
-----------------------
start creating 32777 processes
reached max pid <32768>
removing pids: <32766> <6138> <31103> <9796> <8527>
               <20693> <22994> <14848> <18477> <7977>
spent 4881 microseconds in finding <6138>
spent 9496 microseconds in finding <7977>
spent 14033 microseconds in finding <8527>
spent 18563 microseconds in finding <9796>
.........
.........
spent 45425 microseconds in finding <32766>

In the above output searching for pid <32766> which is
PID_MAX-1 is a good example, which tells how long the old
and new search algorithm's take to complete one full
loop (300 - PID_MAX).

  Old            New
  ---            ---
49.8 sec        45425 microseconds


Thanks,
Rajan

Here is a patch which was taken against 2.4.18

diff -Naur linux-2.4.18-v/kernel/fork.c linux-2.4.18-getpid/kernel/fork.c
--- linux-2.4.18-v/kernel/fork.c    Mon Feb 25 14:38:13 2002
+++ linux-2.4.18-getpid/kernel/fork.c     Wed Feb 27 16:20:56 2002
@@ -20,6 +20,7 @@
 #include <linux/vmalloc.h>
 #include <linux/completion.h>
 #include <linux/personality.h>
+#include <linux/compiler.h>

 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -85,12 +86,13 @@
 {
      static int next_safe = PID_MAX;
      struct task_struct *p;
-     int pid;
+     int pid, beginpid;

      if (flags & CLONE_PID)
            return current->pid;

      spin_lock(&lastpid_lock);
+     beginpid = last_pid;
      if((++last_pid) & 0xffff8000) {
            last_pid = 300;         /* Skip daemons etc. */
            goto inside;
@@ -109,8 +111,11 @@
                              if(last_pid & 0xffff8000)
                                    last_pid = 300;
                              next_safe = PID_MAX;
+                             goto repeat;
                        }
-                       goto repeat;
+                       if(unlikely(last_pid == beginpid))
+                             goto nomorepids;
+                       continue;
                  }
                  if(p->pid > last_pid && next_safe > p->pid)
                        next_safe = p->pid;
@@ -125,6 +130,11 @@
      spin_unlock(&lastpid_lock);

      return pid;
+
+nomorepids:
+     read_unlock(&tasklist_lock);
+     spin_unlock(&lastpid_lock);
+     return 0;
 }

 static inline int dup_mmap(struct mm_struct * mm)
@@ -620,6 +630,8 @@

      copy_flags(clone_flags, p);
      p->pid = get_pid(clone_flags);
+     if (p->pid == 0 && current->pid != 0)
+           goto bad_fork_cleanup;

      p->run_list.next = NULL;
      p->run_list.prev = NULL;


