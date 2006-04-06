Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWDFAYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWDFAYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 20:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWDFAYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 20:24:36 -0400
Received: from ns1.soleranetworks.com ([70.103.108.67]:42699 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S932129AbWDFAYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 20:24:35 -0400
Message-ID: <44346BA5.7060400@wolfmountaingroup.com>
Date: Wed, 05 Apr 2006 19:15:17 -0600
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Hudson <joshudson@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: readers-writers mutex
References: <bda6d13a0604051521o229de77dvb38992d6427a450c@mail.gmail.com>
In-Reply-To: <bda6d13a0604051521o229de77dvb38992d6427a450c@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------010102010807060008060704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010102010807060008060704
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Joshua Hudson wrote:

>Since we are moving from semaphores to mutex, there should be a
>mutex_rw. I had a try
>at creating one (might as well convert from sem_rw). I'll bet somebody
>here can do a
>lot better, but this will do if need be.
>
>--- linux-2.6.16.1-stock/include/linux/mutex_rw.h       1969-12-31
>16:00:00.000000000 -0800
>+++ linux-2.6.16.1-nvl/include/linux/mutex_rw.h 2006-04-04
>18:11:56.000000000 -0700
>@@ -0,0 +1,60 @@
>+/* Linux RW mutex
>+ * This file: GNU GPL v2 or later, Joshua Hudson <joshudson@gmail.com>
>+ *
>+ * Somebody else can make this fast. I just made this work.
>+ *
>+ * DANGER! Change of this file will break module binaries if any
>+ *  rw mutex is shared between main kernel and modules or between
>+ *  modules with a different version.
>+ */
>+
>+#ifndef __KERNEL_MUTEX_RW
>+#define __KERNEL_MUTEX_RW
>+#ifdef __KERNEL__
>+
>+#include <linux/mutex.h>
>+
>+struct rw_mutex {
>+       struct mutex r_mutex;
>+       struct mutex w_mutex;
>+       unsigned n_readers;
>+};
>+
>+static inline void rw_mutex_init(struct rw_mutex *rw)
>+{
>+       mutex_init(&rw->r_mutex);
>+       mutex_init(&rw->w_mutex);
>+       rw->n_readers = 0;
>+}
>+
>+static inline void rw_mutex_destroy(struct rw_mutex *rw)
>+{
>+       mutex_destroy(&rw->r_mutex);
>+       mutex_destroy(&rw->w_mutex);
>+}
>+
>+static inline void mutex_lock_w(struct rw_mutex *rw)
>+{
>+       mutex_lock(&rw->w_mutex);
>+}
>+
>+static inline void mutex_unlock_w(struct rw_mutex *rw)
>+{
>+       mutex_unlock(&rw->w_mutex);
>+}
>+
>+static inline void mutex_lock_r(struct rw_mutex *rw)
>+{
>+       mutex_lock(&rw->r_mutex);
>+       if (++rw->n_readers == 1)
>+               mutex_lock(&rw->w_mutex);
>+       mutex_unlock(&rw->r_mutex);
>+}
>+
>+static inline void mutex_unlock_r(struct rw_mutex *rw)
>+{
>+       mutex_lock(&rw->r_mutex);
>+       if (--rw->n_readers == 0)
>+               mutex_unlock(&rw->w_mutex);
>+       mutex_unlock(&rw->r_mutex);
>+}
>+
>+#endif
>+#endif
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Race conditions here.

Try this code. These have been tested and I have been using the code for 
couple of years in another OS (which is just about done now and is in 
alpha and beta and little more SMP friendly).

Jeff





--------------010102010807060008060704
Content-Type: text/x-csrc;
 name="rwlock.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rwlock.c"



/***************************************************************************
*
*   Copyright (c) 2005, 2006 Cherokee Nation. All Rights Reserved. 
*
*   This Program is released under GPLv3
*
*   AUTHOR   :  Jeff V. Merkey
*   FILE     :  RWLOCK.C
*   DESCRIP  :  Multi-Processing Reader/Writer Locks Gadugi v7
*   DATE     :  October 23, 2004
*
***************************************************************************/

#include "stdarg.h"
#include "stdio.h"
#include "stdlib.h"
#include "ctype.h"
#include "string.h"
#include "kernel.h"
#include "keyboard.h"
#include "screen.h"
#include "types.h"
#include "emit.h"
#include "dos.h"
#include "tss.h"
#include "os.h"
#include "mps.h"
#include "hal.h"
#include "timer.h"
#include "peexe.h"
#include "malloc.h"
#include "free.h"
#include "event.h"

#define  WRITER_OWNED   -10
#define  READER_OWNED   -11
#define  UNOWNED        -12

rwlock_t *rwlock_init(rwlock_t *rwlock);
rwlock_t *rwlock_alloc(void);
LONG rwlock_free(rwlock_t *rwlock);
LONG rwlock_read_lock(rwlock_t *rwlock);
LONG rwlock_write_lock(rwlock_t *rwlock);
LONG rwlock_read_try_lock(rwlock_t *rwlock);
LONG rwlock_write_try_lock(rwlock_t *rwlock);
LONG rwlock_unlock(rwlock_t *rwlock);
LONG rwlock_reader_to_writer(rwlock_t *rwlock);
LONG rwlock_reader_to_writer_unordered(rwlock_t *rwlock);
LONG rwlock_writer_to_reader(rwlock_t *rwlock);
LONG rwlock_release(rwlock_t *rwlock);
PROCESS *get_rwlock_process(rwlock_t *rwlock);
void put_rwlock_process(rwlock_t *rwlock, PROCESS *p);

rwlock_t *rwlock_init(rwlock_t *rwlock)
{

   if (rwlock && !rwlock->signature)
   {
      SetData((LONG *) rwlock, 0, sizeof(rwlock_t));
      rwlock->signature = LRWLOCK_SIGNATURE;
      rwlock->flags = UNOWNED;
      return (rwlock_t *) rwlock;
   }
   return 0;

}

rwlock_t *rwlock_alloc(void)
{

   register rwlock_t *rwlock;

   rwlock = kmalloc(sizeof(rwlock_t));
   if (rwlock)
   {
      SetData((LONG *) rwlock, 0, sizeof(rwlock_t));
      rwlock->signature = RWLOCK_SIGNATURE;
      rwlock->flags = UNOWNED;
      return (rwlock_t *) rwlock;
   }
   return 0;

}

LONG rwlock_free(rwlock_t *rwlock)
{
    if (rwlock->signature == RWLOCK_SIGNATURE ||
	rwlock->signature == LRWLOCK_SIGNATURE)
    {
       if (!rwlock_release(rwlock))
       {
	  if (rwlock->signature == RWLOCK_SIGNATURE)
	     kfree(rwlock);
	  else
	     rwlock->signature = 0;
	  return 0;
       }
       return -2;
    }
    return -1;

}

#if RWLOCK_TRACE

BYTE *get_RW_TYPE(LONG p)
{
     switch (p)
     {
	case RREAD_LOCK:
	   return "READ_LOCK";

	case RREAD_UNLOCK:
	   return "READ_UNLOCK";

	case WWRITE_LOCK:
	   return "WRITE_LOCK";

	case WWRITE_UNLOCK:
	   return "WRITE_UNLOCK";

	default:
	   return "????";
     }

}

BYTE *get_RW_OP(LONG p)
{
    switch (p)
    {
       case READER_LOCK:
	  return "READER_LOCK  ";

       case READER_UNLOCK:
	  return "READER_UNLOCK";

       case READER_SLEEP:
	  return "READER_SLEEP ";

       case READER_WAKE:
	  return "READER_WAKE  ";

       case WRITER_LOCK:
	  return "WRITER_LOCK  ";

       case WRITER_UNLOCK:
	  return "WRITER_UNLOCK";

       case WRITER_SLEEP:
	  return "WRITER_SLEEP ";

       case WRITER_WAKE:
	  return "WRITER_WAKE  ";

       default:
	  return "????         ";
    }
}

void RW_DISPLAY(SCREEN *screen, rwlock_t *rwlock)
{
     register LONG i;

     SetPauseMode(screen, screen->nLines - 5);

     printfScreen(screen, "RWIndex %d\n");
     for (i=0; i < 256; i++)
     {
	printfScreen(screen, "process-%08X time-%08X target-%08X s-%s t-%s\n",
		      rwlock->RWProcess[i],
		      rwlock->RWTime[i],
		      rwlock->RWTarget[i],
		      get_RW_OP(rwlock->RWOp[i]),
		      get_RW_TYPE(rwlock->RWType[i]));
     }

     ClearPauseMode(screen);

     return;

}

void RW_TRACE(rwlock_t *rwlock, LONG event, LONG target, LONG type)
{
     LONG base, counter;

     GetSystemDTSC(&base, &counter);
     rwlock->RWProcess[rwlock->RWIndex & 0xFF] = (LONG) get_running_process();
     rwlock->RWOp[rwlock->RWIndex & 0xFF] = event;
     rwlock->RWTarget[rwlock->RWIndex & 0xFF] = target;
     rwlock->RWType[rwlock->RWIndex & 0xFF] = type;
     rwlock->RWTime[rwlock->RWIndex & 0xFF] = (LONG) base;
     rwlock->RWIndex++;

}

#endif

LONG rwlock_read_lock(rwlock_t *rwlock)
{
    register PROCESS *p = get_running_process();
    register LONG flags;

    if (rwlock->signature == RWLOCK_SIGNATURE ||
	rwlock->signature == LRWLOCK_SIGNATURE)
    {
       flags = get_flags();
       spin_lock(&rwlock->mutex);
       p->syncFlag = 0;
       switch (rwlock->flags)
       {
	  case WRITER_OWNED:
#if RWLOCK_TRACE
	     RW_TRACE(rwlock, READER_SLEEP, (LONG) p, RREAD_LOCK);
#endif
	     spin_lock(&p->threadMutex);    // lock current thread
	     put_rwlock_process(rwlock, p);
	     p->stackPointer = 0;
	     p->threadState = PS_SLEEP;
	     p->syncObject = rwlock;
	     p->syncState = PROCESS_READER_BLOCKED_SYNC;
	     spin_unlock(&rwlock->mutex);
	     thread_switch();               // context switch will unlock thread
	     cli();
	     set_flags(flags);
	     return p->syncFlag;

	  case READER_OWNED:
	     if (rwlock->writers)
	     {
#if RWLOCK_TRACE
		RW_TRACE(rwlock, READER_SLEEP, (LONG) p, RREAD_LOCK);
#endif
		spin_lock(&p->threadMutex);    // lock current thread
		put_rwlock_process(rwlock, p);
		p->stackPointer = 0;
		p->threadState = PS_SLEEP;
		p->syncObject = rwlock;
		p->syncState = PROCESS_READER_BLOCKED_SYNC;
		spin_unlock(&rwlock->mutex);
		thread_switch();               // context switch will unlock thread
		cli();
		set_flags(flags);
		return p->syncFlag;
	     }

#if RWLOCK_TRACE
	     RW_TRACE(rwlock, READER_LOCK, 0, RREAD_LOCK);
#endif
	     rwlock->flags = (LONG) READER_OWNED;
	     rwlock->readers++;          // set reader count
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return p->syncFlag;

	  case UNOWNED:
#if RWLOCK_TRACE
	     RW_TRACE(rwlock, READER_LOCK, 0, RREAD_LOCK);
#endif
	     rwlock->flags = (LONG) READER_OWNED;
	     rwlock->readers++;          // set reader count
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return p->syncFlag;

	  default:
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return -1;
       }
    }
    return -1;

}

LONG rwlock_write_lock(rwlock_t *rwlock)
{
    register PROCESS *p = get_running_process();
    register LONG flags;

    if (rwlock->signature == RWLOCK_SIGNATURE ||
	rwlock->signature == LRWLOCK_SIGNATURE)
    {
       flags = get_flags();
       spin_lock(&rwlock->mutex);
       p->syncFlag = 0;
       switch (rwlock->flags)
       {
	  case READER_OWNED:
	  case WRITER_OWNED:
#if RWLOCK_TRACE
	     RW_TRACE(rwlock, WRITER_SLEEP, (LONG) p, WWRITE_LOCK);
#endif
	     spin_lock(&p->threadMutex);    // lock current thread
	     put_rwlock_process(rwlock, p);
	     rwlock->writers++;
	     p->stackPointer = 0;
	     p->threadState = PS_SLEEP;
	     p->syncObject = rwlock;
	     p->syncState = PROCESS_WRITER_BLOCKED_SYNC;
	     spin_unlock(&rwlock->mutex);
	     thread_switch();               // context switch will unlock thread
	     cli();
	     set_flags(flags);
	     return p->syncFlag;

	  case UNOWNED:
#if RWLOCK_TRACE
	     RW_TRACE(rwlock, WRITER_LOCK, 0, WWRITE_LOCK);
#endif
	     rwlock->flags = (LONG) WRITER_OWNED;
	     rwlock->owner = (LONG) p;
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return p->syncFlag;

	  default:
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return -1;
       }
    }
    return -1;

}

LONG rwlock_read_try_lock(rwlock_t *rwlock)
{
    register PROCESS *p = get_running_process();
    register LONG flags;

    if (rwlock->signature == RWLOCK_SIGNATURE ||
	rwlock->signature == LRWLOCK_SIGNATURE)
    {
       flags = get_flags();
       spin_lock(&rwlock->mutex);
       p->syncFlag = 0;
       switch (rwlock->flags)
       {
	  case WRITER_OWNED:
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return 1;

	  case READER_OWNED:
	     if (rwlock->writers)
	     {
		spin_unlock(&rwlock->mutex);
		set_flags(flags);
		return 1;
	     }
#if RWLOCK_TRACE
	     RW_TRACE(rwlock, READER_LOCK, 0, RREAD_TRY_LOCK);
#endif
	     rwlock->flags = (LONG) READER_OWNED;
	     rwlock->readers++;          // set reader count
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return p->syncFlag;

	  case UNOWNED:
#if RWLOCK_TRACE
	     RW_TRACE(rwlock, READER_LOCK, 0, RREAD_TRY_LOCK);
#endif
	     rwlock->flags = (LONG) READER_OWNED;
	     rwlock->readers++;          // set reader count
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return p->syncFlag;

	  default:
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return -1;
       }
    }
    return -1;

}

LONG rwlock_write_try_lock(rwlock_t *rwlock)
{
    register PROCESS *p = get_running_process();
    register LONG flags;

    if (rwlock->signature == RWLOCK_SIGNATURE ||
	rwlock->signature == LRWLOCK_SIGNATURE)
    {
       flags = get_flags();
       spin_lock(&rwlock->mutex);
       p->syncFlag = 0;
       switch (rwlock->flags)
       {
	  case READER_OWNED:
	  case WRITER_OWNED:
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return 1;

	  case UNOWNED:
#if RWLOCK_TRACE
	     RW_TRACE(rwlock, WRITER_LOCK, 0, WWRITE_TRY_LOCK);
#endif
	     rwlock->flags = (LONG) WRITER_OWNED;
	     rwlock->owner = (LONG) p;
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return p->syncFlag;

	  default:
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return -1;
       }
    }
    return -1;

}

LONG rwlock_read_unlock(rwlock_t *rwlock)
{
    register PROCESS *p;
    register LONG flags;

    if (rwlock->signature == RWLOCK_SIGNATURE ||
	rwlock->signature == LRWLOCK_SIGNATURE)
    {
       flags = get_flags();
       spin_lock(&rwlock->mutex);
       switch (rwlock->flags)
       {
	  case WRITER_OWNED:
	     panic("rwlock_read_unlock called with writer owning rwlock");
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return -1;

	  case READER_OWNED:
	     if (rwlock->readers)
		rwlock->readers--;

#if RWLOCK_TRACE
	     RW_TRACE(rwlock, READER_UNLOCK, 0, RREAD_UNLOCK);
#endif
	     if (!rwlock->readers)
	     {
		rwlock->flags = UNOWNED;
		if (rwlock->head)
		{
		   p = rwlock->head;
		   if (p->syncState != PROCESS_WRITER_BLOCKED_SYNC)
		   {
		      panic("rwlock_read_unlock called with sleeping READER");
		      spin_unlock(&rwlock->mutex);
		      set_flags(flags);
		      return -1;
		   }

		   p = get_rwlock_process(rwlock);
		   rwlock->writers--;
		   spin_lock(&p->threadMutex);     // lock thread
		   if (p->threadState == PS_SLEEP)
		   {
#if RWLOCK_TRACE
		      RW_TRACE(rwlock, WRITER_WAKE, (LONG) p, RREAD_UNLOCK);
#endif
		      p->threadState = PS_ACTIVE;
		      p->syncObject = 0;
		      p->syncState = 0;
		      p->syncFlag = 0;
		      (!p->processorBinding)
		      ? put_dispatch(p)
		      : put_bind_pset(p, (PROCESSOR_SET *)p->processorBinding);
#if RWLOCK_TRACE
		      RW_TRACE(rwlock, WRITER_LOCK, 0, RREAD_UNLOCK);
#endif
		      rwlock->flags = WRITER_OWNED;
		      rwlock->owner = (LONG) p;
		   }
		   spin_unlock(&p->threadMutex);   // unlock thread
		}
	     }
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return 0;

	  case UNOWNED:
	  default:
	     panic("rwlock_read_unlock called in inconsistent state");
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return -1;
       }
    }
    return -1;
}

LONG rwlock_write_unlock(rwlock_t *rwlock)
{
    register PROCESS *p, *curr;
    register LONG flags;

    if (rwlock->signature == RWLOCK_SIGNATURE ||
	rwlock->signature == LRWLOCK_SIGNATURE)
    {
       flags = get_flags();
       spin_lock(&rwlock->mutex);

       curr = get_running_process();
       if (rwlock->owner != (LONG) curr)
       {
	  panic("rwlock_write_unlock called by process other than owner");
	  spin_unlock(&rwlock->mutex);
	  set_flags(flags);
	  return -1;
       }

       switch (rwlock->flags)
       {
	  case WRITER_OWNED:
#if RWLOCK_TRACE
	     RW_TRACE(rwlock, WRITER_UNLOCK, 0, WWRITE_UNLOCK);
#endif
	     rwlock->owner = 0;
	     rwlock->flags = UNOWNED;
	     if (rwlock->head)
	     {
		p = rwlock->head;
		if (p->syncState == PROCESS_WRITER_BLOCKED_SYNC)
		{
		   p = get_rwlock_process(rwlock);
		   rwlock->writers--;
		   spin_lock(&p->threadMutex);     // lock thread
		   if (p->threadState == PS_SLEEP)
		   {
#if RWLOCK_TRACE
		      RW_TRACE(rwlock, WRITER_WAKE, (LONG) p, WWRITE_UNLOCK);
#endif
		      p->threadState = PS_ACTIVE;
		      p->syncObject = 0;
		      p->syncState = 0;
		      p->syncFlag = 0;
		      (!p->processorBinding)
		      ? put_dispatch(p)
		      : put_bind_pset(p, (PROCESSOR_SET *)p->processorBinding);
#if RWLOCK_TRACE
		      RW_TRACE(rwlock, WRITER_LOCK, 0, WWRITE_UNLOCK);
#endif
		      rwlock->flags = WRITER_OWNED;
		      rwlock->owner = (LONG) p;
		   }
		   spin_unlock(&p->threadMutex);   // unlock thread
		   spin_unlock(&rwlock->mutex);
		   set_flags(flags);
		   return 0;
		}

		while (rwlock->head)
		{
		   p = rwlock->head;
		   if (p->syncState == PROCESS_WRITER_BLOCKED_SYNC)
		      break;

		   p = get_rwlock_process(rwlock);
		   spin_lock(&p->threadMutex);     // lock thread
		   if (p->threadState == PS_SLEEP)
		   {
#if RWLOCK_TRACE
		      RW_TRACE(rwlock, READER_WAKE, (LONG) p, WWRITE_UNLOCK);
#endif
		      p->threadState = PS_ACTIVE;
		      p->syncObject = 0;
		      p->syncState = 0;
		      p->syncFlag = 0;
		      (!p->processorBinding)
		      ? put_dispatch(p)
		      : put_bind_pset(p, (PROCESSOR_SET *)p->processorBinding);
#if RWLOCK_TRACE
		      RW_TRACE(rwlock, READER_LOCK, 0, WWRITE_UNLOCK);
#endif
		      rwlock->flags = READER_OWNED;
		      rwlock->readers++;
		      rwlock->owner = 0;                           		}
		   }
		   spin_unlock(&p->threadMutex);   // unlock thread

	     }
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return 0;

	  case READER_OWNED:
	     panic("rwlock_write_unlock called with reader owning rwlock");
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return -1;

	  case UNOWNED:
	  default:
	     panic("rwlock_write_unlock called in inconsistent state");
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return -1;
       }
    }
    return -1;
}


LONG rwlock_reader_to_writer(rwlock_t *rwlock)
{
    register PROCESS *p;
    register LONG flags;

    if (rwlock->signature == RWLOCK_SIGNATURE ||
	rwlock->signature == LRWLOCK_SIGNATURE)
    {
       flags = get_flags();
       spin_lock(&rwlock->mutex);
       switch (rwlock->flags)
       {
	  case WRITER_OWNED:
	     panic("rwlock_reader_to_writer called with writer owning rwlock");
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return -1;

	  case READER_OWNED:
	     if (rwlock->readers)
		rwlock->readers--;

#if RWLOCK_TRACE
	     RW_TRACE(rwlock, READER_UNLOCK, 0, RREAD_UNLOCK);
#endif
	     if (!rwlock->readers)
	     {
		rwlock->flags = UNOWNED;
		if (rwlock->head)
		{
		   p = rwlock->head;
		   if (p->syncState != PROCESS_WRITER_BLOCKED_SYNC)
		   {
		      panic("rwlock_read_unlock called with sleeping READER");
		      spin_unlock(&rwlock->mutex);
		      set_flags(flags);
		      return -1;
		   }

		   p = get_rwlock_process(rwlock);
		   rwlock->writers--;
		   spin_lock(&p->threadMutex);     // lock thread
		   if (p->threadState == PS_SLEEP)
		   {
#if RWLOCK_TRACE
		      RW_TRACE(rwlock, WRITER_WAKE, (LONG) p, RREAD_UNLOCK);
#endif
		      p->threadState = PS_ACTIVE;
		      p->syncObject = 0;
		      p->syncState = 0;
		      p->syncFlag = 0;
		      (!p->processorBinding)
		      ? put_dispatch(p)
		      : put_bind_pset(p, (PROCESSOR_SET *)p->processorBinding);
#if RWLOCK_TRACE
		      RW_TRACE(rwlock, WRITER_LOCK, 0, RREAD_UNLOCK);
#endif
		      rwlock->flags = WRITER_OWNED;
		      rwlock->owner = (LONG) p;
		   }
		   spin_unlock(&p->threadMutex);   // unlock thread
		}
	     }
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return 0;

	  case UNOWNED:
	  default:
	     panic("rwlock_reader_to_writer called in inconsistent state");
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return -1;
       }
    }
    return -1;
}

LONG rwlock_reader_to_writer_unordered(rwlock_t *rwlock)
{
    register PROCESS *p;
    register LONG flags;

    if (rwlock->signature == RWLOCK_SIGNATURE ||
	rwlock->signature == LRWLOCK_SIGNATURE)
    {
       flags = get_flags();
       spin_lock(&rwlock->mutex);
       switch (rwlock->flags)
       {
	  case WRITER_OWNED:
	     panic("rwlock_reader_to_writer_unordered called with writer owning rwlock");
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return -1;

	  case READER_OWNED:
	     if (rwlock->readers)
		rwlock->readers--;

#if RWLOCK_TRACE
	     RW_TRACE(rwlock, READER_UNLOCK, 0, RREAD_UNLOCK);
#endif
	     if (!rwlock->readers)
	     {
		rwlock->flags = UNOWNED;
		if (rwlock->head)
		{
		   p = rwlock->head;
		   if (p->syncState != PROCESS_WRITER_BLOCKED_SYNC)
		   {
		      panic("rwlock_read_unlock called with sleeping READER");
		      spin_unlock(&rwlock->mutex);
		      set_flags(flags);
		      return -1;
		   }

		   p = get_rwlock_process(rwlock);
		   rwlock->writers--;
		   spin_lock(&p->threadMutex);     // lock thread
		   if (p->threadState == PS_SLEEP)
		   {
#if RWLOCK_TRACE
		      RW_TRACE(rwlock, WRITER_WAKE, (LONG) p, RREAD_UNLOCK);
#endif
		      p->threadState = PS_ACTIVE;
		      p->syncObject = 0;
		      p->syncState = 0;
		      p->syncFlag = 0;
		      (!p->processorBinding)
		      ? put_dispatch(p)
		      : put_bind_pset(p, (PROCESSOR_SET *)p->processorBinding);
#if RWLOCK_TRACE
		      RW_TRACE(rwlock, WRITER_LOCK, 0, RREAD_UNLOCK);
#endif
		      rwlock->flags = WRITER_OWNED;
		      rwlock->owner = (LONG) p;
		   }
		   spin_unlock(&p->threadMutex);   // unlock thread
		}
	     }
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return 0;

	  case UNOWNED:
	  default:
	     panic("rwlock_reader_to_writer_unordered called in inconsistent state");
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return -1;
       }
    }
    return -1;
}

LONG rwlock_writer_to_reader(rwlock_t *rwlock)
{
    register PROCESS *p, *curr;
    register LONG flags;

    if (rwlock->signature == RWLOCK_SIGNATURE ||
	rwlock->signature == LRWLOCK_SIGNATURE)
    {
       flags = get_flags();
       spin_lock(&rwlock->mutex);

       curr = get_running_process();
       if (rwlock->owner != (LONG) curr)
       {
	  panic("rwlock_writer_to_reader called by process other than owner");
	  spin_unlock(&rwlock->mutex);
	  set_flags(flags);
	  return -1;
       }

       switch (rwlock->flags)
       {
	  case WRITER_OWNED:
#if RWLOCK_TRACE
	     RW_TRACE(rwlock, WRITER_UNLOCK, 0, WWRITE_UNLOCK);
#endif
	     rwlock->owner = 0;
	     rwlock->flags = UNOWNED;
	     if (rwlock->head)
	     {
		p = rwlock->head;
		if (p->syncState == PROCESS_WRITER_BLOCKED_SYNC)
		{
		   p = get_rwlock_process(rwlock);
		   rwlock->writers--;
		   spin_lock(&p->threadMutex);     // lock thread
		   if (p->threadState == PS_SLEEP)
		   {
#if RWLOCK_TRACE
		      RW_TRACE(rwlock, WRITER_WAKE, (LONG) p, WWRITE_UNLOCK);
#endif
		      p->threadState = PS_ACTIVE;
		      p->syncObject = 0;
		      p->syncState = 0;
		      p->syncFlag = 0;
		      (!p->processorBinding)
		      ? put_dispatch(p)
		      : put_bind_pset(p, (PROCESSOR_SET *)p->processorBinding);
#if RWLOCK_TRACE
		      RW_TRACE(rwlock, WRITER_LOCK, 0, WWRITE_UNLOCK);
#endif
		      rwlock->flags = WRITER_OWNED;
		      rwlock->owner = (LONG) p;
		   }
		   spin_unlock(&p->threadMutex);   // unlock thread
		   spin_unlock(&rwlock->mutex);
		   set_flags(flags);
		   return 0;
		}

		while (rwlock->head)
		{
		   p = rwlock->head;
		   if (p->syncState == PROCESS_WRITER_BLOCKED_SYNC)
		      break;

		   p = get_rwlock_process(rwlock);
		   spin_lock(&p->threadMutex);     // lock thread
		   if (p->threadState == PS_SLEEP)
		   {
#if RWLOCK_TRACE
		      RW_TRACE(rwlock, READER_WAKE, (LONG) p, WWRITE_UNLOCK);
#endif
		      p->threadState = PS_ACTIVE;
		      p->syncObject = 0;
		      p->syncState = 0;
		      p->syncFlag = 0;
		      (!p->processorBinding)
		      ? put_dispatch(p)
		      : put_bind_pset(p, (PROCESSOR_SET *)p->processorBinding);
#if RWLOCK_TRACE
		      RW_TRACE(rwlock, READER_LOCK, 0, WWRITE_UNLOCK);
#endif
		      rwlock->flags = READER_OWNED;
		      rwlock->readers++;
		      rwlock->owner = 0;                           		}
		   }
		   spin_unlock(&p->threadMutex);   // unlock thread

	     }
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return 0;

	  case READER_OWNED:
	     panic("rwlock_writer_to_reader called with reader owning rwlock");
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return -1;

	  case UNOWNED:
	  default:
	     panic("rwlock_writer_to_reader called in inconsistent state");
	     spin_unlock(&rwlock->mutex);
	     set_flags(flags);
	     return -1;
       }
    }
    return -1;
}


PROCESS *get_rwlock_process(rwlock_t *rwlock)
{

    register PROCESS *p, *list;

    if (rwlock->head)
    {
       p = rwlock->head;
       list = (PROCESS *) rwlock->head = (void *) p->syncNext;
       if (list)
	  list->syncPrior = NULL;
       else
	  rwlock->tail = NULL;
       return p;
    }
    return 0;

}

void put_rwlock_process(rwlock_t *rwlock, PROCESS *p)
{

    register PROCESS *search, *list;

    search = rwlock->head;
    while (search)
    {
       if (search == p)
	  return;
       search = search->syncNext;
    }

    if (!rwlock->head)
    {
       rwlock->head = rwlock->tail = p;
       p->syncNext = p->syncPrior = 0;
    }
    else
    {
       list = (PROCESS *) rwlock->tail;
       list->syncNext = p;
       p->syncNext = 0;
       p->syncPrior = rwlock->tail;
       rwlock->tail = p;
    }
    return;

}

LONG rwlock_release(rwlock_t *rwlock)
{
    register PROCESS *p, *list;
    register LONG flags;

    if (rwlock->signature == RWLOCK_SIGNATURE ||
	rwlock->signature == LRWLOCK_SIGNATURE)
    {
       flags = get_flags();
       spin_lock(&rwlock->mutex);

       p = rwlock->head;
       while (p)
       {
	  list = p->syncNext;
	  spin_lock(&p->threadMutex);     // lock thread
	  if (p->threadState == PS_SLEEP)
	  {
	     p->threadState = PS_ACTIVE;
	     p->syncObject = 0;
	     p->syncState = 0;
	     p->syncFlag = -2;
	     if (rwlock->waiters)
		rwlock->waiters--;
	     (!p->processorBinding)
	     ? put_dispatch(p)
	     : put_bind_pset(p, (PROCESSOR_SET *)p->processorBinding);
	  }
	  spin_unlock(&p->threadMutex);   // unlock thread
	  p = list;
       }

       rwlock->owner = 0;
       spin_unlock(&rwlock->mutex);
       set_flags(flags);
       return 0;
    }
    return -1;

}

--------------010102010807060008060704--
