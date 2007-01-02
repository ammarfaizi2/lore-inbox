Return-Path: <linux-kernel-owner+w=401wt.eu-S1754898AbXABQhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898AbXABQhN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755365AbXABQhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:37:13 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:55624 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754898AbXABQhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:37:11 -0500
X-Greylist: delayed 875 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 11:37:11 EST
Subject: 2.6.20-rc2-mm1:  Makefile drops local version when checking headers
From: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: sam@ravnborg.org
Content-Type: text/plain
Organization: HP/OSLO
Date: Tue, 02 Jan 2007 11:23:35 -0500
Message-Id: <1167755015.5104.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When building 2.6.20-rc2-mm1 with CHECK_HEADERS=y, the Makefile will
build the target "include/config/kernel.release" twice.  The first time,
the CONFIG_LOCALVERSION [and any auto local version] will correctly be
appended.  Then, when it builds the "headers_check" target, the Makefile
will build the "include/config/kernel.release" target again, dropping
the local version information.  If you then do a "make
[modules_]install" in this tree, the install will use the second version
string w/o the localversion, installing modules in the wrong place and
kernel/initrd with wrong name, possibly overwriting desired copies of
the "2.6.20-rc2-mm1" kernel/modules.

[Aside:  it also appears that several items, including the kernel
itself, get rebuilt during "make [modules_]install" after a successful
"make [all]".  I think this is new behavior.]

This behavior appears to have been introduced by the patch:

build-compileh-earlier.patch

Sorry, no patch to propose.  Simple workaround is just to omit header
checks.

Here's the results of some instrumentation that I added to the Makefile
showing the sequence of targets built and which dependents cause the
build:

-------------------
<first build of target OK>

generating include/config/kernel.release:  2.6.20-rc1-mm1+foo
	KERNELVERSION = 2.6.20-rc1-mm1
	localver-full = +foo
 		localver      = +foo
		localver-auto = 
Target:  include/linux/utsrelease.h
Target:  prepare3
Target:  prepare1

<but later, for headers check>

generating include/config/kernel.release:  2.6.20-rc1-mm1
	KERNELVERSION = 2.6.20-rc1-mm1
	localver-full = 
 		localver      = 
		localver-auto = 
Target:  include/linux/utsrelease.h
Target:  headers_install
Target:  headers_check
----------------------------

Regards,
Lee

