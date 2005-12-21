Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbVLURgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbVLURgN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 12:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbVLURgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 12:36:13 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:33382 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751145AbVLURgM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 12:36:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=H42ZghU/erjjR4e1dvoH+dUwNoKAjVzrTsKUvijxZkmtQDA4Mo+fxpRiNQxKKbdyr1VyxqzZ56AYFgjskHAGpF1Nhp4/3QJT4mRpfo3RTKHENvCYwS+zV7sdxV3zIjwu+XPKIkk51a5xCFFAum97Y0BBemQDTuUmwIfBLzkO+n4=
Message-ID: <6f48278f0512210936y25169c37t9fb7eb13fef3a97d@mail.gmail.com>
Date: Thu, 22 Dec 2005 01:36:10 +0800
From: Jie Zhang <jzhang918@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Question on the current behaviour of malloc () on Linux
Cc: lars.friedrich@wago.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I first asked this question on uClinux mailing list. My first question
is <http://mailman.uclinux.org/pipermail/uclinux-dev/2005-December/036042.html>.
Although I found this issue on uClinux, it's also can be demostrated
on Linux. This is a small program:

$> cat test2.c
#include <stdio.h>
#include <stdlib.h>

int
main ()
{
  char *p;
  int i, j;
  for (i = 0;; i++)
    {
      p = (char *) malloc (8 * 1024 * 1024);
      if (p)
        for (j = 0; j < 8 * 1024 * 1024; j++)
          p[j] = 0x55;
      else
        {
          printf ("%d fail\n", i);
          break;
        }
    }
  return 0;
}

When I run it on my Linux notebook, it will be killed. I expect to see
it prints out   "fail".

Thanks,
Jie


---------- Forwarded message ----------
From: Jie Zhang <jzhang918@gmail.com>
Date: Dec 22, 2005 1:10 AM
Subject: Re: [uClinux-dev] Question on the current behaviour of malloc
() onuClinux
To: uClinux development list <uclinux-dev@uclinux.org>


On 12/21/05, Friedrich, Lars <lars.friedrich@wago.com> wrote:
> > I traced this issue to __alloc_pages (). If there is not
> > enough free pages for allocation, it will call
> > try_to_free_pages () to reclaim page frames. If
> > try_to_free_pages () cannot help, which usually occurs when
> > run a fail-to-malloc application the second time, __alloc_pages
> > () will call out_of_memory (), which in turn will kill something.
> >
> > Can we make __alloc_pages () not call out_of_memory () if the
> > allocations request comes from malloc () and just return NULL?
>
> This is intended Linux behaviour. It is assumed that it is more
> important for you to run your new application than it is to
> keep an old application running. After all, if you wouldn't
> want that your new application runs, you wouldn't have started
> it in the first place.
>
> Imagine f.e. you can't call kill because there is not enough
> memory left and you can't free memory because kill can't be called.
>
> Despite this, it seems to be in accordance of SuSv3. Linux is able
> to allocate memory for the application. There is afaik no requirement
> how this has to be achieved. Anyway, requests to change this behaviour
> need to be posted on the Linux kernel mailing list.
>
Here is very small program

$> cat test.c
#include <stdio.h>
#include <stdlib.h>

int
main ()
{
  char *p;
  p = (char *) malloc (32 * 1024 * 1024);
  if (p)
    printf ("sucess\n");
  else
    printf ("fail\n");
  return 0;
}

When I run it on uClinux for Blackfin (BF533-STAMP board, which has
64MB SDRAM), The first invocation of it usually prints out "fail" as
expected. But the following invocations will be killed by kernel
because out of memory. The problem is  why the second and further runs
should be killed. (The first run is not because try_to_free_pages ()
did some progress.) In these failed malloc () cases, the 32MB memory
has not been allocated. So there is no such out-of-memory case which
will make kernel cannot kill. There is no difference on the memory
consumption between this program and a program which has only an empty
main () function. Why should it be killed?

It's true that Linux can allocate memory for application, but SuSv3
also says If the space cannot be allocated, a null pointer shall be
returned. But uClinux kills this application while there is plenty of
memory just because it cannot reclaim enough pages. It's very weird.
It would be better to nicely tell application that malloc () fails.

Thanks,
Jie
