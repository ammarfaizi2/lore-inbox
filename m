Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVDKIeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVDKIeq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 04:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVDKIeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 04:34:25 -0400
Received: from fmr17.intel.com ([134.134.136.16]:51886 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261729AbVDKI2f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 04:28:35 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Priority Lists for the RT mutex
Date: Mon, 11 Apr 2005 01:27:40 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A02F64C64@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Priority Lists for the RT mutex
Thread-Index: AcU9veVmVLYQebmJRse/cJVAX71MMgAlmr3A
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>,
       "Sven-Thorsten Dietrich" <sdietrich@mvista.com>
Cc: "Daniel Walker" <dwalker@mvista.com>, <linux-kernel@vger.kernel.org>,
       "Steven Rostedt" <rostedt@goodmis.org>,
       "Esben Nielsen" <simlo@phys.au.dk>, "Joe Korty" <joe.korty@ccur.com>
X-OriginalArrivalTime: 11 Apr 2005 08:27:47.0368 (UTC) FILETIME=[5768EA80:01C53E70]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Ingo Molnar [mailto:mingo@elte.hu]
>
>
>i'd not mind merging the extra bits to PREEMPT_RT to enable fusyn's, if
>they come in small, clean steps. E.g. Daniel's plist.h stuff was nice
>and clean.

I am finishing breaking it up in small bits so you can take a look
at it. Should be finished tomorrow noon (PST).

>is priority ceiling coming in via some POSIX feature that fusyn's need
>to address? What would be needed precisely - a way to set a priority
for
>a lock (independently of the owner's task priority), and let that
>control the PI mechanism?

Yep. It is kind of easy to do (at least in fusyns)--it is just a
matter of setting the priority of the lock, that sets the priority
of its list node.

Because the promotion code only cares about the priority of the
list node, it blends automatically in the whole scheme. The PI
code will modify the list node's priority while promoting all the
tasks affected in the ownership chain, only when the fulocks/mutexes
are PI. The PP code will modify the priority of the fulock/mutex's
list node with an special call. 

[you can check for my 2004 OLS paper for a deeper explanation, or
I can extend this one, if you want]. 

>i.e. this doesnt seem to really affect the core design of RT mutexes.

Nope it doesn't. As I said, it is done in such a way that no 
modifications are needed.

>OTOH, deadlock detection is another issue. It's quite expensive and i'm
>not sure we want to make it a runtime thing. But for fusyn's deadlock
>detection and safe teardown on owner-exit is a must-have i suspect?

Not really. Deadlock check is needed on PI, so it can be done at the
same time (you have to walk the chain anyway). In any other case, it
is an option you can request (or not).

-- Inaky
