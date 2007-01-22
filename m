Return-Path: <linux-kernel-owner+w=401wt.eu-S1751087AbXAVJ03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbXAVJ03 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 04:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbXAVJ03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 04:26:29 -0500
Received: from gw.exalead.com ([193.47.80.25]:14812 "EHLO exalead.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751087AbXAVJ02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 04:26:28 -0500
X-Greylist: delayed 1754 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jan 2007 04:26:28 EST
Message-ID: <45B47C68.2000903@exalead.com>
Date: Mon, 22 Jan 2007 09:57:12 +0100
From: Xavier Roche <roche+kml2@exalead.com>
Organization: Exalead
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1b2) Gecko/20060821 SeaMonkey/1.1a
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sigaction's ucontext_t with incorrect stack reference when SA_SIGINFO
 is being used ?
Content-Type: multipart/mixed;
 boundary="------------070005040304070505060800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070005040304070505060800
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi folks,

I have a probably louzy question regarding sigaction() behaviour when an
alternate signal stack is used: it seems that I can not get the user
stack reference in the ucontext_t stack context ; ie. the uc_stack
member contains reference of the alternate signal stack, not the stack
that was used before the crash.

Is this is a normal behaviour ? Is there a way to retrieve the original
user's stack inside the signal callback ?

The example given below demonstrates the issue:
top of stack==0x7fffff3d7000, alternative_stack==0x501010
SEGV==0x7fffff3d6ff8; sp==0x501010; current stack is the alternate stack

It is obvious that the SEGV was a stack overflow: the si_addr address is
just on the page below the stack limit.

--------------070005040304070505060800
Content-Type: text/x-csrc;
 name="stacktest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stacktest.c"

/* gcc -g [ -D_REENTRANT ] stacktest.c [ -lpthread ] -o stacktest */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/resource.h>
#include <sys/ucontext.h>

#ifdef _REENTRANT
#include <pthread.h>
#endif

/* the alternative stack reference */
static stack_t ss;

/* this function does nasty things */
static void overflow(void) { overflow(); }

/* test entry point */
static void* threadEntry(void* parg) {
  struct rlimit rlim;
  /* setup alternative strack for the current thread */
  ss.ss_flags = 0;
  ss.ss_size = SIGSTKSZ;
  ss.ss_sp = malloc(ss.ss_size);
  if (ss.ss_sp == NULL) {
    abort();
  }
  if (sigaltstack(&ss, NULL) == -1) {
    abort();
  }
  /* print current stack limit */
  if (getrlimit(RLIMIT_STACK, &rlim) == 0) {
    const unsigned long page_size = (unsigned long) sysconf(_SC_PAGE_SIZE);
    const unsigned long stack_bottom =
      (((unsigned long)&rlim-rlim.rlim_cur+page_size-1)/page_size)*page_size;
    printf("bottom of stack==%p, alternative_stack==%p\n", (void*)stack_bottom,
           (void*)ss.ss_sp);
  }
  /* do something very nasty */
  overflow();
  /* we may not reach this point */
  return NULL;
}

/* SEGV handler */
static void saHandler(int code, siginfo_t *si, void *sc_) {
  void *kenny = (void*) &code;
  ucontext_t * const sc = (ucontext_t*) sc_;
  printf("SEGV==%p; sp==%p; current stack is the %s\n", (void*)si->si_addr,
         (void*)((ucontext_t*)sc_)->uc_stack.ss_sp,
         ( kenny >= ss.ss_sp && kenny < ss.ss_sp + SIGSTKSZ )
         ? "alternate stack" : "original stack");
  abort();
}

/* main entry point */
int main(void) {
  /* catch SEGV with SA_ONSTACK enabled */
  struct sigaction s;
  memset(&s, 0, sizeof(s));
  sigemptyset(&s.sa_mask);
  s.sa_flags = SA_SIGINFO | SA_ONSTACK;
  s.sa_sigaction = saHandler;
  if(sigaction (SIGSEGV, &s, NULL)) {
    abort();
  }

#ifdef _REENTRANT
  /* threaded version */
  {
    pthread_t t;
    pthread_create(&t, NULL, threadEntry, NULL);
    pause();  /* wait (almost) endlessly */
  }
#else
  /* single threaded version */
  (void) threadEntry(NULL);
#endif

  /* not reached */
  abort();
  return 0;
}

--------------070005040304070505060800--
