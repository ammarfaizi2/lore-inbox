Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272828AbTHEPBv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 11:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272832AbTHEPBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 11:01:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:18335 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272828AbTHEPBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 11:01:47 -0400
Date: Tue, 5 Aug 2003 07:57:58 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 vs 2.6 versions of include/linux/ioport.h
Message-Id: <20030805075758.31f51879.rddunlap@osdl.org>
In-Reply-To: <200308051041.08078.gene.heskett@verizon.net>
References: <200308051041.08078.gene.heskett@verizon.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 10:41:08 -0400 Gene Heskett <gene.heskett@verizon.net> wrote:

| Greetings;
| 
| In the 2.4 includes, find this in ioport.h
| ----
| /* Compatibility cruft */
| #define check_region(start,n)   __check_region(&ioport_resource, 
| (start), (n))
| [snip]
| extern int __check_region(struct resource *, unsigned long, unsigned 
| long);
| ----
| But in the 2.6 version, find this:
| ----
| /* Compatibility cruft */
| [snip]
| extern int __check_region(struct resource *, unsigned long, unsigned 
| long);
| [snip]
| static inline int __deprecated check_region(unsigned long s, unsigned 
| long n)
| {
|         return __check_region(&ioport_resource, s, n);
| }
| ----
| First, the define itself is missing in the 2.6 version.
| 
| Many drivers seem to use this call, and in that which I'm trying to 
| build, the nforce and advansys modules use it.  And while the modules 
| seem to build, they do not run properly.
| 
| I cannot run 2.6.x for extended tests because of the advansys breakage 
| this causes.  I also haven't even tried to run X because of the 
| nforce error reported when its built, the same error as attacks the 
| advansys code.
| 
| Can I ask why this change was made, and is there a suitable 
| replacement call available that these drivers could use instead of 
| check_region(), as shown here in a snip from advansys.c?
| ----
| if (check_region(iop, ASC_IOADR_GAP) != 0) {
| ...
| if (check_region(iop_base, ASC_IOADR_GAP) != 0) {
| ...
| 
| Hopeing for some hints here.

check_region() was racy.  Use request_region() instead.

   if (!request_region(iop, ASC_IOADR_GAP, "advansys")) {
   ...

   if (!request_region(iop_base, ASC_IOADR, "advansys")) {
   ...

Of course, if successful, this assigns the region to the driver,
while check_region() didn't do this, so release_region() should be
used as needed to return the resources.

--
~Randy
