Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279990AbRJ3P7Y>; Tue, 30 Oct 2001 10:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279991AbRJ3P7N>; Tue, 30 Oct 2001 10:59:13 -0500
Received: from hermes.toad.net ([162.33.130.251]:22492 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S279996AbRJ3P65>;
	Tue, 30 Oct 2001 10:58:57 -0500
Subject: Re: apm suspend broken ?
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 30 Oct 2001 10:58:51 -0500
Message-Id: <1004457533.4243.98.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I, by the way, had my Latitude suspend perfectly with 2.4.12-ac5.
> Now, with 2.4.13-ac[34] pressing Fn+Suspend just blanks the screen (it
> doesn't shut it off, _just_ blanks it) and hangs the machine.
> 
> Any ideas on how to proceed in order to find out where the problem
> lies?

The apm driver was changed so that clients who open
the apm device without the write flag won't be expected
to return standby or suspend events; and clients who
open the apm device without the read flag won't be
notified of apm events.

For consistency, clients without the write flag should
not be able to request standbys or suspends.  Thus
this patch seems required:
--- linux-2.4.13-ac2/arch/i386/kernel/apm.c	Mon Oct 22 09:22:38 2001
+++ linux-2.4.13-ac2-fix/arch/i386/kernel/apm.c	Tue Oct 30 10:29:41 2001
@@ -1473,6 +1473,8 @@
 		return -EIO;
 	if (!as->suser)
 		return -EPERM;
+	if (!as->writer)
+		return -EPERM;
 	switch (cmd) {
 	case APM_IOC_STANDBY:
 		if (as->standbys_read > 0) {

Applying this patch may solve your problem.

Scenario: You have a client that is opening the apm
device O_RDONLY, yet has been acking standby events
back to the apm driver.  Formerly the driver would
ignore the lack of write permission, but now, since
the client does not have write permission, the driver
does not count the standby event that it sends to the
client as "pending".  So when the client acks the
event, it looks to the driver like a new request.
Without the above patch, the driver will process this
request, dutifully  queueing it to the other clients.
If there is more than one client of this kind, then
an infinite series of standby requests will result.

The patch should prevent that from happening.

However, if there are apm clients that expect the
driver to inform them of standby and suspend events
and to wait for an ack before going ahead with the
standby or suspend, then such clients should be
modified to open the apm device O_RDWR.  So long
as such a client opens the apm device O_RDONLY,
the driver will not wait for it to reply and
(patched with the above) will reject its reply
when it comes.

The changelog at the top of apm.c cites me as the
originator of the idea behind the change.  The
motivation was to eliminate queue overflows for
clients that aren't interested in the events and
don't read them.  The idea of not waiting for 
feedback from clients without write perm seems
like a good one too, since some clients might
just want to hear about events, not generate or
ack them.  However this does constitute an API
change, so either (1) we should disable the
change until 2.5, or (2) we should check that
clients such as apmd are opening the apm device
with O_RDWR.

--
Thomas Hood


