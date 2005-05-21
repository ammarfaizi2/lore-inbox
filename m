Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVEUHeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVEUHeX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 03:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVEUHeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 03:34:22 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:47538 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261694AbVEUHeH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 03:34:07 -0400
In-Reply-To: <428DFA8D.6060204@sw.ru>
To: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>
Cc: Christian Borntraeger <cborntra@de.ibm.com>, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
MIME-Version: 1.0
Subject: Re: Running OOM and worse with broken signal handler
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF65FF28C6.9C7B30EE-ONC1257008.0029505D-C1257008.00297392@de.ibm.com>
From: Heiko Carstens <Heiko.Carstens@de.ibm.com>
Date: Sat, 21 May 2005 09:34:01 +0200
X-MIMETrack: S/MIME Sign by Notes Client on Heiko Carstens/Germany/IBM(Release 6.0.2CF1|June
 9, 2003) at 21.05.2005 09:32:45,
	Serialize by Notes Client on Heiko Carstens/Germany/IBM(Release 6.0.2CF1|June
 9, 2003) at 21.05.2005 09:32:45,
	Serialize complete at 21.05.2005 09:32:45,
	S/MIME Sign failed at 21.05.2005 09:32:45: The cryptographic key was not
 found,
	Serialize by Router on D12ML064/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 21/05/2005 09:34:05,
	Serialize complete at 21/05/2005 09:34:05
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

your patch fixes this issue. Thanks!
Andrew, any chances to get this merged?

Heiko

> Can you test this patch, please?
> 
> Alexey Kuznetsov discovered long ago that SIGKILL is low priority than 
> signalls 1-8, so it can be delivered very long... But we didn't 
> succedded to reproduce this in real life, looks like you did it :)
> 
> Kirill
> 
> > Hi all,
> > 
> > we experienced some interesting behaviour with an out of
> > memory condition caused by signal handling (on s390x).
> > The following program ran our system in an OOM situation
> > and couldn't be killed because the SIGKILL signal couldn't
> > be delivered.
> > Necessary for this to happen is that the stack size limit
> > is set to unlimited.
> > 
> > sig_handler(int sig)
> > {
> >   asm volatile(".long 0\n");
> > }
> > 
> > int main (int argc, char **argv)
> > {
> >   struct sigaction act;
> > 
> >   act.sa_handler = &sig_handler;
> >   act.sa_restorer = 0;
> >   act.sa_flags = SA_NOMASK | SA_RESTART;
> > 
> >   sigaction(SIGILL, &act, 0);
> >   sigaction(SIGSEGV, &act, 0);
> > 
> >   asm volatile(".long 0\n");
> > }
> > 
> > The instruction in the asm block is suppossed to be an
> > illegal opcode which enforces a SIGILL.
> > When executed the following happens:
> > The illegal instruction causes a SIGILL to be delivered to
> > the process. Since the signal handler itself contains an
> > illegal instruction this causes another SIGILL to
> > be delivered, thus causing the stack to grow unlimited.
> > When we are finally out of memory the OOM killer selects
> > our process and sends it a SIGKILL.
> > Only problem in this scenario is that the SIGKILL never
> > will be sent to our process simply because there is
> > always a SIGILL pending too, which will be handled before
> > the SIGKILL because of its lower number (see next_signal()
> > in kernel/signal.c).
> > The only possibly way this signal would be handled would
> > be that the process is running in userspace while trying
> > to handle the delivered SIGILL, where it would be interrupted
> > by an interrupt and upon return to userspace do_signal()
> > would be called again. This is unfortunately very unlikely
> > if you are running a nearly timer interrupt free kernel
> > like we do on s390/s390x.
> > Since the OOM killer set the TIF_MEMDIE flag for our
> > process it now is allowed to eat up all the memory left
> > and our system is more or less dead until you're lucky
> > and an interrupt hits at the right time and finally
> > causing the process to be terminated...
> > 
> > Maybe the OOM killer or signal handling would need
> > a change to fix this?
> > 
> > Thanks,
> > Heiko
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> diff -ur orig/linux-2.6.8.1/kernel/signal.c 
linux-2.6.8.1/kernel/signal.c
> --- orig/linux-2.6.8.1/kernel/signal.c   2005-05-12 02:44:12.000000000 
+0400
> +++ linux-2.6.8.1/kernel/signal.c   2005-05-13 12:07:04.000000000 +0400
> @@ -519,7 +520,16 @@
>  {
>     int sig = 0;
> 
> -   sig = next_signal(pending, mask);
> +   /* SIGKILL must have priority, otherwise it is quite easy
> +    * to create an unkillable process, sending sig < SIGKILL
> +    * to self */
> +   if (unlikely(sigismember(&pending->signal, SIGKILL))) {
> +      if (!sigismember(mask, SIGKILL))
> +         sig = SIGKILL;
> +   }
> +
> +   if (likely(!sig))
> +      sig = next_signal(pending, mask);
>     if (sig) {
>        if (current->notifier) {
>           if (sigismember(current->notifier_mask, sig)) {

