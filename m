Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752656AbWAHR7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbWAHR7u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 12:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752657AbWAHR7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 12:59:50 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:34578 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1752656AbWAHR7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 12:59:49 -0500
Date: Sun, 8 Jan 2006 18:59:34 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@sgi.com>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: reference_discarded addition
Message-ID: <20060108175934.GA15445@mars.ravnborg.org>
References: <20060106074019.GA1226@redhat.com> <31103.1136685155@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31103.1136685155@ocs3.ocs.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 12:52:35PM +1100, Keith Owens wrote:
> Dave Jones (on Fri, 6 Jan 2006 02:40:19 -0500) wrote:
> >Error: ./fs/quota_v2.o .opd refers to 0000000000000020 R_PPC64_ADDR64    .exit.text
> >
> >Been carrying this for some time in Red Hat trees.
> >
> >Signed-off-by: Dave Jones <davej@redhat.com>
> >
> >diff -urNp --exclude-from=/home/davej/.exclude linux-3022/scripts/reference_discarded.pl linux-10000/scripts/reference_discarded.pl
> >--- linux-3022/scripts/reference_discarded.pl
> >+++ linux-10000/scripts/reference_discarded.pl
> >@@ -88,6 +88,7 @@ foreach $object (keys(%object)) {
> > 		    ($from !~ /\.text\.exit$/ &&
> > 		     $from !~ /\.exit\.text$/ &&
> > 		     $from !~ /\.data\.exit$/ &&
> >+		     $from !~ /\.opd$/ &&
> > 		     $from !~ /\.exit\.data$/ &&
> > 		     $from !~ /\.altinstructions$/ &&
> > 		     $from !~ /\.pdr$/ &&
> 
> For our future {in}sanity, add a comment that this is the ppc .opd
> section, not the ia64 .opd section.  ia64 .opd should not point to
> discarded sections.
> 
> Any idea why ppc .opd points to discarded sections when ia64 does not?
> AFAICT no ia64 object has a useful .opd section, they are all empty or
> (sometimes) a dummy entry which is 1 byte long.  ia64 .opd data is
> built at link time, not compile time.
> 
> It is a pity that ppc is generating .opd entries at compile time.  It
> makes it impossible to detect a real reference to a discarded function.

Thanks for the comments Keith.
I have applied the following:


diff-tree 442ce844e139c1e3c23e8b4df13468041ae35721 (from 50aa88e2877f1375ba79d1be7a0ff4aa563741c7)
Author: Dave Jones <davej@redhat.com>
Date:   Fri Jan 6 02:40:19 2006 -0500

    kbuild: reference_discarded addition
    
    Error: ./fs/quota_v2.o .opd refers to 0000000000000020 R_PPC64_ADDR64    .exit.text
    
    Been carrying this for some time in Red Hat trees.
    
    Keith Ownes <kaos@sgi.com> commented:
    For our future {in}sanity, add a comment that this is the ppc .opd
    section, not the ia64 .opd section.  ia64 .opd should not point to
    discarded sections.
    
    Any idea why ppc .opd points to discarded sections when ia64 does not?
    AFAICT no ia64 object has a useful .opd section, they are all empty or
    (sometimes) a dummy entry which is 1 byte long.  ia64 .opd data is
    built at link time, not compile time.
    
    Signed-off-by: Dave Jones <davej@redhat.com>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/scripts/reference_discarded.pl b/scripts/reference_discarded.pl
index c2d5414..4ee6ab2 100644
--- a/scripts/reference_discarded.pl
+++ b/scripts/reference_discarded.pl
@@ -69,10 +69,15 @@ foreach $object (keys(%object)) {
 	}
 }
 # printf("ignoring %d conglomerate(s)\n", $ignore);
 
 # printf("Scanning objects\n");
+
+# Keith Ownes <kaos@sgi.com> commented:
+# For our future {in}sanity, add a comment that this is the ppc .opd
+# section, not the ia64 .opd section.
+# ia64 .opd should not point to discarded sections.
 $errorcount = 0;
 foreach $object (keys(%object)) {
 	my $from;
 	open(OBJDUMP, "objdump -r $object|") || die "cannot objdump -r $object";
 	while (defined($line = <OBJDUMP>)) {
@@ -86,10 +91,11 @@ foreach $object (keys(%object)) {
 		     $line =~ /\.exit\.data$/ ||
 		     $line =~ /\.exitcall\.exit$/) &&
 		    ($from !~ /\.text\.exit$/ &&
 		     $from !~ /\.exit\.text$/ &&
 		     $from !~ /\.data\.exit$/ &&
+		     $from !~ /\.opd$/ &&
 		     $from !~ /\.exit\.data$/ &&
 		     $from !~ /\.altinstructions$/ &&
 		     $from !~ /\.pdr$/ &&
 		     $from !~ /\.debug_.*$/ &&
 		     $from !~ /\.exitcall\.exit$/ &&
