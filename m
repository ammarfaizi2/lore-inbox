Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVDDIOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVDDIOo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 04:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVDDIOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 04:14:43 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:13045 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261167AbVDDIOj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 04:14:39 -0400
Date: Mon, 4 Apr 2005 13:45:38 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: hien@us.ibm.com, SystemTAP <systemtap@sources.redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc1-mm3] [1/2]  kprobes += function-return
Message-ID: <20050404081538.GF1715@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hien,

This patch looks good to me, but I have some comments on this patch.

>This patch adds function-return probes (AKA exit probes) to kprobes. 
> When establishing a probepoint at the entry to a function, you can also 
>establish a handler to be run when the function returns.

>The subsequent post give example of how function-return probes can be used.

>Two new registration interfaces are added to kprobes:

>int register_kretprobe(struct kprobe *kp, struct rprobe *rp);
>Registers a probepoint at the entry to the function whose address is 
>kp->addr.  Each time that function returns, rp->handler will be run.

>int register_jretprobe(struct jprobe *jp, struct rprobe *rp);
>Like register_kretprobe, except a jprobe is established for the probed 
>function.

Why two interfaces for the same feature?
You can provide a simple interface like

register_exitprobe(struct rprobe *rp) {
	....................
}

or 
int register_returnprobe(struct rprobe *rp) {

	....................
}

whichever you feel is a good name. 


independent of kprobe and jprobe.
This routine should take care to register entry handler internally if not 
present. This routine can check if there are already entry point kprobe/jprobe
and use some flags internally to say if the entry jprobe/kprobe already exists.

>To unregister, you still use unregister_kprobe or unregister_jprobe. To 
>probe only a function's returns, call register_kretprobe() and specify 
>NULL handlers for the kprobe.

make unregister exitprobes independent of kprobe/jprobe.

To unregister provide this interface 

unregister_exitprobe(struct rpobe *rp) { 
	....................
}

This routine should check if entry point kprobe/jprobe belows to user/ 
registered by exit probe. Remove the entry probe if no user has registered 
entry point kprobe/jprobe. If user has already registered entry point probes,
just leave the entry point probes and remove only the exit point probes.

Please let me know if you need more information.

Thanks
Prasanna
- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
