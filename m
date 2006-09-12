Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbWILR6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWILR6V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 13:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWILR6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 13:58:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:52634 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030321AbWILR6O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 13:58:14 -0400
Subject: [PATCH 7/7] SLIM: documentation
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>
Cc: Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>, akpm@osdl.org
Content-Type: text/plain; charset=utf-8
Date: Tue, 12 Sep 2006 10:58:08 -0700
Message-Id: <1158083888.18137.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation.

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 Documentation/slim.txt |  136 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 136 insertions(+)

--- linux-2.6.18/Documentation/slim.txt	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18-rc4/Documentation/slim.txt	2006-08-22 14:48:12.000000000 -0700
@@ -0,0 +1,136 @@
+Simple Linux Integrity Model (SLIM)
+
+SLIM is an LSM module which provides an enhanced low water-mark
+integrity and high water-mark secrecy mandatory access control
+model. It also is a consumer of the new integrity subsystem,
+using the integrity_verify_data(), integrity_verify_metadata(),
+and integrity_measure() calls to base mandatory access control
+decisions on the verified integrity status of the involved objects.
+SLIM is an extension of several prior models, including Biba[1],
+Lowmac[2], and Caernarvon[3], which provide excellent background.
+
+SLIM's specific model is:
+
+	All objects (files) are labeled with extended attributes to indicate:
+		Integrity Access Class (IAC)
+			(one of SYSTEM, USER, UNTRUSTED)
+		Secrecy Access Class (SAC)
+			(one of PUBLIC, USER, USER_SENSITIVE,
+				SYSTEM_SENSITIVE)
+
+	All processes inherit from their parents:
+		Integrity Read Access Class (IRAC)
+		Integrity Write/Execute Access Class (IWXAC)
+		Secrecy Write Access Class (SWAC)
+		Secrecy Read/Execute Access Class (SRXAC)
+
+	SLIM enforces the following Mandatory Access Control Rules:
+		Read:
+			IRAC(process) <= IAC(object)
+			SRXAC(process) >= SAC(object)
+		Write:
+			IWXAC(process) >= IAC(object)
+			SWAC(process) <= SAC(process)
+		Execute:
+			IWXAC(process) <= IAC(object)
+			SRXAC(process) >= SAC(object)
+
+In the low water-mark model, rather than blocking attempted
+reads of lower integrity objects, the reading process is demoted
+to the integrity level of the object, so that the read is allowed.
+In a Linux client, this provides a much more usable environment,
+in which applications run more transparently, while being demoted
+as needed to protect the integrity of the system.
+
+When the process is demoted, it may have objects open for write
+of now higher integrity level, and these objects have to have their
+write access revoked. This revocation of write privilege must
+occur for normal and mmap'ed file writes.  Similarly, when reading
+an object of higher secrecy, the process is promoted to the higher
+secrecy level, and write access to now lower secrecy objects is revoked.
+
+SLIM performs a generic revocation operation, including revoking
+mmap and shared memory access. Note that during demotion or promotion
+of a process, SLIM needs only revoke write access to files with higher
+integrity, or lower secrecy. 
+
+SLIM inherently deals with dynamic task labels, which is a feature 
+not currently available in selinux. While it might be possible to
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
+did not handle their demotions well, as they occurred well into their
+startup. For these applications, we simply force them to start up
+as UNTRUSTED, so demotion is not an issue. The one application type
+that does tend to get demoted over time is shells, such as bash.
+These are not problems, as new ones can be created with the
+windowing system, or with su, as needed. To help with the associated
+user interface issue, the user space package[4] README shows how to
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
+As mentioned earlier, cupsd and Notes are applications which are
+always run directly in untrusted mode, regardless of the level of
+the invoking process.
+
+The bottom line is that SLIM guard programs inherently do security
+sensitive things, and have to be trusted. There are only a small
+number of them, and they are clearly identified by their labels.
+
+Userspace Tools:
+
+Papers and slides on SLIM, along with source code for the needed
+userspace tools, and installation instructions are available at:
+
+[4]	http://www.research.ibm.com/gsal/tcpa
+
+References:
+
+[1 Biba]: K. J. Biba. “Integrity Considerations for Secure Computer Systems”
+Technical Report ESD-TR-76-372, USAF Electronic Systems Division, Hanscom Air
+Force Base, Bedford, Massachusetts, April 1977.
+
+[2 Lomac]: T. Fraser, "LOMAC: Low Water-Mark Integrity Protection for COTS
+Environments,"  Proceedings of the 2000 IEEE Symposium on Security and
+Privacy, Oakland, California, USA, 2000.
+
+[3 Caernarvon]: P. Karger, V. Austel, and D. Toll. “Using a Mandatory Secrecy
+and Integrity Policy on Smart Cards and Mobile Devices” EUROSMART Security
+Conference. 13-15 June 2000, Marseilles, France p. 134-148. 


