Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261350AbSJLUuP>; Sat, 12 Oct 2002 16:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSJLUuP>; Sat, 12 Oct 2002 16:50:15 -0400
Received: from ip68-4-86-174.oc.oc.cox.net ([68.4.86.174]:26606 "EHLO
	ip68-4-86-174.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S261350AbSJLUuP>; Sat, 12 Oct 2002 16:50:15 -0400
Date: Sat, 12 Oct 2002 13:56:04 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: Re: [BUG] pl2303 oops in 2.4.20-pre10 (and 2.5 too)
Message-ID: <20021012205604.GB17162@ip68-4-86-174.oc.oc.cox.net>
References: <20021009233624.GA17162@ip68-4-86-174.oc.oc.cox.net> <20021009235332.GA19351@kroah.com> <20021011023925.GA9142@ip68-4-86-174.oc.oc.cox.net> <20021011170623.GB4123@kroah.com> <20021012063036.GA10921@ip68-4-86-174.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021012063036.GA10921@ip68-4-86-174.oc.oc.cox.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch (which reverts part of 2.4.20-pre2) seems to fix my
pl2303 oopsing (and let me use the device properly again) in 2.4.20-pre2
through -pre5. This patch doesn't work with -pre6 or up though (due to
white space differences and, more importantly, the removal of all 6
variables referenced in the if-statement).

Anyway, I'm posting this in case it provides another clue as to what's
not working.

-Barry K. Nathan <barryn@pobox.com>

--- linux-2.4.20-pre2/drivers/usb/serial/usbserial.c	2002-10-12 00:09:35.000000000 -0700
+++ linux-2.4.20-pre1/drivers/usb/serial/usbserial.c	2002-01-22 13:22:58.000000000 -0800
@@ -1161,6 +1161,15 @@
 	/* END HORRIBLE HACK FOR PL2303 */
 #endif
 	
+	/* verify that we found all of the endpoints that we need */
+	if (!((interrupt_pipe & type->needs_interrupt_in) &&
+	      (bulk_in_pipe & type->needs_bulk_in) &&
+	      (bulk_out_pipe & type->needs_bulk_out))) {
+		/* nope, they don't match what we expected */
+		info("descriptors matched, but endpoints did not");
+		return NULL;
+	}
+
 	/* found all that we need */
 	info("%s converter detected", type->name);
 
