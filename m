Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265119AbUENJuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbUENJuQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 05:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265138AbUENJuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 05:50:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62336 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265119AbUENJuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 05:50:05 -0400
Date: Fri, 14 May 2004 11:49:23 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kronos@kronoz.cjb.net,
       linux-kernel@vger.kernel.org
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-ID: <20040514094923.GB29106@devserv.devel.redhat.com>
References: <20040513145640.GA3430@dreamland.darkstar.lan> <1084488901.3021.116.camel@gaston> <20040513182153.1feb488b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513182153.1feb488b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 11:47:39AM +0200, Andrew Morton wrote:
> There's a `make buildcheck' target in -mm (from Arjan) into which we could
> integrate such a tool.  Although probably it should be a different make
> target.

I added it to buildcheck for now, based on Keith Owens' check-stack.sh
script. I added a tiny bit of perl (shudder) to it to 
1) Make it print in decimal not hex
2) Filter the stack users to users of 400 bytes and higher

I arbitrarily used 400; that surely is debatable.

Greetings,
    Arjan van de Ven

diff -purN linux-2.6.6/Makefile linux/Makefile
--- linux-2.6.6/Makefile	2004-05-14 09:22:43.735077088 +0200
+++ linux/Makefile	2004-05-14 11:44:40.277365864 +0200
@@ -1061,6 +1061,8 @@ versioncheck:
 
 buildcheck:
 	$(PERL) scripts/reference_discarded.pl
+	sh scripts/check-stack.sh vmlinux
+	find -name "*.ko" | xargs sh scripts/check-stack.sh
 
 endif #ifeq ($(config-targets),1)
 endif #ifeq ($(mixed-targets),1)
diff -purN linux-2.6.6/scripts/check-stack.sh linux/scripts/check-stack.sh
--- linux-2.6.6/scripts/check-stack.sh	1970-01-01 01:00:00.000000000 +0100
+++ linux/scripts/check-stack.sh	2004-05-14 11:43:12.484712376 +0200
@@ -0,0 +1,47 @@
+#!/bin/bash
+#
+# Written by Keith Owens, modified by Arjan van de Ven to output in deciman
+#
+# Usage :  check-stack.sh vmlinux $(/sbin/modprobe -l)
+#
+#	Run a compiled ix86 kernel and print large local stack usage.
+#
+#	/>:/{s/[<>:]*//g; h; }   On lines that contain '>:' (headings like
+#	c0100000 <_stext>:), remove <, > and : and hold the line.  Identifies
+#	the procedure and its start address.
+#
+#	/subl\?.*\$0x[^,][^,][^,].*,%esp/{    Select lines containing
+#	subl\?...0x...,%esp but only if there are at least 3 digits between 0x and
+#	,%esp.  These are local stacks of at least 0x100 bytes.
+#
+#	s/.*$0x\([^,]*\).*/\1/;   Extract just the stack adjustment
+#	/^[89a-f].......$/d;   Ignore line with 8 digit offsets that are
+#	negative.  Some compilers adjust the stack on exit, seems to be related
+#	to goto statements
+#	G;   Append the held line (procedure and start address).
+#	s/\(.*\)\n.* \(.*\)/\1 \2/;  Remove the newline and procedure start
+#	address.  Leaves just stack size and procedure name.
+#	p; };   Print stack size and procedure name.
+#
+#	/subl\?.*%.*,%esp/{   Selects adjustment of %esp by register, dynamic
+#	arrays on stack.
+#	G;   Append the held line (procedure and start address).
+#	s/\(.*\)\n\(.*\)/Dynamic \2 \1/;   Reformat to "Dynamic", procedure
+#	start address, procedure name and the instruction that adjusts the
+#	stack, including its offset within the proc.
+#	p; };   Print the dynamic line.
+#
+#
+#	Leading spaces in the sed string are required.
+#
+# first check if it's x86, since only that arch works for now
+file vmlinux  | grep 80386 > /dev/null || exit
+#
+objdump --disassemble "$@" | \
+sed -ne '/>:/{s/[<>:]*//g; h; }
+ /subl\?.*\$0x[^,][^,][^,].*,%esp/{
+ s/.*\$0x\([^,]*\).*/\1/; /^[89a-f].......$/d; G; s/\(.*\)\n.* \(.*\)/\1 \2/; p; };
+ /subl\?.*%.*,%esp/{ G; s/\(.*\)\n\(.*\)/Dynamic \2 \1/; p; }; ' | \
+ sort | \
+perl -e 'while (<>) { if (/^([0-9a-f]+)(.*)/) { $decn = hex("0x" . $1); if ($decn > 400) { print "$decn $2\n";} } }'
+
