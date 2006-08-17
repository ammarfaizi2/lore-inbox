Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWHQTzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWHQTzR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 15:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWHQTyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 15:54:49 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:32199 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030229AbWHQTyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 15:54:18 -0400
Subject: [RFC][PATCH 8/8] SLIM: documentation
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>
Cc: Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 12:53:39 -0700
Message-Id: <1155844419.6788.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation.

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
Documentation/slim.txt |   69 +++++++++++++++++++++++++++++++++++++++
1 files changed, 69 insertions(+) 

--- linux-2.6.18/Documentation/slim.txt	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18-rc4/Documentation/slim.txt	2006-08-17 12:38:24.000000000 -0700
@@ -0,0 +1,69 @@
+SLIM is an LSM module which provides an enhanced low water-mark
+integrity and high water-mark secrecy mandatory access control
+model.
+
+SLIM now performs a generic revocation operation, including revoking
+mmap and shared memory access. Note that during demotion or promotion
+of a process, SLIM needs only revoke write access to files with higher
+integrity, or lower secrecy. Read and execute permissions are blocked
+as needed, not revoked.  SLIM hopefully uses d_instantiate correctly now.
+
+SLIM inherently deals with dynamic labels, which is a feature not
+currently available in selinux. While it might be possible to
+add support for this to selinux, it would not appear to be simple,
+and it is not clear if the added complexity would be desirable
+just to support this one model.
+
+Comments on the model:
+
+Some of the prior comments questioned the usefulness of the
+low water-mark model itself. Two major questions raised concerned
+a potential progression of the entire system to a fully demoted
+state, and the security issues surrounding the guard processes.
+
+In normal operation, the system seems to stabilize with a roughly
+equal mixture of SYSTEM, USER, and UNTRUSTED processes. Most
+applications seem to do a fixed set of operations in a fixed domain,
+and stabilize at their appropriate level. Some applications, like
+firefox and evolution, which inherently deal with untrusted data,
+immediately go to the UNTRUSTED level, which is where they belong.
+In a couple of cases, including cups and Notes, the applications
+did not handle their demotions well, as they occured well into their
+startup. For these applications, we simply force them to start up
+as UNTRUSTED, so demotion is not an issue. The one application
+that does tend to get demoted over time are shells, such as bash.
+These are not problems, as new ones can be created with the
+windowing system, or with su, as needed. To help with the associated
+user interface issue, the user space package README shows how to
+display the SLIM level in window titles, so it is always clear at
+what level the process is currently running.
+
+As for the issue of guard processes, SLIM defines three types of
+guard processes: Unlimited Guards, Limited Guards, and Untrusted
+Guards.  Unlimited Guards are the most security sensitive, as they
+allow less trusted process to acquire a higher level of trust.
+On my current system there are two unlimited guards, passwd and
+userhelper. These two applications inherently have to be trusted
+this way regardless of the MAC model used. In SLIM, the policy
+clearly and simply labels them as having this level of trust.
+
+Limited Guards are programs which cannot give away higher
+trust, but which can keep their existing level despite reading
+less trusted data. On my system I have seven limited guards:
+yum, which is trusted to verify the signature on an (untrusted)
+downloaded RPM file, and to install it, login and sshd, which read
+untrusted user supplied login data, for authentication, dhclient
+which reads untrusted network data, and updates they system
+file /etc/resolv.conf, dbus-daemon, which accepts data from
+potentially untrusted processes, Xorg, which has to accept data
+from all Xwindow clients, regardless of level, and postfix which
+delivers untrusted mail. Again, these applications inherently
+must cross trust levels, and SLIM properly identifies them.
+
+As mentioned earlier, cupsd and notes are applications which are
+always run directly in untrusted mode, regardless of the level of
+the invoking process.
+
+The bottom line is that SLIM guard programs inherently do security
+sensitive things, and have to be trusted. There are only a small
+number of them, and they are clearly identified by their labels.


