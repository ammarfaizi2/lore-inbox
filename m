Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272512AbTHEPtX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 11:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272835AbTHEPtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 11:49:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:42937 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272512AbTHEPtR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 11:49:17 -0400
Date: Tue, 5 Aug 2003 08:45:33 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 vs 2.6 versions of include/linux/ioport.h
Message-Id: <20030805084533.3b0fd474.rddunlap@osdl.org>
In-Reply-To: <200308051122.35712.gene.heskett@verizon.net>
References: <200308051041.08078.gene.heskett@verizon.net>
	<20030805075758.31f51879.rddunlap@osdl.org>
	<200308051122.35712.gene.heskett@verizon.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 11:22:35 -0400 Gene Heskett <gene.heskett@verizon.net> wrote:

| On Tuesday 05 August 2003 10:57, Randy.Dunlap wrote:
| >On Tue, 5 Aug 2003 10:41:08 -0400 Gene Heskett 
| <gene.heskett@verizon.net> wrote:
| >| ----
| >| First, the define itself is missing in the 2.6 version.
| >|
| >| Many drivers seem to use this call, and in that which I'm trying
| >| to build, the nforce and advansys modules use it.  And while the
| >| modules seem to build, they do not run properly.
| >|
| >| I cannot run 2.6.x for extended tests because of the advansys
| >| breakage this causes.  I also haven't even tried to run X because
| >| of the nforce error reported when its built, the same error as
| >| attacks the advansys code.
| >|
| >| Can I ask why this change was made, and is there a suitable
| >| replacement call available that these drivers could use instead of
| >| check_region(), as shown here in a snip from advansys.c?
| >| ----
| >| if (check_region(iop, ASC_IOADR_GAP) != 0) {
| >| ...
| >| if (check_region(iop_base, ASC_IOADR_GAP) != 0) {
| >| ...
| >|
| >| Hopeing for some hints here.
| >
| >check_region() was racy.  Use request_region() instead.
| >
| >   if (!request_region(iop, ASC_IOADR_GAP, "advansys")) {
| >   ...
| >
| >   if (!request_region(iop_base, ASC_IOADR, "advansys")) {
| >   ...
| >
| >Of course, if successful, this assigns the region to the driver,
| >while check_region() didn't do this, so release_region() should be
| >used as needed to return the resources.
| 
| Oops... I have a test compile going that changed those to 
| check_mem_region.  And while I didn't change the i2c stuff, which 
| still reports the error, advansys.o built w/o error this time.
| 
| Ok, so I can change that to !request_region, but I have NDI when to go 
| about releasing it, if ever, for a kernel driver thats either there, 
| and the hardware is used, or not because the hardware isn't present.  

release_region() is already done for the normal case.
It needs to be added for the error cases in advansys_detect()
[wow, what a long function].
For your kernel(s) and known hardware, it may not be much of an
issue.  However, the in-kernel driver needs to be repaired, but
it seems that not many people have the hardware...

| It seems to me that if its allocated to this driver, and capable of 
| being re-used at anytime, then the allocation should, once made, 
| stand.

Yes, request_region() should keep the region assigned until the driver
is exiting (unloading).  release_region() is already done in
advansys_release().

| Or is my view of the world skewed and it should be done at 
| the bottom of whatever conditional is involved?  Inquiring minds want 
| to know.  I guess it all depends on what happens if the call is 
| repeated.  Will it assign a new buffer each time?, thereby causeing a 
| memory leak, or will it find its been done once and return success 
| anyway?

advansys_detect() should call release_region() if it encounters errors
[after it has called request_region() and returns an error].

request_region() doesn't assign buffers, it allocates IO resources,
as seen in /proc/ioports or /proc/iomem.  I don't know what happens
on repeated calls by the same driver|module, but in general a second
call will fail if the region is already allocated.

--
~Randy
