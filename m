Return-Path: <linux-kernel-owner+w=401wt.eu-S1030764AbWLPI2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030764AbWLPI2J (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 03:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030766AbWLPI2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 03:28:09 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:36611 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030765AbWLPI2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 03:28:08 -0500
X-Greylist: delayed 1564 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 03:28:07 EST
Date: Sat, 16 Dec 2006 17:31:36 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, clameter@engr.sgi.com, apw@shadowen.org,
       akpm@osdl.org, heiko.carstens@de.ibm.com, bob.picco@hp.com,
       "kamezawa.hiroyu@jp.fujitsu.com" <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [PATCH][2.6.20-rc1-mm1] sparsemem vmem_map optimzed pfn_valid()
 [0/2]
Message-Id: <20061216173136.fbc91fa6.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements pfn_valid() micro optimization.

This uses ia64_pfn_valid() idea to check mem_map is valid or not instead of
sparsemem's logic.

By this, we'll not access mem_section[] in usual ops.

I attaches my easy test result with *micro* benchmark on SMP system.
I'm glad if you give me an advice about testing.

-Kame
==
AIM Independent Resource Benchmark - Suite IX "1.1"

test on 
CPU: Itanium2(madison) 1.3GHz x2, SMP
Memory: memory 8G
2.6.20-rc1-m1 / 
  extreme means  SPARSEMEM_VMEMMAP=n
  vmem_map means SPARSEMEM_VMEMMAP=y + optimze pfn_valid patch.
==
                extreme	    vmem_map
creat-clo       136322      136989  File Creations and Closes per second
page_test       1042187     1076976 System Allocations & Pages per second
brk_test        2678559     2727286 System Memory Allocations per second
signal_test     309525      321052  Signal Traps per second
exec_test       803         801     Program Loads per second
fork_test       9354        9679    Task Creations per second
disk_rr         103766      103970  Random Disk Reads (K) per second
disk_rw         82978       80244   Random Disk Writes (K) per second
disk_rd         802548      872983  Sequential Disk Reads (K) per second
disk_wrt        130342      131408  Sequential Disk Writes (K) per second
disk_cp         107498      107823  Disk Copies (K) per second
sync_disk_rw    800         752     Sync Random Disk Writes (K) per second
sync_disk_wrt   81          78      Sync Sequential Disk Writes (K) per second
sync_disk_cp    84          78      Sync Disk Copies (K) per second
disk_src        44417       44379   Directory Searches per second
mem_rtns_1      3239352     3222140 Dynamic Memory Operations per second
mem_rtns_2      1157321     1155260 Block Memory Operations per second
misc_rtns_1     10799       10993   Auxiliary Loops per second
dir_rtns_1      1276159     1373725 Directory Operations per second
shell_rtns_1    175         176     Shell Scripts per second
shell_rtns_2    174         175     Shell Scripts per second
shell_rtns_3    175         175     Shell Scripts per second
shared_memory   646725      628769  Shared Memory Operations per second
tcp_test        93258       94928   TCP/IP Messages per second
udp_test        177984      177276  UDP/IP DataGrams per second
fifo_test       362774      385434  FIFO Messages per second
stream_pipe     320825      325931  Stream Pipe Messages per second
dgram_pipe      300789      303339  DataGram Pipe Messages per second
pipe_cpy        410539      449521  Pipe Messages per second

