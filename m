Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275301AbRJNO7P>; Sun, 14 Oct 2001 10:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275424AbRJNO7I>; Sun, 14 Oct 2001 10:59:08 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:24246 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S275301AbRJNO6v>;
	Sun, 14 Oct 2001 10:58:51 -0400
Date: Sun, 14 Oct 2001 19:01:44 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Question about spinlock and timer
Message-Id: <20011014190144.58e6f212.johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
X-Mailer: stuphead ver. 0.5.3 (Wiskas) (GTK+ 1.2.9; Linux 2.4.9; i686)
Organization: MIPT
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, linux guru.

After reading spinlock documentation at the kernelnewbie.org, i've got a
question:
If i clearly understand, each kernel timer is connected with some memory
region, and this region should be freed when timer becomes clear.
And this can occur before spi_lock_bh(). Therefore this memory regin will
be freed second time in the loop.

   spin_lock_bh(&list_lock);

         while (list) {
                 struct foo *next = list->next;
                 del_timer(&list->timer);
                 kfree(list);
                 list = next;
         }
         spin_unlock_bh(&list_lock);


This is correct example:

      retry:  
                 spin_lock_bh(&list_lock);

                 while (list) {
                         struct foo *next = list->next;
                         if (!del_timer(&list->timer)) {
                                 /* Give timer a chance to delete this */
                                 spin_unlock_bh(&list_lock);
                                 goto retry;
                         }
                         kfree(list);
                         list = next;
                 }

                 spin_unlock_bh(&list_lock);

If i was right in previous assumption, than this code may be owervritten
in such manner:
.....
 if (!del_timer(&list->timer)) {
     if (!next)
          break;
     list = next;
     continue;
     }
.....

Or am I wrong again?
If it is so, please tell me the write answer and explanation.

Thanks in advance for you answers and appologies.

---
WBR. //s0mbre
