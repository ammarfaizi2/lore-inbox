Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262260AbVAZAPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbVAZAPK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbVAZANL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:13:11 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:22084 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262264AbVAZALW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:11:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=GkwF+6QOLVZCRfuaQyFmL2ddjntRwaxQlm5F1Yh9olqZKgLAFQsr2qqaukLJ0/LylS2Gdj2xKfmW45G/Y35XoOrCaSxGFT6/x84gdZ8GhsEAA41L807UyKLhg+isKLc199ycPD/WfAx7z3eHthGmn9feMkpvX6AqOU3HI0TxB0w=
Message-ID: <3f250c71050125161175234ef9@mail.gmail.com>
Date: Tue, 25 Jan 2005 20:11:19 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: tglx@linutronix.de
Subject: Re: User space out of memory approach
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Edjard Souza Mota <edjard@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1106689179.4538.22.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <20050111083837.GE26799@dualathlon.random>
	 <3f250c71050121132713a145e3@mail.gmail.com>
	 <3f250c7105012113455e986ca8@mail.gmail.com>
	 <20050122033219.GG11112@dualathlon.random>
	 <3f250c7105012513136ae2587e@mail.gmail.com>
	 <1106689179.4538.22.camel@tglx.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomaz,

On Tue, 25 Jan 2005 22:39:39 +0100, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 2005-01-25 at 17:13 -0400, Mauricio Lin wrote:
> > Hi Andrea,
> >
> > Your OOM Killer patch was tested and a strange behaviour was found.
> > Basically as normal user we started some applications as openoffice,
> > mozilla and emacs.
> > And as a root (in another tty) we started a simple program that uses
> > malloc in a forever loop as below:
> >
> > int main (void)
> > {
> >   int * mem;
> >   for (;;)
> >         mem = (int *) malloc(sizeof(int));
> >   return 0;
> > }
> >
> >
> > Using the original OOM Killer, malloc is the first killed application
> > and the sytem is restored in a useful state. After applying your patch
> > and accomplish the same experiment, the OOM Killer it does not kill
> > malloc program and it enters in a kind of forever loop as below:
> >
> > 1) out_of_memory is invoked;
> > 2) select_bad_process is invoked;
> 
> Which process is selected ?
Sometimes the first application to be killed is XFree. AFAIK the
malloc is never killed, because the OOM Killer does not stop to do its
work. Usually we are not able to check the kernel log file after
rebooting the system. Because nothing was written there (perhaps
syslogd or klogd were killed during OOM). But I can see the printk
messages on the screen during OOM Killer action. This does not happen
with original OOM Killer.

I put some printk in order to trace the OOM Killer and IMHO what is going is:

out_of_memory function is invoked and after that the
select_bad_process is also invoked.
So its starts to point each task. But during the do_each_thread /
while each_thread loop the
condition:

if ((unlikely(test_tsk_thread_flag(p, TIF_MEMDIE)) || (p->flags &
PF_EXITING)) &&
			    !(p->flags & PF_DEAD))
       return ERR_PTR(-1UL);

is true and it leaves from select_bad_process function because of the
return statement.

So the running code return from the point that select_bad_process was
called, i.e., in the out_of_memory function. The condition statement
in out_of_memory function:

if (PTR_ERR(p) == -1UL)
		goto out;

is also true so it goes to "out" label and leaves from the
out_of_memory function. But because of the OOM state the out_of_memory
function is invoked again and after that the select_bad_process is
also invoked again. And during the do_each_thread / while each_thread
loop the same condition as mentioned above is true again. So it leaves
from select_bad_process function because of the return statement and
goes to "out" label and
leaves from the out_of_memory function again. This behaviour is
repeated continuously
during a long time until I stop waiting and reboot the system using my
own finger.

> Can you please show the kernel messages ?

OK. We will try to reach a situation that the printk messages can be
written entirely in the log file and show you the kernel messages. But
as I said: usually the printks messages are not written in the log
file using Andrea's patch. But using the original OOM Killer we can
see the messages in the log file. The syslog.conf file is the same for
both OOM Killer(Andrea and Original). Do you have any idea what is
happening to log file?

If you do not mind, you can accomplish the same test case as I
mentioned on my last email. I would like to know if this problem
happens to others people as well.

We tested on the laptop and desktop machines with 128MB of RAM and
swap space disabled.


BR,

Mauricio Lin.
