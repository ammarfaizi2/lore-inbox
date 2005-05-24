Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVEXUcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVEXUcL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 16:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVEXUcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 16:32:11 -0400
Received: from ftp.ardi.com ([207.188.170.178]:17169 "EHLO www.ardi.com")
	by vger.kernel.org with ESMTP id S262040AbVEXUb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 16:31:57 -0400
From: "Clifford T. Matthews" <ctm@ardi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17043.36668.164277.860295@newbie.ardi.com>
Date: Tue, 24 May 2005 14:31:56 -0600
To: linux-kernel@vger.kernel.org
Cc: Cliff Matthews <ctm@ardi.com>
Subject: trouble trapping SEGV on 2.6.11.2 & 2.6.12-rc4
X-Mailer: VM 7.17 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The included program dies with a SEGV under 2.6.11.2 and 2.6.12-rc4.
It doesn't die under 2.4.25.  I compiled the kernels myself.  The
distribution is Fedora Core release 3, with glibc 2.3.5.

I don't have any earlier 2.6 kernels to test it on, so I have no idea
when this bug first appeared.

I only skim LKML through fa.linux.kernel, so please CC me on any reply
that I should see.

--Cliff Matthews <ctm@ardi.com>
+1 505 363 5754 Cell

#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#include <stdbool.h>
#include <assert.h>
#include <setjmp.h>
#include <signal.h>

static jmp_buf segv_return;

static void
segv_handler (int signum_ignored __attribute__((unused)))
{
  longjmp (segv_return, 1);
}

int
main (void)
{
  volatile char *volatile addr;
  volatile int n_failures;

  addr = (void *) 0x10000L;
  n_failures = 0;

  signal (SIGSEGV, segv_handler);
  if (setjmp (segv_return) != 0)
    ++n_failures;
  else
    *addr;

  printf ("n_failures = %d\n", n_failures);

  if (setjmp (segv_return) != 0)
    ++n_failures;
  else
    *addr;

  printf ("n_failures = %d\n", n_failures);

  return 0;
}
