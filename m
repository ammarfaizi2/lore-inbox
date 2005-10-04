Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbVJDV3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbVJDV3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 17:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbVJDV3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 17:29:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:7660 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964985AbVJDV3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 17:29:36 -0400
Subject: Re: Making nice niser for system hogging programs
From: Matt Helsley <matthltc@us.ibm.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Marc Perkel <marc@perkel.com>, LKML <linux-kernel@vger.kernel.org>,
       Shailabh Nagar <nagar@watson.ibm.com>
In-Reply-To: <200510021307.10372.kernel@kolivas.org>
References: <433F4563.5060700@perkel.com>
	 <200510021307.10372.kernel@kolivas.org>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 14:26:02 -0700
Message-Id: <1128461162.12346.2609.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-02 at 13:07 +1000, Con Kolivas wrote:
> On Sun, 2 Oct 2005 12:26, Marc Perkel wrote:
> > Just a thought -----
> >
> > Programs like cp -a /bigdir /backup and rsync usually bring the server
> > to a crawl no matter how much "nice" you put on them. Is there any way
> > to make "nice" smarter in that it limits io as well as processor usage?
> > If cp and rsyne ran a little slower IO wise then everything else could
> > run too.
> 
> The latest cfq io scheduler supports io nice levels. By default it links the 
> io nice levels to the cpu nice levels so if you use cfq and set your file 
> commands nice 19 they will use as little io priority as possible. Note this 
> only works on the read side but that makes a dramatic difference already.
> 
> Cheers
> Con

	If you want a way to assign io priorities without relying on process
inheritance and (re)nice you might find CKRM, with it's cfq-based IO
controller, useful.

	Basically you create a set of classes that group tasks and give an
appropriate share of IO performance to tasks in that class. As processes
get created CKRM will assign tasks to the IO classes based on a set of
rules. You can run commands like:

mkdir /rcfs/taskclass/makin_copies
echo 'res=io,guarantee=20' > /rcfs/taskclass/makin_copies/shares
echo 'path=/usr/bin/rsync,class=makin_copies' > /rcfs/ce/rsync_rule
echo 'path=/bin/cp,class=makin_copies' > /rcfs/ce/cp_rule

to set this up. This should make CKRM useful for those unwilling to
become full-time administrators just to run their own desktops.

Cheers,
	-Matt Helsley

