Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWGXP45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWGXP45 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 11:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWGXP45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 11:56:57 -0400
Received: from [212.70.63.67] ([212.70.63.67]:9223 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751302AbWGXP44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 11:56:56 -0400
From: Al Boldi <a1426z@gawab.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] x86: Don't randomize stack unless current->personality permits it
Date: Mon, 24 Jul 2006 18:57:46 +0300
User-Agent: KMail/1.5
Cc: Paulo Marques <pmarques@grupopie.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Frank van Maarseveen <frankvm@frankvm.com>
References: <200607191305_MC3-1-C56F-6E4F@compuserve.com> <200607202023.13901.a1426z@gawab.com>
In-Reply-To: <200607202023.13901.a1426z@gawab.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607241857.46594.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Chuck Ebbert wrote:
> > On Tue, 18 Jul 2006 08:21:45 +0300. Al Boldi wrote:
> > > Going one step further,
> > > with #define arch_stack_align(x) (x)
> > > all blips/hits/weirdness are gone
> > >
> > > Which means that either arch_stack_align isn't necessary at all, or
> > > randomization isn't working as intended.
> > >
> > > Can somebody prove me wrong here?
> >
> > Your program seems highly sensitive to any changes,
>
> Extremely sensitive.  You may have noticed the strange repetitions in main
> instead of a for loop.  It's like that for a reason:  compile semantics.
>
> > $ ./tst.ex
> > &x = 0xbfb32d90, &y = 0xbfb32d98
> >   10    6   10   10    6   10    7   10   10   10   10   10   10   10  
>
> With your changes on:
>
> stock kernel, randomize_va_space=0, gcc.322 -Os tstExec.c,
> while :; do ./a.out; done
> &x = 0xbffff874, &y = 0xbffff86c   28   28
> &x = 0xbffff874, &y = 0xbffff86c   27   27  
> &x = 0xbffff874, &y = 0xbffff86c   27   27
> &x = 0xbffff874, &y = 0xbffff86c   28   27
> &x = 0xbffff874, &y = 0xbffff86c   27   30
> &x = 0xbffff874, &y = 0xbffff86c   27   29
>
> stock kernel, randomize_va_space=1, gcc.322 -Os tstExec.c,
> while :; do ./a.out; done
> &x = 0xbfe2e614, &y = 0xbfe2e60c   29   28
> &x = 0xbfd6a104, &y = 0xbfd6a0fc   55   56  
> &x = 0xbf91d454, &y = 0xbf91d44c   27   27
> &x = 0xbf941e84, &y = 0xbf941e7c   55   56
> &x = 0xbfa75834, &y = 0xbfa7582c   28   27
> &x = 0xbfb58634, &y = 0xbfb5862c   27   30

After closer inspection, it looks like addresses ending with 3c,7c,bc,fc 
cause a slowdown on P4, while addresses ending with 1c,3c,5c,7c,9c,bc,dc,fc 
cause a slowdown on P2.

Any easy way to instruct the kernel to skip those addresses?

Thanks!

--
Al

