Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936859AbWLEWka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936859AbWLEWka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 17:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936870AbWLEWk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 17:40:29 -0500
Received: from wr-out-0506.google.com ([64.233.184.230]:31357 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936859AbWLEWk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 17:40:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l2hP5UsoZh5WeJm5/dSxjph52Beh32fU4u45k6rwsuJRgoGfAyeQAF723lZQlt7FUbrlojeOxHgcafSvO8N9EdQMp0Nfu+wd8+Lke5I/rDkgc8tEDBmjU8p/q6UvPTz5mvADvsXhEin8inpQeGYIlxCoklFeG5AKY1/G8eeHwxA=
Message-ID: <9a8748490612051440v81372dcia879acdf718047bb@mail.gmail.com>
Date: Tue, 5 Dec 2006 23:40:28 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Corey Minyard" <minyard@acm.org>
Subject: Re: [PATCH 7/12] IPMI: add poll delay
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "OpenIPMI Developers" <openipmi-developer@lists.sourceforge.net>
In-Reply-To: <4575779C.1050204@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061202043520.GC30531@localdomain>
	 <20061203132610.471786ca.akpm@osdl.org> <4575779C.1050204@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/06, Corey Minyard <minyard@acm.org> wrote:
> Andrew Morton wrote:
> > On Fri, 1 Dec 2006 22:35:20 -0600
> > Corey Minyard <minyard@acm.org> wrote:
> >
> >
> >> Make sure to delay a little in the IPMI poll routine so we can pass in
> >> a timeout time and thus time things out.
> >>
> >> Signed-off-by: Corey Minyard <minyard@acm.org>
> >>
> >> Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
> >> ===================================================================
> >> --- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_si_intf.c
> >> +++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
> >> @@ -807,7 +807,12 @@ static void poll(void *send_info)
> >>  {
> >>      struct smi_info *smi_info = send_info;
> >>
> >> -    smi_event_handler(smi_info, 0);
> >> +    /*
> >> +     * Make sure there is some delay in the poll loop so we can
> >> +     * drive time forward and timeout things.
> >> +     */
> >> +    udelay(10);
> >> +    smi_event_handler(smi_info, 10);
> >>  }
> >>
> >
> > I don't understand what this patch is doing.  It looks fishy.  More
> > details, please?
> >
> Yeah, it does look a little fishy.  This is a poll routine that is only
> called at panic
> time; it is used to force things to happen in the driver without
> scheduling or
> timers.  The driver does this so it can set watchdog parameters and store
> panic information in the event log at panic time.
>
> Without this change, if something goes wrong in the BMC the driver will
> never
> time out the operation since it doesn't see time being driven forward.
> So this
> makes sure the driver sees time advancing as it should.
>

Hmm, I wonder if this could explain why some of my IBM servers become
unreachable via IPMI after a kernel crash.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
