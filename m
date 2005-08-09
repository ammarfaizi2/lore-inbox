Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbVHITdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVHITdm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 15:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVHITdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 15:33:42 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:44983 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S932264AbVHITdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 15:33:41 -0400
From: Jeremy Maitin-Shepard <jbms@cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Signal handling possibly wrong
References: <42F8EB66.8020002@fujitsu-siemens.com>
	<1123612016.3167.3.camel@localhost.localdomain>
	<42F8F6CC.7090709@fujitsu-siemens.com>
	<1123612789.3167.9.camel@localhost.localdomain>
	<42F8F98B.3080908@fujitsu-siemens.com>
	<1123614253.3167.18.camel@localhost.localdomain>
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
Date: Tue, 09 Aug 2005 15:33:40 -0400
In-Reply-To: <1123614253.3167.18.camel@localhost.localdomain> (Robert
	Wilkens's message of "Tue, 09 Aug 2005 15:04:13 -0400")
Message-ID: <87d5omkiqz.fsf@jbms.ath.cx>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears to me that Bodo Stroesser is correct.  The description of
sa_mask given in the man page is:

"sa_mask gives a mask of signals which should be blocked during
execution of the signal handler.  In addition, the signal which
triggered the handler will be blocked, unless the SA_NODEFER flag is
used."

Note that the "unless the SA_NODEFER flag is used" clause applies only
to "In addition, the signal which triggered the handler will be
blocked."  The first sentence of the description, which is unaffected by
this clause, states that the signals specified in sa_mask will be
blocked while the signal handler being installed executes.  The
description of sa_mask in no way suggests that if SA_NODEFER is
specified, the signals specified in sa_mask will not be blocked.

The description of SA_NODEFER given in the man page is:

"SA_NODEFER

Do not prevent the signal from being received from within its own signal
handler.  SA_NOMASK is an obsolete, non-standard synonym for this flag."

Clearly, the first sentence of this description is the only one which
specifies any behavior at all, so the second sentence can be ignored.
This description only states that SA_NODEFER will block the signal for
which a signal handler is being installed while the signal handler being
installed executes.  It does not indicate that SA_NODEFER has any effect
on the blocking of signals other than the one for which a handler is
being installed, and thus it should be assumed that it has no such
effect.

The source code indicates, though, that SA_NODEFER has precisely this
effect; specifying SA_NODEFER prevents the signals specified in sa_mask
from being blocked (an exception to the normal behavior of sa_mask,
described by the first sentence of the sa_mask man page description
included above), when neither the description of sa_mask nor the
description of SA_NODEFER specifies such an exception.

-- 
Jeremy Maitin-Shepard
