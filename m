Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031420AbWFOV1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031420AbWFOV1H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 17:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031426AbWFOV1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 17:27:07 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:26329 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1031420AbWFOV1F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 17:27:05 -0400
Date: Thu, 15 Jun 2006 14:26:43 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: frode isaksen <frode.isaksen@gmail.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: sys_poll with timeout -1 bug fix
Message-ID: <20060615212643.GZ11131@us.ibm.com>
References: <383D1CA3-E74C-4530-A8C8-D0B9608A1970@gmail.com> <1150406009.21787.375.camel@stark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150406009.21787.375.camel@stark>
X-Operating-System: Linux 2.6.17-rc6 (x86_64)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.2006 [14:13:29 -0700], Matt Helsley wrote:
> On Thu, 2006-06-15 at 17:33 +0200, frode isaksen wrote:
> > From: Frode Isaksen <frode.isaksen@gmail.com>
> > 
> > If you do a poll() call with timeout -1, the wait will be a big  
> > number (depending on HZ)  instead of infinite wait, since -1 is  
> > passed to the msecs_to_jiffies function.
> > 
> > Signed-off-by: Frode Isaksen <frode.isaksen@gmail.com>
> > 
> > ---
> > --- linux-2.6.16.20/fs/select.c.orig.c	2006-06-05 19:18:23.000000000  
> > +0200
> > +++ linux-2.6.16.20/fs/select.c	2006-06-15 14:20:47.000000000 +0200
> > @@ -699,9 +699,9 @@ out_fds:
> >   asmlinkage long sys_poll(struct pollfd __user *ufds, unsigned int  
> > nfds,
> >   			long timeout_msecs)
> >   {
> > -	s64 timeout_jiffies = 0;
> > +	s64 timeout_jiffies;
> > 
> > -	if (timeout_msecs) {
> > +	if (timeout_msecs > 0) {
> >   #if HZ > 1000
> >   		/* We can only overflow if HZ > 1000 */
> >   		if (timeout_msecs / 1000 > (s64)0x7fffffffffffffffULL / (s64)HZ)
> > @@ -709,6 +709,9 @@ asmlinkage long sys_poll(struct pollfd _
> >   		else
> >   #endif
> >   			timeout_jiffies = msecs_to_jiffies(timeout_msecs);
> > +	} else {
> > +		/* Infinite (-1) or no (0) timeout */
> > +		timeout_jiffies = timeout_msecs;
> 
> nit: The comment isn't quite right according to the poll manpage. Any
> negative number represents an infinite timeout. I think you want:
> 
> + 		/* Infinite (< 0) or no (0) timeout */

Err, true.

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
