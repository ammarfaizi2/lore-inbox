Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280052AbRJaEFc>; Tue, 30 Oct 2001 23:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280051AbRJaEFW>; Tue, 30 Oct 2001 23:05:22 -0500
Received: from hermes.toad.net ([162.33.130.251]:37258 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S280052AbRJaEFF>;
	Tue, 30 Oct 2001 23:05:05 -0500
Subject: Re: apm suspend broken ?
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 30 Oct 2001 23:05:01 -0500
Message-Id: <1004501103.4367.172.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following  up on my earlier message.

On my machine, lsof reveals that apmd and X both open
/dev/apm_bios with O_RDWR flags; also, reading the source
of libapm reveals that it too opens with O_RDWR;
so none of these should see any change in the behavior
of the apm driver.

Nevertheless, the two-line patch given below needs to be
applied in order to prevent the problem I described before.
I'm running a kernel with the patch applied now and it
works fine.

--
Thomas


--- original message ---

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



