Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276639AbRJQNY4>; Wed, 17 Oct 2001 09:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276642AbRJQNYq>; Wed, 17 Oct 2001 09:24:46 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:59911 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S276639AbRJQNYm>;
	Wed, 17 Oct 2001 09:24:42 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@linuxia64.org
Subject: console_loglevel is broken on ia64
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Oct 2001 23:25:02 +1000
Message-ID: <2784.1003325102@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/printk.c has this abomination.

/* Keep together for sysctl support */
int console_loglevel = DEFAULT_CONSOLE_LOGLEVEL;
int default_message_loglevel = DEFAULT_MESSAGE_LOGLEVEL;
int minimum_console_loglevel = MINIMUM_CONSOLE_LOGLEVEL;
int default_console_loglevel = DEFAULT_CONSOLE_LOGLEVEL;

sysctl assumes that the 4 variables occupy contiguous storage.  They
don't on ia64, console_loglevel is separate from the other variables.

  echo 6 4 1 7 > /proc/sys/kernel/printk
  
on ia64 overwrites console_loglevel and the next 3 integers, whatever
they happen to be.  On 2.4.12 it corrupts console_sem, other ia64
kernels will corrupt different data.

Does anybody fancy a small project to clean up these variables?  They
need to become an integer array (say console_printk) containing 4
elements, which is what sysctl assumes.  All references to these fields
have to be changed to refer to the corresponding array element.  That
should be as simple as

  #define console_loglevel (console_printk[0])
  
in kernel.h, as long as no other files declare console_loglevel or the
other variables.  Alas at least two other files declare console_loglevel,
they need to be fixed to use the common declaration.  I have not
checked the other console_xxx variables for extra declarations.

  arch/parisc/kernel/traps.c:   extern int console_loglevel;
  arch/i386/mm/fault.c:extern int console_loglevel;

