Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129774AbQL1M2N>; Thu, 28 Dec 2000 07:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130109AbQL1M2D>; Thu, 28 Dec 2000 07:28:03 -0500
Received: from ppp-97-167-an04u-dada6.iunet.it ([151.35.97.167]:6149 "HELO
	home.bogus") by vger.kernel.org with SMTP id <S129774AbQL1M1u>;
	Thu, 28 Dec 2000 07:27:50 -0500
From: Davide Libenzi <davidel@xmail.virusscreen.com>
To: R.E.Wolff@BitWizard.nl (Rogier Wolff), linux-kernel@vger.kernel.org
Subject: Re: Semaphores slow???
Date: Thu, 28 Dec 2000 13:27:54 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <200012271415.PAA18730@cave.bitwizard.nl>
In-Reply-To: <200012271415.PAA18730@cave.bitwizard.nl>
MIME-Version: 1.0
Message-Id: <00122814171703.00232@linux1.home.bogus>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Dec 2000, Rogier Wolff wrote:
> Hi,
> 
> We have a typical semaphore application that has a producer and a
> consumer.
> 
> Without the semaphores we are limited by the rest of the stuff to
> 10000 times around the loop per second. That's good.
> 
> When we put the "push the semaphore" call in there, the rate drops to
> around 8000 per second. I'm not happy about that, but ok. When we add
> the "wait for bufferspace" semaphore wait in there, the rate drops to
> 4000 per second. This is way too low.

This sound weird to me.
I think that linux semaphores ( not SysV IPC ) are quite fast instead.
They're based on fast spinlocks and linux scheduling ( no need of predefined
scheduling points ) code.


> 
> Does anybody have an idea why linux semaphores are so slow?
> 
> init: 
> 	sem_init (&write_sem, 1, 0);
> 	sem_init (&write_buffer_sem, 1, 0);
> 
> 
> 
> producer: 
> 
> 	
> 	while (1) {
>                 sem_wait (&write_buffer_sem);
> 		... 
> 
>                 sem_post (&write_sem);
>         }
> 
> 
> consumer: 
> 	for (i=0;i<nbufs;i++) {
> 		Create_buffer (i);
> 		sem_post (&write_buffer_sem);
>         }
> 
> 	while (1) {
>                 sem_wait (&write_sem);
> 		... 
> 
>                 sem_post (&write_buffer_sem);
> 	}
> 

Which kind of syncronization have You used to get 10000 loops/sec ?



> (pshared == 0 doesn't work: returns error. The manpage claims that
> thsi would happen for pshared != 0... )

Which glibc version are You using ?
This is the code for sem_init() ( 2.1.3 ) :

int __new_sem_init(sem_t *sem, int pshared, unsigned int value)
{
  if (value > SEM_VALUE_MAX) {
    errno = EINVAL;
    return -1;
  }
  if (pshared) {
    errno = ENOSYS;
    return -1;
  }
  __pthread_init_lock((struct _pthread_fastlock *) &sem->__sem_lock);
  sem->__sem_value = value;
  sem->__sem_waiting = NULL;
  return 0;
}


Are You sure You're not using a pthread emulation of GNU Pth library ?




- Davide

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
