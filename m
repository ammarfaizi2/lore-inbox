Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbVHIRoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbVHIRoY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 13:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVHIRoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 13:44:24 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:18345 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S932556AbVHIRoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 13:44:23 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.96,92,1122847200"; 
   d="scan'208"; a="13840042:sNHT25482412"
Message-ID: <42F8EB66.8020002@fujitsu-siemens.com>
Date: Tue, 09 Aug 2005 19:44:06 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Signal handling possibly wrong
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

reading man pages for sigaction and comparing it to what kernel does
when starting a signal handler (i386, s390, ppc and others), I think
one of both might be wrong.

 From man pages:

  sa_mask gives a mask of signals which should be blocked during
  execu­tion of the signal handler. In addition, the signal which
  triggered the handler will be blocked, unless the SA_NODEFER or
  SA_NOMASK flags are used.

 From arch/i386/kernel/signal.c:

         if (ret && !(ka->sa.sa_flags & SA_NODEFER)) {
                 spin_lock_irq(&current->sighand->siglock);
                 sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
                 sigaddset(&current->blocked,sig);
                 recalc_sigpending();
                 spin_unlock_irq(&current->sighand->siglock);
         }


If I understand man pages correctly, the handled signal should be blocked
depending on SA_NODEFER, while sa_mask should be used unconditionally to
block additional signals.
Kernel code blocks both "handled signal" _and_ sa_mask only if SA_NODEFER
isn't set.

Which is the right behavior?

Regards
		Bodo

P.S.:
Please CC me, I'm not on the list.
