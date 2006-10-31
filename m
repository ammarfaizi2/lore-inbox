Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946145AbWJaXNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946145AbWJaXNm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 18:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946143AbWJaXNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 18:13:42 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:58276 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946139AbWJaXNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 18:13:41 -0500
Date: Tue, 31 Oct 2006 17:13:34 -0600
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-scsi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: PCI Error Recovery: Symbios SCSI device driver
Message-ID: <20061031231334.GR6360@austin.ibm.com>
References: <20061020180510.GN6537@austin.ibm.com> <20061031185506.GE26964@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031185506.GE26964@parisc-linux.org>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 11:55:07AM -0700, Matthew Wilcox wrote:
> On Fri, Oct 20, 2006 at 01:05:10PM -0500, Linas Vepstas wrote:
> > Index: linux-2.6.19-rc1-git11/drivers/scsi/sym53c8xx_2/sym_glue.c
> 
> This needs to be before the printf_debug call.

Right. This'll be in the next patch submision.

> > @@ -726,6 +731,19 @@ static int sym_eh_handler(int op, char *
> > +	/* We may be in an error condition because the PCI bus
> > +	 * went down. In this case, we need to wait until the
> > +	 * PCI bus is reset, the card is reset, and only then
> > +	 * proceed with the scsi error recovery.  There's no
> > +	 * point in hurrying; take a leisurely wait.
> > +	 */
> > +#define WAIT_FOR_PCI_RECOVERY	35
> > +	if ((np->s.device->error_state != pci_channel_io_normal) &&
> > +	    (np->s.device->error_state != 0) &&
> > +	    (wait_for_completion_timeout(&np->s.io_reset_wait,
> > +		                         WAIT_FOR_PCI_RECOVERY*HZ) == 0))
> > +			return SCSI_FAILED;
> > +
> 
> Is it safe / reasonable / a good idea to sleep for 35 seconds in the EH
> handler?  I'm not that familiar with how the EH code works.  It has its
> own thread, so I suppose that's OK.

As James pointed out, the pci channel is is not available until the 
reset sequence is done.  The 35 seconds seemed like a reasonable time
to wait for the pci reset to complete; hopefuly it will complete much 
sooner.  If the pci reset fails for some reason, then things are hosed, 
and the sysadmin will need to intervene.

> Are the driver's data structures still intact after a reset?

They should be. No one is attempting to free or shut down the driver.

> I generally prefer not to be so perlish in conditionals, ie:

I wasn't sure what style is popular. Actually, I agree with you on 
that, and picked the other style cause i thought it was prefered.
Nex patch submission will be more nested.

> 	if ((np->s.device->error_state != pci_channel_io_normal) &&
> 	    (np->s.device->error_state != 0) {
> 
> Why is the condition so complicated though?  What does 0 mean if it's
> not io_normal?  

Its an unresolved stupidity. For some imagined, hypothetical
reason, it momentarily seemed wise to make pci_channel_io_normal 
be non-zero; but this imagined reason, although vague, did manage
to bite back, as the above code demonstrates.

> At least let's hide that behind a convenience macro:
> 
> 	if (abnormal_error_state(np->s.device->error_state)) {

Should I submit a patch to make pci_channel_io_normal be zero,
or submit a patch to define abnormal_error_state, or both?
Both, probably; I don't have much of an opinion.

> Though, since INB and INW will return 0xff and 0xffff, why not use that
> as our test rather than using a counter?

Right. I wanted to avoid checking for specific values, 
as that vaguely seemed more robust; the direct check is easier.
I'll change this.

