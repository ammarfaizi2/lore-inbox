Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130207AbRALAQZ>; Thu, 11 Jan 2001 19:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131033AbRALAP4>; Thu, 11 Jan 2001 19:15:56 -0500
Received: from feral.com ([192.67.166.1]:60782 "EHLO feral.com")
	by vger.kernel.org with ESMTP id <S129790AbRALAPn>;
	Thu, 11 Jan 2001 19:15:43 -0500
Date: Thu, 11 Jan 2001 16:15:34 -0800 (PST)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: RESEND: [ PATCH ] externalize (new) scsi timer function
Message-ID: <Pine.LNX.4.21.0101111613210.29666-100000@zeppo.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I sent this about a month ago. I think it's important. For what it's worth,
Doug Gilbert thought it was a good idea too. Can you please reconsider and
drop it in.

---------

Late in the game, and possibly questionable, but it would be helpful to have
the (new) scsi timer functions externalized so that loadable HBA modules can
easily see them.

This is needed because, particularly for Fibre Channel, it's only the HBA that
knows when a command is actually sent to the device as opposed to being
(temporarily) queued up locally while some Fibre Channel or SCSI reset
wreckage is being cleared. The time limit for a command should be while it's
actually active- not while it's waiting to be started.

The alternative of returning commands as having not been queued doesn't work
as well because of race conditions. You can, with several type os HBA, get
cases of having queued up one or more commands and after returning success to
the midlayer, still get an interrupt that says, "that command you thought I
started? Ooops... Sorry. I lied. I couldn't get it started, but it's really
okay to start it now...".

At any rate- it's a minor change, which I've been using for a bit, which
really only is an aid to the case that you have a loadable module that wants
this symbol (natuarally, resident drivers don't care). The only real downside
to any of this is that effectively use the scsi_add_timer to restart a timer

is that you have to use a portion of the Scsi_Cmnd that is not marked as
public. An alternative could be to change the midlayer to add a function to
pause and restart the timer.

-matt

--- linux.orig/drivers/scsi/scsi_syms.c Wed Nov 29 18:19:45 2000
+++ linux/drivers/scsi/scsi_syms.c Wed Nov 29 18:18:35 2000
@@ -91,3 +91,10 @@
 EXPORT_SYMBOL(scsi_devicelist);
 EXPORT_SYMBOL(scsi_device_types);

+/*
+ * Externalize timers so that HBAs can safely start/restart commands.
+ */
+extern void scsi_add_timer(Scsi_Cmnd *, int, void ((*) (Scsi_Cmnd *)));
+extern int scsi_delete_timer(Scsi_Cmnd *);
+EXPORT_SYMBOL(scsi_add_timer);
+EXPORT_SYMBOL(scsi_delete_timer);



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
