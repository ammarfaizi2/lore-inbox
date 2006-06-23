Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWFWPEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWFWPEs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWFWPEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:04:48 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:14518 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751329AbWFWPEr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:04:47 -0400
Date: Fri, 23 Jun 2006 10:04:43 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Eric Sesterhenn <snakebyte@gmx.de>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Fault tolerance/bad patch, [was Re: [PATCH 29/30] [PATCH] PCI Hotplug: fake NULL pointer dereferences in IBM Hot Plug Controller Driver]
Message-ID: <20060623150442.GK8866@austin.ibm.com>
References: <1150753481625-git-send-email-greg@kroah.com> <115075348565-git-send-email-greg@kroah.com> <11507534883521-git-send-email-greg@kroah.com> <11507534914002-git-send-email-greg@kroah.com> <11507534953044-git-send-email-greg@kroah.com> <11507534983982-git-send-email-greg@kroah.com> <11507535021937-git-send-email-greg@kroah.com> <11507535054091-git-send-email-greg@kroah.com> <11507535082418-git-send-email-greg@kroah.com> <11507535123764-git-send-email-greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11507535123764-git-send-email-greg@kroah.com>
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 19, 2006 at 02:43:35PM -0700, Greg KH wrote:
> From: Eric Sesterhenn <snakebyte@gmx.de>
> 
> Remove checks for value, since the hotplug core always provides
> a valid value.
> 
> -	if (hotplug_slot && value) {
> +	if (hotplug_slot) {

This may be the wrong place to bring up a philosphical issue,
but this example was just too good to pass up.  This patch violates
the general dictates of high-reliability/fault-tolerant programming.

If someone in the future changes the hotplug core so that it 
sometimes returns a null value, this code will potentially crash
and/or do other bad things (corrupt, invalid state, etc.)
This means that this routine will no longer be "robust" in the face of
changes in other parts of the kernel. 

I can hear the objections:
-- Performance. B.S. This routine is not performance critical, it will
   get called once a week, once a month or less often; a few extra
   cycles are utterly irrelevant.

-- Many eyes/shallow bugs. A patch that breaks things would be rejected.
   B.S. Patches that break things get into the kernel all the time.

-- If its broken, testing will find it and fix it. B.S.  The hotplug 
   routines are lightly tested, infrequently tested.  There's not much 
   hardware that does hotplug, and its expensive. Home enthsiasts 
   won't find this.

   Worse, the null-value condition could be a rare corner case that won't 
   show up during "normal" operation, i.e. during "normal" hotplug testing.
   It may only get triggered in some obscuare case e.g. bad pci card
   or sysadmin error, or due to error in a user-land tool.

Hotplug ops are rare; they typically are not done until they are needed 
(e.g. because the card failed), and that is a really bad time to discover 
that you've crashed the kernel.  The whole point of hotplug is to *not* 
have to reboot. 

(If I may blather and pompously pontificate some more: This is also 
why Linux could never be used in life-critical/safety-critical apps, 
like health care, machine control, automoitive, aviation, satellites,
or the Mars rover.  Code that controls life-critical apps has zillions 
of safety checks for situations that "can't possibly happen". But
every insider knows "can't happen" does happen: take the Hyabusa 
asteroid mission as a recent example.  My goal in pontificating is not 
to reject this one patch, but to change the cowboy attitude that makes 
people think that patches like this are OK.)

Thus, I can't begin to imagine why anyone would want to remove
robustness with a patch like this, and gain absolutely nothing in
return.


--linas

