Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWAJTw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWAJTw4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWAJTwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:52:55 -0500
Received: from fmr24.intel.com ([143.183.121.16]:36487 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932533AbWAJTwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:52:54 -0500
Message-Id: <20060110203912.007577046@csdlinux-2.jf.intel.com>
Date: Tue, 10 Jan 2006 12:39:12 -0800
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Cc: tony.luck@intel.com, "Systemtap" <systemtap@sources.redhat.com>,
       "Jim Keniston" <jkenisto@us.ibm.com>, "Keith Owens" <kaos@sgi.com>
Subject: kallsyms_lookup_name should return the text addres 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On architectures like IA64, kallsyms_lookup_name(name) returns
the actual text address corresponding to the "name" and sometimes
returns address of the function descriptor, the behavior is
not consistent.

The bug is kallsyms_lookup_name() -> module_kallsyms_lookup_name(mod, name)
search the name in the given module and returns the address when
name is matched. This address very well could be the address of 'U' type
which is different address than 't' type.

Example:
Here is the output of cat /proc/kallsyms when we have test1.ko using the
my_test_reentrant_export_function.
-----------------------------------------------------------------
a00000020008c090 U my_test_reentrant_export_function    [test1]
a00000020008c0a0 r __ksymtab_my_test_reentrant_export_function  [mon_dummy]
a00000020008c0b0 r __kstrtab_my_test_reentrant_export_function  [mon_dummy]
a00000020008c0d8 r __kcrctab_my_test_reentrant_export_function  [mon_dummy]
00000000a356bab8 a __crc_my_test_reentrant_export_function      [mon_dummy]
a00000020008c000 T my_test_reentrant_export_function    [mon_dummy]
---------------------------------------------------------------

When we have test1.ko loaded, 
kallsyms_lookup_name(my_test_reentrant_export_function)
returns 0xa00000020008c090 which is a function descriptor address and 
when test1.ko is removed
kallsyms_lookup_name(my_test_reentrant_export_function)
returns 0xa00000020008c000 which is the actual text address

The patch following this mail fixes this issue.

-Anil Keshavamurthy

