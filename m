Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281841AbRKRC13>; Sat, 17 Nov 2001 21:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281842AbRKRC1T>; Sat, 17 Nov 2001 21:27:19 -0500
Received: from [208.129.208.52] ([208.129.208.52]:12804 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S281841AbRKRC1L>;
	Sat, 17 Nov 2001 21:27:11 -0500
Date: Sat, 17 Nov 2001 18:36:27 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: David Sanchez <dsanchez@veloxia.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Possible bug; latest kernels with LinuxThreads
In-Reply-To: <5.1.0.14.2.20011118025147.035feb08@pop.veloxia.com>
Message-ID: <Pine.LNX.4.40.0111171834100.1011-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2001, David Sanchez wrote:

> #0 0x40053f0f in __pthread_create_2_1 (thread=0x40244fc4, attr=0x40244fc8,
> start_routine=0x804ae20 <gMantThread(void *)>, arg=0x40244fc4) at pthread.c:488

In that case a look at the code always helps :


int __pthread_create_2_1(pthread_t *thread, const pthread_attr_t *attr,
             void * (*start_routine)(void *), void *arg)
{
  pthread_descr self = thread_self();
  struct pthread_request request;
  if (__pthread_manager_request < 0) {
    if (__pthread_initialize_manager() < 0) return EAGAIN;
  }
  request.req_thread = self;
  request.req_kind = REQ_CREATE;
  request.req_args.create.attr = attr;
  request.req_args.create.fn = start_routine;
  request.req_args.create.arg = arg;
  sigprocmask(SIG_SETMASK, (const sigset_t *) NULL,
              &request.req_args.create.mask);
  __libc_write(__pthread_manager_request, (char *) &request,
	sizeof(request));
  suspend(self);
  if (THREAD_GETMEM(self, p_retcode) == 0)

>>>>    *thread = (pthread_t) THREAD_GETMEM(self, p_retval);

  return THREAD_GETMEM(self, p_retcode);
}

The line marked >>>> is line 488 in pthread.c , are you plain sure that
you're not passing a NULL thread id ptr ?





- Davide


