Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263444AbUJ2Qw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbUJ2Qw2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 12:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbUJ2QsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 12:48:06 -0400
Received: from dsl254-100-205.nyc1.dsl.speakeasy.net ([216.254.100.205]:753
	"EHLO memeplex.com") by vger.kernel.org with ESMTP id S263386AbUJ2Qnu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 12:43:50 -0400
From: "Andrew A." <aathan-linux-kernel-1542@cloakmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Andrew" <aathan-linux-kernel-1542@cloakmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <roland@topspin.com>, "Andrew Morton" <akpm@osdl.org>
Subject: RE: Consistent lock up 2.6.10-rc1-bk7 (mutex/SCHED_RR bug?)
Date: Fri, 29 Oct 2004 12:43:11 -0400
Message-ID: <OMEGLKPBDPDHAGCIBHHJGEMIFCAA.aathan-linux-kernel-1542@cloakmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1099062404.13098.59.camel@localhost.localdomain>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan:

Thanks for your note.  The application in question is not "hard RT" and I am using SCHED_RR to improve latency, rather than
guarantee a particular latency number.  Also, since I am using the ACE framework, and don't have the time to detangle its
protability preprocesor macros to add support for a different futex/mutex mechanism, I'm inclined to use stock code.  I did dig up
Inaky's work which is a fusyn mapping to existing futex calls--I might try that.

However, would any of that really solve this problem?  That is, do lower priority non-RR tasks and/or kernel signal delivery benefit
from additional scheduled time under those patches?

I suspect what is happening here is that my process is essentially in a

while(1)
{
  lock();
  unlock();
}

loop from two or mode SCHED_RR threads running at nice -15.  They seem to be unkillable.

However, should we really dismiss the possibility that the problem could be that these threads are in some kind of deadlock that
involves the scheduler?

A.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Alan Cox
Sent: Friday, October 29, 2004 11:07 AM
To: Andrew
Cc: Linux Kernel Mailing List; roland@topspin.com; Andrew Morton
Subject: RE: Consistent lock up 2.6.10-rc1-bk7 (mutex/SCHED_RR bug?)


On Gwe, 2004-10-29 at 15:26, Andrew wrote:
> Although it appears I need to fix an applicaiton bug, is it normal/desirable for an application calling system mutex facilities to
> starve the system so completely, and/or become "unkillable"?

If it is SCHED_RR then it may get to hog the processor but it should not
be doing worse than that and should be killable by something higher
priority.

You are right to suspect futexes don't deal with hard real time but the
failure you see isnt the intended failure case.

[Inaky has posted some drafts of a near futex efficient lock system that
ought to work for real time use btw]

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



