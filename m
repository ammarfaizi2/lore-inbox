Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266567AbUFYIhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266567AbUFYIhi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 04:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265945AbUFYIhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 04:37:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:36996 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266567AbUFYIgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 04:36:37 -0400
Date: Fri, 25 Jun 2004 01:35:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.7-mm2, mmaps rework, buggy apps, setarch
Message-Id: <20040625013508.70e6d689.akpm@osdl.org>
In-Reply-To: <20040625082243.GA11515@gamma.logic.tuwien.ac.at>
References: <20040625082243.GA11515@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> wrote:
>
> Hi list, hi Andrew!
> 
> You wrote:
> > Added a patch from Ingo which reworks the placement of mmaps within the
> > ia32 virtual memory layout.  Has been in RH kernels for a long time.
> >
> >  If it breaks something, the app was already buggy.  You can use
> >
> >	setarch -L my-buggy-app <args>
> >
> > to run in back-compat mode.  This requires a setarch patch - see the
> > changelog in flexible-mmap-267-mm1-a0.patch for details.
> 
> Can someone please explain me *what* the effects of a `buggy app' would
> be: Segfault I suppose.

Yes, that would be one symptom.

> But what to do with a commerical app where I
> cannot check a stack trace or whatever?

Use strace -f, look at the last screenful of output.  That usually works.

> Background: I am having problems with current debian/sid on 2.6.7-mm2
> with vuescan.

Well I have suspicions about that patch too.  Mozilla crashing
occasionally, mplayer not working at all and quitting from X left the VGA
console all black with no sync.  This happened on two boots and hasn't
happened since I reverted the flexible-mmap patches.

Ingo's setarch patch wasn't a lot of use because it seems to be against a
setarch which doesn't exist.  I hacked one up.  Try

	setarch i386 your-program

(The below program _has_ to be called "setarch")


/* Copyright (C) 2003 Red Hat, Inc. */
/* Licensed under the terms of the GPL */
/* Written by Elliot Lee <sopwith@redhat.com> */
/* based on ideas from the ppc32 util by Guy Streeter (2002-01), based on the
   sparc32 util by Jakub Jelinek (1998, 1999) */

#include <syscall.h>
#include <linux/personality.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/utsname.h>

#define set_pers(pers) syscall(SYS_personality, pers)

int
set_arch(const char *pers)
{
  struct utsname un;
  int i;

  struct {
    int perval;
    char *target_arch, *result_arch;
  } transitions[] = {
#if defined(__powerpc__) || defined(__powerpc64__)
    {PER_LINUX32, "ppc32", "ppc"},
    {PER_LINUX32, "ppc", "ppc"},
    {PER_LINUX, "ppc64", "ppc64"},
    {PER_LINUX, "ppc64pseries", "ppc64"},
    {PER_LINUX, "ppc64iseries", "ppc64"},
#endif
#if defined(__x86_64__) || defined(__i386__) || defined(__ia64__)
    {PER_LINUX32, "i386", "i386"},
    {PER_LINUX32, "i486", "i386"},
    {PER_LINUX32, "i586", "i386"},
    {PER_LINUX32, "i686", "i386"},
    {PER_LINUX32, "athlon", "i386"},
#endif
#if defined(__x86_64__) || defined(__i386__)
    {PER_LINUX, "x86_64", "x86_64"},
#endif
#if defined(__ia64__) || defined(__i386__)
    {PER_LINUX, "ia64", "ia64"},
#endif
#if defined(__s390x__) || defined(__s390__)
    {PER_LINUX32, "s390", "s390"},
    {PER_LINUX, "s390x", "s390x"},
#endif
#if defined(__sparc64__) || defined(__sparc__)
    {PER_LINUX32, "sparc", "sparc"},
    {PER_LINUX, "sparc64", "sparc64"},
#endif
    {-1, NULL, NULL}
  };

  for(i = 0; transitions[i].perval >= 0; i++)
    {
      if(!strcmp(pers, transitions[i].target_arch))
	break;
    }

  if(transitions[i].perval < 0)
    {
      fprintf(stderr, "Don't know how to set arch to %s\n", pers);
      exit(1);
    }

  if(set_pers(transitions[i].perval | 0x0200000))
    return 1;

  printf("OK\n");

  uname(&un);
  if(strcmp(un.machine, transitions[i].result_arch))
    {
      if(strcmp(transitions[i].result_arch, "i386")
	 || (strcmp(un.machine, "i486")
	     && strcmp(un.machine, "i586")
	     && strcmp(un.machine, "i686")
	     && strcmp(un.machine, "athlon")))
	{
	  fprintf(stderr, "Don't know how to set arch to %s\n", pers);
	  exit(1);
	}
    }

  return 0;
}

int main(int argc, char *argv[])
{
  char *p = strrchr(argv[0], '/');

  p = p ? p + 1 : argv[0];

  if(argc <= 1) {
    fprintf(stderr, "Usage: %s %s program arguments\n",
	    p, !strcmp(p, "setarch")?"arch":"");
    return 1;
  }
  if(!strcmp(p, "setarch"))
    {
      argv++;
      argc--;
      p = argv[0];
    }

  if(set_arch(p))
    {
      perror(argv[0]);
      return 1;
    }

  if(argc < 2)
    {
      execl("/bin/sh", "-sh", NULL);
      return 1;
    }

  execvp(argv[1], argv+1);
  return 1;
}

