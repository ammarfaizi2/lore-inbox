Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263844AbTHZOBB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbTHZOA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:00:56 -0400
Received: from gate.perex.cz ([194.212.165.105]:46350 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S263799AbTHZOAj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 10:00:39 -0400
Date: Tue, 26 Aug 2003 15:59:40 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Strange memory usage reporting
In-Reply-To: <Pine.LNX.4.44.0308261459180.29234-100000@pnote.perex-int.cz>
Message-ID: <Pine.LNX.4.44.0308261550240.1958-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Aug 2003, Jaroslav Kysela wrote:

> On Tue, 26 Aug 2003, [iso-8859-1] Måns Rullgård wrote:
> 
> > I was a little surprised to see top tell me this:
> > 
> >   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND           
> > 10642 mru       11   0 23200  81m 2740 S  0.0 37.0   0:00.07 tcvp              
> > 
> > It didn't make sense that RES > VIRT, so I check /proc/pid/*.  Their
> > contents are below.  Am I missing something?  Note that they are not
> > consistent with the 'top' line above, since they were copied at a
> > different time.  The effect is easily reproducible.  It happens every
> > time I run my music player with using ALSA.
> 
> I have exactly same behaviour with 2.4.21 kernel. It seems that VmRSS
> grows with the mmap2 syscalls although appropriate munmap is called. I'm
> investigating a possible problem with the memory accounting.

Yes, it seems so. The do_no_page() function in mm/memory.c does accounting 
for reserved pages (++mm->rss), but in zap_pte_range() there is a check 
preventing increase the count of freed pages.

Here is a patch for VM gurus to review (for 2.4 kernel, but it should 
apply to 2.6 as well):

===== mm/memory.c 1.57 vs edited =====
--- 1.57/mm/memory.c	Fri Jun 13 18:26:23 2003
+++ edited/mm/memory.c	Tue Aug 26 15:33:28 2003
@@ -1306,7 +1306,8 @@
 	 */
 	/* Only go through if we didn't race with anybody else... */
 	if (pte_none(*page_table)) {
-		++mm->rss;
+		if (!PageReserved(new_page))
+			++mm->rss;
 		flush_page_to_ram(new_page);
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

