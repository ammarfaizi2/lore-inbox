Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264607AbTFHGWK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 02:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbTFHGWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 02:22:10 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:11922 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP id S264607AbTFHGWH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 02:22:07 -0400
Message-ID: <3EE2DA43.3060606@kegel.com>
Date: Sat, 07 Jun 2003 23:40:03 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix segmentation fault in "make menuconfig" in current 2.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just ran into the following error:
~/linux-2.4.19$ make ARCH=arm menuconfig
...
/bin/sh scripts/Menuconfig arch/arm/config.in
Using defaults found in arch/arm/defconfig
Preparing scripts: functions, parsingscripts/Menuconfig: line 1: 21468 Segmentation fault      awk "$1"
Awk died with error code 139. Giving up.
make: *** [menuconfig] Error 1

Looks like it's been reported before; Menuconfig has two mistakes
in how it handles missing files in its awk sections.
See http://mail.gnu.org/archive/html/bug-gnu-utils/2001-10/msg00155.html
Even 2.4.21-rc7 seems to still contain the bug (unless I squinted wrong).

Here's a patch relative to 2.4.19 that gets rid of the awk crash,
as recommended by Arnold Robbins (!):

--- linux-2.4.19/scripts/Menuconfig.old	Sat Jun  7 23:07:37 2003
+++ linux-2.4.19/scripts/Menuconfig	Sat Jun  7 23:08:24 2003
@@ -714,7 +714,7 @@

  function parser(ifile,menu) {

-	while (getline <ifile) {
+	while ((getline <ifile) > 0) {
  		if ($1 == "mainmenu_option") {
  			comment_is_option = "1"
  		}
@@ -761,7 +761,7 @@

  function parser(ifile,menu) {

-	while (getline <ifile) {
+	while ((getline <ifile) > 0) {
  		if ($0 ~ /^#|$MAKE|mainmenu_name/) {
  			printf("") >>menu
  		}


Once that's applied, Menuconfig produces a more useful, though still bad,
error message:

-----
scripts/Menuconfig: ./MCmenu0: line 63: syntax error near unexpected token `fi'
scripts/Menuconfig: ./MCmenu0: line 63: `fi'
done.
^[[H^[[2J+ cat

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

  Q> scripts/Menuconfig: MCmenu0: command not found
-----

Figuring out what's going on then requires commenting out the line in
Menuconfig that removes MCmenu0.
The root cause of the error is that the file drivers/ssi/Config.in
is in the arm-linux kernel, but not in the vger kernel.
Sigh.  So I only ran into the problem because I was trying to configure
(let alone build) the vger kernel for arm, which apparantly is something nobody ever does.
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

