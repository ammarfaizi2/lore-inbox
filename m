Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282540AbRLRNFQ>; Tue, 18 Dec 2001 08:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282705AbRLRNFH>; Tue, 18 Dec 2001 08:05:07 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:33468 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S282483AbRLRNEu>; Tue, 18 Dec 2001 08:04:50 -0500
Message-ID: <3C1F3F3D.14B515F0@oracle.com>
Date: Tue, 18 Dec 2001 14:06:05 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.1-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: _PepeR_ <peper@wsisiz.edu.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1 crashed during sending processes TERM signal
In-Reply-To: <Pine.LNX.4.42.0112181226460.20596-100000@oceanic.wsisiz.edu.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

_PepeR_ wrote:
> 
> Hello,
> 
> At shutdown the system stops at the message "Sending all precesses TERM
> signal...". The isn't any messages of possible failure in logs.
> I'm using 2.5.1 kernel. If it's matter my system is an Athlon 1GHz on ECS
> K7S5A mainboard. If you need some detailed information please contact me
> on my e-mail 'coz I'm not subscribed to lkml.

No, this is generic, and is due to a recent patch (from -pre11 to -final)
 that should have made Linux more standards-compliant. Linus already
 reverted it in his tree so I assume the correctly-working shutdown
 sequence will work again in 2.5.2-preX. zdiff'ing -pre11 from -final
 patches I'd say it's this chunk (don't try to apply with 'patch', I
 just cut'n'pasted from my xterm):

> --- v2.5.0/linux/kernel/signal.c      Wed Nov 21 16:26:27 2001
> +++ linux/kernel/signal.c     Fri Dec 14 12:25:24 2001
> @@ -649,8 +649,10 @@
>  /*
>   * kill_something_info() interprets pid in interesting ways just like kill(2).
>   *
> - * POSIX specifies that kill(-1,sig) is unspecified, but what we have
> - * is probably wrong.  Should make it like BSD or SYSV.
> + * POSIX (2001) specifies "If pid is -1, sig shall be sent to all processes
> + * (excluding an unspecified set of system processes) for which the process
> + * has permission to send that signal."
> + * So, probably the process should also signal itself.
>   */
>  
>  static int kill_something_info(int sig, struct siginfo *info, int pid)
> @@ -663,7 +665,7 @@
>  
>               read_lock(&tasklist_lock);
>               for_each_task(p) {
> -                     if (p->pid > 1 && p != current) {
> +                     if (p->pid > 1) {
>                               int err = send_sig_info(sig, info, p);
>                               ++count;
>                               if (err != -EPERM)


I see the same behavior on RedHat 7.2.

--alessandro

 "we live as we dream alone / to break the spell we mix with the others
  we were not born in isolation / but sometimes it seems that way"
     (R.E.M., live intro to 'World Leader Pretend')
