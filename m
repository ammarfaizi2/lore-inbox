Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVETGMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVETGMs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 02:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVETGMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 02:12:48 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:8603 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261357AbVETGMW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 02:12:22 -0400
Date: Fri, 20 May 2005 08:12:20 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Christian Borntraeger <cborntra@de.ibm.com>
Subject: Running OOM and worse with broken signal handler
Message-ID: <20050520061125.GA12656@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

we experienced some interesting behaviour with an out of
memory condition caused by signal handling (on s390x).
The following program ran our system in an OOM situation
and couldn't be killed because the SIGKILL signal couldn't
be delivered.
Necessary for this to happen is that the stack size limit
is set to unlimited.

sig_handler(int sig)
{
  asm volatile(".long 0\n");
}

int main (int argc, char **argv)
{
  struct sigaction act;

  act.sa_handler = &sig_handler;
  act.sa_restorer = 0;
  act.sa_flags = SA_NOMASK | SA_RESTART;

  sigaction(SIGILL, &act, 0);
  sigaction(SIGSEGV, &act, 0);

  asm volatile(".long 0\n");
}

The instruction in the asm block is suppossed to be an
illegal opcode which enforces a SIGILL.
When executed the following happens:
The illegal instruction causes a SIGILL to be delivered to
the process. Since the signal handler itself contains an
illegal instruction this causes another SIGILL to
be delivered, thus causing the stack to grow unlimited.
When we are finally out of memory the OOM killer selects
our process and sends it a SIGKILL.
Only problem in this scenario is that the SIGKILL never
will be sent to our process simply because there is
always a SIGILL pending too, which will be handled before
the SIGKILL because of its lower number (see next_signal()
in kernel/signal.c).
The only possibly way this signal would be handled would
be that the process is running in userspace while trying
to handle the delivered SIGILL, where it would be interrupted
by an interrupt and upon return to userspace do_signal()
would be called again. This is unfortunately very unlikely
if you are running a nearly timer interrupt free kernel
like we do on s390/s390x.
Since the OOM killer set the TIF_MEMDIE flag for our
process it now is allowed to eat up all the memory left
and our system is more or less dead until you're lucky
and an interrupt hits at the right time and finally
causing the process to be terminated...

Maybe the OOM killer or signal handling would need
a change to fix this?

Thanks,
Heiko
