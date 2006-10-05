Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWJEISV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWJEISV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWJEISV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:18:21 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:511 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751259AbWJEISS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:18:18 -0400
Date: Thu, 5 Oct 2006 10:17:05 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Jeff Garzik <jeff@garzik.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ashok Raj <ashok.raj@intel.com>, Nathan Lynch <nathanl@austin.ibm.com>
Subject: Re: [PATCH] drivers/base: error handling fixes
Message-ID: <20061005081705.GA6920@osiris.boeblingen.de.ibm.com>
References: <20061004130554.GA25974@havoc.gtf.org> <20061004172434.1a2ddb71@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004172434.1a2ddb71@gondolin.boeblingen.de.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 05:24:34PM +0200, Cornelia Huck wrote:
> On Wed, 4 Oct 2006 09:05:54 -0400,
> Jeff Garzik <jeff@garzik.org> wrote:
> 
> >  static int __cpuinit topology_cpu_callback(struct notifier_block *nfb,
> > @@ -112,17 +110,18 @@ static int __cpuinit topology_cpu_callba
> >  {
> >  	unsigned int cpu = (unsigned long)hcpu;
> >  	struct sys_device *sys_dev;
> > +	int rc = 0;
> >  
> >  	sys_dev = get_cpu_sysdev(cpu);
> >  	switch (action) {
> >  	case CPU_ONLINE:
> > -		topology_add_dev(sys_dev);
> > +		rc = topology_add_dev(sys_dev);
> >  		break;
> >  	case CPU_DEAD:
> >  		topology_remove_dev(sys_dev);
> >  		break;
> >  	}
> > -	return NOTIFY_OK;
> > +	return rc ? NOTIFY_BAD : NOTIFY_OK;
> >  }
> 
> Wouldn't that also require that _cpu_up checked the return code when
> doing CPU_ONLINE notification (and clean up on error)?

After all code that gets a CPU_ONLINE notification is not supposed to fail.
For allocating resources while bringing up a cpu CPU_UP_PREPARE is supposed
to be used. That one is allowed to fail.
