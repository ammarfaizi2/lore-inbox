Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264100AbUDRCwL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 22:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263231AbUDRCwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 22:52:11 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:7041
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S264100AbUDRCwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 22:52:05 -0400
Subject: Re: NFS and kernel 2.6.x
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Marc Singer <elf@buici.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040417201914.B21974@flint.arm.linux.org.uk>
References: <20040415185355.1674115b.akpm@osdl.org>
	 <1082084048.7141.142.camel@lade.trondhjem.org>
	 <20040416045924.GA4870@linuxace.com>
	 <1082093346.7141.159.camel@lade.trondhjem.org>
	 <pan.2004.04.17.16.44.00.630010@smurf.noris.de>
	 <1082225747.2580.18.camel@lade.trondhjem.org> <20040417183219.GB3856@flea>
	 <1082228313.2580.25.camel@lade.trondhjem.org> <20040417190107.GA4179@flea>
	 <1082228963.2580.34.camel@lade.trondhjem.org>
	 <20040417201914.B21974@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082256704.3619.68.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 17 Apr 2004 19:51:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-17 at 12:19, Russell King wrote:

> Firstly, as far as I can see, args[] is uninitialised.  If match_token
> doesn't touch args[] then we pass match_int some uninitialised kernel
> memory.
>
> Secondly, we seem to exit if match_int doesn't parse a number.  Not
> all options in "tokens" have a number associated with them, including
> ones like "tcp".

Agreed. The correct fix should be something like the appended patch. It
depends on all tokens that do take an integer argument being listed
first in the enum.

Comments?

Cheers,
  Trond
 nfsroot.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

--- linux-2.6.6-up/fs/nfs/nfsroot.c.orig	2004-04-17 11:05:10.000000000 -0700
+++ linux-2.6.6-up/fs/nfs/nfsroot.c	2004-04-17 18:47:05.000000000 -0700
@@ -117,11 +117,16 @@ static int mount_port __initdata = 0;		/
  ***************************************************************************/
 
 enum {
+	/* Options that take integer arguments */
 	Opt_port, Opt_rsize, Opt_wsize, Opt_timeo, Opt_retrans, Opt_acregmin,
-	Opt_acregmax, Opt_acdirmin, Opt_acdirmax, Opt_soft, Opt_hard, Opt_intr,
+	Opt_acregmax, Opt_acdirmin, Opt_acdirmax,
+	/* Options that take no arguments */
+	Opt_soft, Opt_hard, Opt_intr,
 	Opt_nointr, Opt_posix, Opt_noposix, Opt_cto, Opt_nocto, Opt_ac, 
 	Opt_noac, Opt_lock, Opt_nolock, Opt_v2, Opt_v3, Opt_udp, Opt_tcp,
-	Opt_broken_suid, Opt_err,
+	Opt_broken_suid,
+	/* Error token */
+	Opt_err
 };
 
 static match_table_t tokens = {
@@ -146,9 +151,13 @@ static match_table_t tokens = {
 	{Opt_noac, "noac"},
 	{Opt_lock, "lock"},
 	{Opt_nolock, "nolock"},
+	{Opt_v2, "nfsvers=2"},
 	{Opt_v2, "v2"},
+	{Opt_v3, "nfsvers=3"},
 	{Opt_v3, "v3"},
+	{Opt_udp, "proto=udp"},
 	{Opt_udp, "udp"},
+	{Opt_udp, "proto=tcp"},
 	{Opt_tcp, "tcp"},
 	{Opt_broken_suid, "broken_suid"},
 	{Opt_err, NULL}
@@ -179,8 +188,8 @@ static int __init root_nfs_parse(char *n
 			continue;
 		token = match_token(p, tokens, args);
 
-		/* %u tokens only */
-		if (match_int(&args[0], &option))
+		/* %u tokens only. Beware if you add new tokens! */
+		if (token < Opt_soft && match_int(&args[0], &option))
 			return 0;
 		switch (token) {
 			case Opt_port:

