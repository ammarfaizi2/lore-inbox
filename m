Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263208AbTEMG3l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 02:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTEMG3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 02:29:41 -0400
Received: from ns.suse.de ([213.95.15.193]:60421 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263208AbTEMG3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 02:29:38 -0400
Date: Tue, 13 May 2003 08:42:23 +0200
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: 2.5.69-mjb1
Message-ID: <20030513064223.GB29078@Wotan.suse.de>
References: <9380000.1052624649@[10.10.2.4]> <20030512132939.GF19053@holomorphy.com> <21850000.1052743254@[10.10.2.4]> <3EBFB82B.8040509@us.ibm.com> <20030513012346.GQ19053@holomorphy.com> <17070000.1052797281@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17070000.1052797281@[10.10.2.4]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > -#define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1019])
> > -#define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1022])
> > +#define KSTK_EIP(task)	((task)->thread.eip)
> > +#define KSTK_ESP(task)	((task)->thread.esp)
> 
> Can I assume it's tested, or does it need someone to do that?

It's broken. It will report the kernel values, not the user values like the previous
version and also get it wrong for the current task

(KSTK_* is really a misnomer, it should be USTK_*. WCHAN is handled by a different 
mechanism) 

Something like this should work (untested)

#define KSTK_PTREGS(tsk) \
	((struct pt_regs *)((unsigned long)((tsk)->thread_info) + THREAD_SIZE) - 1)
#define KSTK_EIP(tsk) (KSTK_PTREGS(tsk)->eip)
#define KSTK_ESP(tsk) (KSTK_PTREGS(tsk)->esp)

-Andi
