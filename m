Return-Path: <linux-kernel-owner+w=401wt.eu-S932068AbWLIGUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWLIGUo (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 01:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759225AbWLIGUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 01:20:43 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:36668 "EHLO
	rwcrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759200AbWLIGUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 01:20:43 -0500
Message-ID: <457A6637.3060101@wolfmountaingroup.com>
Date: Sat, 09 Dec 2006 00:31:03 -0700
From: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Recursive spinlocks for Network Recursion Bugs in 2.6.18
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This code segment in /net/core/dev.c is a prime example of the need for 
recursive spin locks.

       if (dev->flags & IFF_UP) {
                int cpu = smp_processor_id(); /* ok because BHs are off */

                if (dev->xmit_lock_owner != cpu) {

                        HARD_TX_LOCK(dev, cpu);

                        if (!netif_queue_stopped(dev)) {
                                rc = 0;
                                if (!dev_hard_start_xmit(skb, dev)) {
                                        HARD_TX_UNLOCK(dev);
                                        goto out;
                                }
                        }
                        HARD_TX_UNLOCK(dev);
                        if (net_ratelimit())
                                printk(KERN_CRIT "Virtual device %s asks 
to "
                                       "queue packet!\n", dev->name);
                } else {
                        /* Recursion is detected! It is possible,
                         * unfortunately */
                        if (net_ratelimit())
                                printk(KERN_CRIT "Dead loop on virtual 
device "
                                       "%s, fix it urgently!\n", dev->name);
                }
        }

Recursive spinlocks perform the logic

rspin_lock(spin_lock)
{
   if (spin_lock->lock->cpu_owner = cpu I am on) && (spin_lock->lock)
   {
       spin_lock->use_count++;
   }
    else
    {
          spin_lock(lock)
          lock->cpu_owner = cpu I am on;
          lock->use_count++;
    }
}

rspin_unlock(spin_lock)
{
   if (spin_lock->lock->cpu_owner = cpu I am on) && (spin_lock->use_count)
   {
       spin_lock->use_count--;
   }
    else
    {   
           lock->use_count++;     
           lock->cpu_owner = cpu I am on;
           spin_unlock(lock)
    }
}

One implementation of this is:

LONG rspin_lock(rlock_t *rlock)
{
   register LONG proc = get_processor_id();
   register LONG retCode;

   if (rlock->lockValue && rlock->processor == (proc + 1))
   {
      rlock->count++;
      retCode = 1;
   }
   else
   {
      dspin_lock(&rlock->lockValue);
      rlock->processor = (proc + 1);
      retCode = 0;
   }

   return retCode;

}
LONG rspin_unlock(rlock_t *rlock)
{

   register LONG retCode;

   if (rlock->count)
   {
      rlock->count--;
      retCode = 1;
   }
   else
   {
      rlock->processor = 0;
      dspin_unlock(&rlock->lockValue);
      retCode = 0;
   }

   return retCode;
}

Just a suggestion.   Would be a useful primitive for a lot of context 
implementations where users turn on interrupts inside of nested spin 
lock code.

Jeff




