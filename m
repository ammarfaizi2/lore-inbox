Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131117AbQKYPkT>; Sat, 25 Nov 2000 10:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131092AbQKYPkJ>; Sat, 25 Nov 2000 10:40:09 -0500
Received: from mailc.telia.com ([194.22.190.4]:8908 "EHLO mailc.telia.com")
        by vger.kernel.org with ESMTP id <S129434AbQKYPkB>;
        Sat, 25 Nov 2000 10:40:01 -0500
From: Roger Larsson <roger.larsson@norran.net>
Date: Sat, 25 Nov 2000 16:07:25 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nigel Gamble <nigel@nrg.org>
Subject: *_trylock return on success?
MIME-Version: 1.0
Message-Id: <00112516072500.01122@dox>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Background information:
 compiled and tested a test11 with the Montavista preemptive patch.
 After pressing Magic-SysRq-M all processes that tried to do IO hung in 'D'
 Last message "Buffer memory ..."
 Pressing Magic-SysRq-M again, all hung processes continued...

Checking the patch it looks like this

 	printk("Buffer memory:   %6dkB\n",
 			atomic_read(&buffermem_pages) << (PAGE_SHIFT-10));

-#ifdef CONFIG_SMP /* trylock does nothing on UP and so we could deadlock */
-	if (!spin_trylock(&lru_list_lock))
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
+	if (!mutex_trylock(&lru_list_mtx))
 		return;
 	for(nlist = 0; nlist < NR_LIST; nlist++) {

Ok, so I run some more code now than before (UP system with PREEMPT).
mutex_trylock is defined as:

+#define mutex_trylock(x) down_trylock(x)

Noticed that if the spin_trylock returns 0 on success, I will get the 
behavior I see.
  Not printing buffer info first time.
  Holding the lock - stopping other fs processes.
  Failing the mutex_trylock next attempt, interprete as success
  - continuing and printing the buffer info.
  - finally release the mutex

I removed the not (!) and now it works as expected.

Questions:
  What are _trylocks supposed to return?
  Does spin_trylock and down_trylock behave differently?
  Why isn't the expected return value documented?
  
/RogerL

-- 
--
Home page:
  http://www.norran.net/nra02596/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
