Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265217AbUELUXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265217AbUELUXB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265221AbUELUXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:23:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:44467 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265217AbUELUW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:22:58 -0400
Date: Wed, 12 May 2004 13:20:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: davidel@xmailserver.org, jgarzik@pobox.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-Id: <20040512132050.6eae6905.akpm@osdl.org>
In-Reply-To: <20040512200305.GA16078@elte.hu>
References: <20040512020700.6f6aa61f.akpm@osdl.org>
	<20040512181903.GG13421@kroah.com>
	<40A26FFA.4030701@pobox.com>
	<20040512193349.GA14936@elte.hu>
	<Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com>
	<20040512200305.GA16078@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Davide Libenzi <davidel@xmailserver.org> wrote:
> 
> > > why is it wrong?
> > 
> > For HZ == 1000 it's fine, even if it'd better to explicitly make it HZ
> > dependent and let the compiler to discard them.
> 
> the compiler cannot discard the multiplication and the division from the
> following:
> 
> 	x * 1000 / 1000
> 
> due to overflows. But we know that HZ is 1000 in the arch-dependent
> param.h, and in sched.c we use the HZ dependent variant:
> 
>  #ifndef JIFFIES_TO_MSEC
>  # define JIFFIES_TO_MSEC(x) ((x) * 1000 / HZ)
>  #endif
>  #ifndef MSEC_TO_JIFFIES
>  # define MSEC_TO_JIFFIES(x) ((x) * HZ / 1000)
>  #endif
> 

Yes, that's a correct optimisation.  This is simply a namespace clash.

How about we do:

#if HZ=1000
#define	MSEC_TO_JIFFIES(msec) (msec)
#define JIFFIES_TO_MESC(jiffies) (jiffies)
#elif HZ=100
#define	MSEC_TO_JIFFIES(msec) (msec * 10)
#define JIFFIES_TO_MESC(jiffies) (jiffies / 10)
#else
#define	MSEC_TO_JIFFIES(msec) ((HZ * (msec) + 999) / 1000)
#define	JIFFIES_TO_MSEC(jiffies) ...
#endif

in some kernel-wide header then kill off all the private implementations?

