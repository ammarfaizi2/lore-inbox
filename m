Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVANGfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVANGfu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 01:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVANGft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 01:35:49 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:53519 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261158AbVANGfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 01:35:37 -0500
Date: Fri, 14 Jan 2005 07:25:26 +0100
From: Willy Tarreau <willy@w.ods.org>
To: linux-kernel@vger.kernel.org
Subject: Re: propolice support for linux
Message-ID: <20050114062526.GK7048@alpha.home.local>
References: <20050113134620.GA14127@boetes.org> <a36005b5050113131179d932eb@mail.gmail.com> <20050113225244.GH14127@boetes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113225244.GH14127@boetes.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 13, 2005 at 11:52:22PM +0100, Han Boetes wrote:
> 1) Where an application compiled with PP is working worse or even
>    failing where it would work right without PP.

No idea on this one, I never tried PP, although I know how it basically
works since I worked on a similar concept in 97 of last century (but I
didn't have the skills to touch the compiler and still don't).

> 2) Where a bufferoverflow can be exploited even though the
>    application is compiled with PP.

1) any broken function of this kind :

int create_temp_dir(struct task *t, char *dir) {
   int err;
   int can_unlink;
   char dirname[MAXPATHLEN];

   can_unlink = (task->euid == 0);
   strncpy(dirname, dir, MAXPATHLEN);
   strcat(dirname, "/tmp");
   dirname[MAXPATHLEN] = '\0';

   if (err = mkdir(dirname, 0755)) {
      if (can_unlink) {
         unlink(dirname);
         err = mkdir(dirname, 0755);
      }
   }
   return err;
}

Get it ? Just pass any name of MAXPATHLEN length, and get
any existing file removed and replace with an empty directory.
Useful for hosts.deny, /var/log/messages, init scripts, etc...

2) all heap overflows (but not in kernel AFAIK).

I think you have a misconception about what a buffer overflow is. First,
propolice will be usable only against some *stack* overflows (which I agree
are the most common in userspace). But regular buffer overflows like above,
which can be triggered either in the stack on in the data space, are not
stopped. And heap overflows such as the double free bug in zlib will not
be prevented by propolice either.

> As an example where PP does work right the test-code provided by
> the propolice maintainer:
> 
>     /* test-propolice.c */
>     #define OVERFLOW "This is longer than 10 bytes"
>     #include <string.h>
>     int main (int argc, char *argv[]) {
>         char buffer[10];
>         strcpy(buffer, OVERFLOW);
>         return 0;
>     }
> 

This is kind, but this is also the easiest buggy program to write. The one
we all use when trying to write shell code. But this is far away from real
life, there often are other constraints.

Like others, I think that PP is close to useless in the kernel, but since
the patch is little and does not break anything, why not include it to let
people try it and return feedback ?

Regards,
Willy

