Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131389AbRABXZh>; Tue, 2 Jan 2001 18:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131216AbRABXZ1>; Tue, 2 Jan 2001 18:25:27 -0500
Received: from dialin175.pg3-nt.dusseldorf.nikoma.de ([213.54.98.175]:18670
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131389AbRABXZR>; Tue, 2 Jan 2001 18:25:17 -0500
Date: Tue, 2 Jan 2001 23:55:45 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Gerold Jury <geroldj@grips.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, <dl8bcu@gmx.net>,
        <Maik.Zumstrull@gmx.de>
Subject: Re: Happy new year^H^H^H^Hkernel..
In-Reply-To: <3A52582B.9080307@grips.com>
Message-ID: <Pine.LNX.4.30.0101022348550.1202-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Gerold Jury wrote:

> I have reversed the patches part by part, the only thing that makes a
> difference is the diversion services.
> The reason for this remains unknown for me.

I think I found it. Could everybody who was getting the crash on ISDN line
hangup try if the following patch fixes the problem?

I think the problem was that we relied on divert_if being initialized to
zero automatically, which didn't happen because it was not declared static
and therefore not in .bss (*is this true?*).

diff -ur linux-2.4.0-prerelease-diff/drivers/isdn/isdn_common.c linux-2.4.0-prerelease-diff.fix/drivers/isdn/isdn_common.c
--- linux-2.4.0-prerelease-diff/drivers/isdn/isdn_common.c	Tue Jan  2 12:26:45 2001
+++ linux-2.4.0-prerelease-diff.fix/drivers/isdn/isdn_common.c	Tue Jan  2 23:47:48 2001
@@ -68,7 +68,7 @@
 extern char *isdn_v110_revision;

 #ifdef CONFIG_ISDN_DIVERSION
-isdn_divert_if *divert_if; /* interface to diversion module */
+static isdn_divert_if *divert_if; /* = NULL */
 #endif CONFIG_ISDN_DIVERSION


@@ -2118,7 +2118,6 @@
 }

 #ifdef CONFIG_ISDN_DIVERSION
-extern isdn_divert_if *divert_if;

 static char *map_drvname(int di)
 {


I also attached a patch which disables diversion service being selected as
built-in during kernel config, because this doesn't work yet.

--Kai


diff -ur linux-2.4.0-prerelease-diff/drivers/isdn/Config.in linux-2.4.0-prerelease-diff.fix/drivers/isdn/Config.in
--- linux-2.4.0-prerelease-diff/drivers/isdn/Config.in	Tue Jan  2 12:26:45 2001
+++ linux-2.4.0-prerelease-diff.fix/drivers/isdn/Config.in	Tue Jan  2 23:46:00 2001
@@ -23,7 +23,7 @@
 mainmenu_option next_comment
 comment 'ISDN feature submodules'
    dep_tristate 'isdnloop support' CONFIG_ISDN_DRV_LOOP $CONFIG_ISDN
-   dep_tristate 'Support isdn diversion services' CONFIG_ISDN_DIVERSION $CONFIG_ISDN
+   dep_tristate 'Support isdn diversion services' CONFIG_ISDN_DIVERSION $CONFIG_ISDN m
 endmenu

 comment 'low-level hardware drivers'


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
