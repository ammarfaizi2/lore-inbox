Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVKKAXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVKKAXh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 19:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVKKAXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 19:23:37 -0500
Received: from maggie.cs.pitt.edu ([130.49.220.148]:20913 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S932272AbVKKAXh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 19:23:37 -0500
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: "Hua Zhong \(hzhong\)" <hzhong@cisco.com>
Subject: Re: [PATCH] getrusage sucks
Date: Fri, 11 Nov 2005 01:23:28 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
References: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com>
In-Reply-To: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511110123.29664.cloud.of.andor@gmail.com>
X-Spam-Score: -1.665/8 BAYES_00 SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 November 2005 00:47, Hua Zhong (hzhong) wrote:
> The reason is what if tsk is no longer available when you call
> getrusage?

Sorry, but honestly I don't see any problem: as you can see from my patch, if 
tsk is no longer available, getrusage returns -1 and sets errno appropriately 
(equal to EINVAL, which means that who is invalid).

            Claudio

>
> > -----Original Message-----
> >
> > Does exist any _real_ reason why getrusage can't be invoked
> > by a task to know
> > statistics of another task ?
> >
> > The changes would be very trivial, as shown by the following patch.
> >
> >               Claudio
> >
> >
> > diff --git a/kernel/sys.c b/kernel/sys.c
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -1746,9 +1746,13 @@ int getrusage(struct task_struct *p, int
> >
> >  asmlinkage long sys_getrusage(int who, struct rusage __user *ru)
> >  {
> > -  if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN)
> > -     return -EINVAL;
> > -  return getrusage(current, who, ru);
> > +  if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN) {
> > +      struct task_struct* tsk = find_task_by_pid(who);
> > +      if (tsk == NULL)
> > +        return -EINVAL;
> > +     return getrusage(tsk, RUSAGE_SELF, ru);
> > +   } else
> > +     return getrusage(current, who, ru);
> >  }
> >
> >  asmlinkage long sys_umask(int mask)
