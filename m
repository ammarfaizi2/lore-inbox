Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSG2Kkk>; Mon, 29 Jul 2002 06:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSG2Kkk>; Mon, 29 Jul 2002 06:40:40 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:39406 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S314634AbSG2Kk3>; Mon, 29 Jul 2002 06:40:29 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove cli() from R3964 line discipline.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Jul 2002 11:43:49 +0100
Message-ID: <26769.1027939429@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did this ages ago but never submitted it because I never got round to 
testing it. I still haven't tested it, but it ought to work, and the code 
is definitely broken without it...

===== drivers/char/n_r3964.c 1.9 vs edited =====
--- 1.9/drivers/char/n_r3964.c	Thu May 23 17:07:43 2002
+++ edited/drivers/char/n_r3964.c	Mon Jul 29 11:39:36 2002
@@ -13,6 +13,12 @@
  * L. Haag
  *
  * $Log: n_r3964.c,v $
+ * Revision 1.10  2001/03/18 13:02:24  dwmw2
+ * Fix timer usage, use spinlocks properly.
+ *
+ * Revision 1.9  2001/03/18 12:52:14  dwmw2
+ * Merge changes in 2.4.2
+ *
  * Revision 1.8  2000/03/23 14:14:54  dwmw2
  * Fix race in sleeping in r3964_read()
  *
@@ -110,8 +116,6 @@
 #define TRACE_Q(fmt, arg...) /**/
 #endif
 
-static void on_timer_1(void*);
-static void on_timer_2(void*);
 static void add_tx_queue(struct r3964_info *, struct r3964_block_header *);
 static void remove_from_tx_queue(struct r3964_info *pInfo, int error_code);
 static void put_char(struct r3964_info *pInfo, unsigned char ch);
@@ -120,7 +124,7 @@
 static void transmit_block(struct r3964_info *pInfo);
 static void receive_char(struct r3964_info *pInfo, const unsigned char c);
 static void receive_error(struct r3964_info *pInfo, const char flag);
-static void on_timeout(struct r3964_info *pInfo);
+static void on_timeout(unsigned long priv);
 static int enable_signals(struct r3964_info *pInfo, pid_t pid, int arg);
 static int read_telegram(struct r3964_info *pInfo, pid_t pid, unsigned char *buf);
 static void add_msg(struct r3964_client_info *pClient, int msg_id, int arg,
@@ -217,7 +221,7 @@
 {
    int status;
    
-   printk ("r3964: Philips r3964 Driver $Revision: 1.8 $\n");
+   printk ("r3964: Philips r3964 Driver $Revision: 1.10 $\n");
 
    /*
     * Register the tty line discipline
@@ -247,40 +251,11 @@
  * Protocol implementation routines
  *************************************************************/
 
-static void on_timer_1(void *arg)
-{
-   struct r3964_info *pInfo = (struct r3964_info *)arg;
-  
-   if(pInfo->count_down)
-   {
-      if(!--pInfo->count_down)
-      {
-         on_timeout(pInfo);
-      }
-   }
-   queue_task(&pInfo->bh_2, &tq_timer);
-}
-
-static void on_timer_2(void *arg)
-{
-   struct r3964_info *pInfo = (struct r3964_info *)arg;
-  
-   if(pInfo->count_down)
-   {
-      if(!--pInfo->count_down)
-      {
-         on_timeout(pInfo);
-      }
-   }
-   queue_task(&pInfo->bh_1, &tq_timer);
-}
-
 static void add_tx_queue(struct r3964_info *pInfo, struct r3964_block_header *pHeader)
 {
    unsigned long flags;
    
-   save_flags(flags);
-   cli();
+   spin_lock_irqsave(&pInfo->lock, flags);
 
    pHeader->next = NULL;
 
@@ -294,7 +269,7 @@
       pInfo->tx_last = pHeader;
    }
    
-   restore_flags(flags);
+   spin_unlock_irqrestore(&pInfo->lock, flags);
 
    TRACE_Q("add_tx_queue %x, length %d, tx_first = %x", 
           (int)pHeader, pHeader->length, (int)pInfo->tx_first );
@@ -337,8 +312,7 @@
       wake_up_interruptible (&pInfo->read_wait);
    }
 
-   save_flags(flags);
-   cli();
+   spin_lock_irqsave(&pInfo->lock, flags);
 
    pInfo->tx_first = pHeader->next;
    if(pInfo->tx_first==NULL)
@@ -346,7 +320,7 @@
       pInfo->tx_last = NULL;
    }
 
-   restore_flags(flags);
+   spin_unlock_irqrestore(&pInfo->lock, flags);
 
    kfree(pHeader);
    TRACE_M("remove_from_tx_queue - kfree %x",(int)pHeader);
@@ -359,8 +333,7 @@
 {
    unsigned long flags;
    
-   save_flags(flags);
-   cli();
+   spin_lock_irqsave(&pInfo->lock, flags);
 
    pHeader->next = NULL;
 
@@ -375,7 +348,7 @@
    }
    pInfo->blocks_in_rx_queue++;
    
-   restore_flags(flags);
+   spin_unlock_irqrestore(&pInfo->lock, flags);
 
    TRACE_Q("add_rx_queue: %x, length = %d, rx_first = %x, count = %d",
           (int)pHeader, pHeader->length,
@@ -396,8 +369,7 @@
    TRACE_Q("remove_from_rx_queue: %x, length %d",
           (int)pHeader, (int)pHeader->length );
 
-   save_flags(flags);
-   cli();
+   spin_lock_irqsave(&pInfo->lock, flags);
 
    if(pInfo->rx_first == pHeader)
    {
@@ -430,7 +402,7 @@
       }
    }
 
-   restore_flags(flags);
+   spin_unlock_irqrestore(&pInfo->lock, flags);
 
    kfree(pHeader);
    TRACE_M("remove_from_rx_queue - kfree %x",(int)pHeader);
@@ -471,17 +443,16 @@
    unsigned long flags;
    
 
-   save_flags(flags);
-   cli();
+   spin_lock_irqsave(&pInfo->lock, flags);
 
    if((pInfo->state == R3964_IDLE) && (pInfo->tx_first!=NULL))
    {
       pInfo->state = R3964_TX_REQUEST;
-      pInfo->count_down = R3964_TO_QVZ;
       pInfo->nRetry=0;
       pInfo->flags &= ~R3964_ERROR;
-      
-      restore_flags(flags);
+      mod_timer(&pInfo->tmr, jiffies + R3964_TO_QVZ);
+
+      spin_unlock_irqrestore(&pInfo->lock, flags);
 
       TRACE_PS("trigger_transmit - sent STX");
 
@@ -492,7 +463,7 @@
    }
    else
    {
-      restore_flags(flags);
+      spin_unlock_irqrestore(&pInfo->lock, flags);
    }
 }
 
@@ -506,8 +477,8 @@
       put_char(pInfo, STX);
       flush(pInfo);
       pInfo->state = R3964_TX_REQUEST;
-      pInfo->count_down = R3964_TO_QVZ;
       pInfo->nRetry++;
+      mod_timer(&pInfo->tmr, jiffies + R3964_TO_QVZ);
    }
    else
    {
@@ -566,7 +537,7 @@
          put_char(pInfo, pInfo->bcc);
       }
       pInfo->state = R3964_WAIT_FOR_TX_ACK;
-      pInfo->count_down = R3964_TO_QVZ;
+      mod_timer(&pInfo->tmr, jiffies + R3964_TO_QVZ);
    }
    flush(pInfo);
 }
@@ -601,8 +572,8 @@
       if(pInfo->nRetry<R3964_MAX_RETRIES)
       {
          pInfo->state=R3964_WAIT_FOR_RX_REPEAT;
-         pInfo->count_down = R3964_TO_RX_PANIC;
          pInfo->nRetry++;
+	 mod_timer(&pInfo->tmr, jiffies + R3964_TO_RX_PANIC);
       }
       else
       {
@@ -616,7 +587,7 @@
    /* received block; submit DLE: */
    put_char(pInfo, DLE);
    flush(pInfo);
-   pInfo->count_down=0;
+   del_timer_sync(&pInfo->tmr);
    TRACE_PS(" rx success: got %d chars", length);
 
    /* prepare struct r3964_block_header: */
@@ -701,7 +672,7 @@
             TRACE_PE("TRANSMITTING - got illegal char");
  
             pInfo->state = R3964_WAIT_ZVZ_BEFORE_TX_RETRY;
-            pInfo->count_down = R3964_TO_ZVZ;
+	    mod_timer(&pInfo->tmr, jiffies + R3964_TO_ZVZ);
          }
          break;
       case R3964_WAIT_FOR_TX_ACK:
@@ -728,7 +699,7 @@
             {
                TRACE_PE("IDLE - got STX but no space in rx_queue!");
                pInfo->state=R3964_WAIT_FOR_RX_BUF;
-               pInfo->count_down = R3964_TO_NO_BUF;
+	       mod_timer(&pInfo->tmr, R3964_TO_NO_BUF);
                break;
             }
 start_receiving:
@@ -738,8 +709,8 @@
             pInfo->last_rx = 0;
             pInfo->flags &= ~R3964_ERROR;
             pInfo->state=R3964_RECEIVING;
-            pInfo->count_down = R3964_TO_ZVZ;
-            pInfo->nRetry = 0;
+	    mod_timer(&pInfo->tmr, R3964_TO_ZVZ);
+	    pInfo->nRetry = 0;
             put_char(pInfo, DLE);
             flush(pInfo);
             pInfo->bcc = 0;
@@ -765,7 +736,7 @@
                if(pInfo->flags & R3964_BCC)
                {
                   pInfo->state = R3964_WAIT_FOR_BCC;
-                  pInfo->count_down = R3964_TO_ZVZ;
+		  mod_timer(&pInfo->tmr, R3964_TO_ZVZ);
                }
                else 
                {
@@ -777,7 +748,7 @@
                pInfo->last_rx = c;
 char_to_buf:
                pInfo->rx_buf[pInfo->rx_position++] = c;
-               pInfo->count_down = R3964_TO_ZVZ;
+	       mod_timer(&pInfo->tmr, R3964_TO_ZVZ);
             }
          }
         /* else: overflow-msg? BUF_SIZE>MTU; should not happen? */ 
@@ -818,8 +789,10 @@
     }
 }
 
-static void on_timeout(struct r3964_info *pInfo)
+static void on_timeout(unsigned long priv)
 {
+   struct r3964_info *pInfo = (void *)priv;
+
    switch(pInfo->state)
    {
       case R3964_TX_REQUEST:
@@ -926,6 +899,7 @@
             return -ENOMEM;
 
          TRACE_PS("add client %d to client list", pid);
+	 spin_lock_init(&pClient->lock);
          pClient->sig_flags=arg;
          pClient->pid = pid;
          pClient->next=pInfo->firstClient;
@@ -989,8 +963,7 @@
          return;
       }
 
-      save_flags(flags);
-      cli();
+      spin_lock_irqsave(&pClient->lock, flags);
 
       pMsg->msg_id = msg_id;
       pMsg->arg    = arg;
@@ -1014,7 +987,7 @@
       {
          pBlock->locks++;
       }
-      restore_flags(flags);
+      spin_unlock_irqrestore(&pClient->lock, flags);
    }
    else
    {
@@ -1049,8 +1022,7 @@
 
    if(pClient->first_msg)
    {
-      save_flags(flags);
-      cli();
+      spin_lock_irqsave(&pClient->lock, flags);
 
       pMsg = pClient->first_msg;
       pClient->first_msg = pMsg->next;
@@ -1065,7 +1037,7 @@
         remove_client_block(pInfo, pClient);
         pClient->next_block_to_read = pMsg->block;
       }
-      restore_flags(flags);
+      spin_unlock_irqrestore(&pClient->lock, flags);
    }
    return pMsg;
 }
@@ -1137,6 +1109,7 @@
       return -ENOMEM;
    }
 
+   spin_lock_init(&pInfo->lock);
    pInfo->tty = tty;
    init_waitqueue_head (&pInfo->read_wait);
    pInfo->priority = R3964_MASTER;
@@ -1149,26 +1122,13 @@
    pInfo->firstClient=NULL;
    pInfo->state=R3964_IDLE;
    pInfo->flags = R3964_DEBUG;
-   pInfo->count_down = 0;
    pInfo->nRetry = 0;
    
    tty->disc_data = pInfo;
 
-   /*
-    * Add 'on_timer' to timer task queue
-    * (will be called from timer bh)
-    */
-   INIT_LIST_HEAD(&pInfo->bh_1.list);
-   pInfo->bh_1.sync = 0;
-   pInfo->bh_1.routine = &on_timer_1;
-   pInfo->bh_1.data = pInfo;
-   
-   INIT_LIST_HEAD(&pInfo->bh_2.list);
-   pInfo->bh_2.sync = 0;
-   pInfo->bh_2.routine = &on_timer_2;
-   pInfo->bh_2.data = pInfo;
-
-   queue_task(&pInfo->bh_1, &tq_timer);
+   INIT_LIST_HEAD(&pInfo->tmr.list);
+   pInfo->tmr.data = (unsigned long)pInfo;
+   pInfo->tmr.function = on_timeout;
 
    return 0;
 }
@@ -1187,12 +1147,7 @@
      * Make sure that our task queue isn't activated.  If it
      * is, take it out of the linked list.
      */
-    spin_lock_irqsave(&tqueue_lock, flags);
-    if (pInfo->bh_1.sync)
-    	list_del(&pInfo->bh_1.list);
-    if (pInfo->bh_2.sync)
-    	list_del(&pInfo->bh_2.list);
-    spin_unlock_irqrestore(&tqueue_lock, flags);
+    del_timer_sync(&pInfo->tmr);
 
    /* Remove client-structs and message queues: */
     pClient=pInfo->firstClient;
@@ -1213,11 +1168,10 @@
        pClient=pNext;
     }
     /* Remove jobs from tx_queue: */
-	save_flags(flags);
-        cli();
+        spin_lock_irqsave(&pInfo->lock, flags);
 	pHeader=pInfo->tx_first;
 	pInfo->tx_first=pInfo->tx_last=NULL;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pInfo->lock, flags);
 	
     while(pHeader)
 	{
@@ -1430,10 +1384,9 @@
    if(pClient)
      {
        poll_wait(file, &pInfo->read_wait, wait);
-       save_flags(flags);
-       cli();
+       spin_lock_irqsave(&pInfo->lock, flags);
        pMsg=pClient->first_msg;
-       restore_flags(flags);
+       spin_unlock_irqrestore(&pInfo->lock, flags);
        if(pMsg)
 	   result |= POLLIN | POLLRDNORM;
      }
===== include/linux/n_r3964.h 1.2 vs edited =====
--- 1.2/include/linux/n_r3964.h	Tue Feb  5 07:38:17 2002
+++ edited/include/linux/n_r3964.h	Mon Jul 29 11:38:46 2002
@@ -13,6 +13,12 @@
  * L. Haag
  *
  * $Log: r3964.h,v $
+ * Revision 1.3  2001/03/18 13:02:24  dwmw2
+ * Fix timer usage, use spinlocks properly.
+ *
+ * Revision 1.2  2001/03/18 12:53:15  dwmw2
+ * Merge changes in 2.4.2
+ *
  * Revision 1.1.1.1  1998/10/13 16:43:14  dwmw2
  * This'll screw the version control
  *
@@ -103,8 +109,9 @@
 struct r3964_message;
 
 struct r3964_client_info {
+	spinlock_t     lock;
 	pid_t          pid;
-    unsigned int   sig_flags;
+	unsigned int   sig_flags;
 
 	struct r3964_client_info *next;
 
@@ -186,6 +193,7 @@
 
 
 struct r3964_info {
+	spinlock_t     lock;
 	struct tty_struct *tty;
 	unsigned char priority;
 	unsigned char *rx_buf;            /* ring buffer */
@@ -209,11 +217,8 @@
 	unsigned int state;
 	unsigned int flags;
 
-	int count_down;
-    int nRetry;
-
-    struct tq_struct bh_1;
-    struct tq_struct bh_2;
+	struct timer_list tmr;
+	int nRetry;
 };
 
 #endif	

--
dwmw2


