Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbULBRG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbULBRG7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 12:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbULBRG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 12:06:59 -0500
Received: from imap.gmx.net ([213.165.64.20]:19604 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261690AbULBRGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 12:06:55 -0500
X-Authenticated: #4399952
Date: Thu, 2 Dec 2004 18:09:10 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: "Jack O'Quin" <joq@io.com>, Andrew Burgess <aab@cichlid.com>,
       linux-kernel@vger.kernel.org, jackit-devel@lists.sourceforge.net
Subject: Re: [Jackit-devel] Re: Real-Time Preemption,
 -RT-2.6.10-rc2-mm3-V0.7.31-19
Message-ID: <20041202180910.0d77cbbb@mango.fruits.de>
In-Reply-To: <20041202175756.0e50f101@mango.fruits.de>
References: <200412021546.iB2FkK5a005502@cichlid.com>
	<20041202170315.067d7853@mango.fruits.de>
	<87y8ggekds.fsf@sulphur.joq.us>
	<20041202175756.0e50f101@mango.fruits.de>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2004 17:57:56 +0100
Florian Schmidt <mista.tapas@gmx.net> wrote:

> On 02 Dec 2004 10:26:55 -0600
> "Jack O'Quin" <joq@io.com> wrote:
> 
> > 
> > > On Thu, 2 Dec 2004 07:46:20 -0800
> > > Andrew Burgess <aab@cichlid.com> wrote:
> > > > On further thought, I suppose libjack could install a SIGUSR2 handler and
> > > > have that call abort for all the rt client threads. Still no client mods
> > > > needed, only an RT-aware libjack.
> > 
> > Florian Schmidt <mista.tapas@gmx.net> writes:
> > > right. Or instead of aborting jackd might print a debug output (like
> > > "client foo violated RT constraints"). 
> > 
> > Libjack cannot assume the client has no SIGUSR2 handler of its own.
> 
> i see..
> 
> > It would be wonderful to have a reliable mechanism for debugging them.
> 
> I suppose instead of catching the signal the user might just monitor the
> syslog. I'm not sure there's printk's triggered by thisalready , but i'm
> sure if not, ingo might add them. So a trivial patch for jackd would
> probably look like this:
> 
> --- libjack/client.c.orig       2004-12-02 17:55:04.000000000 +0100
> +++ libjack/client.c    2004-12-02 17:56:23.000000000 +0100
> @@ -1238,6 +1238,9 @@
>                         if (control->sync_cb)
>                                 jack_call_sync_client (client);
>  
> +                       // enable atomicity check for RP kernels
> +                       gettimeofday(1,1);
> +
>                         if (control->process) {
>                                 if (control->process (control->nframes,
>                                                       control->process_arg)
> @@ -1247,7 +1250,10 @@
>                         } else {
>                                 control->state = Finished;
>                         }
> -
> +
> +                       // disable atomicity check
> +                       gettimeofday(0,1);
> +
>                         if (control->timebase_cb)
>                                 jack_call_timebase_master (client);
>  

Well, i do get syslog output with this patch like this:

Dec  2 18:01:11 mango kernel: jack_test:22645 userspace BUG: scheduling in user-atomic context!
Dec  2 18:01:11 mango kernel:  [<c02a38b6>] schedule+0x76/0x130 (8)
Dec  2 18:01:11 mango kernel:  [<c02a44c5>] schedule_timeout+0x85/0xe0 (36)
Dec  2 18:01:11 mango kernel:  [<c016677f>] do_pollfd+0x4f/0x90 (48)
Dec  2 18:01:11 mango kernel:  [<c011ceb0>] process_timeout+0x0/0x10 (8)
Dec  2 18:01:11 mango kernel:  [<c016686a>] do_poll+0xaa/0xd0 (20)
Dec  2 18:01:11 mango kernel:  [<c01669e2>] sys_poll+0x152/0x230 (48)
Dec  2 18:01:11 mango kernel:  [<c0165db0>] __pollwait+0x0/0xd0 (36)
Dec  2 18:01:11 mango kernel:  [<c01025cb>] syscall_call+0x7/0xb (32)

even if the client's process callback is a noop (except for returning
0). Hmm, i must have missed something in jackd's source. i thought
control->process() directly calls the clients process callback..

hmm..
