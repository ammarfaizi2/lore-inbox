Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264191AbTCXNEG>; Mon, 24 Mar 2003 08:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264198AbTCXNED>; Mon, 24 Mar 2003 08:04:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9932 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264191AbTCXND1>;
	Mon, 24 Mar 2003 08:03:27 -0500
Date: Mon, 24 Mar 2003 14:14:28 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.5.64-mm6: oops in elv_remove_request
Message-ID: <20030324131428.GF2371@suse.de>
References: <20030314104219.GA791@suse.de> <1047637870.1147.27.camel@ixodes.goop.org> <20030314113732.GC791@suse.de> <1047664774.25536.47.camel@ixodes.goop.org> <20030314180716.GZ791@suse.de> <1047680345.1508.2.camel@ixodes.goop.org> <20030315081558.GK791@suse.de> <1047783292.1209.3.camel@ixodes.goop.org> <20030317080522.GE791@suse.de> <1047920186.1246.32.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047920186.1246.32.camel@ixodes.goop.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17 2003, Jeremy Fitzhardinge wrote:
> On Mon, 2003-03-17 at 00:05, Jens Axboe wrote:
> > On Sat, Mar 15 2003, Jeremy Fitzhardinge wrote:
> > > On Sat, 2003-03-15 at 00:15, Jens Axboe wrote:
> > > > I can reliably crash the box with SG_IO -> ide-cd here, so I'm hoping
> > > > there's a connection. Need to move it to a box where nmi watchdog
> > > > actually works...
> > > 
> > > And wouldn't you know it - with -mm7 it seems to be working fine...
> >                                        ^^
> > What is 'it'?
> 
> Sorry: I meant "cdrecord dev=/dev/hdc -checkdrive" returns correct
> "supported modes".
> 
> I was wrong, however: it is still broken.  Sometimes it will return
> version 2/format 2 results time after time (with supported modes), but
> then I leave it for a while and it reverts to returning 0/1 results with
> no supported modes.  There doesn't seem to be any rhyme or reason about
> it: the "put a disc in and it works" trick doesn't work any more.
> 
> This is with 2.5.64-mm8.  What other details would help?  strace output
> of cdrecord?

Does this patch help at all? At least it solves the hard hangs (machine
double faults) in some circumstances. Linus, please apply. It may not be
this bug, but it's at least one bug.

===== drivers/ide/ide-cd.c 1.40 vs edited =====
--- 1.40/drivers/ide/ide-cd.c	Fri Mar 14 01:49:24 2003
+++ edited/drivers/ide/ide-cd.c	Mon Mar 24 14:08:15 2003
@@ -1749,8 +1749,8 @@
 	/*
 	 * pad, if necessary
 	 */
-	if (len) {
-		while (len) {
+	if (len > 0) {
+		while (len > 0) {
 			int pad = 0;
 
 			xferfunc(drive, &pad, sizeof(pad));

-- 
Jens Axboe

