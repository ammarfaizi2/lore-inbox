Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271024AbRHOFJa>; Wed, 15 Aug 2001 01:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271027AbRHOFJV>; Wed, 15 Aug 2001 01:09:21 -0400
Received: from mail.fbab.net ([212.75.83.8]:51983 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S271024AbRHOFJN>;
	Wed, 15 Aug 2001 01:09:13 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 7.710883 secs)
Message-ID: <3ce801c12548$b7971750$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: 2.4.8 Resource leaks + limits
Date: Wed, 15 Aug 2001 07:11:18 +0200
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

Can anyone please explain something to me?
I saw Alan's comments on Ivan Kalvatchev's malloc "bomb".
So i thought maybe i should test to impose some limits, and try some changes
with Ivan's code.

Box:

Linux UltraSparc 2.4.8 #3 Tue Aug 14 01:03:31 CEST 2001 sparc64 unknown
(a Sun Ultra10)

Code:

--------8<-------8<-------8<-------8<-------8<-----------
struct entry { struct entry *next; char *p;} * head=0;

int main() {
   int i;
   struct entry *e;
   for(i=0;;i+=2*4) {
      if (!(e=malloc(4096)) || !(e->p = malloc(4096)))
        break;
      e->next = head;
      head = e;
      if (!(i%1024)) printf("malloc @ %dkb\n",i);
   }

   printf("Stopped at %dkb \nTouching-in-a-loop.\n",i);

   for (e=head ;; e=e->next?e->next:head )
     memset(e->p,++i % 256,4096);

   return 0;
}
--------8<-------8<-------8<-------8<-------8<-----------

Memory is (after run + swapoff + swapon):

[root@UltraSparc src]# free -m
             total       used       free     shared    buffers     cached
Mem:           122         38         83          0          1         17
-/+ buffers/cache:         20        101
Swap:         1057          0       1057

And the limits are:

*               -       rss             64000
*               -       memlock         32000
*               -       as              128000
*               -       data            64000
*               hard    nproc           50
*               soft    nproc           40
*               -       stack           666
*               soft    priority        16
*               hard    priority        12


I ran maybe 20-30 instances at once.
All process allocated the 64MB that it was allowed by the "data" limit.
The system went down to really crawling (but never locked up completly).
After a while the oom killer kicked in as well, when i ran out of swap+ram.

Question: why isn't there a limit for global memory usage per user?
No way could i stop these processes without decreasing the nproc stuff.
That's not really what one want's some time, you know :)

The more "real" issue here is that after this run i couldn't log on as
another user than root.
Even now (after swapoff -a and so) i can't log on as another user:

[root@UltraSparc src]# su -l mag2
can not fork user shell: Resource temporarily unavailable

How can i get my fargin resources back? :)

Nice that the system survived (kinda, took 15 min to get logged on via ssh
;) ), but it's not cool if i have to reboot anyways because my resources are
farged.

Can i do anything, or what?

Magnus

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


