Return-Path: <linux-kernel-owner+w=401wt.eu-S1751791AbXAVL5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbXAVL5y (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 06:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbXAVL5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 06:57:53 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:59611 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbXAVL5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 06:57:52 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
Subject: Re: Suspend to RAM generates oops and general protection fault
Date: Mon, 22 Jan 2007 12:59:06 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <45B422D3.9040409@usherbrooke.ca>
In-Reply-To: <45B422D3.9040409@usherbrooke.ca>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KcKtFnSwmhDPAT3"
Message-Id: <200701221259.06817.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_KcKtFnSwmhDPAT3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Monday, 22 January 2007 03:34, Jean-Marc Valin wrote:
> Hi,
> 
> I just encountered the following oops and general protection fault
> trying to suspend/resume my laptop. I've got a Dell D820 laptop with a 2
> GHz Core 2 Duo CPU. It usually suspends/resumes fine but not always. The
> relevant errors are below but the full dmesg log is at
> http://people.xiph.org/~jm/suspend_resume_oops.txt and my config is in
> http://people.xiph.org/~jm/config-2.6.20-rc5.txt
> 
> This happens when I'm running 2.6.20-rc5. The previous kernel version I
> was using is 2.6.19-rc6 and was much more broken (second attempt
> *always* failed), so it's probably not a regression.

This is a shot against the odds, but could you please check if the attached
patch has any effect?

Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King

--Boundary-00=_KcKtFnSwmhDPAT3
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="page_alloc-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="page_alloc-fix.patch"

Both process_zones()and drain_node_pages() check for populated zones before
touching pagesets. However, __drain_pages does not do so,

This may result in a NULL pointer dereference for pagesets in unpopulated
zones if a NUMA setup is combined with cpu hotplug.

Initially the unpopulated zone has the pcp pointers pointing to the boot
pagesets.  Since the zone is not populated the boot pageset pointers will
not be changed during page allocator and slab bootstrap.

If a cpu is later brought down (first call to __drain_pages()) then the pcp
pointers for cpus in unpopulated zones are set to NULL since __drain_pages
does not first check for an unpopulated zone.

If the cpu is then brought up again then we call process_zones() which will ignore
the unpopulated zone. So the pageset pointers will still be NULL.

If the cpu is then again brought down then __drain_pages will attempt to drain
pages by following the NULL pageset pointer for unpopulated zones.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

---
 mm/page_alloc.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6.20-rc4/mm/page_alloc.c
===================================================================
--- linux-2.6.20-rc4.orig/mm/page_alloc.c
+++ linux-2.6.20-rc4/mm/page_alloc.c
@@ -714,6 +714,9 @@ static void __drain_pages(unsigned int c
 		if (!populated_zone(zone))
 			continue;
 
+		if (!populated_zone(zone))
+			continue;
+
 		pset = zone_pcp(zone, cpu);
 		for (i = 0; i < ARRAY_SIZE(pset->pcp); i++) {
 			struct per_cpu_pages *pcp;

--Boundary-00=_KcKtFnSwmhDPAT3--
