Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbTHYWqn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 18:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbTHYWqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 18:46:43 -0400
Received: from vdp115.ath12.cas.hol.gr ([195.97.124.116]:27043 "EHLO
	pfn1.pefnos") by vger.kernel.org with ESMTP id S262433AbTHYWqe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 18:46:34 -0400
From: "P. Christeas" <p_christ@hol.gr>
To: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: [PATCH] 2.6.0-test4: Trivial /sys/power/state patch, sleep status report
Date: Tue, 26 Aug 2003 01:47:50 +0300
User-Agent: KMail/1.5
Cc: acpi-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
References: <200308260125.30194.p_christ@hol.gr> <1061851218.12331.23.camel@gimli.at.home>
In-Reply-To: <1061851218.12331.23.camel@gimli.at.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308260147.50968.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch wrote:
> On Tue, 2003-08-26 at 00:25, P. Christeas wrote:
> > Just found out that by 'echo sth_wrong > /sys/power/state' the kernel
> > would oops in a fatal way (no clean exit from there).
> > The oops suggested that the code would enter an invalid fn.
> >
> > You may apply the included patch to solve the bug. IMHO doing a clean
> > exit is much preferrable than having BUG() there.
>
> > diff -Bbur /diskb/users/panos/linux-off/kernel/power/main.c
> > /usr/src/linux/kernel/power/main.c ---
> > /diskb/users/panos/linux-off/kernel/power/main.c	2003-08-23
> > 12:13:17.000000000 +0300 +++
> > /usr/src/linux/kernel/power/main.c	2003-08-26 00:59:34.000000000 +0300 @@
> > -500,7 +514,7 @@
> >  		if (s->name && !strcmp(buf,s->name))
> >  			break;
> >  	}
> > -	if (s)
> > +	if ( (s) && (state < PM_SUSPEND_MAX) )
> >  		error = enter_state(state);
> >  	else
> >  		error = -EINVAL;
>
> What do you think about the attached patch to solve the bug and remove a
> warning?
>
> 	Bernd

Already tried that. If you look more closely, the s will receive the state 
*before* the name *in it* is strcmp()'ed. This means it won't be NULL anyway.
>               if (s->name && !strcmp(buf,s->name))
>                       break;

I also thought of checking "( (s) && (s->name !=NULL) )" ,  but IMHO the 
'state' check is cleaner (no dereference).


--- linux-2.6.0-test4/kernel/power/main.c       Sat Aug 23 01:53:13 2003
+++ linux-2.6.0-test4-patched/kernel/power/main.c       Mon Aug 25 21:16:50 
2003
@@ -492,7 +492,7 @@
 static ssize_t state_store(struct subsystem * subsys, const char * buf, 
size_t n)
 {
        u32 state;
-       struct pm_state * s;
+       struct pm_state * s = NULL;
        int error;
 
        for (state = 0; state < PM_SUSPEND_MAX; state++) {


