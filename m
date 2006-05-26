Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWEZSSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWEZSSM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 14:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWEZSSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 14:18:12 -0400
Received: from mga03.intel.com ([143.182.124.21]:25902 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751232AbWEZSSL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 14:18:11 -0400
X-IronPort-AV: i="4.05,177,1146466800"; 
   d="scan'208"; a="42148225:sNHT27784064"
Subject: Re: 2.6.17-rc4-mm3 - kernel panic
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Brown, Len" <len.brown@intel.com>, Andreas Saur <saur@acmelabs.de>,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060526071518.GC1699@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB68AD7E1@hdsmsx411.amr.corp.intel.com>
	 <1148583675.3070.41.camel@whizzy> <20060525221222.GA1608@elf.ucw.cz>
	 <20060525221744.GA1671@elf.ucw.cz> <1148601858.3070.62.camel@whizzy>
	 <20060526071518.GC1699@elf.ucw.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date: Fri, 26 May 2006 11:29:35 -0700
Message-Id: <1148668175.7600.11.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
X-OriginalArrivalTime: 26 May 2006 18:18:08.0764 (UTC) FILETIME=[BD9283C0:01C680F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-26 at 09:15 +0200, Pavel Machek wrote:
> On Čt 25-05-06 17:04:18, Kristen Accardi wrote:
> > On Fri, 2006-05-26 at 00:17 +0200, Pavel Machek wrote:
> > > On Pá 26-05-06 00:12:22, Pavel Machek wrote:
> > > > Hi!
> > > > 
> > > > > > Does the panic go away with CONFIG_ACPI_DOCK=n?
> > > > 
> > > > > Can either Pavel or Andreas please try this little debugging patch and
> > > > > send me the dmesg output?  Please enable the CONFIG_DEBUG_KERNEL option
> > > > > in your .config as well so that I can get additional info.
> > > > 
> > > > Yep, you were right... this debugging patch helps.
> > > 
> > > ...and docking +/- works, but it does not look like PCI in docking
> > > station is properly connected:
> > > 
> > 
> > No, I would not expect PCI to work properly with the debug patch -
> > basically all I did was prevent the oops and confirm that this is the
> > issue, I did not actually solve the problem.
> > 
> > I need some way to prevent acpiphp from loading before dock is completed
> > it's init.
> > 
> > I guess I will think about this some more.
> 
> Using different _init levels? Like putting dock at subsys_initcall()
> while acpiphp at late_initcall()?
> 								Pavel

Can you see if this works for you?  Revert the first debug patch I sent
and apply this one instead (against -mm).

Thanks,
Kristen


---
 drivers/acpi/dock.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- 2.6-mm.orig/drivers/acpi/dock.c
+++ 2.6-mm/drivers/acpi/dock.c
@@ -190,6 +190,9 @@ static int is_dock(acpi_handle handle)
  */
 int is_dock_device(acpi_handle handle)
 {
+	if (!dock_station)
+		return 0;
+
 	if (is_dock(handle) || find_dock_dependent_device(dock_station, handle))
 		return 1;
 
@@ -674,5 +677,5 @@ static void __exit dock_exit(void)
 	dock_remove();
 }
 
-module_init(dock_init);
+postcore_initcall(dock_init);
 module_exit(dock_exit);
