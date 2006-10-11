Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161436AbWJKVIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161436AbWJKVIt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161438AbWJKVIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:08:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:24226 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161421AbWJKVIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:08:09 -0400
Date: Wed, 11 Oct 2006 14:07:37 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, haveblue@us.ibm.com, ak@suse.de,
       apw@shadowen.org, Keith Mannthey <kmannth@us.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 46/67] i386: fix flat mode numa on a real numa system
Message-ID: <20061011210737.GU16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="i386-fix-flat-mode-numa-on-a-real-numa-system.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: keith mannthey <kmannth@us.ibm.com>

If there is only 1 node in the system cpus should think they are apart of
some other node.

If cases where a real numa system boots the Flat numa option make sure the
cpus don't claim to be apart on a non-existent node.

Signed-off-by: Keith Mannthey <kmannth@us.ibm.com>
Cc: Andy Whitcroft <apw@shadowen.org>
Cc: Dave Hansen <haveblue@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/i386/kernel/smpboot.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- linux-2.6.18.orig/arch/i386/kernel/smpboot.c
+++ linux-2.6.18/arch/i386/kernel/smpboot.c
@@ -642,9 +642,13 @@ static void map_cpu_to_logical_apicid(vo
 {
 	int cpu = smp_processor_id();
 	int apicid = logical_smp_processor_id();
+	int node = apicid_to_node(apicid);
+
+	if (!node_online(node))
+		node = first_online_node;
 
 	cpu_2_logical_apicid[cpu] = apicid;
-	map_cpu_to_node(cpu, apicid_to_node(apicid));
+	map_cpu_to_node(cpu, node);
 }
 
 static void unmap_cpu_to_logical_apicid(int cpu)

--
